Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1A4C7927
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiB1TwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiB1Tv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:51:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE71113DB5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:50:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso101694wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dt2TIAnb0hgPqs5E3ITetwBw03oi/KH3u9qpCDk2YIc=;
        b=CzppBtYiraF7Cxt5R+XptC5OZH8T2dPKrJJAwATivyW9xyYv8ML0Zpo3RRuWvWj1b9
         sbztzFqB0fhBZriWexQYXobqmEYn27dfo2mtBneBPeUY8xoGIm5tqPk0EKcATihU6sim
         FI7j94CdJvpfOj8JJEXQR8FkJw1TSp1IDUdvLFNCsEhuWza8Wd9QGUfUDQwbkRAi9eFw
         ZDv7gSrroAHp2d9LQewq1b5E1hnDwirl8RlAvKWjzMkPXLjN357U5NYIPdhRgypkXnLB
         09LgnjK7rRLBbGsv0vqg02YaDnMI1uoGntf3wbcilLWtye4Fy9lrYqdXg9mkX1jalXpX
         pVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt2TIAnb0hgPqs5E3ITetwBw03oi/KH3u9qpCDk2YIc=;
        b=k+yxjbtjR3Emsymj78v+jnr6UYMgdFVNyEsXgqmTVuWzChVNxR7BscfxieWB9GOs2x
         GiNs6ZmPmkbDdfKVvlmPQ8xadQ4+5OVqJdaA5lykbz7Z8CFNhqwouJAYlQXG+QemymtV
         8gRrYfbWuNemc8W/DS7hGyGVpA/F36DpljescIfnZ4JLSFwS5ectP+evutscRplVGazH
         lR0LBPU4ZAHt5mZT+WdPrBu4+ty1SLsCAYXE8wfGn43B2Ohj44/U4L8+v//rJxik7Lan
         mnzK8LWl1rmkI+CYXRQVh/i0tccbGUN341+5LD2M0lMlDPVZoolQ16oCPMals64tJ2ex
         DkJQ==
X-Gm-Message-State: AOAM531PkhJrw7Gemf76XYAC12LdtKJ1mE6kngdEaTTwX/QmEr7slkLW
        9v1QY/8WefL5QNnKm7cKSiX6u780qSY0yQ==
X-Google-Smtp-Source: ABdhPJwxapsCu4s5/opiNJQ1tveKgMBQM6nggLxpg5XCcMpIT8JTP2LSc/eToaPcGR8ftKaNzRfOoQ==
X-Received: by 2002:a1c:1907:0:b0:380:f6ec:4daa with SMTP id 7-20020a1c1907000000b00380f6ec4daamr14950116wmz.50.1646077255350;
        Mon, 28 Feb 2022 11:40:55 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 16/16] crypto: rockchip: add myself as maintainer
Date:   Mon, 28 Feb 2022 19:40:37 +0000
Message-Id: <20220228194037.1600509-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
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

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db8052bc1d26..b1b2303ac285 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16828,6 +16828,12 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CRYPTO DRIVERS
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/rockchip/
+
 ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
-- 
2.34.1

