Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069D58C629
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbiHHKQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiHHKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:16:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA76DF85
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:16:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e15so12044373lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSWhWVIMTdJmNV7dT9qbKSPZrPrjVzwG2y9B/jqm4bI=;
        b=wGcPgMyieO9cFvxTr79rS8AREemXIwc2wUFNElRfqEBdu9/xR5fsJEYyDhTDCpnFU5
         5XQthhQY2MGzL+JC/gVaFgeMpiHud6rGrIfIArCUVLUxFgpBiR+OT3G0n3jgDS9pGxqY
         24uzj13OFJGEuWH7D51hwsfbRXhSrGL61Ri87xWfoZEnwTjUmcKJ9Md6qb+El90tUsp0
         qRdiqyG1WDavMTJtM9WybGesHfpCnseXWIhvasJxOuzkhjQ3TTJkiYTsqugKCDTuV5WC
         0wvpdFIKSTfIb9VJwK6AdgDQfLBmXlRopfSfJRJn/8ekWknLSVL7XSE9mJMWcth8Vmo+
         KNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSWhWVIMTdJmNV7dT9qbKSPZrPrjVzwG2y9B/jqm4bI=;
        b=yUz/zL4yp+DsDdbM1fUsfn0kyBHGtZde7WpHY0Sh/8rZvmBn0zJtp/9nW05KrJAmXB
         49iwQI1dfg4pNRgLyNJ7yrcHkj8eNhEjRbGGDntWrk2n/S3YIO24wygex5O0Bjm9gfxm
         YLZp6QORWRDucUfVEFk6ninZU0KZNAh+vhBO3iufEtOzEnwy9Lkoub8Sp9xtvqsh75uO
         jUFbVy4fLbYjyv6MN0J5Go+s3GDtj9lxCAPtLbB5TmSIq3CWARLmB5sHo+bb6xMZvqiL
         c+dt7R4WaenAcJ+9SvcxmNoqc9h/840KoOgRbrlP1BZeZxOjvsWiPPdGQIgxvvOKKZZs
         s9qQ==
X-Gm-Message-State: ACgBeo3z6eIG8bnn28numJL+azF6rwrReoPWfocYFy10MsjQ33qRjnm3
        Nc4jI19DdW9FKxrvjogXz8Mmrg==
X-Google-Smtp-Source: AA6agR6WbH/uUBPu/P11zqkM//sK+ay53hJ55+HI/jBG+cpCuOejT7yCoIJ5LI688QEEuBe0vJLETA==
X-Received: by 2002:a05:6512:13a0:b0:48c:e86e:fe1a with SMTP id p32-20020a05651213a000b0048ce86efe1amr57526lfa.594.1659953779439;
        Mon, 08 Aug 2022 03:16:19 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:18 -0700 (PDT)
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
Subject: [PATCH 1/3] MAINTAINERS: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:24 +0300
Message-Id: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2180312fe0a4..423c81f8ba61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5369,8 +5369,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	drivers/cpuidle/cpuidle-big_little.c
 
 CPUIDLE DRIVER - ARM EXYNOS
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Kukjin Kim <kgene@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
@@ -12404,7 +12404,6 @@ F:	drivers/power/supply/max77976_charger.c
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	mailto:linux-samsung-soc@vger.kernel.org
@@ -12416,7 +12415,6 @@ F:	drivers/power/supply/max77693_charger.c
 MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 B:	mailto:linux-samsung-soc@vger.kernel.org
@@ -17973,7 +17971,6 @@ F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
-- 
2.34.1

