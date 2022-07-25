Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A54580664
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiGYVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiGYVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:22:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E391D33C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso10179902wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=DOcNy8kqYK6sAPS7P/IO3V8ogtDR/thqiU27gmzm1HA8hR4VYYMjXOMrCVUyv9Hbah
         iij8TZSgffcqnxeMe1Q3NtaAYBUVg8D8NdKmm+XmKNKRgnbgg93GW9TI81tslEougbUD
         f/1WIT1ll89nNi6aQIbDd9YK8BebooyQKR5s8dlX3HRRVmzxCV7+PvbtmNqDAHJhsNhR
         dWvquqfFm8kfb5O15q0Sdokn7yLRcHcHu+zA2SxX9SHfseVl1gYdYpHFapg84TmSoGP3
         glzxeEXCqVcjkoO0ifSnsGbl8JEHLKIL4SIoVzuEoGe/5nUa1G/S028tHf/vNWMA5ByV
         R1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=XeqC5BPQQXN08pQuD/GbDVuefeRKk8fGNZk7dl1rxQg+V9vFeKQpE9n4EmjLRao8kx
         nuHWu+9hGI5JBImG4M/XRLWhIne3l6MrHJaVF9ObYfbOt/6LF/VxpbAlWHzly9ryV5Jq
         05vhnmCE0goBTjl2cH9h1MQFnh5wPqwJGRLHxQ061RihautdZDtGpuKruRfs+RORGRC3
         NN6pW45MvZYrfm2Whkkkkxp7OjywxX4wzeFf8VGd8DxW8/Iznjflu+TKop1VN9JdwGHf
         ICW2fTe8RTG1FGY7LFNg2TZBCrp9RSVrk9DxHG1Oe4BJibMfg2iW7V/74Ptj1tnFW9r9
         kEbA==
X-Gm-Message-State: AJIora/9m4DrGcObirsysbi1DvL2Q+rj2zKsb+HjgXgkeyl55cYIKT9+
        cbIQoFgvMNkCq5l5bw57s9mRJA==
X-Google-Smtp-Source: AGRyM1tz88RgQIrsyEUWR89bcNW1ctJNDrQ9GG67ogI7VI0JG8/S7lDAdDLx5QiBksTDg5iDSjtuaQ==
X-Received: by 2002:a05:600c:4ecd:b0:3a3:3eb0:9101 with SMTP id g13-20020a05600c4ecd00b003a33eb09101mr9863686wmq.49.1658784127410;
        Mon, 25 Jul 2022 14:22:07 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:07 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 3/9] pwm: change &pci->dev to dev in probe
Date:   Mon, 25 Jul 2022 22:21:34 +0100
Message-Id: <20220725212140.741644-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
&pci->dev throughout the function. Change these all to the be
'dev' variable to make lines shorter.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 7568300bb11e..c706ef9a7ba1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -202,14 +202,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
 		return -ENOMEM;
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to enable device (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -217,14 +216,13 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
 	if (ret) {
-		dev_err(&pci->dev,
-			"Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
+		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	dwc->base = pcim_iomap_table(pci)[0];
 	if (!dwc->base) {
-		dev_err(&pci->dev, "Base address missing\n");
+		dev_err(dev, "Base address missing\n");
 		return -ENOMEM;
 	}
 
-- 
2.35.1

