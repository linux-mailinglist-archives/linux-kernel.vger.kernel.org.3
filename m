Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA04B06AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiBJGvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiBJGvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:51:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51E115B;
        Wed,  9 Feb 2022 22:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D0D661CC6;
        Thu, 10 Feb 2022 06:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54377C004E1;
        Thu, 10 Feb 2022 06:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644475904;
        bh=dYbpKbKmMH09KEhVGiK8fe9cVi1GcDr6cnrXLyfYOXY=;
        h=From:To:Cc:Subject:Date:From;
        b=lSDNVk8oqvt7M2Z4olp9DwmAFM1M5mCGF9pN56kVBW2u+6Wf+nJS7osN/ENcxQodE
         5E9RwfYZe6Nh8zZdGlR5H55lHt16ZAqwcT9IGEY3Gb7Px+9tJ8c0ptddxMmCbm+rVk
         dgG2TrRmx7jlGGMvCNPtBAJjD6sNbM75Hi+teE05ZvuZGxnAQcG8nq4GitTrkG03Kq
         8TuqDkntpHTOGpFQ+c2PAJPSUGKh/0p7KPjWzoZ0+lcW18JBeSgHGXTXVxIZ0g7JOn
         ipIaAf54uFuGRPftTO/SLdzyXm77FeUbqGzdxkaUrUC/2a15muSiPbooKnzDSgvZfa
         gYqMeeQaE/yNQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Don't report disabled nodes with duplicate addresses
Date:   Thu, 10 Feb 2022 12:21:32 +0530
Message-Id: <20220210065132.234341-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicated unit address is okay if we have only one such node enabled.
So, remove '-Wno-unique_unit_address' from DTC_FLAGS.

This helps in reducing warnings in qcom dts from

   6483 unique_unit_address
   1108 simple_bus_reg
    764 avoid_unnecessary_addr_size
    712 unit_address_vs_reg
    120 graph_child_address
     32 unique_unit_address_if_enabled

after this patch:
    277 simple_bus_reg
    191 avoid_unnecessary_addr_size
    178 unit_address_vs_reg
     32 unique_unit_address_if_enabled
     30 graph_child_address

which would help people focus on the actual warnings and fix them.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 scripts/Makefile.lib | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57fdd32a..7e4f6671d950 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -299,7 +299,8 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-DTC_FLAGS += -Wno-interrupt_provider
+DTC_FLAGS += -Wno-interrupt_provider \
+       -Wno-unique_unit_address
 
 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
@@ -307,8 +308,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
-	-Wno-simple_bus_reg \
-	-Wno-unique_unit_address
+	-Wno-simple_bus_reg
+else
+DTC_FLAGS += -Wunique_unit_address_if_enabled
 endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
-- 
2.31.1

