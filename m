Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113155B2CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFZQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFZQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:33:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DB657E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:33:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so2084605edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVuYX13nI5OGMjjEITD7pC0Wd81Pv/YPWpmj93LvrA8=;
        b=WQPH7TPAF5nk0M0CIiemSalGkHAQpRXBYySfGbh8M92ShbwCKawZTWlZumKpVTA8ah
         2sHzR+Dvct2Tszp0DLViGXmm+VbQTTUjub/XvrjDSMy/CRwHA2TH5HMeSBa8yegZvb3p
         IlKqqHlfWBVNPsVOaT7hSh6fboWejbSz1LE48v+ZmoD5ow2ru26OmluujK+kzfldpTEP
         7YJdXI67F5Rp7wPmpUOPVTaZ7YTb6PjH2TUUHRRyx4vvsDGYsvJ6pnxwOiiQbc/3pSq/
         wY960MNg5DmHt8ehTFfyW7JHNwk92jhQlhdrLJlEFz1WK9Z/1zqTD2k3GDJ/xbVIQbJ9
         Uomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVuYX13nI5OGMjjEITD7pC0Wd81Pv/YPWpmj93LvrA8=;
        b=w1abUtIIxY8CVWEg/YpUVcv43EjUJUDAIsUMS/+JOf3ZTCovHOQtj8ThKRrtcHxy9P
         NHDo09goiZ6oMKz0LQkTnixPCF/HA3OKwuq5sSifYExs6n7OMBEjsDQxXINgnNINEREY
         tEAjfcAd3XFaS4SZMCiHFtpRHTYENLL6B+PXrUqycruOiyfpG5PmKWkSkVbGjj3EaGTh
         3EERUTyXBluEB8FoeA3Pq/5b5zsxIzG5JMGXO44LbIX6vlANM/3D+Y5aIwfpYDjsbrdO
         Li3Dbt9jS4ArTBEAqtCd1iO13mMuwm69GQeSwo5AU8Fs9J+57J3+4F5jAv7pVf6hzEPJ
         4fHQ==
X-Gm-Message-State: AJIora/BLGXSoON7UhLK+JL1QddofsRD4793wkyPHU6CVHzE2H/vUwHo
        Q51tF0onJGNSRkjzzOstwi7MyA==
X-Google-Smtp-Source: AGRyM1uJs7rgZJoZInvDvRsjNQuVqjd/QN9uwVR+kEH4w9BGFiyiQCHnGTed8Gkp5FmJ9A/WneZopg==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr11863215edb.246.1656261206306;
        Sun, 26 Jun 2022 09:33:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090613c500b00722fb3c99bcsm3930403ejc.203.2022.06.26.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:33:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] drm/exynos: MAINTAINERS: move Joonyoung Shim to credits
Date:   Sun, 26 Jun 2022 18:33:19 +0200
Message-Id: <20220626163320.6393-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Joonyoung Shim bounce ("550 5.1.1 Recipient address rejected:
User unknown"), so move him to credits file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 7e85a53b6a88..91a564c17012 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3491,6 +3491,10 @@ D: wd33c93 SCSI driver (linux-m68k)
 S: San Jose, California
 S: USA
 
+N: Joonyoung Shim
+E: y0922.shim@samsung.com
+D: Samsung Exynos DRM drivers
+
 N: Robert Siemer
 E: Robert.Siemer@gmx.de
 P: 2048/C99A4289 2F DC 17 2E 56 62 01 C8  3D F2 AC 09 F2 E5 DD EE
diff --git a/MAINTAINERS b/MAINTAINERS
index 19875f60ebb1..d208bf3b6f11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6695,7 +6695,6 @@ F:	drivers/gpu/drm/bridge/
 
 DRM DRIVERS FOR EXYNOS
 M:	Inki Dae <inki.dae@samsung.com>
-M:	Joonyoung Shim <jy0922.shim@samsung.com>
 M:	Seung-Woo Kim <sw0312.kim@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	dri-devel@lists.freedesktop.org
-- 
2.34.1

