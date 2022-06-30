Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07225623D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiF3UGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiF3UGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:06:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D663B568
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:06:30 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B62C76601970;
        Thu, 30 Jun 2022 21:06:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619589;
        bh=OhSkXrSS3JerWrWYxqJzBuqGxBc+62T8wuwKfrF4ixA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOtpIMLmVVflkHoW+a4+UtPNT5eRi4ZjuwXVuo85uWmlu096b8gf7QClBheALXclk
         9igku/L5dyRPv6NgkbZe72JCcBaacR0XzdiwREG8UDRG5nJzBFtAxfGn2D3BdCBNv6
         1ziDPRtsYgJf8mtzm5i8E0cvU09KkoLS5B0yEx1BJNyF3Qouyh+LJZGjJVmUaPz4Tc
         czL+FuDO6CReouCH8krC4Ak3TTX6ZPh25rYvQ/AAtEwL+CsI0AyLvukOTcr6DfGcm6
         CjvhC2S9STTKUthOUm87UH28xpGm/UBV0xifQJbHmz1y3E7w7CM5Kebr0iTfz4qfJN
         ouSfcwlqUN8rA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 1/2] drm/panfrost: Put mapping instead of shmem obj on panfrost_mmu_map_fault_addr() error
Date:   Thu, 30 Jun 2022 23:06:00 +0300
Message-Id: <20220630200601.1884120-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630200601.1884120-1-dmitry.osipenko@collabora.com>
References: <20220630200601.1884120-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When panfrost_mmu_map_fault_addr() fails, the BO's mapping should be
unreferenced and not the shmem object which backs the mapping.

Cc: stable@vger.kernel.org
Fixes: bdefca2d8dc0 ("drm/panfrost: Add the panfrost_gem_mapping concept")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index d3f82b26a631..b285a8001b1d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -518,7 +518,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 err_pages:
 	drm_gem_shmem_put_pages(&bo->base);
 err_bo:
-	drm_gem_object_put(&bo->base.base);
+	panfrost_gem_mapping_put(bomapping);
 	return ret;
 }
 
-- 
2.36.1

