Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952585682BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiGFJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiGFJF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:05:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C55324BDF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so11453941wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRwoijrMVyavgOhukFjDrHIPhw2Aizqfl4rhNplf9c8=;
        b=EbUW1CorL++pA5HZwPVyXI6H8KXbBXQOWYFlcoiY3OJsBDxqinf63l+PavhtEofQAo
         W5ftr1cD08Cle/swB280sWtQPz3Biv445WGbK7hStJXcJbOz9fGedSzu8RCp7g5c3g9M
         jSSYhf9YXDACW67Yty9sEtXLo7REbXz6KWlh7kadZkKFilPJoloPNyfRXJUEU80sAnNj
         vs3lWwjwx51u0xAyJT3JjzzG6IfewPbFTHbbmQIFuKMeB/dBz+ti+h+gaRNVbaZzPR7P
         ANktB5poxuBZ1wpftcZabrVA2vcgeVzX3tfT8DtYQ/5Nrq6kDF60QW5/cWpMtLfKfuPk
         cRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRwoijrMVyavgOhukFjDrHIPhw2Aizqfl4rhNplf9c8=;
        b=js5a6xuEvZaYLvS8w7/H6D8FHWaIVXFhcGke4FgzHnwg2Y6tADT9x39mQ1T6zYM+rZ
         wvRRmnmwrpk6vU+wcHJDzghA0jGd86Wr5QnEWH5uLHeG7owS+qoHg+OXJ0hggtwYb79T
         Vh8Y3GZ08n0pDHLn3EZhCGTMcE+aDAXpKgchW54XZn2sA/FscPXeMgMn1fsXj1Kzt9Bi
         5U8ia6u8lf6bJ66QWeP8FldVfAyReZ58m4nhOtNNc7FbkB3vmXFAzEftcGaqUVNMhA5x
         lLsZUGYdcji+cF1WpVQNghVIdq6GrY0iO/ggrMErP/SVmoEzcOSewDR3vRvrkYqPR/v6
         geMQ==
X-Gm-Message-State: AJIora8Qdru2fr56KH0cmtc2wzwDAJVJrkDxVLELx0vKHaXdHoqjhWdl
        i4OH1TtCjBWB5kKUI7Gf+1Eqkw==
X-Google-Smtp-Source: AGRyM1uHRACL/yhNWelXRoGTrppw3+XTWYAI6/alcnOGghNjRVtWhGW3TsrfO52e6QKv1JVHStv7sw==
X-Received: by 2002:adf:e8ca:0:b0:21d:4ace:15b1 with SMTP id k10-20020adfe8ca000000b0021d4ace15b1mr24902118wrn.400.1657098289986;
        Wed, 06 Jul 2022 02:04:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:49 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 16/33] crypto: rockchip: add myself as maintainer
Date:   Wed,  6 Jul 2022 09:03:55 +0000
Message-Id: <20220706090412.806101-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is set as maintainer of rockchip crypto, I propose to do it as I
have already reworked lot of this code.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 392e59e9a03e..f8af07fa96fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17449,6 +17449,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
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

