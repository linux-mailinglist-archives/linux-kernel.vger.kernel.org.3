Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CF658C630
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiHHKQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbiHHKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:16:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E794101D2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:16:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u1so11975049lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWyHWpRZ1Kh32AMhlQIk7pyHBxJVf8IzTt5zqpwObhY=;
        b=MrROKyLJJ83f3Rr2mGc49Yse06wHtSB+UZ/fdnVkIROrdgd6G5U0BHv6wZCH0y/ELG
         AJ/m/Z/4Q7nc+d7bJBHuSjCXT9hyjQr6FsJpynKeTu7fw5UTIUgWnyB4ROV6D1v5kGxH
         vKTPX90RZrqPKvjtOl/EiKG71FvteMwCGWYOobnquUOQm8jIHa9oCCfQu+PvxlH5NrCW
         iwRFPN/ePSPg8LUGx4iyC/fG14Oske8ipp/nAcCYTlFCM7MokuuK008QWNlC2JyW29WO
         FHjxT9M+nzbkNOPuHVaA9LMMz6lcaIpnRfAwa8DyvaqiF6QwEl9fAi1PbdzqmFR0fH97
         EVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWyHWpRZ1Kh32AMhlQIk7pyHBxJVf8IzTt5zqpwObhY=;
        b=EwdwjRMcu5yT2KMjXgxuzUDOdjRRNF18soshY7hMBBtoR51COUtHbsWGDvxFGIY9Un
         kWoqcJqCyKYP4E+DMPnYXbfq0kntFB2bJodV5wKYYSl+X21Y9jloz530K7APC15wA9Zp
         UFkVYqe7hPjVgH5Fn/cIZhvAZT4BeNuM3YsryjdQTep4SKfDjUdLXkCSlXf54XcMM+iK
         6NruQ0OgrQrUYPx9aTj1czNnTkVEwjtr4i292iIsndQ7LK76wxkW2ewQ/ljyN8Rp654Y
         IvLmMW7vGRegQevTdD1F6NydSLSvOS6MLO/F+IqfYOuilMTS56ShM8tm+P3XIe7uxLdD
         l0lA==
X-Gm-Message-State: ACgBeo09GoJ63hG0+Z56I5fm2DSXhCWzYky6hsF1JgfHXy+SD+lePNYO
        EiJjR2TpjFRnNTeqOWK5H7TzNA==
X-Google-Smtp-Source: AA6agR7cfm64Y6GBFeSO18v6MzV1E5WMXn0USHffiVixm1IpLgTYtoCxMdxCHJ8TpfOA7GHPubr/eg==
X-Received: by 2002:a05:6512:2349:b0:48c:ee14:7fc with SMTP id p9-20020a056512234900b0048cee1407fcmr1125838lfu.71.1659953780871;
        Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] MAINTAINERS: pwm-fan: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:25 +0300
Message-Id: <20220808101526.46556-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
References: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
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

Bartlomiej's Samsung email address is not working since around last
year and there was no follow up patch take over of the drivers, so drop
the email from maintainers.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume that if other change was preferred, there was quite enough of
time to send a patch for this. :)
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 423c81f8ba61..4832b317fe05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16529,14 +16529,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/pwc/*
 F:	include/trace/events/pwc.h
 
-PWM FAN DRIVER
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-L:	linux-hwmon@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
-F:	Documentation/hwmon/pwm-fan.rst
-F:	drivers/hwmon/pwm-fan.c
-
 PWM IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

