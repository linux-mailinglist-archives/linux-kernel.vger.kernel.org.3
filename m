Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6249F0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbiA1CVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbiA1CVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:21:14 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88FC061714;
        Thu, 27 Jan 2022 18:21:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p37so4758098pfh.4;
        Thu, 27 Jan 2022 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NcGRBfrBgFXvYNxRqUNbHZ56z9OSzIZx7TjN4+98bXQ=;
        b=aMLkbGkc23rFZOGCZ8BSMyxCgDsmbPlNMf/ZWiVAXCmwCBShltFCvu+UuoJkwQTi0h
         N4tdbeFI9lY0WabrVthqmlm0WVcQpKNrC4X8rRf6OMm/9hDMSoIPfA4dUcfaNFmEnhDF
         SNholhHRvoI2BaMKpyu+RruVSAH3B9yH3cUIzNUmAcS7yO3Prq25bFOZB1Gj/iR+b40q
         bc69yBEBdpHILCKf7JlXr5zxRdquLFqLOMvib+6sgBxUSCXbU6+WNBmNf0oreFna63TT
         ylqa/IfTut4LhPqvVqcrX0GQz/0VKrOYiWzuUhVHPUBE//D/h6JE4AqKKGBFJAdLno7K
         0RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NcGRBfrBgFXvYNxRqUNbHZ56z9OSzIZx7TjN4+98bXQ=;
        b=oV+tBIrPAsi/mtWIQQM7YqlLNSVJV3sn6JelpOaV2OHVb0d7WezqK+oz0owYu7Ee/1
         tx7m4vheFjbx9OJcBVg/0Wz5U15PmiihYPTAVT6AXgFOLhHZZ21jFzXV1iX3lxEALKcw
         l+ckdbZdQm2tuUjDqA0Osfndm1cPi8K3IGzD5Z+GLB0eVfAD28h6IuXXvGjvuHHf8rva
         hoX3x5eTErAIJVhwu/6fQ3IMvD1lgBYbQzaIlKGZw959OdIntVTzY3UKPuIMdUXc2wgv
         Tz5K8mag2Ze8R2IyV8e5wgUsDiiXwlsddUNdnc88pOvKD+q2LFvTkKiG/7ey6A8UM7qz
         CKJw==
X-Gm-Message-State: AOAM533Zf0sPYHd8NzoXwIwdxAn6JljyIUbyYCGy3GEcySXUIBTX3lL7
        Rv6mMfWFzF09aHENcXTASJt5iuHdU9/75Q==
X-Google-Smtp-Source: ABdhPJzPErDkFoHutPaRc6Q1NWMOqt10E0FSw+P+1Uh/Y4QS4CXscFfGkBqZsPnxPtiPEnUdHZWfPg==
X-Received: by 2002:a05:6a00:1a4f:: with SMTP id h15mr5666054pfv.50.1643336473555;
        Thu, 27 Jan 2022 18:21:13 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t1sm7052330pfj.115.2022.01.27.18.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 18:21:13 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, sfr@canb.auug.org.au,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH -next] spi: Fix compiler warning for kernel test
Date:   Fri, 28 Jan 2022 10:21:25 +0800
Message-Id: <1643336485-10942-1-git-send-email-lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/spi/spi-sunplus-sp7021.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 627b9c3..d45b5dd 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -124,7 +124,7 @@ static int sp7021_spi_slave_abort(struct spi_controller *ctlr)
 	return 0;
 }
 
-int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
+static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
 
@@ -142,7 +142,7 @@ int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
 	return 0;
 }
 
-int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
+static int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
 	int ret = 0;
@@ -160,7 +160,7 @@ int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
 	return ret;
 }
 
-void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+static void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
 {
 	int i;
 
@@ -171,7 +171,7 @@ void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
 	}
 }
 
-void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
+static void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
 {
 	int i;
 
@@ -557,6 +557,7 @@ static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
 	return clk_prepare_enable(pspim->spi_clk);
 }
 
+#ifdef CONFIG_PM
 static int sp7021_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
@@ -572,6 +573,7 @@ static int sp7021_spi_runtime_resume(struct device *dev)
 
 	return reset_control_deassert(pspim->rstc);
 }
+#endif
 
 static const struct dev_pm_ops sp7021_spi_pm_ops = {
 	SET_RUNTIME_PM_OPS(sp7021_spi_runtime_suspend,
-- 
2.7.4

