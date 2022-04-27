Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0E5122F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiD0TmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiD0TkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA01096
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5468DB8294F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F12C385A7;
        Wed, 27 Apr 2022 19:36:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSt-002Iyo-4T;
        Wed, 27 Apr 2022 15:36:43 -0400
Message-ID: <20220427193642.976993500@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [for-next][PATCH 19/21] ring-buffer: Simplify if-if to if-else
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wan Jiabing <wanjiabing@vivo.com>

Use if and else instead of if(A) and if (!A).

Link: https://lkml.kernel.org/r/20220426070628.167565-1-wanjiabing@vivo.com

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..655d6db3e3c3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6011,10 +6011,10 @@ static __init int test_ringbuffer(void)
 		pr_info("        total events:   %ld\n", total_lost + total_read);
 		pr_info("  recorded len bytes:   %ld\n", total_len);
 		pr_info(" recorded size bytes:   %ld\n", total_size);
-		if (total_lost)
+		if (total_lost) {
 			pr_info(" With dropped events, record len and size may not match\n"
 				" alloced and written from above\n");
-		if (!total_lost) {
+		} else {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
 				break;
-- 
2.35.1
