Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEF4FFEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiDMTK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiDMTKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:10:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC906E8FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t1so3996418wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EUIIfE60m4fjWffrZnRhJkHwQAH6pvzsFNjcyOjc+M=;
        b=OhXrjpQ7TkqgTzvU861G+Pk5dZhNtBHUkuXDGbH/m5gtuoYcPwFTR4OwwwHQTCSKnD
         rPUg/K6BusXVCrYS2aYITzkfnsnby/5ACm8IjqxOvp+N/WtQlZzLgtr+ERFpOuZAy7j6
         JTmNcjTrMIlelYCRL7+TiZ2qyNnWRVxPjoPu27CGJfbpn6TgSTYAsv3coIediTDo62Y9
         qxRqoonC/Mrw0nd2Oj6/4ZvTPgKdn+XVoXOkqZbWuvyANRDY9ph8dUjF0mAYCTL59Soi
         oa2+pkJhoxKe9lPo9VOtwZCvEs4niAxAe6+tepMftrJO6m2TmL995WBhKtSdLTumifXf
         0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EUIIfE60m4fjWffrZnRhJkHwQAH6pvzsFNjcyOjc+M=;
        b=nxDMt6szwJVl6O6CTTQcVz1FQgKQ2KQLD8vZjshIc2MXBlelHq8A36TkpUXAN1W/81
         yu9vNbn6KNFvcDWPpDOAaQzW9OKsKE+l5q6EYgcH0n3EsFnrXOdA8Q/tzbPserGjfVQa
         KqZ3/CW5VsAj8MO5j+raB6csSTzRFsLZQY2BFHL2hz0brtpT3xdjDtIzOf6iQWzaJArr
         3SuwauHpj0jqTIe0NLRq6rbEErQ+R0kroLzJPlZbqY8nQNOJIDb5dk3dQNRepDJ2gVu8
         sSlkxMnMVBzJRSFXeg3SMztN43BW050b1d64X9I2ZrMoSImVXcI71JZTkkCgAaVh8mWR
         RY0Q==
X-Gm-Message-State: AOAM531t1lJUjCM0cNrGqfi1HbJZhPsQ4XYfFvVooEkLw0bBB9nn1jTn
        An0SuCYftPJV9+Iey7RVFVPdaA==
X-Google-Smtp-Source: ABdhPJyd7sC1T0PJCNTlLw2E2XQeYDeV+5s9CziMq9ZGLP70JZ+RghahoRyCVXcIK5APO0x4BRk/MQ==
X-Received: by 2002:a5d:558e:0:b0:206:f7e:4634 with SMTP id i14-20020a5d558e000000b002060f7e4634mr242269wrv.662.1649876858616;
        Wed, 13 Apr 2022 12:07:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 16/33] crypto: rockchip: add myself as maintainer
Date:   Wed, 13 Apr 2022 19:06:56 +0000
Message-Id: <20220413190713.1427956-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is set as maintainer of rockchip crypto, I propose to do it as I
have already reworked lot of this code.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1699bb7cc867..4df40a40bcdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16966,6 +16966,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CRYPTO DRIVERS
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+F:	drivers/crypto/rockchip/
+
 ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
-- 
2.35.1

