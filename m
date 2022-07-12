Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC34D5726CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiGLTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiGLTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:55:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC721AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BA78B81BDB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CC2C3411C;
        Tue, 12 Jul 2022 19:55:10 +0000 (UTC)
Date:   Tue, 12 Jul 2022 15:55:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] tracing/probes: allow no event name input when
 create group
Message-ID: <20220712155509.02b8d246@gandalf.local.home>
In-Reply-To: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 10:19:04 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> take kprobe event as example, when create a group of events,
> p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
> according to this format, we must input EVENT name,
> 
> this change allow only GRP/ input, EVENT name auto generate from KSYM,
> p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
> 
> similar change apply to eprobe and uprobe.
> 


With this patch set applied, this selftest fails:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc

This exactly:

  echo 'p:foo/ vfs_read' > kprobe_events

no longer fails as the test expects it to.

I guess we need to remove that check as it now works and no longer fails as
"expected".

This change fixes it.

If it's OK with everyone, I'll apply this change.

-- Steve

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index fa928b431555..7c02509c71d0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -21,7 +21,6 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
 check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
 
 check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
-check_error 'p:foo/^ vfs_read'		# NO_EVENT_NAME
 check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
 
