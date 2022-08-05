Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4399158ACC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiHEO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiHEO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:58:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918165540
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv3so3543290wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aHSSKm1CSzN5vwGV08kNfsH4BDoAMa6ZUS/6iWqxg5k=;
        b=bYIh99cZKW92wCosk/ip7+C+33vsEMz7pPTHq1jGf39+BpHTBkNZlY6lClCjzvgPn5
         jxrPWM3t/R5SnpoMRkQxsGKtUCJ0fNj8RCI6V3L2qpX7qGR2QKouCImNFzOdPjbuDEw5
         2FrXN5nIhGl1FJG04MVTA+AkllwkGazPVk3nemT7LG1Y3ejpau8Gjh5PVjdXI9FKnlVG
         y7BJ6i60HGZvQ2N1xEytFap+pBP/7ZgTMGLr3aEB7lulBYOQPn44sRvd0FKeH8PxmZfO
         AM8hL6gl9kGtjl2dksxTCYJkbN5QimmqfcuLKonlW5bpOAoAJK1agC29NMBc4rf9m3mK
         7rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aHSSKm1CSzN5vwGV08kNfsH4BDoAMa6ZUS/6iWqxg5k=;
        b=MumTZuP+l/aWoxj4IgFA7yZW2kLnCLP5VrB+URSzYiwb9xPnefWbghmaQof6EXlkjN
         yqMb3s9FyNkRaIItDab35qhFY+OKCiVO59UmrQ8vA9dceNTfVQyYeI2UklHJy+jscYkc
         JE4KXHxIuDpEHLMG1xLr4UBO/dCONzVH13MOocv5Ph5lMEyP1IrBL38w8Nf1fRcAofPx
         jQLbc9eLJ1yL5bmiQMhyS6GX2/PbqTgcPfW7pQIAiHsnlq/vAuulSxGOC7fyJRJFFkWz
         iepYlrY+jDtpFDvzsu+DuWutsvAhvVXdqaPR+f1f9HbqEzCyi09xT83xnu+qZUcMmJbU
         2Hmw==
X-Gm-Message-State: ACgBeo26Ayg4k6U33Mf57jxxDwBoyZPS15ZikTP1+JLk/6SgOAT0UKQv
        r1L+bfeLa/dWkLGwFDjKAhdCqQ==
X-Google-Smtp-Source: AA6agR6RzpBov29+x0206Scw9Yc31wiRd16l1RCaGDp/DT+zfwYOvRHA5puC8KB64T1djgqor+Nsbw==
X-Received: by 2002:a5d:64e1:0:b0:220:63c9:7d85 with SMTP id g1-20020a5d64e1000000b0022063c97d85mr4685539wri.692.1659711485239;
        Fri, 05 Aug 2022 07:58:05 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v1 15/26] thermal/drivers/rcar_gen3: Use the generic function to get the number of trips
Date:   Fri,  5 Aug 2022 16:57:18 +0200
Message-Id: <20220805145729.2491611-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 40ec63ad0a1b..6a6aaad2bcac 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -525,7 +525,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
+		ret = thermal_zone_get_num_trips(tsc->zone);
 		if (ret < 0)
 			goto error_unregister;
 
-- 
2.25.1

