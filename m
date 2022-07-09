Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6298456CBB6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGIWd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGIWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:33:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F0D2A96A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so2656312wrx.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=RcvOqEck88xAzhO8wdgxIvjttBHQPuMGZUg/RETkEveNw4cdaCfgGf/7RjGuDNZ0WG
         +ujPPcMSAzKcgAxazIq6k17Eu71ZnNwHHN2ILAEqxyJrfii6iB6Qty+XiONR77p4may6
         f6ZrzYBOOvmN2vkW2SLXMXYYAGJgcth2KyQO/oq+JEkn7mkD6lt9TYtVum8Jq+BhPlJh
         S8lpuVVHl40EUBTBkBA3XJ86/7LRFkSJk2Bwq/CNO3lnntpW1Rq6dEwfam+7YIDRqnHK
         Jk4dtuOHRy1DIdUmh/yj4Zmb/VrZopuKAmTArPy3M0hTsY5Qw7bCEqTQ+eZlRKbRmMYE
         YKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=fo2u8GKT8vyFF4bIaFh0sPpd5kBDC9auZDHSZUkDAxu/EoEZnootbTHwZ7rqChGRn0
         XvJ88kcAGqEGLIUqNNLm0WZOE7jJpkwZL0XaKEeD+CScZDEsle/P7wjbNa+hZTPZ8plo
         +Yg82kiqQjsLJ387eJ14bbl0ZkZYljJbbaMpbWx8u9fOCp97P1MsqHL6JcOMopwG6O7i
         NL7fihV9H6g+saOnHKJwdVl3VFhHPJ3ibMzDCMRXcngHLNhZB41aK/5hOPxfJgiWEbJB
         3u8d+lFeXa3hJy2Gez8I14gFEBSQN58oMsWCdpYPYtaZ/OYdiuKawW9s6gzhb+Dou6Ke
         2yNw==
X-Gm-Message-State: AJIora/8kvM/OEuXwLakDhJXL9o0Zjx7RGQFgnF18O32FAEi5oQmPo/w
        3x38Vbsx6uFtIchRoHcaBGhckQ==
X-Google-Smtp-Source: AGRyM1sGkxRlyHa+gpai0tumMnF8pEalUeKlv4qXaDBxC3YJsKbtt5dGaIUI842HEHohfM6d/rw2vQ==
X-Received: by 2002:a5d:4aca:0:b0:21d:6793:1c11 with SMTP id y10-20020a5d4aca000000b0021d67931c11mr9560106wrs.202.1657405977407;
        Sat, 09 Jul 2022 15:32:57 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 10/12] thermal/of: Store the trips in the thermal zone
Date:   Sun, 10 Jul 2022 00:32:27 +0200
Message-Id: <20220709223229.1619339-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the thermal zone contains the trip point, we can store them
directly when registering the thermal zone. That will allow another
step forward to remove the duplicate thermal zone structure we find in
the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 19243c57b3f4..e187461dd396 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
+							       mask, tz, ops, tzp, tz->passive_delay,
+							       tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
-- 
2.25.1

