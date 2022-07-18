Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF32577C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiGRHFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiGRHFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FE1706D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9484AB81017
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E854CC341C8;
        Mon, 18 Jul 2022 07:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658127914;
        bh=y0FZxij6CvyvfMSt+gg4iakPWo0pYfMXFYDWiT1Rz44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LozyIHWKrzWVR6M6he3IthnQ8VZTmY16LVf7v8xRuaJE7oNncrMMdlAKQImcE+CWN
         YebvJ8/tIy4N122goNr2lSCcCAOAoFb7p57T9lwdkDrnyb4eQkYoD0L0i2eqdFEDOC
         HjFwPbwwyNu1w3T9cVqhSdIUr9m4fggb1VyNcNbBmTnDPPHqLkQf3cecPv2YEVH2aQ
         ybJDnVkD6H9a4qSk2dS1AzFk1101f6cwCo4V5mIeRj9bhx5sMEYzgiyeysEHddu7tN
         3JqA8v8x8MjBuQ1YLEWfnVGJAiVxfAKhq1LX0mqEUQUC7pkf/h8tVrqYAF7f1foXok
         A3vPyIjTdoVNQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH] selftests/kprobe: Update test for no event name syntax error
Date:   Mon, 18 Jul 2022 16:05:10 +0900
Message-Id: <165812790993.1377963.9762767354560397298.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
References: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The commit 208003254c32 ("selftests/kprobe: Do not test for GRP/
without event failures") removed a syntax which is no more cause
a syntax error (NO_EVENT_NAME error with GRP/).
However, there are another case (NO_EVENT_NAME error without GRP/)
which causes a same error. This adds a test for that case.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 7c02509c71d0..9e85d3019ff0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -21,6 +21,7 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
 check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
 
 check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
+check_error 'p:^ vfs_read'		# NO_EVENT_NAME
 check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
 

