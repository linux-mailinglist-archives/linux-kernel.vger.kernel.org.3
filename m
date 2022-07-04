Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451856548D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGDMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiGDMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:09:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063E12776
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:09:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4873774pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAMHigCn1QN+1TDwn/mbxMoFc35nWEMDHAOhKmW0B9s=;
        b=Dd74ljO2SM7wVwhMJ+AQbkj7z/UCcDzXnMaoWlVaB/RQVugQB89DGMynP03Shx/C74
         lKsR7mRnR7DZVUIknex094Qetz3tlJLcavKGxYuAAwKvLRypLonVVQw7Kq+bfn41T8Mr
         RZlk2gd8SFWG9xBBlYcyFDnV1aJ2h4L6hv6wyZFv0ICkvnmRB9LMoiLmu2L2ovCzjYUS
         RGFKFvEu4vISb6mLQnPAwJabrF7DoskMoSYHX62YhxKEcPLR81Vu7Ewk9E08HKHR6Rwh
         xiMQdA6jSdf6YZpOGTc3NVohfRY6aty60DRKmnRDTxGkZGJMCHxrnJ/TFHmqy5zOP8xG
         4ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAMHigCn1QN+1TDwn/mbxMoFc35nWEMDHAOhKmW0B9s=;
        b=m0yJFfFiGi9kcbtN1S9pwlQq/dxRB3F5Vd23kBmD5+bt+Eb42Ojw+o/5QXfVxJtSm/
         j1qlDylQQnkBi3NFf6yjGJrCLjUGa/FVBukbsB0BhqcVNoC0LrImVOpCAUXX+EFOQvLr
         JpsUYcbfUpZzaC8l+pBRxo6IDEcU7BwGsTlc2a7wJ8D3nhvq63SnMDAjq1ILU7sq3q+M
         JI1Apr/N9irPDLvvZNO+saqEeG5E1IjrvSgzOAD2PXrcGYgUsm2a3VMCpjk2jHZcxhVE
         Xfc2QARnsmBKlWEeLdGAlUKYE904g0qXjYelLU3lg6A+XemO2VXNPdwO60ABZG/8OjDq
         epOQ==
X-Gm-Message-State: AJIora/ydXSdOxUhCTTx3ZAO0BuCewDjHWvEm5i6AGSnHVFV3E7IJGqY
        XdhaH/WN0HC3kujwPO6pU80RsQ==
X-Google-Smtp-Source: AGRyM1uAZ6e8I45NEVqS4vNNYKyJGPhM9CDuyTbc3Y4NHbng16Pg8T/NithFAf85w+tNz6V3FUsD4A==
X-Received: by 2002:a17:90b:4b51:b0:1ec:f991:baaf with SMTP id mi17-20020a17090b4b5100b001ecf991baafmr35371632pjb.186.1656936542647;
        Mon, 04 Jul 2022 05:09:02 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id n19-20020a635913000000b0040df0c9a1aasm15335278pgb.14.2022.07.04.05.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:09:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 18/20] OPP: Add dev_pm_opp_get_supplies()
Date:   Mon,  4 Jul 2022 17:37:56 +0530
Message-Id: <e149ff64602f4aba95547add0e96dbf947b5cfdb.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

We already have an API for getting voltage information for a single
regulator, dev_pm_opp_get_voltage(), but there is nothing available for
multiple regulator case.

This patch adds a new API, dev_pm_opp_get_supplies(), to get all
information related to the supplies for an OPP.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 25 +++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5ecf077b6b17..3a794bff2ba1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -117,6 +117,31 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
+/**
+ * dev_pm_opp_get_supplies() - Gets the supply information corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ * @supplies:	Placeholder for copying the supply information.
+ *
+ * Return: negative error number on failure, 0 otherwise on success after
+ * setting @supplies.
+ *
+ * This can be used for devices with any number of power supplies. The caller
+ * must ensure the @supplies array must contain space for each regulator.
+ */
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp,
+			    struct dev_pm_opp_supply *supplies)
+{
+	if (IS_ERR_OR_NULL(opp) || !supplies) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return -EINVAL;
+	}
+
+	memcpy(supplies, opp->supplies,
+	       sizeof(*supplies) * opp->opp_table->regulator_count);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_supplies);
+
 /**
  * dev_pm_opp_get_power() - Gets the power corresponding to an opp
  * @opp:	opp for which power has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 9f2f9a792a19..1e2b33d79ba6 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -129,6 +129,8 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies);
+
 unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
@@ -217,6 +219,11 @@ static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.31.1.272.g89b43f80a514

