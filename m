Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38651607D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiD3Uyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbiD3Uyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:54:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C6532E9;
        Sat, 30 Apr 2022 13:51:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p4so12736747edx.0;
        Sat, 30 Apr 2022 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFkwqeNMXvWSRmicZbw5B/Ot0aDTRBEW7BnChVj7xEc=;
        b=otpsIF8sueEsELZJ6LGa5NwG7TNIzfBab+KTQUTMAO7W2tSysaRa4Gs183WeGU0yh+
         E+/3g66TWlcP8hZKy6Ssqa6CgHT2V2SIcfUmzVh5FV0J71N+DdpP7ZDLQeSK9Fwe2ZkF
         37huykerUr3gTLmjAR7dgKSxXL5Iak3hsI7eH5MLsYmfrUi+W0Pdt41WJHOiGKrOM5wp
         E9mBIz9iBFyX+XUrlQb6cvNvp7QoGf/HJln7ymBvHMt8faRHgbhF65YrVl+Gj3vGi/Hv
         0gRd4gQmCybQ+fiJFPPh+hVWJ8GW10AqaYpcSOQ0E82517pNnNNFJcfDuUg/4MHA3jtb
         t0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFkwqeNMXvWSRmicZbw5B/Ot0aDTRBEW7BnChVj7xEc=;
        b=50sBRefQsfUbvCwx+fVCc8VkoYKr3u/9ic2vmbnW+QK2TPgmDA4QJUS4aQ5INqBYbc
         Wu34yUMfZdHatYPCp2o2GrsXavFbSlAM6XNS9AxUts84QtN5QPWJLIBPjpw2vygFKYra
         cVOBd+6bQKYbv028UlMx67iw5FxWNtXhZfNfdNc87jNHdLrLdiUCWHSakInQnrWKCj4f
         dExKrvF0fSIX6h1z+Aa1Cq9VcbPrwSdHyK7VuoblHMrgUnSOOuhiYbVDdCK0sLQNrO+w
         k7w8kS0DulJGepYupR/HjGY36/DLV47FOES1Ih3ZKUfA7BWTtKgPLoBUO7alKY3uCz9d
         2IHA==
X-Gm-Message-State: AOAM532+H0sSHLkxYxTTJLjUguXS/O+TkkCnAcRqqNh/wcQU1iIomiIz
        zXYiBxnRcxLz7REFr8Khhq0=
X-Google-Smtp-Source: ABdhPJwaKWb5VBGvDPU2LLGfyk0OCYzX0aWU8+lLdvGtfniyGyrsQbOzhbktfSERpISco92/ms2rXg==
X-Received: by 2002:aa7:de93:0:b0:418:d700:662a with SMTP id j19-20020aa7de93000000b00418d700662amr5843854edv.107.1651351868110;
        Sat, 30 Apr 2022 13:51:08 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-113.zg.cable.xnet.hr. [94.253.165.113])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm4457852edx.50.2022.04.30.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 13:51:07 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/5] drivers: thermal: tsens: allow configuring min and max trips
Date:   Sat, 30 Apr 2022 22:50:59 +0200
Message-Id: <20220430205101.459782-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430205101.459782-1-robimarko@gmail.com>
References: <20220430205101.459782-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 and IPQ6018 dont support negative trip temperatures and support
up to 204 degrees C as the max trip temperature.

So, instead of always setting the -40 as min and 120 degrees C as max
allow it to be configured as part of the features.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 2 ++
 drivers/thermal/qcom/tsens-v0_1.c | 2 ++
 drivers/thermal/qcom/tsens-v1.c   | 2 ++
 drivers/thermal/qcom/tsens-v2.c   | 2 ++
 drivers/thermal/qcom/tsens.c      | 4 ++--
 drivers/thermal/qcom/tsens.h      | 4 ++++
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index ee584e5b07e5..4585904fb380 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -273,6 +273,8 @@ static struct tsens_features tsens_8960_feat = {
 	.adc		= 1,
 	.srot_split	= 0,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 struct tsens_plat_data data_8960 = {
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6effb822bf3c..2c203ff374e6 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -543,6 +543,8 @@ static struct tsens_features tsens_v0_1_feat = {
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index a4f561a6e582..1d7f8a80bd13 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -306,6 +306,8 @@ static struct tsens_features tsens_v1_feat = {
 	.adc		= 1,
 	.srot_split	= 1,
 	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 129cdb247381..9babc69bfd22 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -35,6 +35,8 @@ static struct tsens_features tsens_v2_feat = {
 	.adc		= 0,
 	.srot_split	= 1,
 	.max_sensors	= 16,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
 };
 
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 69b6f7b97e9e..b7701d5efdfc 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -572,8 +572,8 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
 
-	cl_high = clamp_val(high, -40000, 120000);
-	cl_low  = clamp_val(low, -40000, 120000);
+	cl_high = clamp_val(high, priv->feat->trip_min_temp, priv->feat->trip_max_temp);
+	cl_low  = clamp_val(low, priv->feat->trip_min_temp, priv->feat->trip_max_temp);
 
 	high_val = tsens_mC_to_hw(s, cl_high);
 	low_val  = tsens_mC_to_hw(s, cl_low);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 4614177944d6..747004476347 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -501,6 +501,8 @@ enum regfield_ids {
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
  * @max_sensors: maximum sensors supported by this version of the IP
+ * @trip_min_temp: minimum trip temperature supported by this version of the IP
+ * @trip_max_temp: maximum trip temperature supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_major;
@@ -510,6 +512,8 @@ struct tsens_features {
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
 	unsigned int max_sensors;
+	int trip_min_temp;
+	int trip_max_temp;
 };
 
 /**
-- 
2.35.1

