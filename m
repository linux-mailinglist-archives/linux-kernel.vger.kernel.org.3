Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42558AE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiHEQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiHEQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:50:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD11BEB6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:50:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bv3so3868697wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=BWgOaWILsYq3ZBv0suGifNsfC2RNDB9yng6qUNHLD2A72Z8UNlShi8mSGKRMUhqsIS
         ANwKPPkJr1qBoG5gzFp7/dbql53OzOY3rJCUPu0kmgNnoX8TBwRPwI41gsZaH7SNFdRr
         FEM8YoCzDYRYdNGS5ao/oeN4tr3ipUYJoISGPc215xJvVGnltoFdX2wIgStnAdqc+VME
         uEl9traG294lJCrT4DIKtF/p7u52k7qErwMgLPGIFdG1lEi0OoEtOgz+zko45xnpAO8g
         RuXrfuMOSRYqE1QqDn6rZztuuXu7wAcqVzNPQVs60UZmIRTVTqyxDyyNmgEWtdSWycrq
         3B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BEOpRioXienSDDf6vjruAkPlsDKDhUNbn1dmZioZ4X4=;
        b=Icab3lXZ99NMSqcAcQHwuEZeyPuj+SUHS8qadoRir2xZggn2qaDj0BTqPIh/p8jIvE
         K0i29DEihYSnAv4s/D9+jTNeRPK3+4RNT77mGv1RRt8G/9ZK9UFub0R+GUEdzwdkotpH
         T61j77CVAl6h6Uw8gqnIF48Rcq//BQ+1Y1b/b2tK+ctXs2/qs8yF0IH5jT5s7loQHVdN
         oWQLotJnaYLP2T7lQ9hNBkNocSqTR3m9Dn0sTq3SwBl0qdWtnNQaZOySV8MIn2cj2NuI
         hoca9xQKLW2+Nnj2Lbno7JnmDcm+wA9zWOzKeOjASNn7nnYqQinZi1IiiWP74ogTXbOz
         3RCw==
X-Gm-Message-State: ACgBeo0YLuloEEtTyUCigOtUEaaGFxWeCt06zYNbcfl0nCueKZ1yS432
        IM2etO1hhg87yz4VI0IcHOjw0A==
X-Google-Smtp-Source: AA6agR43TeIxmPhDHtFF9FnHQf/9/Wzpvq74xTkzRALOkCM6ipkcvArjUG7CwoF9zR+WV3poGVebpw==
X-Received: by 2002:a5d:47a8:0:b0:221:7c03:f60 with SMTP id 8-20020a5d47a8000000b002217c030f60mr1331655wrb.4.1659718245049;
        Fri, 05 Aug 2022 09:50:45 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:44 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 2/8] pwm: change &pci->dev to dev in probe
Date:   Fri,  5 Aug 2022 17:50:27 +0100
Message-Id: <20220805165033.140958-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

