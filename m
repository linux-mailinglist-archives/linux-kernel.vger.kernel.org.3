Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D71560ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiF2UBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiF2UBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE9F96434
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656532867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AmJoOaiBEwTvOlBR6tPF1TnQpeu1brYhbJVBBtBBv/U=;
        b=C0+2F1mID3CZn9g4uvq1yWsoO0ey4MAvy22Y91s5Wi7qczKvAcmUzxvhATE/lG0l7TySgc
        O4tQgFqP4rL4jINJ73vvnx3bF3lFPwV/s9SglLrm0FXmbgARlzebxq2q2i29ujXgXZy4Nn
        k1PCMx+zHvv3m2rN3kAx2xKz5Lk+0Ng=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-Q3LAvtZpNRWpE1cR73JaGA-1; Wed, 29 Jun 2022 16:01:05 -0400
X-MC-Unique: Q3LAvtZpNRWpE1cR73JaGA-1
Received: by mail-qk1-f199.google.com with SMTP id bi36-20020a05620a31a400b006a79f0706e5so17206139qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmJoOaiBEwTvOlBR6tPF1TnQpeu1brYhbJVBBtBBv/U=;
        b=trdPuyL4bhF8N6hVVlA3S+Rt5t80Lqp+/ZIsiBRoJ793p9TpcZ6pMDEBg2MCANtOTJ
         qBA1bEKVFZTMztMlhK5luOgPO8mwubKRzhhZ03lfN9ZmAdJwtujfZXXfN9J3ik1+SvP0
         z4vVqUECnUTRqbm+VI2Y9y6OKMCiwajbYBKMEhTPZ2vG5+AVboUgcEah4EWYvV8Ka35X
         FHps43shb878OUYDngS256YJYjVihxatchkT7K7jwipbSZF0rZL9K7hvrvu2zwREYacQ
         /n6ab0lKbIRmjc+IVprQTfk/Q9SR2JaTw01QtmXznmiEfiu0Cw9v7D+heC/c7jqdO2Lp
         x1Vw==
X-Gm-Message-State: AJIora8/QVkkjk/5+uwjGthojh9jF4x58KyGVF1DKQdVdxt/HfmnZkmO
        6fUkoZnCueQu5UFmTHbYUSOPjjKnZ0kr3Y+UsziOkrgNxKnDPaKiRW8iFxFaZE1Vf0gLSwEZ3MA
        /KpEKaJavU/YlpqRdSN0pIfxN
X-Received: by 2002:a05:620a:4502:b0:6a6:deef:75ac with SMTP id t2-20020a05620a450200b006a6deef75acmr3558705qkp.69.1656532864849;
        Wed, 29 Jun 2022 13:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vC964FyYrkteZarVUW140Wh6U7bPa3vZk++aoOryCFqOhwM79b4t1kGovUXgTXVmT/qMkHJw==
X-Received: by 2002:a05:620a:4502:b0:6a6:deef:75ac with SMTP id t2-20020a05620a450200b006a6deef75acmr3558668qkp.69.1656532864430;
        Wed, 29 Jun 2022 13:01:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006afd667535asm3280362qkp.83.2022.06.29.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:01:03 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     emma@anholt.net, mripard@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dave.stevenson@raspberrypi.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/vc4: change vc4_dma_range_matches from a global to static
Date:   Wed, 29 Jun 2022 16:01:01 -0400
Message-Id: <20220629200101.498138-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/gpu/drm/vc4/vc4_drv.c:270:27: warning: symbol 'vc4_dma_range_matches' was not declared. Should it be static?

vc4_dma_range_matches is only used in vc4_drv.c, so it's storage class specifier
should be static.

Fixes: da8e393e23ef ("drm/vc4: drv: Adopt the dma configuration from the HVS or V3D component")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 2b014b6332a6..292d1b6a01b6 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -267,7 +267,7 @@ static void vc4_match_add_drivers(struct device *dev,
 	}
 }
 
-const struct of_device_id vc4_dma_range_matches[] = {
+static const struct of_device_id vc4_dma_range_matches[] = {
 	{ .compatible = "brcm,bcm2711-hvs" },
 	{ .compatible = "brcm,bcm2835-hvs" },
 	{ .compatible = "brcm,bcm2835-v3d" },
-- 
2.27.0

