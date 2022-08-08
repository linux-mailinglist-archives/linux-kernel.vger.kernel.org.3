Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91658CD5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbiHHSJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiHHSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:09:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AA6154
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:09:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a18-20020a05600c349200b003a30de68697so6229296wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uQc495y1/n7wZ6jO9fLLJ/vKRB7PCtus+u7rmKliZco=;
        b=xd8tHtBu57N9gyW+8dkc3DzhvLWSm4tNmCZuS/wD2wvS7tsJnNk748CrilQOsAcamf
         m+vt8etF//ZLeZLTpRexXdvsj0urf4hwcdcCzIvdKLCTFRIRQ3jpGYxllnH2Nk6sqB/H
         WuT3pgpuUiyUO4omg2ka+TerTetnnj4aZ1hQRb4StwDjaVy9lxKGj7nVs0j2TB/foHaP
         CCUCJTxHUS4YNKlQ1A8ZoskTuZmCHYe6Y1Fy4RMxvpZLWM/XOv0dOBeifGStCwwfTJpq
         9wTjjJTUGwqctohL7JNV35PyE/ybPOVTXzIN18O/LbqguwgZ0NhBtOof0HN31SIrH7Rg
         ieUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uQc495y1/n7wZ6jO9fLLJ/vKRB7PCtus+u7rmKliZco=;
        b=fsh+sryZcwOid97SHfH0FmvggaeSmHI7YPqXg4hstCuDJFaz3vsBN4hjipMqR+kUNL
         b4H0r1WhsrSJ3q88IUSMnxQTJbfVQpyXHDLI94w5ePJVOMavMn3JF1qwFF/NVVuosPWZ
         JOLa3tiIgDKh+nN3mtt9J0IHze72ysVEr/uI/N3Ipdmn1WfqoKBqSfbAEDQSBVhRABB1
         YhmdoemGPtgoANTduAb0CaZv07IPQFlZQ95TW/49wfzh+Yhe068v2HlJKcBWGa3n7Qu+
         83Py+8Za5ggdiQD6wqnJu/BMtf/m1y/krYX+rt8e5GlJ962T42xYu6nGg6lPXmyCvO+r
         iPfQ==
X-Gm-Message-State: ACgBeo14kan3rvPgtBn5PFoJhS9U2HKYVuoFK/BosSKBDqIYO/O9/Z5N
        KZ5zgJaWbijSUzd/MkvTO5XkBQ==
X-Google-Smtp-Source: AA6agR6sMWkGY9GvKfraieQyoAw1LduLL+vuILV6wOvM9IT4tcgeEDn6pwt9oZ0fdzWmfOf2X7imKQ==
X-Received: by 2002:a05:600c:2650:b0:3a5:4402:bc2a with SMTP id 16-20020a05600c265000b003a54402bc2amr2838141wmy.108.1659982173974;
        Mon, 08 Aug 2022 11:09:33 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b002205a5de337sm11937309wru.102.2022.08.08.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:09:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if registration fails
Date:   Mon,  8 Aug 2022 20:09:13 +0200
Message-Id: <20220808180915.446053-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808180915.446053-1-daniel.lezcano@linaro.org>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of the OF code was returning -ENODEV if no
thermal zones description was found or if the lookup of the sensor in
the thermal zones was not found.

The backend drivers are expecting this return value as an information
about skipping the sensor initialization and considered as normal.

Fix the return value by replacing -EINVAL by -ENODEV

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 368eb58e97cf..4210c18ef7b2 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -329,7 +329,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
 		pr_err("Unable to find thermal zones description\n");
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENODEV);
 	}
 
 	/*
@@ -368,7 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			}
 		}
 	}
-	tz = ERR_PTR(-EINVAL);
+	tz = ERR_PTR(-ENODEV);
 out:
 	of_node_put(np);
 	return tz;
-- 
2.34.1

