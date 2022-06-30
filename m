Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EA5612A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiF3GkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiF3GkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:40:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F622E9DE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:40:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o9so25178420edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YRjk+I1tOU+IE/aXdonB59E6sy7aNXVn8XEDauefqQ=;
        b=CrZpADPV9qdNUMyNR0WCBSyyHAhUtDgoCe0NWzMNFi7M0+7nQsggCNreJqHql8H0fW
         KlM22JXiYUrKpr5EJ6rPKnNYXjnARkmT5KB4NB/pCauB+Th4HD0raxHvl2s5mWV+3lCm
         zKjto8Ywx97VLoTHMQqZGZbOjpJ792BwqAqHE9tXD5QOOFY2LVyk6NqsGsJWAz7hziTA
         4Vb1pWTLsq7a1L0ezJz/P61elhmqGzWJ0UixxQAVgqv8biN+mLnS4NwvBP7Ly73s1ZyK
         PVskO49lOWESGRRH/ESlnaQ3KWrWC331sruD+A1XHMOePno/2SStnsvFH6rkf+tvQFSy
         LFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YRjk+I1tOU+IE/aXdonB59E6sy7aNXVn8XEDauefqQ=;
        b=4yX+E1mb1PESEklArxzTIidEc+wywITYuhLSUPcUN777EyPRxRLOku5cQ79cycTWma
         Zd3qN+wglFTSnnqZ2/Sh8pWe7fE1oT34B6FTV9r+gfHJnK6gtL/UwgqHGgPLtPox1Kpm
         YgloM+e5nGWk1V447w8YHySouYe2OUNuuaIJUDlnE5142p/eHqDMFaR9ptFk4RUIaKKl
         CcGDodfh7t8Bb4aQuYtMa4Kyf5Lj+motl9C8EdQ3bcxTMjJ/2Zf/3DBY0lchWZrz0tIj
         kqqFafAMWo0YBQmKJQaPepWrVUax9wAve6wHEWzz+XbdusoL2BGxaVgSDsFDlCH8OLK3
         6IAA==
X-Gm-Message-State: AJIora8TBIJDREnemw09HXSqTKn6dvQh1IT+M63tYeAjVskwLyEpFPtS
        p5mSE4CGvnxmsbPV47at48qEV1MAQbk=
X-Google-Smtp-Source: AGRyM1vRJhE//LmjjGmIeJh5OLMJsvM8XsEeSlrk8TO1LDZBLk7KUtQzYrQE/U3WiDU0tnr5r4BYPA==
X-Received: by 2002:a05:6402:50ce:b0:435:a2bf:e44d with SMTP id h14-20020a05640250ce00b00435a2bfe44dmr9465489edb.386.1656571213480;
        Wed, 29 Jun 2022 23:40:13 -0700 (PDT)
Received: from uni.. (adsl-146.37.6.170.tellas.gr. [37.6.170.146])
        by smtp.googlemail.com with ESMTPSA id g4-20020a170906868400b006fee98045cdsm8834469ejx.10.2022.06.29.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:40:13 -0700 (PDT)
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
To:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Date:   Thu, 30 Jun 2022 09:39:59 +0300
Message-Id: <20220630063959.27226-1-burzalodowa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expression 1 << 31 results in undefined behaviour because the type of
integer constant 1 is (signed) int and the result of shifting 1 by 31 bits
is not representable in the (signed) int type.

Change the type of 1 to unsigned int by adding the U suffix.

Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..44fbd499edea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -96,7 +96,7 @@
 #define CR2_E2H				(1 << 0)
 
 #define ARM_SMMU_GBPA			0x44
-#define GBPA_UPDATE			(1 << 31)
+#define GBPA_UPDATE			(1U << 31)
 #define GBPA_ABORT			(1 << 20)
 
 #define ARM_SMMU_IRQ_CTRL		0x50
-- 
2.34.1

