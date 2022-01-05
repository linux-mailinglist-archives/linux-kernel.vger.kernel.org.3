Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE548534B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiAENOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:14:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42512 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiAENOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:14:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 14F311F41675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641388449;
        bh=IwWZqhmpLW18piwprcmNzBUFX3j3YU95JZk1ANO0MaM=;
        h=Date:From:To:Cc:Subject:From;
        b=SUV8iyam7YQf4KN3P5zwUXPRj55SIQGEC0EWQDIU21R2WC7WdsLYha6fP6G30yoMd
         +bLRI36IcHBoq5/hXpGXY8AYyWcfTc+ot9PT7jCo55bthcazQ4VCRkQdlwaBsIBDHc
         rQjlA/f5EvR72LNBez76ZolJuynOHxRurbUbjwzyDS64B8kHorMoO+wGYKS2qNpi52
         gjpSCss4KeLiMpz9sDXWns6ovaLAf6py9oEmukqsXXTItN7NrOyqCoP1rZPhLn1Awg
         95QxQa1+TxnOAikmgkBXF+HkbNBl3YMZo7G1k4fTskMUXRl066757c5/24h9J2mb8V
         j60mpL9FfRqTA==
Date:   Wed, 5 Jan 2022 18:14:03 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com
Subject: [PATCH v2] crypto: qat - use signed variable to store status and
 error checking
Message-ID: <YdWZm6QJAYbYTKAR@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret should be signed. adf_cfg_get_param_value() and match_string()
return signed statuses. The return status may be saved wrongly in
unsigned ret variable. Correct the data type of ret to signed int.

Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v2:
	Updated commit message
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index 6d10edc40aca..68d39c833332 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -52,7 +52,7 @@ static const char *const dev_cfg_services[] = {
 static int get_service_enabled(struct adf_accel_dev *accel_dev)
 {
 	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
-	u32 ret;
+	int ret;
 
 	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
 				      ADF_SERVICES_ENABLED, services);
-- 
2.30.2

