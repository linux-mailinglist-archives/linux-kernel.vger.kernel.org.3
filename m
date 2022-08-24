Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1325A0345
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiHXVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiHXVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:24:55 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 14:24:52 PDT
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F8F25C2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:24:51 -0700 (PDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94])
        by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 27OLMsGN013478;
        Wed, 24 Aug 2022 17:22:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 27OLMsGN013478
From:   Olivier Dion <olivier.dion@polymtl.ca>
To:     linux-kernel@vger.kernel.org
Subject: ptrace() - Tracing the wrong thread after TID recycling
CC:     Oleg Nesterov <oleg@redhat.com>
Date:   Wed, 24 Aug 2022 17:22:54 -0400
Message-ID: <87czcpjpzl.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
X-Poly-FromMTA: (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94]) at Wed, 24 Aug 2022 21:22:54 +0000
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's some cases where it is not currently possible to ensure that the
ptrace commands sent to a thread is the correct target because of TID
recycling.  Usually this is not a problem if the tracer is the direct
parent of the tracee with the help of PTRACE_O_TRACECLONE.

However, in the cases of tracing sibling threads, one has to fork
another process and now the roles have exchanged.  If the tracer wants
to attach to already running sibling threads of its parent, it has to
scan `/proc/[ppid]/task` to get the tids.  However, it's possible for
these tids to be reuse by another process by the time the tracer attach
itself.  Resulting in tracing the wrong threads.  The obvious solution
would be to pass the thread group id to ptrace() like tgkill() has.

This RFC <https://lkml.org/lkml/2020/4/26/253> seems to address this
issue.  Although IIRC pidfd only applies to PID and not to TID.  So the
problem remains.

An ad-hoc solution I've come up with is to `open(/proc/[self]/task)' in
the tracee before forking the tracer.  Then, the tracer will
ptrace(PTRACE_ATTACH) itself to the desired threads found in the
directory by scanning it.  Assuming that the attach worked, the tracer
will then do a openat(O_PATH) on the same directory with the thread id
as the pathname.  If the call failed, it means that thread is not a
sibling of our parent and the tracer can detach itself.

Thought?

-- 
Olivier Dion
oldiob.dev

