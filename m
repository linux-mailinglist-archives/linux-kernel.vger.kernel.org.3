Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB484EFB31
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiDAUVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350623AbiDAUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D422AC6E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so5810505wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSFleWzrdsVbfp76J0nZbw1NClVkvSpLHtH7RE9jkRs=;
        b=TjfHtdu71Zr1OsnHmJFojygbrytwG15ix1WIAML6l/Ksanl3O75cRxcUTNh35ZaLbt
         5fNy8B+wTUQe6R8WaM+AI8jMoDUanqa5/xrCuF2XEOBXl6StcncbQebtHfBVxUzeuWif
         H+3PzsQX6U7jqked9n9i4ypLM0Q47fdzUMkvjwFees4Ss+N7iJFdVtH1MSztF44r8fHX
         WjWjinZdGaVLjE0A9rEImoJQyDINEDbnDt4foQMSSv9/ah8gYWT4MxmFhKFUxqvEPJeB
         CeFCX+xAzDxbK2JstV4vUjprNh4SKgCk/ET0pB9AYLygB9xHKtqboIuHdWiVc+aHbR5I
         QNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSFleWzrdsVbfp76J0nZbw1NClVkvSpLHtH7RE9jkRs=;
        b=3vZqEv7BFzoRWa9bz84OoEvLachgFRtBybp9jDIe5Ens1lu64U6XP7n+sOxvmBYsDY
         knoqoUDpptICv7JoPFyW0I3CE9gOi/hHzqkS2hsueo7L6FsnmNkoKMmA/8mPOjiuW9Jl
         IbR+8y8RCXInsDPCC65PHT/auYKiB8ZQPoEOfTGFdRYeTNTVLUGIwwyPHO253YqKasx+
         J67rPrUFJgfVOY3+rGFQwth78YvNzqokyaIx/EHMJWnbaJmKXSBSwVijCoWEcS7cEzct
         oecfQE+oBqhHoLpzYX7Ej0BxytwKRexRZL8+tI03pE4jEsEYzZeTHWAmew583gcugO3f
         9DNA==
X-Gm-Message-State: AOAM530Qy/uoJ6iF7aAnlgTdqbw8ptRbm+mvqHxd8Ik2a+AB2/09ynRj
        XE/SWa1J4RT4OPqS98Gy/vxDXg==
X-Google-Smtp-Source: ABdhPJyVkLT0AZgz4GOL4/42AJH9cfjelfykjHRuCbl0zKR/Jvr/gHI+20fFVbGUT1YYYu2ml8ZsMg==
X-Received: by 2002:a05:6000:1d2:b0:204:7fc:d6c1 with SMTP id t18-20020a05600001d200b0020407fcd6c1mr8731359wrx.367.1648844302622;
        Fri, 01 Apr 2022 13:18:22 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 16/33] crypto: rockchip: add myself as maintainer
Date:   Fri,  1 Apr 2022 20:17:47 +0000
Message-Id: <20220401201804.2867154-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
index 64e15af4fab1..70e2e46d0710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16952,6 +16952,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
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

