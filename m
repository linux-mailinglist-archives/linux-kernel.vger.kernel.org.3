Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEE483463
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiACPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiACPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:46:55 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5645C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:46:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w7so24588668plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGd2tehqllUPXzMzPxa45XALLgMArX9xtGYlZrmeREY=;
        b=WvtxB1ung9NzUxIWNt+S8bbVr7Oo/WYuoF1OH9gg15H9VGzCZDxkFMYB6WJB0j54PM
         Eb9HjuoT5rA5xMB3aY1+5NI5/68dutfwSltaz1WOMLZGjc9BOAqXKEF7NDoZRUGGmm7e
         u3crLy0GnKkTWuD2EUHEusSLAhntfBkG3uAYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGd2tehqllUPXzMzPxa45XALLgMArX9xtGYlZrmeREY=;
        b=yiKlm8+GYYzKH7LOW1PZz4UGsuJ0M+nAVAQprYtNK+jbIHo+0opmz9KLGz+W6sodpw
         RbWmcLvyhgUs6z7CrVWRnRjEsO0g73dP5sUN0v+D1xvz06d90RlUZhxf+/0AO+qtf/yP
         k/2ZiE4sQ2f14jogN7LF0urIFV2BapkaBYJ1MudpDGAg3C52w/N0avqI8hVXsuQw0tE4
         XBkBc10wnGNtIM7iNgw41CSSrh9EO0vHJhjKpGopVyQaU7Hh3Cytm07upsoya5Il8FRE
         1/Z+9RizSllzMUOqvlss6vNsUDVjFDe9/jB01/eB3e+bW1XWQzkop3ztAS3st4i4/3fn
         c7AQ==
X-Gm-Message-State: AOAM533fIEqFfbbxCOm9SwReD98RQqpkPEeLAfEi8o+9W6T9qMW9RoDf
        /TKBqfhchu82CZT5q5WOpxyJqg==
X-Google-Smtp-Source: ABdhPJzUBnOMa3u341HSV7yD1MmYO/74k9hrxYCcrAiKRckCANPf4WLP8hN5nqUEW6OFbqayue0rVQ==
X-Received: by 2002:a17:902:8e82:b0:149:b26a:b9c8 with SMTP id bg2-20020a1709028e8200b00149b26ab9c8mr10850854plb.143.1641224814429;
        Mon, 03 Jan 2022 07:46:54 -0800 (PST)
Received: from localhost.localdomain (lfbn-idf1-1-1088-186.w82-125.abo.wanadoo.fr. [82.125.191.186])
        by smtp.gmail.com with ESMTPSA id l2sm41080153pfc.42.2022.01.03.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:46:54 -0800 (PST)
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     linux-amlogic@lists.infradead.org
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: meson-g12a: add more pwm_f options
Date:   Mon,  3 Jan 2022 16:46:14 +0100
Message-Id: <20220103154616.308376-2-gary.bisson@boundarydevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing PWM_F pin muxing for GPIOA_11 and GPIOZ_12.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index cd9656b13836..d182a575981e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -283,6 +283,8 @@ static const unsigned int pwm_d_x6_pins[]		= { GPIOX_6 };
 static const unsigned int pwm_e_pins[]			= { GPIOX_16 };
 
 /* pwm_f */
+static const unsigned int pwm_f_z_pins[]		= { GPIOZ_12 };
+static const unsigned int pwm_f_a_pins[]		= { GPIOA_11 };
 static const unsigned int pwm_f_x_pins[]		= { GPIOX_7 };
 static const unsigned int pwm_f_h_pins[]		= { GPIOH_5 };
 
@@ -618,6 +620,7 @@ static struct meson_pmx_group meson_g12a_periphs_groups[] = {
 	GROUP(tdm_c_dout2_z,		4),
 	GROUP(tdm_c_dout3_z,		4),
 	GROUP(mclk1_z,			4),
+	GROUP(pwm_f_z,			5),
 
 	/* bank GPIOX */
 	GROUP(sdio_d0,			1),
@@ -768,6 +771,7 @@ static struct meson_pmx_group meson_g12a_periphs_groups[] = {
 	GROUP(tdm_c_dout3_a,		2),
 	GROUP(mclk0_a,			1),
 	GROUP(mclk1_a,			2),
+	GROUP(pwm_f_a,			3),
 };
 
 /* uart_ao_a */
@@ -1069,7 +1073,7 @@ static const char * const pwm_e_groups[] = {
 };
 
 static const char * const pwm_f_groups[] = {
-	"pwm_f_x", "pwm_f_h",
+	"pwm_f_z", "pwm_f_a", "pwm_f_x", "pwm_f_h",
 };
 
 static const char * const cec_ao_a_h_groups[] = {
-- 
2.34.1

