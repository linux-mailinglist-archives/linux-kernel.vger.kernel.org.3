Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF25AD83A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiIERQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiIERQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:16:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA2520B1;
        Mon,  5 Sep 2022 10:16:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id az27so12152325wrb.6;
        Mon, 05 Sep 2022 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NET4x4RxN//LkpTQU1F+09NLgubloV7JTbO9k0HaAgY=;
        b=dPN1jPhO3Ox1DPE1QeeWh7fFaJiVMYKpZrIWkTLDULG8JKbE0BG12yAZD7LUspmR4c
         5L82zH3hO5Cg2erfw//Iou0IjhGaXHrFIgoC9/Bd7LO4sWlc6besZC8bfzIYaxVYMyvX
         sl4uEY+E81PXs4qkPVQTl9qNHHS68+Qj8PQYP01hmd4MPqOguVyRpNAMjRJ/iedES2uf
         NONZestwjbNy5HZxctzLKRgZWmkSDKtqdTAJA/2amlzQZaqnvrlOCT4LBPnGYJ2tg27B
         8mzBO+i1r7IiZ3NhusdNrP/Fzb0xEKXp/ExoQYRhpQTsRSff+MLQhH13Bo7MZySuc/B9
         6MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NET4x4RxN//LkpTQU1F+09NLgubloV7JTbO9k0HaAgY=;
        b=ZvSdSYwMkyblou9bEJYPYXv+syHIloqOPF9NxZBOOW7+HLVtScZiRyEd9yURscWfQS
         K50xIzA8DNWnpXUlDUYk+a7KFocYh0T2Bci4aaoXm1zObCWWj0i6kP2X8WgQ8iyBHtOh
         4bT3oOLlm5+mtMZ5DAV5ZdBw2bksZTuweYExnhKxTUdEoG1YXEIoCciucvbUoMwry4t5
         gCItUgIoJPhtQ5V08/5j13z7F6bIxwXZsdn+U4oaUCUu6z65TRdl7oKxMy3gnYngqaI/
         AghkrAW8c9hkYXdGv8PkDCYOUwczewMpKrGA3Eki6YI4fmzsT5LuENKB0scGJE5JBdio
         eBoA==
X-Gm-Message-State: ACgBeo0XtPPYiXVsV3JkShmw0i+fImGA9PG2eNDgV5/3jerJFZNxk11z
        Njqx196eHRKrUOGxOv5DgsQ=
X-Google-Smtp-Source: AA6agR58EyV1FL2fPMl6goDeHTg46yXYvXzdF0Scctk5jBM1pIRE9np9mQxUokCZZNVmHaVghq1qfw==
X-Received: by 2002:a05:6000:184e:b0:228:bb9d:f98a with SMTP id c14-20020a056000184e00b00228bb9df98amr1987643wri.479.1662398171522;
        Mon, 05 Sep 2022 10:16:11 -0700 (PDT)
Received: from Clement-Blade14.home (2a01cb000c0d3d00995730c36491d21b.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:9957:30c3:6491:d21b])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003a5ad7f6de2sm11437072wmj.15.2022.09.05.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:16:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the recommended one to configure and enable regulator
Date:   Mon,  5 Sep 2022 19:16:00 +0200
Message-Id: <20220905171601.79284-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905171601.79284-1-peron.clem@gmail.com>
References: <20220905171601.79284-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

devm_pm_opp_set_regulators() doesn't enable regulator, which make
regulator framework switching it off during regulator_late_cleanup().

Call dev_pm_opp_set_opp() with the recommend OPP in
panfrost_devfreq_init() to enable the regulator and avoid any switch off
by regulator_late_cleanup().

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 5110cd9b2425..67b242407156 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -131,6 +131,14 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return PTR_ERR(opp);
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
+
+	/* Setup and enable regulator */
+	ret = dev_pm_opp_set_opp(dev, opp);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
+		return ret;
+	}
+
 	dev_pm_opp_put(opp);
 
 	/*
-- 
2.34.1

