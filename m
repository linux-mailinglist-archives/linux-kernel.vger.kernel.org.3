Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E928596464
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiHPVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiHPVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF77D7BA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so14017190wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=ZgS0gLE20q/SYBWuNLrxu9Sno7TOaFpV1NkgCf4AK65Vub6UfybE7Tpd5Vb933+Wfm
         /Hazg+tJuP4etPIOnT5uiA/NqdMl58MqqgI1nPyaEPUdvX1nf4oFMFNV7gcx6vq86mMy
         /bgqvwen28x4ovhiIthSyKplWb/jDnobgDYqqhqBBmUZrX/8l4xn+pjz/rCNJFj0om0b
         ++dAYAQzT41JuCeUHZrc2MrBhOAmnU0k6R0cGZWMKCM07qG5O4rgUarvrOyYpsjcpsfh
         ScGHFgr4DbDmwgINMLqAnbatEmUOI0FHctuqOI7LSWxAP0gE0/mc/ge45opSOxOuvskw
         T2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=B3HgJFmLp9Qnl0hp7jxxEd/nV2X9qXzOGvEk+0W2em9GCXeBXMES8bqLzaQzLZpDpF
         SeIRman81Rrn0sQysZMrkj/+M2cL5HsjMGOByhspUnybMC5FkFLpBgKnlOszLhppdKGO
         +cMQgonL/impin03dJXaJxScARQDx90bu6mQq9phR4hLhUk4t3mbQtHjK4R8kKV5UQiZ
         Y+5WsXIgKHJoh4cjuDAXr/UHVEekXAUAcyJUwTNLeYKvOJr2Kl8v/fWwFGO2Encz9D7P
         opukvZtxVn+dciHLCoWr7JJxPCsnKdBTaxoG9tOieDkkbBc+9g9Ba59pVL2QQJi7ppxu
         PcfQ==
X-Gm-Message-State: ACgBeo3piUuUVYDCk6NzxTniR304mDAx98Pok/tsJgw1tVZIpLuje3+j
        E41Xz8e77ngX/96h3gaDbioAGQ==
X-Google-Smtp-Source: AA6agR5Bka2GrYUoEeSZ+ZVFq5fJ9wP+PeUslH+VXEGHP5XUfDuYcJXDECM3TP3h4nSCfjvsegokrA==
X-Received: by 2002:a5d:6481:0:b0:220:7f92:3c0f with SMTP id o1-20020a5d6481000000b002207f923c0fmr12731478wri.464.1660684499876;
        Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
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
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 04/10] pwm: dwc: move memory alloc to own function
Date:   Tue, 16 Aug 2022 22:14:48 +0100
Message-Id: <20220816211454.237751-5-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
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

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

