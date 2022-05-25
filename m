Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C0D533FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbiEYO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbiEYO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:58:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF34AF31D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:58:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id DEE321F450F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653490705;
        bh=eBsjBjQv3sk3UpDCtqJWY59zZ/1tiXDyZ4h31E3V6uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj9NQjRZsmHCeUA9UZ1N3YDj/aLVJj04SpghF69HywUacUVSQQjUQbR5wwHhuVbmJ
         g55kHm08WFg8MNjX91AciJjjm5x9KLbUX0mRDY1148flVCHlmIBy+p1OwPGKPdh2Bn
         toz5w3/tDOcNMBk7QKBOjmQmQ++rzlnB/bOL4LvQHuigvaYh843130psT1U3OYwuao
         jrZbhhpOTxtrPLlxJdaVHGp62zI7eqMcKCU94omvJT8UI8FuJCWhkVrKHuNwPqn630
         OQ8SsPsT1AXgofkKEszU7dPhc9pX4m+xkEaM0fHGvTSN4/CQV6sIQK58GI5XliX0Wc
         XdiN6UkaBZNzw==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] drm/panfrost: Don't set L2_MMU_CONFIG quirks
Date:   Wed, 25 May 2022 10:57:52 -0400
Message-Id: <20220525145754.25866-8-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L2_MMU_CONFIG is an implementation-defined register. Different Mali GPUs
define slightly different MAX_READS and MAX_WRITES fields, which
throttle outstanding reads and writes when set to non-zero values. When
left as zero, reads and writes are not throttled.

Both kbase and panfrost always zero these registers. Per discussion with
Steven Price, there are two reasons these quirks may be used:

1. Simulating slower memory subsystems. This use case is only of
   interest to system-on-chip designers; it is not relevant to mainline.

2. Working around broken memory subsystems. Hopefully we never see this
   case in mainline. If we do, we'll need to set this register based on
   an SoC-compatible, rather than generally matching on the GPU model.

To the best of our knowledge, these fields are zero at reset, so the
write is not necessary. Let's remove the write to aid porting to new
Mali GPUs, which have different layouts for the L2_MMU_CONFIG register.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Suggested-by: Steven Price <steven.price@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 295bef27fb55..e1a6e763d0dc 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -127,18 +127,6 @@ static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_TILER_CONFIG, quirks);
 
 
-	quirks = gpu_read(pfdev, GPU_L2_MMU_CONFIG);
-
-	/* Limit read & write ID width for AXI */
-	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
-		quirks &= ~(L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_READS |
-			    L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_WRITES);
-	else
-		quirks &= ~(L2_MMU_CONFIG_LIMIT_EXTERNAL_READS |
-			    L2_MMU_CONFIG_LIMIT_EXTERNAL_WRITES);
-
-	gpu_write(pfdev, GPU_L2_MMU_CONFIG, quirks);
-
 	quirks = 0;
 	if ((panfrost_model_eq(pfdev, 0x860) || panfrost_model_eq(pfdev, 0x880)) &&
 	    pfdev->features.revision >= 0x2000)
-- 
2.35.1

