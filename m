Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC7580813
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiGYXTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiGYXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:19:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74C2826541;
        Mon, 25 Jul 2022 16:19:06 -0700 (PDT)
Received: from kbox (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0DA0020FE2F5;
        Mon, 25 Jul 2022 16:19:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DA0020FE2F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658791146;
        bh=50UCpKOQPGTdS25dXIntvXoh2LEaS/tcG43pWXcm5W8=;
        h=Date:From:To:Cc:Subject:From;
        b=LF927PYThBgiN2hZSCi8yIABcvTjV2khn7vwGSLdsp8ERlwWypUKMVb+i8j5PDrqC
         6sLXtx3pdcJYajn5LiLHuqi+xrXjlZ87fzbZP8zejl2QkbpFtb7sQC5fL5fgJ74lm1
         gU1aHy14XHJJn3yeVgeByTg4OzW948MZWnvzVZnk=
Date:   Mon, 25 Jul 2022 16:19:00 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: tracing/user_events: Tracking broken status and feedback
Message-ID: <20220725231900.GA2389@kbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help keep track of what is required to remove the broken status from
user_events I am starting this thread. I would like to use this thread
to provide status on the work that has been done so far and to have a
discussion about when the broken status can be removed.

Feedback threads from 5.18 version of user_events:
1. https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
2. https://lore.kernel.org/all/1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com/

All the feedback has been addressed in the patchsets 1 and 2 (see below).
Here are the details: 

1. Use bits vs bytes in event enabled memory mappings.
Fixed in patchset 1.

2. Pack ABI structures where size is used.
Fixed in patchset 1.

3. Don't trust user strings for string formatting.
Fixed in patchset 1.

4. Move to refcount APIs vs atomic for tracking references.
Fixed in patchset 1.

5. Ensure event_mutex is held during registration.
Fixed in patchset 2.

With these, I believe I have addressed all issues to remove the
"broken status".

Here is the list of additional feedback (and status) that I don't believe
should have a bearing on removing the "broken status":

1. Kernel vs user tracers in ABI.
This is not done, the plan is to build a libtracepoint library that allows
working with both kernel and user tracers in user programs. Steven is
working on this at the moment. I don't believe this is required to remove
the broken status, but it will help prove the ABI by having it.

No patchset yet.

2. Container/namespace isolation of events.
user_events utilizes tracefs for user facing files in the ABI. I've created
an RFC patchset showing how if tracefs offered an isolated directory
structure per-namespace the user_events ABI is unaffected. This is true for
other ABIs that tracefs hosts, if they would like to integrate. I don't
believe this is required to remove the broken status, however, it's useful
to have to see how the ABI is unaffected while we work toward enabling
isolation within tracing.

See patchset 3.

Patchsets:
1. https://lore.kernel.org/all/20220425184631.2068-1-beaub@linux.microsoft.com/
2. https://lore.kernel.org/all/20220328223225.1992-1-beaub@linux.microsoft.com/
3. https://lore.kernel.org/all/20220707215828.2021-1-beaub@linux.microsoft.com/

Thanks,
-Beau
