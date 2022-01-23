Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3464975F0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiAWWQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:16:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED829C06173B;
        Sun, 23 Jan 2022 14:16:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s18so10223853wrv.7;
        Sun, 23 Jan 2022 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkiEYCh+nlDFeOW7dAXi5U5ovMgv7RIgGZQmqUFLweQ=;
        b=Y782NLyzUAydn5rTsHO+uIIA35+kBDOAFG8Zd2Lu5HN6bEOm5f2St6kdME1mBVIFLT
         B05i2B8sv0VgbPfkXV1FDqDFtCOUESixO47CrbpuJ5Xqdj5AzsaT2tIq5cOCWxfW3z56
         QyN314pioZxtgPX2Bd0dMovoddq1ziX8RfT6b2ecLPAol13gyJZgeYcrQ9jbjTzvIHK+
         +fsAdfSs/ptxA/A4s+Hr7NLP4vNMorVREsAaf5k3O+giohF0qXOK0gaHIlCn3N+C9jiG
         VFrtVlmc6ldZ81aVzigMx0OHnwFofzqrj17Wc4julsgY810Sm8QCkdG5UhrUBaDtqNhp
         AZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkiEYCh+nlDFeOW7dAXi5U5ovMgv7RIgGZQmqUFLweQ=;
        b=qy0GHRgw1P60ZrFUM4wwLcF99HF0oVk/guPwmJKye0VoaTSKnsPQcworN+1AlXEtBE
         YcRwQHqcIwPmomhM7+ocfAtwPu1SL5vMf3hWrjuksClI3WfRoPmBC3aHhqVpa0fqBqBS
         XTqydH9ONyhGMHZdjcGeW1akXkjM8pMktnzbpAh0A5Xu2jcCF0AmJ9AqY4YUpEhRzJSU
         /Eu2CN9F7wXM/Rzvx2PJ5xeD1NI6fffQD/7sOqOi+xD7Lt9UM0ZquUjN9JavMFlLbNo+
         usrFJFaCqQff7FHcrPG52Mhwt+KQk/krnMt9S0EeJRvITIYEGv7rbeJTkB27C/8we3jv
         4RKQ==
X-Gm-Message-State: AOAM530zXCTN1DHl+6lsFCpl7IdIIKPXuZ+8wXDn34WEl+HybGdnorid
        JJ3jU7HND+5NZ2pggB+P5uGeaw4th2pDrQ==
X-Google-Smtp-Source: ABdhPJzwzD52JrriVt7nBB3oT3qBFQV1/vCle9VYKW48x0qDjIxIgzgos4imjnz6DAzLb+8xcDKi0Q==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr5731495wrw.196.1642976183468;
        Sun, 23 Jan 2022 14:16:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b11sm1238229wmq.46.2022.01.23.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:16:23 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_atiixp: make static read-only arrays const
Date:   Sun, 23 Jan 2022 22:16:22 +0000
Message-Id: <20220123221622.5543-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static arrays pio_timings and mwdma_timings are read-only so
it make sense to make them const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/pata_atiixp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index c3a65ccd4b79..efdb94cff68b 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -102,7 +102,7 @@ static int atiixp_prereset(struct ata_link *link, unsigned long deadline)
 
 static void atiixp_set_pio_timing(struct ata_port *ap, struct ata_device *adev, int pio)
 {
-	static u8 pio_timings[5] = { 0x5D, 0x47, 0x34, 0x22, 0x20 };
+	static const u8 pio_timings[5] = { 0x5D, 0x47, 0x34, 0x22, 0x20 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dn = 2 * ap->port_no + adev->devno;
@@ -149,7 +149,7 @@ static void atiixp_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 static void atiixp_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	static u8 mwdma_timings[5] = { 0x77, 0x21, 0x20 };
+	static const u8 mwdma_timings[5] = { 0x77, 0x21, 0x20 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int dma = adev->dma_mode;
-- 
2.33.1

