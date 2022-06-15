Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5954C26C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbiFOHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbiFOHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:08:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF7C2899B;
        Wed, 15 Jun 2022 00:08:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso586951wms.2;
        Wed, 15 Jun 2022 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cg9l8Dw5kbbaSW9iT/X0V7LIeInZuZuCPQHiyAl6l3A=;
        b=HSMAYc+f0kXflnPy03sKUdNFiTOuQZ3iMe+rh62nN4LXiC5pFvFZkSxmi7+eXnkHZZ
         13FhRm49eumOmOzDZ0vi4jZNma5HJZEMeR1VPXqgNF24XkIWyzsLtYcrg2tgSAC56nng
         gYGbLWNqfhVJnIaZjqy7RRnUDw9V8BlR6LYF2hEZF851bJbi2O7gO/JOI7TgAnQG0lzj
         u7TGYOqa0C3DHVmfV9Fln7dswaHmqahG5AKzWlkIhaMXmWofXp9KWk9odTXLBXfcwNSP
         TnIz0CSDc841W3GpniUIrkM3Rb5HhkH3SK3Ljyhz3aH4vduqqisogxMF+bg+Ms+l4ZFp
         2tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cg9l8Dw5kbbaSW9iT/X0V7LIeInZuZuCPQHiyAl6l3A=;
        b=IOV2NrtA3yD/HfCbeU1wtynsgHEW91AOfqcLSNBB+rK/c61HPuim/ruh4taLHy5SH6
         eTEfU2ZlGzFizd/XOu+iCgPV5TEuPKeg1hSY7zoC54ILpgKfirEV+6d9hyrxVezWLKit
         nhwyZGhp8HV4vmYMEgHBGfoNXm5ZOyfs3uzb28YA6Wk68/rN9GLpLBft0lNGUZbvhaYq
         RKNLhmDVpNX4zqhMwz7ESIJG2olCeYYJPZOXp1H6r7EJsPtpaAg9gX3jkzTR2T0hLuXr
         xpmrfFAsWLuFxPIfepAKN8YpsUBfac+hqBGJmQppnCZv1EIqgptwI4dK8bQwFXfRq+c5
         qotQ==
X-Gm-Message-State: AOAM530jslE4D4cILVjyYFg5RW/phCL4LCBgrZGV24RAqZdrJe7nboK6
        DmJFISaFNnXyNlAOgf6b0pHZIqDk/Sg=
X-Google-Smtp-Source: ABdhPJz8/duArN33thJ3UidKgsyl5Z3GS7szdDEqz4eiDcM555QgOBVw1pc9kTlG6+JTXnZMKPrvTA==
X-Received: by 2002:a05:600c:240c:b0:39c:5b4b:f3c7 with SMTP id 12-20020a05600c240c00b0039c5b4bf3c7mr8244118wmp.127.1655276914191;
        Wed, 15 Jun 2022 00:08:34 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4809000000b00219e8d28fb1sm13814277wrq.57.2022.06.15.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:08:33 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: mstar: Add pwm device node to infinity3
Date:   Wed, 15 Jun 2022 09:08:12 +0200
Message-Id: <20220615070813.7720-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615070813.7720-1-romain.perier@gmail.com>
References: <20220615070813.7720-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the pwm device node. The PWM being able to
work with the oscillator at 12Mhz for now, it shares the same xtal than
other devices (rtc or watchdog for instance).

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity3.dtsi b/arch/arm/boot/dts/mstar-infinity3.dtsi
index a56cf29e5d82..aa26f25392d0 100644
--- a/arch/arm/boot/dts/mstar-infinity3.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity3.dtsi
@@ -67,3 +67,13 @@ opp-1512000000 {
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
+
+&riu {
+	pwm: pwm@3400 {
+		compatible = "mstar,msc313e-pwm";
+		reg = <0x3400 0x400>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+};
-- 
2.35.1

