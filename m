Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C157B36C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiGTI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiGTI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:59:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D0D6F7D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:58:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e15so19910855wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXCi2krvz5iV3RG6Br/eDWamgQsHstCKOav7b8DNz3k=;
        b=Lqqzbdkwfyi+vtGc9522INJrc1XedLAUHcf868Tzcx5CjEZZg0Zk7Fxxu3MTfxmGdo
         8roZB/SVYpiaTfAu2U5Vzcjn/+ZiNTRi5RznX0BRN8JfaeIg/tFvEIcQKfL92nLUmVpv
         q03r5K3015d578CfB1iKuU6mx4F8DAlPrNwlYbeh+kcIauy64sDXfEcdsKJEkgfoCxaK
         7zlWgmh7/lkUl40pHVULUbgPE3SMN19ylEbFw6i8g8HK9HEupedtKVy13/x6rdrny0u4
         9pqbRsPjDGSUoOIydm/FspUh6NFGVybxlKJ6jQkYH1u5Jx2QNnEBO7lqnD8swkX1lolz
         VRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXCi2krvz5iV3RG6Br/eDWamgQsHstCKOav7b8DNz3k=;
        b=6J3USwkFAhbDLGUszq0+JoM9rDHbKmqrokCZhXRzBhQJTvVQ/gtBh44DqO4osXzCj6
         oPYmarjQxNGsHaW5OSDCxOxl51rMWERd3OQZANMdUx75t2is0pcXGFPGRGWxOCQZqZYF
         kwglvOKu8mhAez6h7dGe0dy7YBlXJTUZzBqicKvOWBK9hZaJqdj/B2vvSmtAXznKLJFI
         ZQBDD2Red4KwOT7chRWJRk2goQpqlfV3uDcLmPIo6661HbXpKAB6+9LbHcCFdVIpS05b
         6Bd4ZG2aU4xPxwTfi1UwBklmmmo27m2Z1j5BxxSBhh+v5YOYJNdG60AKFPmoJLxtKw0F
         Dj8Q==
X-Gm-Message-State: AJIora/ANIPAOYvU2xC37fbTOqKU1qjjmDsFVjctMFYSBl+kjTj7D/BN
        2wnWakCVMOR19jlpt2NJVkF1hg==
X-Google-Smtp-Source: AGRyM1tpaC1pFfFaqkpKdkHi8zMKoU/eQiYQk69VtUESjQWualgkCNfDkjo/qmF4kT3kLruIfHYiBQ==
X-Received: by 2002:adf:e283:0:b0:21e:26fe:14f3 with SMTP id v3-20020adfe283000000b0021e26fe14f3mr8874954wri.98.1658307535476;
        Wed, 20 Jul 2022 01:58:55 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id f4-20020a5d58e4000000b0021d6dad334bsm340571wrd.4.2022.07.20.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:58:55 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     fparent@baylibre.com
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        will@kernel.org, yong.wu@mediatek.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: Re: [PATCH 3/3] iommu: mtk_iommu: add support for MT8365 SoC
Date:   Wed, 20 Jul 2022 10:52:13 +0200
Message-Id: <20220720085213.3803-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220530180328.845692-3-fparent@baylibre.com>
References: <20220530180328.845692-3-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Thank you for the fix.

The kernel would panic if you boot with this patchset because
bank_nr and bank_enable are not set in mt8365_data.

Please add this change:

--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1538,6 +1538,8 @@ static const struct mtk_iommu_plat_data mt8365_data = {
 	.m4u_plat     = M4U_MT8365,
 	.flags	      = RESET_AXI,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.banks_num    = 1,
+	.banks_enable = {true},
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */

With this change, please add my:
Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Regards,
Amjad
