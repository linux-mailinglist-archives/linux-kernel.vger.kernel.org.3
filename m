Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711E9471552
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhLKSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:23:06 -0500
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211]:32983 "EHLO
        out162-62-58-211.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhLKSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:23:05 -0500
X-Greylist: delayed 3890 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Dec 2021 13:23:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639246982;
        bh=c7iaH1wEpw1P7r58WklCov2S3G3TXz1K2JhYBGQ3gN4=;
        h=From:To:Cc:Subject:Date;
        b=kO5PIhmIf3SlXiGJm0VVJmQ6HB97g7gPgPuZ/QudSGuPlJfZuv/5wMoN34Dq+qtWZ
         UGn3x3T5FWs07DLNPNfbYEupKqjP/pXjnjHxTT7yhvQKKu4MLFzSff0P1RZ4iDgtFt
         Wa2KbbXda65Qlw72ahncRBUJ3ipzg96TsudRo8vY=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 3F02327D; Sun, 12 Dec 2021 02:15:48 +0800
X-QQ-mid: xmsmtpt1639246548tmpnv3l5j
Message-ID: <tencent_D3914A6FFF832049CC70B9411CAD1492E108@qq.com>
X-QQ-XMAILINFO: M1Qh2uBElWf6sZ58vtZPlhFctg9RlJPqCKfR6ZWs/ZKZ2eh1LPsrea4jNgB9nr
         K8+UveBsFAdjd4RS72SFxw3VVh2cV+rI8iBln4IkHIgr0SdBQN5yxx9zdVYj6eug2OXtrm4R3ofh
         /hGQ6oGtYkResDigJZdJhVSW/GG7Jp+gkKqob/OJaiq8ZJrbDI69PAYq2cclMId/STgFUUOLkAgN
         Ckmre+6NDXlxMx10p1hnnvc+31gAF/e/iH8JJlrMqfRh88nNUEvDqPdOzAz7KqKMH5t+SCBS+5O8
         Iint8OIkz3fI5YOHpN81+LXMWNTDNCP5/DX753rqFn39J8iU9Ean9Gm4qdnkhIlY+42lg0EYeV+n
         px+QKi9fWqGQdnO1Xo99arLhp2kpQWp94m1iLmjw+/Wxpf8Fro5YQYgIX0GYtdzlOc7ucYal//zP
         Ob8hQnCr3bU6HVamUp3lWfJF+c/3x20jfkhET6gfNLjnHLZxjXIW7DxZwpSDf/gqu0jaem4amz+p
         vcz1vKhG2NzoTpsw8GkdV4uCdBE2esDa4I17pyfiBe7o7wrvETGvdytmYqqDIAbsFUUMC1fJxQGZ
         U266P6lpl60oVAkLPFa3JS9F6/laDpj4WG5ruGYBMxz4KT5fgggYzcrDb7ZCHBUdOvPVegyMKwGS
         D+JjmEfC07qNqkqrFbW4tRsQuu7oM5nNt8+JqSLpyU/J79hR+8FouRAmSOan152bdP7g4AkJEvn9
         vZF+Xw0O/vlILFF8zEKpSZ/ocgZXCUnWQpHF6lHxEoBbuidaoIXWJZ7cDi3Wz7u3pcxJqDYaV8pP
         HrggQxZSv+oMgSCaRyiA1ZYs5NXxHDNFm0asSYuccaYbEFq0J8fj6xZzem1EqJw+IQfgR0nTZV1C
         acliaqhNW8e0uJxDjUt9g=
From:   xkernel <xkernel.wang@foxmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] scsi: ufs: ufshcd-pltfrm: check the return value of kstrdup()
Date:   Sun, 12 Dec 2021 02:14:16 +0800
X-OQ-MSGID: <20211211181416.1133-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() can return NULL if some internal memory errors happen, so it
is better to check the return value of it.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 8859c13..32e7bd3 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -89,9 +89,15 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 			goto out;
 		}
 
+		clki->name = kstrdup(name, GFP_KERNEL);
+		if (!clki->name) {
+			ret = -ENOMEM;
+			devm_kfree(dev, clki);
+			goto out;
+		}
+
 		clki->min_freq = clkfreq[i];
 		clki->max_freq = clkfreq[i+1];
-		clki->name = kstrdup(name, GFP_KERNEL);
 		if (!strcmp(name, "ref_clk"))
 			clki->keep_link_active = true;
 		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
@@ -127,6 +133,10 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 		return -ENOMEM;
 
 	vreg->name = kstrdup(name, GFP_KERNEL);
+	if (!vreg->name) {
+		devm_kfree(dev, vreg);
+		return -ENOMEM;
+	}
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-max-microamp", name);
 	if (of_property_read_u32(np, prop_name, &vreg->max_uA)) {
-- 
