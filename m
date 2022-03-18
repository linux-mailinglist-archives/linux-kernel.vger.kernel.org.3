Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767454DE46D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiCRXKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCRXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C9F8472
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4624CB825E7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 23:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99547C340F4;
        Fri, 18 Mar 2022 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647644938;
        bh=yEsoADbptHdI9cYSyIc5JdQzpMyt92hieOpRtvY3XvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiMLE0eA6e5GU2iyqUD/QBo0thLHb2ogej7foy+2g4erJkfD2LYKr6hrjE/OytJJ+
         OfFPXBvgNfEDqTN/nZCWwq1k+pDrYWzvuCYOFTxZ0nb7raronYXtJLsart9mcVEaW/
         OtcwTne91Y3GzbHtJBOKonFemtUXdBXYD2YsK4BAngSKGXr7JXQ57LAjwWiVSqnzMB
         d3gqaaMeaQlC0udV8a0pX0ksdxNUKuZlNHDvAjoUYHKaSUzrFAFLCkZV7Yf+9tiZmc
         srRsVnyROCBJROmcmFb7oZ5Hbay+6+N+9FRaNwQghDvY1LKDsv37pkrUx3TZaypOsQ
         EteMs7Vls+isw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] x86/Kconfig: Only allow CONFIG_X86_KERNEL_IBT with ld.lld >= 14.0.0
Date:   Fri, 18 Mar 2022 16:07:47 -0700
Message-Id: <20220318230747.3900772-3-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318230747.3900772-1-nathan@kernel.org>
References: <20220318230747.3900772-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_X86_KERNEL_IBT=y and a version of ld.lld prior to 14.0.0,
there are numerous objtool warnings along the lines of:

  warning: objtool: .plt+0x6: indirect jump found in RETPOLINE build

This is a known issue that has been resolved in ld.lld 14.0.0. Prevent
CONFIG_X86_KERNEL_IBT from being selectable when using one of these
problematic ld.lld versions.

Link: https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 921e4ebda564..87579264aa00 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1875,6 +1875,8 @@ config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
 	depends on X86_64 && CC_HAS_IBT && STACK_VALIDATION
+	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
+	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
-- 
2.35.1

