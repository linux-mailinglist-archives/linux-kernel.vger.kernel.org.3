Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D997580672
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiGYVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGYVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:22:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D9424097
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so7090528wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TwuYrtOYxcaO41r/IXewdiLwRuK4ZTTivNq8U8AoeY=;
        b=hjwECCBo0OzkA35B6HQMOVhKewSH3ndklF0A+k7vKEI4eIs9Ui4qRuG8R2ARh9iBnk
         vaE3Koq9JEcms9CzR0B3AGSnLk51uO+3+ZjBFLN31DqiUv5e35Yrxs2sPSflRqX/EWUI
         ltGIENkeUxVySv9ThhbhO7AVmCn5vqjDbRIjw8jfr7+PFzDHihGZIAD10dY3M5/LW37B
         LlF+2U5gnkMy7wKkHbUxCMhIDOmsIBhKH6SQQwO/7p/gJdNN64I5V74I14iGCCODt8CT
         W0bnIJjt24MdCuWzLSjZ7lTyQbZ3ViS+KGUyNzWl+j0TiBd5aqpwftNA/RVCS5tSP4ci
         6IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TwuYrtOYxcaO41r/IXewdiLwRuK4ZTTivNq8U8AoeY=;
        b=3Af3iqRaUU+ExIFiuZBuKDLw9Js0H0yYiYSDqc2kAvjlway9XUl7haq+dW6Yiu7Z/M
         PdftDuakMIgm1/CmkzpbAGDWTNMFawOZcbrhFNG9AGejlwCzIfR6ZuFHL1s6niF7itp6
         A4wTI2C/irBdLdWBfiy3n0nHtZCKmbB14a1Cfs4rTwPtRqdjGYT4h+HD+42Rk/cfhd32
         Mi3jYZr8it38osW1w9nckY2zG1oUmeMJFB8qXm83iw8EoCIItTPDeKhOfysaJy/qBd24
         c9ARsL9y7wC0MGRx4uZTu/di47aqvtrgFn1PXcFhtcGccIlbJdKNvrZj4KIe3vMY5DEN
         hJ2Q==
X-Gm-Message-State: AJIora+rXgEEuK2yZv/6cvI4mou9oo8SBdizt90E/2e3afEtEJ69vVd/
        HmMrziWvqCcm6C2sT1FrLUbfVQ==
X-Google-Smtp-Source: AGRyM1sSUCib+H93coh9uppBTGIcUTEGwrX02g5Ay4PPTMCtH1A1t3Yd/pQRRddSoPNkpAmAjcyOuA==
X-Received: by 2002:a7b:cd15:0:b0:3a3:1d69:5201 with SMTP id f21-20020a7bcd15000000b003a31d695201mr9633609wmj.10.1658784129695;
        Mon, 25 Jul 2022 14:22:09 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:09 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 6/9] pwm: dwc: allow driver to be built with COMPILE_TEST
Date:   Mon, 25 Jul 2022 22:21:37 +0100
Message-Id: <20220725212140.741644-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dwc driver to be built with COMPILE_TEST should allow
better coverage when build testing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e1aa645c1084..2ba248aa2ff9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -166,7 +166,8 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI || OF
+	depends on PCI || OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver for Synopsys DWC PWM Controller attached to either a
 	  PCI or platform bus.
-- 
2.35.1

