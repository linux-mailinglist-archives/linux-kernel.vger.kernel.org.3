Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF20567915
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiGEVCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiGEVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:02:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1437BA180
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:01:55 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 42B4040AA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657054913;
        bh=EI3mxEAHkgT2vU1OOl7PeFFTw9+zwdjdFkAEZQkp71M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LaSU8BF0aYfbkMCz++6iGei0YEOwNfhMl3BGSA7twFo6c+avOkeBdCsf2a7KUAMhj
         Yt53V4c8kYpRlhRtx3V40tFrvpNQNJdlsRrZM+W2hcwtHQb3WHEp1nersbr1pwmHT8
         6BKeRSKskxgxnYlJnLz66eNc2WwLd/qzsxd07Mjbm7+jlLf2pH/nSZIXZC7zG09tE2
         TJGx823quiVK2bvfNqtGDXA6yoaNe1IjQDOjIfOm78JVYlQXQEK6zUgIm6bJvY5tAY
         xeWSj6ekFbMJjKALeISBbX1zAdWX4ZrfL51ZzZAO/bBpkFuY6y0RIklc8PMUUEibgC
         nYVBrxrH8ZJYA==
Received: by mail-wm1-f70.google.com with SMTP id m17-20020a05600c3b1100b003a04a2f4936so7285949wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI3mxEAHkgT2vU1OOl7PeFFTw9+zwdjdFkAEZQkp71M=;
        b=71Lbp7osnMIlz35tLJwTcyeorjPmGqboJAf6AODDRh4SitnK0iqAqHbD+Kj1kXYiPb
         xB1qqeAAMBAY4zUJS7VadUMiXqsbJeRgHXnGTPr7BB9qQ0GnkuPuZTQ2zKj9oFLpKuXD
         2G4WYRqHdUfWylxRnsM1oK5EugoLt2uCi+PZlCP1SYLG7fJ0ylhDclkl1jZAnf2BMLad
         Vrf2n0AP6NxjQdk8UJylmCuwOWJZVV9SI53ZaN0RLP2qKL+oLJAIaxiMwGLiQgWVlWGN
         T0C4kRPqez5qsfh6WHuDjl3G/Fnu2od+QdUV03XshPRF/cm5Uog+jJYhkZgvVBnRbQ82
         NX4g==
X-Gm-Message-State: AJIora+1wG43ZKnr74r/nOpvNUnznWEO+LYUyeqtJvCsSg/AXBPENPl5
        ftKaMi8o+3cJnMH+sy/DeXsEAq8E8Q6Ybm4tDZXepwPiBu+gwtD01uDQQViPPXXBAn20qsbqWS+
        UgnIECByckAwmp83bMA9L5/Bh7OTYSljLTWGTISgL/w==
X-Received: by 2002:a05:6000:1445:b0:21b:a919:7d3 with SMTP id v5-20020a056000144500b0021ba91907d3mr33143895wrx.545.1657054909214;
        Tue, 05 Jul 2022 14:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpGtr585A4zBiBrqeprE38gSsAvDrw/l/xt/heeVYnerThl9ghX7+cZz4Gy93kTP7evrM9SQ==
X-Received: by 2002:a05:6000:1445:b0:21b:a919:7d3 with SMTP id v5-20020a056000144500b0021ba91907d3mr33143858wrx.545.1657054908987;
        Tue, 05 Jul 2022 14:01:48 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm2517667wru.28.2022.07.05.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:01:48 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/4] leds: pwm-multicolor: Support active-low LEDs
Date:   Tue,  5 Jul 2022 23:01:42 +0200
Message-Id: <20220705210143.315151-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for LEDs wired up to light when the PWM output is low, just
like the regular PWM LEDs.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/leds/rgb/leds-pwm-multicolor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/rgb/leds-pwm-multicolor.c b/drivers/leds/rgb/leds-pwm-multicolor.c
index eb67b89d28e9..da9d2218ae18 100644
--- a/drivers/leds/rgb/leds-pwm-multicolor.c
+++ b/drivers/leds/rgb/leds-pwm-multicolor.c
@@ -19,6 +19,7 @@
 struct pwm_led {
 	struct pwm_device *pwm;
 	struct pwm_state state;
+	bool active_low;
 };
 
 struct pwm_mc_led {
@@ -45,6 +46,9 @@ static int led_pwm_mc_set(struct led_classdev *cdev,
 		duty *= mc_cdev->subled_info[i].brightness;
 		do_div(duty, cdev->max_brightness);
 
+		if (priv->leds[i].active_low)
+			duty = priv->leds[i].state.period - duty;
+
 		priv->leds[i].state.duty_cycle = duty;
 		priv->leds[i].state.enabled = duty > 0;
 		ret = pwm_apply_state(priv->leds[i].pwm,
@@ -76,6 +80,7 @@ static int iterate_subleds(struct device *dev, struct pwm_mc_led *priv,
 			goto release_fwnode;
 		}
 		pwm_init_state(pwmled->pwm, &pwmled->state);
+		pwmled->active_low = fwnode_property_read_bool(fwnode, "active-low");
 
 		ret = fwnode_property_read_u32(fwnode, "color", &color);
 		if (ret) {
-- 
2.37.0

