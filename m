Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC17588C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiHCMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHCMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:30:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA585A478;
        Wed,  3 Aug 2022 05:30:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so802003wmm.4;
        Wed, 03 Aug 2022 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9heR4TjDoATr+7jD8mL256mkC9k3Sq6Q/fNFgtLRcY=;
        b=ZWCrDmJsaF5rjaaPFXOCezlG5Hrqxmd82nrthFSbU7rDxjbViSCm0+ug895yBlMx6Y
         O0jzll/IIgV/E6VOt0upI8VMeu3aRPr41B0d6MxNWKDOz95WJwkedTKRWVCu4OIPg2qH
         hlMN/3G9NQjJkpU4uT1048gpDStaZ3joVuzb9O72zv7+YB+WOheB3YY/2cOoA1BSA8Fr
         zFpQcmqnzsnaE6wttEL/FK4F9VGcaqOuSCjeyFZNiUvsW3f0mXc7iUssweq9FB16uB7w
         4SahDV4gENBpOo3hiz8NiYUnYSTbNA5MKlWNTlSwDH1InQDzKgOQL6+bCSGoJX5vSdeg
         3sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9heR4TjDoATr+7jD8mL256mkC9k3Sq6Q/fNFgtLRcY=;
        b=DvaEUHqlVhMooU7YQcX1JCEBAL++DF25xhlnX4sIFyfO9Fd/93XGxWUb0UndXvC6Gh
         dFKRX0vxwe7IwchtgjTr5T4eli7X9IZSaOwIP7JqTM1AZLBhdZ0Nhtnq3S9pJSelOWqN
         0yN1ROorQnusVh7HwX2RbuSt5X5YkESZvTeaF1hmPH1un0c5zkyxb682a08TbQRP0Rpp
         NK4/FNKumzWxDeOwJ4bRIiXLq6AXnzthlgC/A0Xs+eTPrvaB4zNePH7ukxbbsbYc/4Nf
         GUOCLkslb3ya4wQ5hPFsJ5duHZP5uEd2WlCg6P6NER2qJaghNYBdLnfFKkbhtzTBHgCH
         G33w==
X-Gm-Message-State: ACgBeo03MS/teHlEuda8pnT1heqLi1sF9FRBuox8zzc9miCQnP7v9EJU
        yGdizrS5UrtH+aD+ZQOVF7k=
X-Google-Smtp-Source: AA6agR7wc8Pn+zYiaa70OFAL33BgIf99foNkbLKIHZ+NKhsuREFIuv3RbzZoZ7tixwIznPMyvCeHdA==
X-Received: by 2002:a05:600c:511f:b0:3a3:254c:b079 with SMTP id o31-20020a05600c511f00b003a3254cb079mr2898294wms.68.1659529820167;
        Wed, 03 Aug 2022 05:30:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6292000000b0021ec32d130asm18346111wru.74.2022.08.03.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 05:30:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: typec: ucsi: stm32g0: Fix spelling mistake "booloader" -> "bootloader"
Date:   Wed,  3 Aug 2022 13:30:18 +0100
Message-Id: <20220803123018.913710-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a dev_err_probe message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 061551d464f1..6ced49e4d208 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -599,7 +599,7 @@ static int ucsi_stm32g0_probe_bootloader(struct ucsi *ucsi)
 		g0->i2c_bl = i2c_new_dummy_device(g0->client->adapter, STM32G0_I2C_BL_ADDR);
 		if (IS_ERR(g0->i2c_bl)) {
 			ret = dev_err_probe(g0->dev, PTR_ERR(g0->i2c_bl),
-					    "Failed to register booloader I2C address\n");
+					    "Failed to register bootloader I2C address\n");
 			return ret;
 		}
 	}
-- 
2.35.3

