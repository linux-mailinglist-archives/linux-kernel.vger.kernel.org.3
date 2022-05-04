Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7487D51998E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiEDIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbiEDIVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:21:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E022B33
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:17:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k27so841137edk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkkhaokilCoJ0QaueTDdKBuZpYOWRWhVaZ7JrjJkA3o=;
        b=Y11uNctIy3cOjG6//dW4N/QbxtkNnNXXbt+YGwGQrk/ajhsEyznptbi8AU2y1d8d3m
         xfJFJj/HnqUXGjTRJbdMWvjs35Tjktq5qksuGSqzGMQdf++TkE03pAq06h4VxV9JdBep
         vvpF9B6o3zxxstfB5dwrksjHu8wRR+s5jjbMFL2oEE8nv93HeUz8Hhu09yoRtOE16nCr
         fFvTMcPo++ZeX16PQDLYmGqbzqeMZ83XFCbugAF0aM+1jBvRF+GbIS8wv8AhoMQdP5Ax
         8CytUGSiRWGADXtdvZC/Lw86iFzqKMIdbFBAMCYtpviYOQ1PkX2yyVG/YDTk2vQdx19f
         CtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkkhaokilCoJ0QaueTDdKBuZpYOWRWhVaZ7JrjJkA3o=;
        b=fbxEeAQxM62aYNkfWT/CnkzhTaHiYPlAF9ZC6t6yfeTjIJkbe3s/9Iw/IzO/Y23MPs
         n2HU8XSKCIUSPmN2NnOz2HssF3PjSLg8bzhx2uZ22aYI9HqQ9oXiP1UbUV3sUmjpjePW
         pT9ZgYTgMBocWLJwuO91YwQip47ezIG4NgPFfJgybTXjNVcvHvIDAPi2r0VuD/wKCDe6
         56GL5Q5+oX29nk6AE7qCUVRqEdFGIORMLnNmtg58hHqS676fuawkN1zq2zvU+mWfLRjf
         xp0Rtd7N7U3WASnseiAT8sEH1trIJ7yaxb1Tz5iBzu788N+eS3pP0QhfAO6fNBs6w0fV
         0p3g==
X-Gm-Message-State: AOAM530cXvzyUeAkJLLBhDckM23k1FI1FlgiOpR/qHj9NdgvE2bVNioP
        IZ+7E9nta1MuQYJI+K+1JJs26A==
X-Google-Smtp-Source: ABdhPJzBMLLxZOXcRZjm+dXHMkMN32sM1xFJ73fZ+Pc96EBg2i1XMKbCHPBOw7zEo6ONnmcJgPY1KQ==
X-Received: by 2002:a05:6402:35c3:b0:423:f765:4523 with SMTP id z3-20020a05640235c300b00423f7654523mr21785036edc.311.1651652274429;
        Wed, 04 May 2022 01:17:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm8781322edc.29.2022.05.04.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v2 2/5] opp: Add apis to retrieve opps with interconnect bandwidth
Date:   Wed,  4 May 2022 10:17:32 +0200
Message-Id: <20220504081735.26906-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
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

Add dev_pm_opp_find_bw_ceil and dev_pm_opp_find_bw_floor to retrieve opps
based on interconnect associated with the opp and bandwidth. The index
variable is the index of the interconnect as specified in the opp table
in Devicetree.

Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/opp/core.c     | 120 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  19 +++++++
 2 files changed, 139 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2945f3c1ce09..8125342cee2f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -729,6 +729,126 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
 
+/**
+ * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
+ * @dev:	device for which we do this operation
+ * @freq:	start bandwidth
+ * @index:	which bandwidth to compare, in case of OPPs with several values
+ *
+ * Search for the matching floor *available* OPP from a starting bandwidth
+ * for a device.
+ *
+ * Return: matching *opp and refreshes *bw accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
+					   unsigned int *bw, int index)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	if (!dev || !bw) {
+		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	if (index >= opp_table->path_count)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->bandwidth) {
+			if (temp_opp->bandwidth[index].peak >= *bw) {
+				opp = temp_opp;
+				*bw = opp->bandwidth[index].peak;
+
+				/* Increment the reference count of OPP */
+				dev_pm_opp_get(opp);
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
+
+/**
+ * dev_pm_opp_find_bw_floor() - Search for a rounded floor bandwidth
+ * @dev:	device for which we do this operation
+ * @freq:	start bandwidth
+ * @index:	which bandwidth to compare, in case of OPPs with several values
+ *
+ * Search for the matching floor *available* OPP from a starting bandwidth
+ * for a device.
+ *
+ * Return: matching *opp and refreshes *bw accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
+					    unsigned int *bw, int index)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	if (!dev || !bw) {
+		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return ERR_CAST(opp_table);
+
+	if (index >= opp_table->path_count)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->bandwidth) {
+			/* go to the next node, before choosing prev */
+			if (temp_opp->bandwidth[index].peak > *bw)
+				break;
+			opp = temp_opp;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp))
+		dev_pm_opp_get(opp);
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	if (!IS_ERR(opp))
+		*bw = opp->bandwidth[index].peak;
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_floor);
+
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0d85a63a1f78..dcea178868c9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -129,6 +129,13 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
+
+struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
+					   unsigned int *bw, int index);
+
+struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
+					   unsigned int *bw, int index);
+
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
@@ -279,6 +286,18 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
+					unsigned int *bw, int index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
+					unsigned int *bw, int index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
-- 
2.32.0

