Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB755C138
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiF0HlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiF0HlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:41:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A060D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:41:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n1so11693623wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CqHL/4vILcQiCbC55GHosHznhi7ndHOat061Xj3LP1w=;
        b=s51AxvXVUxgccptGcJORHtpFsIh1e1PBr3+fEAjaO6nmZ1At/EH6wF5COR8owaMMTf
         buDZi7R3Ms1FrjWTnB6yQPjjwew+6Lwsq6K6I/SItksSascLa+AdXXlybtVIqFQWgFV8
         PEekxy4hhtcFIOa5S0LMfy/a9SxLfBQs9SYCmVzajM2Z76CUMw5cdzG2dgwsY435r+L3
         UTb7CqMEAlH3jvTpQu6vIrJpxX9Ei9OvgCcZurJbnq9PNi9jKT5XTe7wSNhm8spV+KnQ
         26m6SVSPFHHtOvhZ3nsC5LHbZRqfqYMZjt8t4ZnEzNtZZJlz55fBs5coqgWhXHe2Slgr
         KKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CqHL/4vILcQiCbC55GHosHznhi7ndHOat061Xj3LP1w=;
        b=DmKjvj2CugAlRzmiTX8tcy17nfDaSD8mdLiKcjpRLMoatrPKXb+xVPcClE6BHgmW5r
         y7t6oDMuYJFUXM4teCahAz6yWmn002Vd6GG1CZaUXIi1PsJi728ThblXDN8WsDUj4E2l
         EIcYOyPqQU1AexP4a7ye54X2zwjQEkHcmUvHBkqPt0Wii5VfBHPpNN0isqaTS3MGkAYF
         k7hHdoqp7f4FrXcixUGq087HyyDIXo8+8OCYcp9GLQZ3Up4ni7jzFhCJhQCtOjiewvLS
         fNlXnKlrh1oyyUghDA9t57103YmV8/78m3a22ChCAq30VCw3fZUlQ+wTcHw6rW5wfHAh
         vyHw==
X-Gm-Message-State: AJIora96p0kcONXMhE2bgvfqWgwUmUU5IoYfU5mOmwtaNV98syY6HN7x
        72rBcfxNANR/fBXIo7pdRtr+QQ==
X-Google-Smtp-Source: AGRyM1vCBG2shyGHZdzNppy6uA+sfLShipwUSLZ7jvV9OyFesUftdYh1GMMg0pxTA42UFoHNBuXuDw==
X-Received: by 2002:adf:fdd2:0:b0:21b:a2c1:dcac with SMTP id i18-20020adffdd2000000b0021ba2c1dcacmr11522885wrs.331.1656315673747;
        Mon, 27 Jun 2022 00:41:13 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm9774164wrr.3.2022.06.27.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:41:13 -0700 (PDT)
Date:   Mon, 27 Jun 2022 08:41:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <YrlfF+DMlGFsVBdk@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com>
 <YquZRcuRCrdF+Q1z@google.com>
 <eccbb030-97f7-3a6c-958e-05adcdca6210@quicinc.com>
 <YrAt6dq6ty9p8d05@google.com>
 <a11732d6-a9b1-7ead-e89a-564a57a7192b@quicinc.com>
 <503f1a8b-eadb-d3a6-6e24-d60437f778b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <503f1a8b-eadb-d3a6-6e24-d60437f778b6@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022, Satya Priya Kakitapalli (Temp) wrote:

> Hi Lee,
> 
> 
> On 6/20/2022 4:37 PM, Satya Priya Kakitapalli (Temp) wrote:
> > 
> > On 6/20/2022 1:50 PM, Lee Jones wrote:
> > > On Mon, 20 Jun 2022, Satya Priya Kakitapalli (Temp) wrote:
> > > 
> > > > On 6/17/2022 2:27 AM, Lee Jones wrote:
> > > > > On Tue, 14 Jun 2022, Satya Priya wrote:
> > > > > 
> > > > > > Use i2c_new_dummy_device() to register pm8008-regulator
> > > > > > client present at a different address space, instead of
> > > > > > defining a separate DT node. This avoids calling the probe
> > > > > > twice for the same chip, once for each client pm8008-infra
> > > > > > and pm8008-regulator.
> > > > > > 
> > > > > > As a part of this define pm8008_regmap_init() to do regmap
> > > > > > init for both the clients and define pm8008_get_regmap() to
> > > > > > pass the regmap to the regulator driver.
> > > > > > 
> > > > > > Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> > > > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > > > > ---
> > > > > > Changes in V15:
> > > > > >    - None.
> > > > > > 
> > > > > > Changes in V14:
> > > > > >    - None.
> > > > > > 
> > > > > > Changes in V13:
> > > > > >    - None.
> > > > > > 
> > > > > >    drivers/mfd/qcom-pm8008.c       | 34
> > > > > > ++++++++++++++++++++++++++++++++--
> > > > > >    include/linux/mfd/qcom_pm8008.h |  9 +++++++++
> > > > > >    2 files changed, 41 insertions(+), 2 deletions(-)
> > > > > >    create mode 100644 include/linux/mfd/qcom_pm8008.h
> > > > > > 
> > > > > > diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> > > > > > index 569ffd50..55e2a8e 100644
> > > > > > --- a/drivers/mfd/qcom-pm8008.c
> > > > > > +++ b/drivers/mfd/qcom-pm8008.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >    #include <linux/interrupt.h>
> > > > > >    #include <linux/irq.h>
> > > > > >    #include <linux/irqdomain.h>
> > > > > > +#include <linux/mfd/qcom_pm8008.h>
> > > > > >    #include <linux/module.h>
> > > > > >    #include <linux/of_device.h>
> > > > > >    #include <linux/of_platform.h>
> > > > > > @@ -57,6 +58,7 @@ enum {
> > > > > >    struct pm8008_data {
> > > > > >        struct device *dev;
> > > > > > +    struct regmap *regulators_regmap;
> > > > > >        int irq;
> > > > > >        struct regmap_irq_chip_data *irq_data;
> > > > > >    };
> > > > > > @@ -150,6 +152,12 @@ static struct regmap_config
> > > > > > qcom_mfd_regmap_cfg = {
> > > > > >        .max_register    = 0xFFFF,
> > > > > >    };
> > > > > > +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
> > > > > > +{
> > > > > > +    return chip->regulators_regmap;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(pm8008_get_regmap);
> > > > > Seems like abstraction for the sake of abstraction.
> > > > > 
> > > > > Why not do the dereference inside the regulator driver?
> > > > To derefer this in the regulator driver, we need to have the
> > > > pm8008_data
> > > > struct definition in the qcom_pm8008 header file.
> > > > 
> > > > I think it doesn't look great to have only that structure in
> > > > header and all
> > > > other structs and enum in the mfd driver.
> > > Then why pass 'pm8008_data' at all?
> > 
> > 
> > There is one more option, instead of passing the pm8008_data, we could
> > pass the pdev->dev.parent and get the pm8008 chip data directly in the
> > pm8008_get_regmap() like below
> > 
> > 
> > struct regmap *pm8008_get_regmap(const struct device *dev)
> >  {
> >      const struct pm8008_data *chip = dev_get_drvdata(dev);
> > 
> >      return chip->regulators_regmap;
> > }
> > EXPORT_SYMBOL_GPL(pm8008_get_regmap);
> > 
> > 
> > By doing this we can avoid having declaration of pm8008_data also in the
> > header. Please let me know if this looks good.
> > 
> 
> Could you please confirm on this?
> 
> > > What's preventing you from passing 'regmap'?
> > 
> > 
> > I didn't get what you meant here, could you please elaborate a bit?

Ah yes.  I authored you a patch, but became distracted. Here:

-----8<--------------------8<-------

From: Lee Jones <lee.jones@linaro.org>

mfd: pm8008: Remove driver data structure pm8008_data
    
Maintaining a local driver data structure that is never shared
outside of the core device is an unnecessary complexity.  Half of the
attributes were not used outside of a single function, one of which
was not used at all.  The remaining 2 are generic and can be passed
around as required.
    
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/qcom-pm8008.c | 53 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f8103c4..4b8ff947762f2 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -54,13 +54,6 @@ enum {
 
 #define PM8008_PERIPH_OFFSET(paddr)	(paddr - PM8008_PERIPH_0_BASE)
 
-struct pm8008_data {
-	struct device *dev;
-	struct regmap *regmap;
-	int irq;
-	struct regmap_irq_chip_data *irq_data;
-};
-
 static unsigned int p0_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_0_BASE)};
 static unsigned int p1_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_1_BASE)};
 static unsigned int p2_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_2_BASE)};
@@ -150,7 +143,7 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
-static int pm8008_init(struct pm8008_data *chip)
+static int pm8008_init(struct regmap *regmap)
 {
 	int rc;
 
@@ -160,34 +153,31 @@ static int pm8008_init(struct pm8008_data *chip)
 	 * This is required to enable the writing of TYPE registers in
 	 * regmap_irq_sync_unlock().
 	 */
-	rc = regmap_write(chip->regmap,
-			 (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
-			 BIT(0));
+	rc = regmap_write(regmap, (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
 	if (rc)
 		return rc;
 
 	/* Do the same for GPIO1 and GPIO2 peripherals */
-	rc = regmap_write(chip->regmap,
-			 (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
+	rc = regmap_write(regmap, (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
 	if (rc)
 		return rc;
 
-	rc = regmap_write(chip->regmap,
-			 (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
+	rc = regmap_write(regmap, (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
 
 	return rc;
 }
 
-static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
+static int pm8008_probe_irq_peripherals(struct device *dev,
+					struct regmap *regmap,
 					int client_irq)
 {
 	int rc, i;
 	struct regmap_irq_type *type;
 	struct regmap_irq_chip_data *irq_data;
 
-	rc = pm8008_init(chip);
+	rc = pm8008_init(regmap);
 	if (rc) {
-		dev_err(chip->dev, "Init failed: %d\n", rc);
+		dev_err(dev, "Init failed: %d\n", rc);
 		return rc;
 	}
 
@@ -207,10 +197,10 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
 	}
 
-	rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
+	rc = devm_regmap_add_irq_chip(dev, regmap, client_irq,
 			IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
 	if (rc) {
-		dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
+		dev_err(dev, "Failed to add IRQ chip: %d\n", rc);
 		return rc;
 	}
 
@@ -220,26 +210,23 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 static int pm8008_probe(struct i2c_client *client)
 {
 	int rc;
-	struct pm8008_data *chip;
-
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
+	struct device *dev;
+	struct regmap *regmap;
 
-	chip->dev = &client->dev;
-	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
-	if (!chip->regmap)
+	dev = &client->dev;
+	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	if (!regmap)
 		return -ENODEV;
 
-	i2c_set_clientdata(client, chip);
+	i2c_set_clientdata(client, regmap);
 
-	if (of_property_read_bool(chip->dev->of_node, "interrupt-controller")) {
-		rc = pm8008_probe_irq_peripherals(chip, client->irq);
+	if (of_property_read_bool(dev->of_node, "interrupt-controller")) {
+		rc = pm8008_probe_irq_peripherals(dev, regmap, client->irq);
 		if (rc)
-			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
+			dev_err(dev, "Failed to probe irq periphs: %d\n", rc);
 	}
 
-	return devm_of_platform_populate(chip->dev);
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id pm8008_match[] = {

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
