Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2229C48FA6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiAPDJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:09:08 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:38665 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbiAPDJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642302543;
        bh=GLJp57dCDK6ibqvasrE495fjl0V1+xRpfDN9ufn3Fqc=;
        h=From:To:Cc:Subject:Date;
        b=jmolImVHrTew1DLK4MVJAavEbfZdekT8Gkq8uoiKhFIHHUrytsOinDdlW4sIoOVY+
         PyYDA5AlCfeYT7ZFysVnGl2vB/gPlMRXiDRpH40/LcDK6JVEMGZiruHspU2dJNirJn
         Xh4Uzmd53RDy7i29MQ5q9aL91w1ymPCcnmt6KsEI=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 240084EB; Sun, 16 Jan 2022 11:09:00 +0800
X-QQ-mid: xmsmtpt1642302540tznzxu9hn
Message-ID: <tencent_4257E15D4A94FF9020DDCC4BB9B21C041408@qq.com>
X-QQ-XMAILINFO: NNCgUTg3ctKTkPwe6gHqR9GLm5fQLsdrG8odSOjYTBICwJJmFqXTpTHwPkLAV4
         vpfs209xyPcShTd6BvKbfaxSPGZtELINzzo7hpU87YpCqTI8YxSNkde8nJiiZUlA4ElxGVpLYhAC
         4Wi/xetfYtR4lvG3IE4iWg0aX0q3RFVscDeL+rcB5bwtg2x+T5GPCjWfG+k2HDR7hkDNT2SrlMQR
         BTkM+qnC72NgEoXU8OlAiK6nAbdr7/Lgw77kkcrjpevEc/woIXRA4hP3m7ZurIg82zr3QmEGk7FE
         ijuOJ7zPhwAuwUH1k1p0qCdEG3CxBCgPcPKbDWozUo23JsYCiDe+OuPDktTC+v6yV/4D4mX3QNpu
         DM70G57b1hOQP3vOMa3UNoAymwOnSBCc7nriaiyhbF+x8ZIY/d19tsJRqEvkxu47yD23v2Ym/2Ma
         G+4C2wtLBTZixaytc3qYMvRQZNZ1MGRYM2uj8LzqTF0D1qz9hCZERFDIAQ2vrPN3aJcrtlsGkbUI
         LYDK/CKCfo+6gIdYsgcuVU6mj11QhsyKebfrAvfRAjBK4A5BejADko1w/izF98HEeNcF1S3NhOVX
         HJOa4LZOF3zGJ7Uakp28BJgxd/+F1fhXmbvNsQ/M/LYinPvhmDS1SATUMD8lF3uxdubg17Na1LD5
         xM+eP8VlZypLct/yEVcHTCQ43wvbw/Lmvwzd7RDBqvVU1myHBz+OVLA3kqUzlLsE2w5f1clHVKOA
         KAa6b9IRsqi9UbXrHR5ZFOoDKNvEwrPRRnJg8/RQr5OjrpRjyb+5IP8dx8Fg/NKBhrYcEKmfClUx
         Ax6HEbcnWTa2OBnbhT6EFyhxNtvH/OKjH2HyA8R82ow07uHLwrOMqCmMTQ35aY9JQNyO2VzqIWsG
         I5wGABy7dopUuP+cAV5S9cb2IDUH3DuPJH/iPT4wELqboYVxBadKu5cQ6tTJO75cUMzCeKqsUU
From:   xkernel.wang@foxmail.com
To:     bvanassche@acm.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] scsi: ufs: ufshcd-pltfrm: check the return value of devm_kstrdup()
Date:   Sun, 16 Jan 2022 11:06:49 +0800
X-OQ-MSGID: <20220116030649.2083-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kstrdup() returns pointer to allocated string on success,
NULL on failure. So it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelogs:
1. Use my official name.
2. Synchronize with the latest source code(kstrdup -> devm_kstrdup).
3. Clear up useless code(devm_kfree).
 drivers/scsi/ufs/ufshcd-pltfrm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index d35b892..186540a 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -92,6 +92,11 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 		clki->min_freq = clkfreq[i];
 		clki->max_freq = clkfreq[i+1];
 		clki->name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!clki->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		if (!strcmp(name, "ref_clk"))
 			clki->keep_link_active = true;
 		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
@@ -127,6 +132,8 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 		return -ENOMEM;
 
 	vreg->name = devm_kstrdup(dev, name, GFP_KERNEL);
+	if (!vreg->name)
+		return -ENOMEM;
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-max-microamp", name);
 	if (of_property_read_u32(np, prop_name, &vreg->max_uA)) {
-- 
