Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495B8525B48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377315AbiEMGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377239AbiEMGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:14:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30B273F6B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k2so10018938wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzW3JoJQPDC9Hv68vgom4XDNC9N28iHOq+Cur+ByVqQ=;
        b=zrKpZ6Kx2dSCwdX5Q0oRdTH5rr733qHsdN8O8dGeRJiBpBq1L9iwbLvMvBuRmPLCjt
         OFvYaYDNoa7t3BYOWzILjyBHlydlPCThP0ESB/exAMKXdymr0pH05hz/joLdFSETmadp
         SCB6WEH/ZjEepEQGHgix1RdhRH6Flu9/qa0L7HRlIu8slnxvMVI7dgAIS30tGyWvIAnN
         eZnUc8+eK9BoSVHjGpBilxj6incGshRhhTWfWNSpX7j/m0oS1ACjcydj46c4p33szAIp
         r8RdvDPWdLmMZdXSvN8nU+TuWL4w47y3Z9Pcd8rr5SLgyH1/W/saY5hD2REuMXFMCk8S
         xYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzW3JoJQPDC9Hv68vgom4XDNC9N28iHOq+Cur+ByVqQ=;
        b=FDPoCmKcgwdru1yBisFnF0IOjX+b4X5Rfci8sracTACJUsxaFXRLI8cXjOCpDRaV9J
         sNZp+6E1HY0RDMQOLH+8s6b/qtvf/XfvwJbygWQh4V0OeLjsDa+44XcO/drAvV9OEO4Q
         71TsHoVTYvkzCpakMKDXl2ow67D7TCvnRy2i7bk/aSlFEuz6MmHsN2qRwedhph4Qp+qC
         1pYC7fxvB+SH8hg4CxtqpiJKk5jTNmA9WMi+Zjl7D9g1VnaOrGl8OtfFUp9+DYg5opeX
         SF01wVKmFWUQP/LXoqlug+49NfYLbd6xaLGJHs94cR/MgiulNI8o+oKGTFA2SdpzObha
         norg==
X-Gm-Message-State: AOAM533km3auEyJqCwFFdTY0XM/51gSSsoiF0PLO9cz43yLzn7hi838+
        x/keQuhMFPnbtlV+6RQv1G6c7g==
X-Google-Smtp-Source: ABdhPJxmM0MKGTb9qCGmU9hYDJSgF6LhHt/K3GDRIhTzQ+jQrRpgDVLPrwWVSWhfArX6dSfHStQ+Xw==
X-Received: by 2002:a05:6000:718:b0:20c:c39e:867e with SMTP id bs24-20020a056000071800b0020cc39e867emr2450397wrb.599.1652422460530;
        Thu, 12 May 2022 23:14:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020adfbc84000000b0020c5253d8f3sm1477760wrh.63.2022.05.12.23.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:14:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/7] PM: opp: parse multiple frequencies in each OPP
Date:   Fri, 13 May 2022 08:13:46 +0200
Message-Id: <20220513061347.46480-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
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

Devices might need to control several clocks when scaling the frequency
and voltage, with each clock having different frequency.  Parse the
'opp-hz' Devicetree property as an array and store all frequencies for
the custom set_opp in a new field 'rates'.

Since the PM OPP framework operates on only one clock (multiple clocks
are for custom set_opp helpers), these frequencies are actually not used
internally and still the core relies on the original field 'rate'.

All other PM OPP functions, like finding floor/ceil PM OPPs, operate
still on first rate given in the 'opp-hz' frequency.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c     | 20 +++++++++++++++---
 drivers/opp/of.c       | 47 ++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  3 +++
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index aac3c6d89ae0..563e962c3411 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1033,7 +1033,9 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	data->clks = opp_table->clks;
 	data->dev = dev;
 	data->old_opp.rate = old_opp->rate;
+	data->old_opp.rates = old_opp->rates;
 	data->new_opp.rate = freq;
+	data->new_opp.rates = opp->rates;
 
 	return opp_table->set_opp(data);
 }
@@ -1307,6 +1309,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 				__func__, freq, ret);
 			goto put_opp_table;
 		}
+		/*
+		 * opp->rates are used for scaling clocks, so be sure accurate
+		 * 'freq' is used, instead what was defined via e.g. Devicetree.
+		 */
+		opp->rates[0] = freq;
 	}
 
 	ret = _set_opp(dev, opp_table, opp, freq);
@@ -1761,23 +1768,29 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
-	int supply_count, supply_size, icc_size;
+	int rate_count, rate_size, supply_count, supply_size, icc_size;
 
 	/* Allocate space for at least one supply */
 	supply_count = table->regulator_count > 0 ? table->regulator_count : 1;
 	supply_size = sizeof(*opp->supplies) * supply_count;
+	/* Allocate space for at least one rate */
+	rate_count = table->clk_count > 0 ? table->clk_count : 1;
+	rate_size = sizeof(*opp->rates) * rate_count;
 	icc_size = sizeof(*opp->bandwidth) * table->path_count;
 
 	/* allocate new OPP node and supplies structures */
-	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
+	opp = kzalloc(sizeof(*opp) + rate_size + supply_size + icc_size,
+		      GFP_KERNEL);
 
 	if (!opp)
 		return NULL;
 
 	/* Put the supplies at the end of the OPP structure as an empty array */
 	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
+	opp->rates = (unsigned long *)(opp->supplies + supply_count);
 	if (icc_size)
-		opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
+		opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->rates + rate_count);
+
 	INIT_LIST_HEAD(&opp->node);
 
 	return opp;
@@ -1957,6 +1970,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 
 	/* populate the opp table */
 	new_opp->rate = freq;
+	new_opp->rates[0] = freq;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 30394929d700..b226d2c7a84b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -767,6 +767,46 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_clocks(struct dev_pm_opp *opp, struct opp_table *opp_table,
+			struct device_node *np)
+{
+	int i, count, ret;
+	u64 *freq;
+
+	count = of_property_count_u64_elems(np, "opp-hz");
+	if (count < 0) {
+		pr_err("%s: Invalid %s property (%d)\n",
+			__func__, of_node_full_name(np), count);
+		return count;
+	}
+
+	if (count != opp_table->clk_count) {
+		pr_err("%s: number of rates %d does not match number of clocks %d in %pOF\n",
+		       __func__, count, opp_table->clk_count, np);
+		return -EINVAL;
+	}
+
+	freq = kmalloc_array(count, sizeof(*freq), GFP_KERNEL);
+	if (!freq)
+		return -ENOMEM;
+
+	ret = of_property_read_u64_array(np, "opp-hz", freq, count);
+	if (ret) {
+		pr_err("%s: error parsing %s: %d\n", __func__,
+		       of_node_full_name(np), ret);
+		ret = -EINVAL;
+		goto free_freq;
+	}
+
+	for (i = 0; i < count; i++)
+		opp->rates[i] = freq[i];
+
+free_freq:
+	kfree(freq);
+
+	return ret;
+}
+
 static int _read_bw(struct dev_pm_opp *new_opp, struct opp_table *table,
 		    struct device_node *np, bool peak)
 {
@@ -827,6 +867,13 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct opp_table *table,
 	}
 	*rate_not_available = !!ret;
 
+	if (!ret) {
+		ret = _read_clocks(new_opp, table, np);
+		/* The properties were found but we failed to parse them */
+		if (ret && ret != -ENODEV)
+			return ret;
+	}
+
 	/*
 	 * Bandwidth consists of peak and average (optional) values:
 	 * opp-peak-kBps = <path1_value path2_value>;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 59aac08baf82..217d4376af9b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -61,6 +61,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
  * @rate:	Frequency in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
+ * @rates:	Frequency rates for the clocks (equal to @rate for one clock)
  * @bandwidth:	Interconnect bandwidth values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
@@ -85,6 +86,7 @@ struct dev_pm_opp {
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
+	unsigned long *rates;
 	struct dev_pm_opp_icc_bw *bandwidth;
 
 	unsigned long clock_latency_ns;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5f17f10fcc3f..5fd3895af605 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -60,12 +60,15 @@ struct dev_pm_opp_icc_bw {
 /**
  * struct dev_pm_opp_info - OPP freq/voltage/current values
  * @rate:	Target clk rate in hz
+ * @rates:	Array of clock frequencies for all clocks (equal to @rate for
+ *		one clock)
  * @supplies:	Array of voltage/current values for all power supplies
  *
  * This structure stores the freq/voltage/current values for a single OPP.
  */
 struct dev_pm_opp_info {
 	unsigned long rate;
+	unsigned long *rates;
 	struct dev_pm_opp_supply *supplies;
 };
 
-- 
2.32.0

