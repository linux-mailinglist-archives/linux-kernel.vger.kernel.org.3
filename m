Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224D859ADE4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiHTM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbiHTM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:26:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADC52FD0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:26:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so5348594wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pyvqBQX7PHmwUkD+kzK/20YnD2vhcnUIvUwtpvVjDak=;
        b=NftAlwskhxmtCVJFb5fh7kneVXZ1G92WgDy0jpvlgWIgzvey3QAkLYh3/caPufj816
         OH5TOVSWmpdWp2+60Fokw76l+ze5h3Qd3/NCuEEOo0FfqUFtzxI3LQnKqiOJxVIkXiOc
         lYyi939FS9LSr0nox39HyYwAOK2huC3EedhaRXXsKrijFd+1koSJEQcZaa6++QuanBMp
         fCLv432XbnpEE2+JHaihD+eoSe8UkM1k9OvVvgIWSYqeF7rC4t/jV07/TNKIAJh7/Nwr
         duSLKADuNZ8QT+K7vH/ygdyOJVsj/ew2bt78T0YITMSGNHh+BCR3RaKYq4FlD4k3gX2w
         O0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pyvqBQX7PHmwUkD+kzK/20YnD2vhcnUIvUwtpvVjDak=;
        b=0bDrsX6SgoWVOfEScC55+f3B162MApytm+1lS9nyX0nMQB9hNn3joxqJkepKUtjUmy
         3YzzCqczG4LkgclqN16F8GYCzvn+jH1x6E+pRGH/AQ+Zut8kF3cFWuIdDGF/qRUJffEF
         NRaiAMqhMcdB9kWuWE0ISfKJJWAEj6XwQBhgkUhKx5EPPcFEyRgWmNF3fHgq6E/ZskTX
         PDTs15dgeZsCgjk+3XVp/eI8brm1h0yK2uvUDYAD0lUXTyxCqgqc1q0mqXenQ3dOyGbu
         26raDlKWdxTnp3ChzRmWCmC8gZKG5icd6kRn198y/vH1hUUKIiN+KTyvvZCouWjEI9v5
         1cJw==
X-Gm-Message-State: ACgBeo3Tn5J3n6WJSavq3mYevrytFVcj8Etmtk0cNm7hDYMUmP3Q3qgO
        gcwWi04HDWZyA/N6MKqEhIoc3zuzxD6JEOBe
X-Google-Smtp-Source: AA6agR43pCL6Dz3YEWc1YGm5ewSRGYkIWshFnqTAIICdJJTEC9JcHyMDyH6GREues3RH29/Nq+cpIg==
X-Received: by 2002:a05:600c:4c06:b0:3a5:4eec:eb4b with SMTP id d6-20020a05600c4c0600b003a54eeceb4bmr7557051wmp.151.1660998359654;
        Sat, 20 Aug 2022 05:25:59 -0700 (PDT)
Received: from p330.kohl.home (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id l28-20020a056000023c00b00225213fd4a9sm6484553wrz.33.2022.08.20.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 05:25:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Remove "ramp_delay not set" debug message
Date:   Sat, 20 Aug 2022 12:24:54 +0000
Message-Id: <20220820122453.13071-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message shows up occasionally but in bursts (seen as up 30 times
per second on my ODROID N2+).

According to Matthias Kaehlcke's comment in 'regulator: core: silence
warning: "VDD1: ramp_delay not set"', this message should have been
removed after restructuring previous code that assumed that ramp_delay
being zero in that function was an error.

Link: https://lore.kernel.org/lkml/625675256c0d75805f088b4be17a3308dc1b7ea4.1477571498.git.hns@goldelico.com/T/
Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a5033c6ba01..18fa9206ec2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3497,10 +3497,8 @@ static int _regulator_set_voltage_time(struct regulator_dev *rdev,
 		 (new_uV < old_uV))
 		return rdev->constraints->settling_time_down;
 
-	if (ramp_delay == 0) {
-		rdev_dbg(rdev, "ramp_delay not set\n");
+	if (ramp_delay == 0)
 		return 0;
-	}
 
 	return DIV_ROUND_UP(abs(new_uV - old_uV), ramp_delay);
 }
-- 
2.36.2

