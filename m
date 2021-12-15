Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94A475645
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhLOK0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbhLOK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:26:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D05C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:26:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so37230388wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=Vh/7TIehgWPled8bSP/lFCsJI4k0l+Fnpm73N9Pkq90=;
        b=jER5w63yjF6eofxK3CkDl31djZ1Zefzau0uanXoHCkVAKTipQjO5yVWS420ZR36XzF
         UEvwlY+OSI3RhGNcAPNvq65Csl1LyIRexhrHo1xUWBAijUggKB657B79J1JrGnFV9vIL
         AiZ1axCGEzhVUgtiMWqcPSeTAv1P9pbVhmrBHMiU/0jrmDSO3jNQRYgcRpGvLAcEuVbx
         9emxrgogKTXdrukPMDCT5Io4eTSmuNEx29S0S82cowlY8qrMGaUqIibxwWxQIFbzcFvA
         uES6wdjYZQ4QkI369eIOhQf+gX8M9WU+VbgJ2R43OqqBQUrzPjDn7FtY6ktBcsOPotds
         TKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=Vh/7TIehgWPled8bSP/lFCsJI4k0l+Fnpm73N9Pkq90=;
        b=V9hHuz5vbQdFzD+r50E7Vp4KiSQppJr24VNPslno5lNI6bc9eLRUHD1Cy2cqeCX2Ej
         rAPzz0HCsIp5mrGVsJ53ZoAF33mxNFhzL6lLpi4UcFZm7FHg7WTlvEC01RNSSkBUnSr2
         Q1EhIFXyuKO5uR/lvRovKLv+htsTEjEA14VnrU7OdUsaHgVZjDF+bqzjnCRpRVe3FGgL
         DGVlCMhKUo38H86bTJ8e7udFmx6UJbIh/B/07VQ2vEY1CDD3VfdJ55Y/z+82F6bK5GHD
         zHA22lAE55Flt7TfbjBR54V6d39W1FaXBgIUpKfDwbJfrFlZfH2OYYfVQbzME3nPNTel
         AM5Q==
X-Gm-Message-State: AOAM531WmbaDxm9YfL0KG9/cLxC46IDqsygo8vJsfcwoQtu+WcD1SwCV
        DxtwxxprNkyQdXl7AeNOupHvw2yMtzM=
X-Google-Smtp-Source: ABdhPJzx7amkagXV20i8ZKNRadgiGo8jAOZvRcynzITZEm3Xu7qIZXUB8D1XzYsCACHzr1bo2KGYGA==
X-Received: by 2002:a5d:6111:: with SMTP id v17mr3768888wrt.512.1639563960407;
        Wed, 15 Dec 2021 02:26:00 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:6862:8ea7:f293:5328? (p200300ea8f24fd0068628ea7f2935328.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:6862:8ea7:f293:5328])
        by smtp.googlemail.com with ESMTPSA id v15sm1577372wro.35.2021.12.15.02.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:26:00 -0800 (PST)
Message-ID: <b2131908-0110-006b-862f-080517f3e2d8@gmail.com>
Date:   Wed, 15 Dec 2021 11:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] reset: renesas: Check return value of
 reset_control_deassert()
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deasserting the reset is vital, therefore bail out in case of error.

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 1e8315038..a8dde4606 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -121,7 +121,9 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get reset\n");
 
-	reset_control_deassert(priv->rstc);
+	error = reset_control_deassert(priv->rstc);
+	if (error)
+		return error;
 
 	priv->rcdev.ops = &rzg2l_usbphy_ctrl_reset_ops;
 	priv->rcdev.of_reset_n_cells = 1;
-- 
2.34.1

