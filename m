Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1828349D108
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiAZRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbiAZRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75629C06174E;
        Wed, 26 Jan 2022 09:40:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so296796wms.3;
        Wed, 26 Jan 2022 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPag3SRsfFtkptHhSLA0oo2r5XSMa9TnGzL6mvwwMRo=;
        b=a8JwmXmFvUYYOUX9AvgiUtYHfiu+1fdenrXnR+SfreMqTzm8A9WPEOq5RizyrX2Q6x
         c13XxOIwydhRkbAvz+SzuruNXGL/hBycDD4JeEJLQUPDXBQM0XJj89pfhn4jPXSzTNSg
         mTEO/afksAy1tR4bjCTe66InghHWW4fxLxbv1CXrVQE4gRTjBnIvz9Dqo2//Z0UWMOf0
         n6bAWNmrIZLkNjnwo1yWlopYGPkxZucEIb2aMaZNgXI1z1mgA8NsZiYS5PR6umZ88Xjs
         4PfQ69EX0EucA8qe2hphV9fq+NIS6pPKfxjBoewDbl2GWMhkuNc667V/0+JXrVD+TXpn
         GqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BPag3SRsfFtkptHhSLA0oo2r5XSMa9TnGzL6mvwwMRo=;
        b=tYdTNdh9Nyd08cenImr/7i2TJNjvkv77iHw+mLwxx1ODcIWgxExJslAdb/nOYtgVmH
         JVDyliBhZGApQRZp+77PfvHZk8ohmmqIAJjX6WOFlfcICpASrw0tAPNvfOI9ylKPVfyW
         Zsjd/Ip/kH8a+WA4FcJTabgGtcuAOKJTjGKP1G5J8XIy7krlm44MUw76742pnahevaLd
         jvy5sqDngurPV+Xn22Y+n/eJB+KxBqm/WgKeVf8yVajgCICpda36X9DmMIkJ1tnHXJtB
         EFu/aoF+yef0LgZM/lf2n0XBiwWU6OV3jKuK/cW95OAZkkOg64cLDUFNwiUoy1jHCl9q
         L9lw==
X-Gm-Message-State: AOAM531/jACT1CkBR+UF7DYWHvn7XYRdjdQ+HdCM3b07wQh3DSzdlwkn
        k3no+bxcz+/omb4/nWwF7kgSNR82+GU=
X-Google-Smtp-Source: ABdhPJwl0Bf5Qu7FXpfRAgFIbFkiihwRjENkAog38O9gx4s/dJQq+Mph8DeT/sn7637JV4ixeODgSA==
X-Received: by 2002:a1c:a5d0:: with SMTP id o199mr8327491wme.65.1643218828949;
        Wed, 26 Jan 2022 09:40:28 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:28 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] clk: starfive: jh7100: Support more clock types
Date:   Wed, 26 Jan 2022 18:39:52 +0100
Message-Id: <20220126173953.1016706-7-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the system clocks there are audio clocks that combine both
multiplexer/divider and gate/multiplexer/divider, so add support for
that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 26 ++++++++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh7100.h | 15 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index a6708f9ebf4c..691aeebc7092 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -534,6 +534,27 @@ static const struct clk_ops jh7100_clk_gmux_ops = {
 	.debug_init = jh7100_clk_debug_init,
 };
 
+static const struct clk_ops jh7100_clk_mdiv_ops = {
+	.recalc_rate = jh7100_clk_recalc_rate,
+	.determine_rate = jh7100_clk_determine_rate,
+	.get_parent = jh7100_clk_get_parent,
+	.set_parent = jh7100_clk_set_parent,
+	.set_rate = jh7100_clk_set_rate,
+	.debug_init = jh7100_clk_debug_init,
+};
+
+static const struct clk_ops jh7100_clk_gmd_ops = {
+	.enable = jh7100_clk_enable,
+	.disable = jh7100_clk_disable,
+	.is_enabled = jh7100_clk_is_enabled,
+	.recalc_rate = jh7100_clk_recalc_rate,
+	.determine_rate = jh7100_clk_determine_rate,
+	.get_parent = jh7100_clk_get_parent,
+	.set_parent = jh7100_clk_set_parent,
+	.set_rate = jh7100_clk_set_rate,
+	.debug_init = jh7100_clk_debug_init,
+};
+
 static const struct clk_ops jh7100_clk_inv_ops = {
 	.get_phase = jh7100_clk_get_phase,
 	.set_phase = jh7100_clk_set_phase,
@@ -543,6 +564,11 @@ static const struct clk_ops jh7100_clk_inv_ops = {
 const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
 {
 	if (max & JH7100_CLK_DIV_MASK) {
+		if (max & JH7100_CLK_MUX_MASK) {
+			if (max & JH7100_CLK_ENABLE)
+				return &jh7100_clk_gmd_ops;
+			return &jh7100_clk_mdiv_ops;
+		}
 		if (max & JH7100_CLK_ENABLE)
 			return &jh7100_clk_gdiv_ops;
 		if (max == JH7100_CLK_FRAC_MAX)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.h b/drivers/clk/starfive/clk-starfive-jh7100.h
index 8eccd8c0a746..f116be5740a5 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.h
+++ b/drivers/clk/starfive/clk-starfive-jh7100.h
@@ -70,6 +70,21 @@ struct jh7100_clk_data {
 	.parents = { __VA_ARGS__ },						\
 }
 
+#define JH7100_MDIV(_idx, _name, _max, _nparents, ...) [_idx] = {		\
+	.name = _name,								\
+	.flags = 0,								\
+	.max = (((_nparents) - 1) << JH7100_CLK_MUX_SHIFT) | (_max),		\
+	.parents = { __VA_ARGS__ },						\
+}
+
+#define JH7100__GMD(_idx, _name, _flags, _max, _nparents, ...) [_idx] = {	\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = JH7100_CLK_ENABLE |						\
+		(((_nparents) - 1) << JH7100_CLK_MUX_SHIFT) | (_max),		\
+	.parents = { __VA_ARGS__ },						\
+}
+
 #define JH7100__INV(_idx, _name, _parent) [_idx] = {				\
 	.name = _name,								\
 	.flags = CLK_SET_RATE_PARENT,						\
-- 
2.34.1

