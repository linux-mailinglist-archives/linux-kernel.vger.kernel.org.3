Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D290657533F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbiGNQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiGNQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BD632D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB1D62057
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35239C34114;
        Thu, 14 Jul 2022 16:43:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w4-004lXe-Ae;
        Thu, 14 Jul 2022 12:43:32 -0400
Message-ID: <20220714164332.158636203@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:43:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 23/23] selftests/kprobe: Do not test for GRP/ without event failures
References: <20220714164256.403842845@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A new feature is added where kprobes (and other probes) do not need to
explicitly state the event name when creating a probe. The event name will
come from what is being attached.

That is:

  # echo 'p:foo/ vfs_read' > kprobe_events

Will no longer error, but instead create an event:

  # cat kprobe_events
 p:foo/p_vfs_read_0 vfs_read

This should not be tested as an error case anymore. Remove it from the
selftest as now this feature "breaks" the selftest as it no longer fails
as expected.

Link: https://lore.kernel.org/all/1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com/
Link: https://lkml.kernel.org/r/20220712161707.6dc08a14@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc       | 1 -
 1 file changed, 1 deletion(-)

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
 
-- 
2.35.1
