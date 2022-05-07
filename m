Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09351E71B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446358AbiEGM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384994AbiEGM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:58:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE744474C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so13459983wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fhtgna0SXO11lyolbeD9TX1zF+jZgBIlJXC+kQtz6g=;
        b=xFD1YA0tsUnRveXB4wz1pSDBi/PdW63gXr5X9JyCHnEsDuMWXP7y8Jdywy4ZIkwovv
         p4KVovg7yYqo1lXnemwixXeeOsiwf0P5xoJY0Fg5kA1cwyl8b9kM/nEGeJFxWw8s2o2y
         UFAMNd34ZoyKGlKud0pRyFgfBPSNg3QaCTpJVNi4ZsVSNBEIPkp0ZYMBtMuR10HFS+C7
         KY5A31zCGk2yID4TXbKdm31CvOaMyw6cOiVqcyaPQr53Tt3x7WEqUtpXTSfVBavmin84
         3T7oBt6TwftmYmQn5SG8rPwxYGQGw0LSiTiW2ZJCEWMuMP1mwFXla51Bhidxzlnf91SQ
         MjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fhtgna0SXO11lyolbeD9TX1zF+jZgBIlJXC+kQtz6g=;
        b=qgRUomCggmO/CImnpgaSe24IeQqxT7HiBClGa/IoTLOefmvG7Ya6eP9s/fTqF3qhkV
         hRdE3bBIuVB3v4jJlLqCi0h/5Mjg/c0KJF0oRgjh9ISgyUqN6AfZd6t0Y9tpaniuBfj+
         0cgE4MjcjiofRXbPlnH38CGLGG8AVEnB+v7yECz144iEzd3NOpnyjUPcDg1fs7RJL5hg
         cVDGz2uf0z6YIlICvtEXt2oXplcZh/GWiTvWQ9QOAZrevCRnXU/EJw/5QIzxcEHnYHru
         t79Jbk2O4gdjL4V29b1MMyY519W2ObBNXJmgfksdWl9I4d0YJK5+s8+YzNR8l1g49S2h
         OrgA==
X-Gm-Message-State: AOAM531WIDKa5oD3PehmS35hE4jZgk1xLbW6rrDMNufj/EVoK0njE4do
        +r/WzSc7EU0ptJ4PcKZKhJnBMw==
X-Google-Smtp-Source: ABdhPJzMymEKH74HWUo8C5GwkSp/38Pr1M06JMzc1zU8uSmNahO2ELY+L4cL85PCoMeNlK+d/rGH4g==
X-Received: by 2002:adf:eb87:0:b0:20c:a5b5:6731 with SMTP id t7-20020adfeb87000000b0020ca5b56731mr6745222wrn.199.1651928111223;
        Sat, 07 May 2022 05:55:11 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 05/14] thermal/of: Remove the device node pointer for thermal_trip
Date:   Sat,  7 May 2022 14:54:33 +0200
Message-Id: <20220507125443.2766939-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node pointer is no longer needed in the thermal trip
structure, remove it.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 2 --
 drivers/thermal/thermal_of.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..ff10cdda056c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -70,13 +70,11 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
  */
 struct thermal_trip {
-	struct device_node *np;
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d8b4a0ad2d5f..a8a3cb309822 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -855,10 +855,6 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
-	/* Required for cooling map matching */
-	trip->np = np;
-	of_node_get(np);
-
 	return 0;
 }
 
@@ -988,8 +984,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(gchild);
 free_tz:
@@ -1014,8 +1008,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

