Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C44F14FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiDDMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345285AbiDDMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:39:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8B27B2B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:38:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a6so8676787ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxazKNWdZmuxHrWhtc+LApD4KGO8WGpvem9++wDs/cs=;
        b=O1qLrl6rgLys895swTs9ijWBtJBWy4DbAvI6mMhsteXwdBuz5pihoZstlg2p/ED3XN
         RpLKFVRLXLABDuveV9c00Mb8SVCdQ+DEIaFXLOocSfpW7nlbeT8IKESIGsEeU2u3yvIc
         ItRIklQP9IwgCenucKyCTYV7cTBUytF2IoQ64t9egvULBv0JODzjdmJ+oFgoO+iOPnqy
         CiYZvnJnTmRsFXgreiBHyR+3gOpCd+tAMdENoGzllXqq97VQiff3LzIwFLKkNoqUKAee
         VO/j28Eowzv+XZExpZZj9kQvbvc0whVeT4FcPx6FKYYF86Mzy7Esf/FHQzR+u1H84DEM
         Lx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxazKNWdZmuxHrWhtc+LApD4KGO8WGpvem9++wDs/cs=;
        b=ikdNeqL5MEyHqAe14RC+0XRz4lfLJnA/gWMKS2gBcKqcPeXViK71o6opzpFhdHjWMi
         qUNgIe0DzvxGT30xBXfl8X++pkLgdVRVK6MUIAYV6OK8aFz/ZB+W1bisTtHZLHpjY87d
         7+JrdB9p+DQfMZGI/EkMqGNsKIG7/+h9FRhQhFgyaz11l1cwxYjuEIU7upaBoZLRyAQc
         lHv7nOS46ZgRAWsa/wtxjF7JgBtLko++gP90o3QL19UyuZ5JHbi92ncfw5AIcJLZZ16R
         nDPBpP6zpLQi0YDxge+ayCrn959sYMFeEeE82yF7yj4T0coNF6Jlp/Rgd3epWMN/gBR8
         n4RQ==
X-Gm-Message-State: AOAM533xPLLB4DIdOaEV0MeF09CHI9oKxY488EeVhGYT1dQsIvdJhfMI
        ft1C0nzdlxBYjQh2yV6heZFJpQ==
X-Google-Smtp-Source: ABdhPJxIkjveHM7OqjZ5YObsOBiucW6Soy/YCP9ws9nXkbzZODaT0Td0Tg61RuzkuG1DN60qHkt17w==
X-Received: by 2002:a17:906:3918:b0:6e0:5bbd:bf33 with SMTP id f24-20020a170906391800b006e05bbdbf33mr10262205eje.764.1649075879997;
        Mon, 04 Apr 2022 05:37:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906255800b006e7f44d46fesm924463ejb.222.2022.04.04.05.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 05:37:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] PM: opp: Fix NULL pointer exception on a v2 table combined with v1 opps
Date:   Mon,  4 Apr 2022 14:37:57 +0200
Message-Id: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

dev_pm_opp_add() adds a v1 OPP.  If the Devicetree contains an OPP v2
table with required-opps, but the driver uses dev_pm_opp_add(), the
table might have required_opp_count!=0 but the opp->required_opps will
be NULL.  This leads to NULL pointer exception, e.g. with ufs-qcom.c
driver and v2 OPP table in DTS:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  ...
  Call trace:
   _required_opps_available+0x20/0x80
   _opp_add_v1+0xa8/0x110
   dev_pm_opp_add+0x54/0xcc
   ufshcd_async_scan+0x190/0x31c
   async_run_entry_fn+0x38/0x144

The case of mixing v1 and v2 OPP tables is not supported.  Add a version
field to the OPP table to handle such cases:
1. Disallow mixing v1 and v2 OPPs,
2. Skip parsing required opps when dealing with a v1 OPP table.

Fixes: cf65948d62c6 ("opp: Filter out OPPs based on availability of a required-OPP")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add version field.
2. Skip allocating required fields in _opp_table_alloc_required_tables()
   instead of iterating over it later.
---
 drivers/opp/core.c | 35 +++++++++++++++++++++++------------
 drivers/opp/of.c   | 22 +++++++++++++++++++++-
 drivers/opp/opp.h  | 12 +++++++++++-
 3 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 740407252298..0b5357b9d342 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1227,7 +1227,8 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
-static struct opp_table *_allocate_opp_table(struct device *dev, int index)
+static struct opp_table *_allocate_opp_table(struct device *dev, int index,
+					     enum opp_table_version version)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
@@ -1248,6 +1249,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	/* Mark regulator count uninitialized */
 	opp_table->regulator_count = -1;
+	opp_table->version = version;
 
 	opp_dev = _add_opp_dev(dev, opp_table);
 	if (!opp_dev) {
@@ -1332,7 +1334,8 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
  * of adding an OPP table and others should wait for it to finish.
  */
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
-					 bool getclk)
+					 bool getclk,
+					 enum opp_table_version version)
 {
 	struct opp_table *opp_table;
 
@@ -1367,7 +1370,7 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
 
 		mutex_lock(&opp_table_lock);
 	} else {
-		opp_table = _allocate_opp_table(dev, index);
+		opp_table = _allocate_opp_table(dev, index, version);
 
 		mutex_lock(&opp_table_lock);
 		if (!IS_ERR(opp_table))
@@ -1382,9 +1385,10 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
 	return _update_opp_table_clk(dev, opp_table, getclk);
 }
 
-static struct opp_table *_add_opp_table(struct device *dev, bool getclk)
+static struct opp_table *_add_opp_table(struct device *dev, bool getclk,
+					enum opp_table_version version)
 {
-	return _add_opp_table_indexed(dev, 0, getclk);
+	return _add_opp_table_indexed(dev, 0, getclk, version);
 }
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
@@ -1794,6 +1798,13 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	unsigned long tol;
 	int ret;
 
+	if (opp_table->version != OPP_TABLE_VERSION_UNKNOWN &&
+	    opp_table->version != OPP_TABLE_VERSION_1) {
+		dev_warn(dev, "%s: Mixing v1 and v2 OPP bindings not supported (%lu)\n",
+			 __func__, freq);
+		return -EINVAL;
+	}
+
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
 		return -ENOMEM;
@@ -1844,7 +1855,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 {
 	struct opp_table *opp_table;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_2);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1932,7 +1943,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_2);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1994,7 +2005,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	struct regulator *reg;
 	int ret, i;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_UNKNOWN);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2149,7 +2160,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_UNKNOWN);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2247,7 +2258,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 	if (!set_opp)
 		return ERR_PTR(-EINVAL);
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_UNKNOWN);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2380,7 +2391,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
-	opp_table = _add_opp_table(dev, false);
+	opp_table = _add_opp_table(dev, false, OPP_TABLE_VERSION_UNKNOWN);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2637,7 +2648,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = _add_opp_table(dev, true);
+	opp_table = _add_opp_table(dev, true, OPP_TABLE_VERSION_1);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 440ab5a03df9..aa757f73277a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -169,6 +169,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		return;
 	}
 
+	if (opp_table->version == OPP_TABLE_VERSION_1)
+		goto skip_required_opp;
+
 	count = of_count_phandle_with_args(np, "required-opps", NULL);
 	if (count <= 0)
 		goto put_np;
@@ -193,6 +196,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 			lazy = true;
 	}
 
+skip_required_opp:
 	/* Let's do the linking later on */
 	if (lazy)
 		list_add(&opp_table->lazy, &lazy_opp_tables);
@@ -883,6 +887,13 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	int ret;
 	bool rate_not_available = false;
 
+	if (opp_table->version != OPP_TABLE_VERSION_UNKNOWN &&
+	    opp_table->version != OPP_TABLE_VERSION_2) {
+		dev_warn(dev, "%s: Mixing v1 and v2 OPP bindings not supported\n",
+			 __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
 	new_opp = _opp_allocate(opp_table);
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
@@ -985,6 +996,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = 1;
 	mutex_unlock(&opp_table->lock);
 
+	WARN_ON(opp_table->version != OPP_TABLE_VERSION_UNKNOWN);
+	opp_table->version = OPP_TABLE_VERSION_2;
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
@@ -1020,6 +1034,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 
 remove_static_opp:
 	_opp_remove_all_static(opp_table);
+	opp_table->version = OPP_TABLE_VERSION_UNKNOWN;
 
 	return ret;
 }
@@ -1041,6 +1056,9 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = 1;
 	mutex_unlock(&opp_table->lock);
 
+	WARN_ON(opp_table->version != OPP_TABLE_VERSION_UNKNOWN);
+	opp_table->version = OPP_TABLE_VERSION_1;
+
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop) {
 		ret = -ENODEV;
@@ -1080,6 +1098,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 remove_static_opp:
 	_opp_remove_all_static(opp_table);
+	opp_table->version = OPP_TABLE_VERSION_UNKNOWN;
 
 	return ret;
 }
@@ -1100,7 +1119,8 @@ static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
 			index = 0;
 	}
 
-	opp_table = _add_opp_table_indexed(dev, index, getclk);
+	opp_table = _add_opp_table_indexed(dev, index, getclk,
+					   OPP_TABLE_VERSION_UNKNOWN);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..bd8349f8c7b0 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -124,6 +124,12 @@ enum opp_table_access {
 	OPP_TABLE_ACCESS_SHARED = 2,
 };
 
+enum opp_table_version {
+	OPP_TABLE_VERSION_UNKNOWN = 0,
+	OPP_TABLE_VERSION_1 = 1,
+	OPP_TABLE_VERSION_2 = 2,
+};
+
 /**
  * struct opp_table - Device opp structure
  * @node:	table node - contains the devices with OPPs that
@@ -138,6 +144,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
+ * @version: OPP bindings version to disallow mixing (e.g. v1 and v2).
  * @current_rate: Currently configured frequency.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
@@ -188,6 +195,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
+	enum opp_table_version version;
 	unsigned long current_rate;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
@@ -232,7 +240,9 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
+					 bool getclk,
+					 enum opp_table_version version);
 void _put_opp_list_kref(struct opp_table *opp_table);
 void _required_opps_available(struct dev_pm_opp *opp, int count);
 
-- 
2.32.0

