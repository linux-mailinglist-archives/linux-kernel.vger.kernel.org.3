Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE94849F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiADVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiADVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:39:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658AC061761;
        Tue,  4 Jan 2022 13:39:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 318AB1F4153F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641332344;
        bh=aLC+98XwaM4HLlGjupO+FukM8iF+eKmX3/7qCNfljj0=;
        h=Date:From:To:Cc:Subject:From;
        b=cjQidJOWiRXpx9MBpsfBR7gqPTb2uLcHhGksbfqDw+yEig99jVWbFClSUUwfx9bKc
         uSy+B3aPRJllejRH0sgh2YJx+CX7Dgwf2OahvLO5NsGtW8LpqpHA2r+T48SgMQuRXP
         z9yMNL4Wxd9t/PwMF0l8DPXY3nhBpWmraVG0HG3PFumybNs1JtjtLsl6Ct4qpzyVSH
         KYrLKZoKuZjgsYaY3e63HDORkfwDPNgv5TfUlBnUaPaOQWppH3pXtk+njJnBMUZaj8
         olGMr2yfTGJPu8Mn99KR/9RnChr5MjGb51Uini0nXVtJMQpbJTQIo47jlGQpcuxAOt
         B6A32cMGikTCw==
Date:   Wed, 5 Jan 2022 02:38:58 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com
Subject: [PATCH] crypto: use signed variable to store status and error
 checking
Message-ID: <YdS+cgcyKdXUQaU+@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret should be signed. adf_cfg_get_param_value and match_string return
signed statuses. The return status may be saved wrongly in unsigned ret
variable. Correct the data type of ret to signed int.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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

