Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536A506164
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiDSAtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E142A726
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A252D6142A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74596C36AE3;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=CSPgFxhNYiFfEEQ3oyWb8YPNPLzB29lov0oRZDkF6kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj0WFf3bBOR4XHd++zhKAVuA85aeF/qcSerB68dfRRNBGcOyApPnxR2ztRvOPeDFj
         n0bHD8yg+b48/WLcGuhBucYfLiQp5ZCcz+imeNr1LXbtv2pYo1GxXt1aGx9OWNohUx
         8wW0ok+Km4vk1UkVJHLdi1BYaeUvwILCHIDyxB2jDslBi0woup5znq9xOxh+StPIGZ
         BcPsV85RkWwWs1z5KSA/0twDJnMoie45Z1uO9W13loJFBRpmoMY1fg63j4njSHuLWC
         Ku5wXy4X/j3Ub1sgP/jwOe5bI7SVSf71BdCy1QYTguyFzfWMRDpFFKHoKtDHzQ6qWs
         EoKshYCKUpHuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 539B15C322D; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 42/61] tools/nolibc/stdlib: implement abort()
Date:   Mon, 18 Apr 2022 17:42:06 -0700
Message-Id: <20220419004225.3952530-42-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

libgcc uses it for certain divide functions, so it must be exported. Like
for memset() we do that in its own section so that the linker can strip
it when not needed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index b46bebd48ba2..733105c574ee 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -23,6 +23,14 @@ static __attribute__((unused)) char itoa_buffer[21];
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+/* must be exported, as it's used by libgcc for various divide functions */
+__attribute__((weak,unused,noreturn,section(".text.nolibc_abort")))
+void abort(void)
+{
+	sys_kill(sys_getpid(), SIGABRT);
+	for (;;);
+}
+
 static __attribute__((unused))
 long atol(const char *s)
 {
-- 
2.31.1.189.g2e36527f23

