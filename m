Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517EF50EE38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiDZBtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiDZBtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:49:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2124D32073
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so16531490pfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3d3BRK+rsV0H1MEivwe2mn7frrdSPcB90v4KWuBBaQM=;
        b=ej1HcqsW5KLOqLNaCI4dLiEgQGM6O8Sfb90ZyxBBlRzwTORd8VmkMrjWYneM4Mc/X0
         6BgPOZ3i7s2PP3A12OBzv+lLyJJGIhm+pJtczgpiXmD2gQA6tnidUruHBfeY9f0iM3aS
         S/exhv1wqe+HQQjOWOak11BEW/weBv32YC2ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3d3BRK+rsV0H1MEivwe2mn7frrdSPcB90v4KWuBBaQM=;
        b=0MkZ8CuTYPv8NSSVtu3TPAIcnKi+OqcELalfKTcKwAf1oKcWxQ+bhY+qe5fybDN9i4
         0t1OUv9LKNCeiRBTmgOLNDIiR2OOP1xxBoGxLP8mbvSM+XTznHQnmJqcB+1dogtyWMqE
         MR1Q2G7yblWMdD0KKeiLVi9H2vne9vCwFR5hfr6GDYp7VJutDPHA3HfeUmIVa/recsGe
         XgRgm4wCxemKTjKfJjjU8DoqXf3OFZxU88hy8I4HcNHauOVH+G+RLUxvLyP/Gj/2xvmR
         wwy5VsZqsEsi2F6DvzFO1rn1OHfL/gPoM40/xfQZ95irAD2kESBt63wmWxo2BB5Ec39g
         zFzQ==
X-Gm-Message-State: AOAM531tblCe4e6+CzN9WTTvx+dO1AVGHd794mCfLdn28tO0fVlmPQOq
        6Zh8a72pMRZMx6Edd9vSzqsZpw==
X-Google-Smtp-Source: ABdhPJw/aUTO4Volur0lD5eMJniKHG/Naw8BdeIAI9Zc5hYF0pNjW/rmonH1Z7xjPgDTBUflvk6nlg==
X-Received: by 2002:a05:6a00:138e:b0:50a:9503:44a7 with SMTP id t14-20020a056a00138e00b0050a950344a7mr22021953pfg.75.1650937556699;
        Mon, 25 Apr 2022 18:45:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:84c6:2d6d:c16:1a1b])
        by smtp.gmail.com with UTF8SMTPSA id i11-20020a654d0b000000b0039d82c3e68csm11169010pgt.55.2022.04.25.18.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:45:56 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 2/3] soc: rockchip: power-domain: Replace dsb() with smb()
Date:   Mon, 25 Apr 2022 18:45:43 -0700
Message-Id: <20220426014545.628100-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220426014545.628100-1-briannorris@chromium.org>
References: <20220426014545.628100-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear if these are really needed at all, but seemingly their
purpose is only as a write barrier. Use the general macro instead of the
ARM-specific one.

This driver is partially marked for COMPILE_TEST'ing, but it doesn't
build under non-ARM architectures. Fix this up before *really* enabling
it for COMPILE_TEST.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * New in v3

 drivers/soc/rockchip/pm_domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 1b029e494274..cf16ff9b73b3 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -178,7 +178,7 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 		regmap_update_bits(pmu->regmap, pmu->info->req_offset,
 				   pd_info->req_mask, idle ? -1U : 0);
 
-	dsb(sy);
+	wmb();
 
 	/* Wait util idle_ack = 1 */
 	target_ack = idle ? pd_info->ack_mask : 0;
@@ -285,7 +285,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
 				   pd->info->pwr_mask, on ? 0 : -1U);
 
-	dsb(sy);
+	wmb();
 
 	if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
 				      is_on == on, 0, 10000)) {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

