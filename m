Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C445243CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiELEBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbiELEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:01:43 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08F54FAA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:01:42 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24C41CNQ015198;
        Thu, 12 May 2022 13:01:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24C41CNQ015198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652328074;
        bh=Ms2/QTWIxTLGhPZsXAuaiJFN0GAXthYkkx5TMKK6Voc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZoA5n151D9jvsoc/xgTzrSXON47+7LQAYH129DO8WT58un5cOFdBOi4EDl8iQXaB
         ix9k3wgaS2qmfB8z3Ye2qDJs9IF1Rzy1/MqAdtBqhunPhVlHRv7BQDG2fxLbCTWTa4
         ZBfDvYhHm8F+tvI5cTsIXSl0FE4RKNQEmxPqhF07ebjV6bZc7hAkTp0UI8dWy2ONIF
         ezABc7d4Pqjj/7uHT5guHWMF4SfpY1uG/oEanpVGOK7Zn2k/+XGF2PzSX51xUsAusX
         RO91PIVj9/iV+5fSWSPt4oxRIYE3j6/Sf9ouPYtVkm6DUld4v+p58R+SMkmVWfz4AO
         ODTuX069/kysw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/4] cskly: move $(core-y) into arch/csky/Kbuild
Date:   Thu, 12 May 2022 12:59:03 +0900
Message-Id: <20220512035903.2779287-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512035903.2779287-1-masahiroy@kernel.org>
References: <20220512035903.2779287-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-y form to specify the sub-directories under
arch/csky/. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/csky/Kbuild   | 4 ++++
 arch/csky/Makefile | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
index 4e39f7abdeb6..3015be1afd59 100644
--- a/arch/csky/Kbuild
+++ b/arch/csky/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-y += kernel/ mm/
+obj-$(CONFIG_CPU_ABI_V1) += abiv1/
+obj-$(CONFIG_CPU_ABI_V2) += abiv2/
+
 # for cleaning
 subdir- += boot
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 2b30525f39e1..51150abd2831 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -63,10 +63,6 @@ KBUILD_AFLAGS += $(KBUILD_CFLAGS)
 
 head-y := arch/csky/kernel/head.o
 
-core-y += arch/csky/kernel/
-core-y += arch/csky/mm/
-core-y += arch/csky/$(CSKYABI)/
-
 libs-y += arch/csky/lib/ \
 	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
 
-- 
2.32.0

