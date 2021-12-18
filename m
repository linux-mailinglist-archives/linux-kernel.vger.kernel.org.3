Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A014479C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhLRT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhLRT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:26:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0B1C061574;
        Sat, 18 Dec 2021 11:26:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i63so8850655lji.3;
        Sat, 18 Dec 2021 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdBuTypFEGfAMSy+A4AKKlfEyqqDYZjRKJiYFiXcMZM=;
        b=ixRi07RkxZ3BO6jpkf0IGLvKFIFeKIM1xnjRlUvPC9YqbnoknX7hq+pC2tyz8Rv2ka
         hXKPmbDYLQv8/JGQb69SY3W6laGPqVpDgIaVQpZkzVqaYFuPEJ/NNcdILd0uW3emu1Wd
         iqaUqLny0zt1nuaNdSI+cHrdZGgGVI462Ya/2m0jmKm/3lKTwuhcM4s6VnWzUybSxcKp
         MmkCIfRC3jwEMehhCiDg1AreRBGGBUTac2Sft1yz+xBSBdO6icEXdQH27YibBdqgH+GA
         U3lqNXIgGL6w0TO4ZP4QiQgG4np444JrP2VInkCFHI4aBUWQ4osJvwSasyp0aAAaCtNF
         sQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdBuTypFEGfAMSy+A4AKKlfEyqqDYZjRKJiYFiXcMZM=;
        b=bcE1KxBFmzHLhK6sgV0LIfdrNZsJHsVV/hrXfiBzxgBoXC4kTGwIfxFn1hBTho5w0w
         E+eIqMiKwqbNVMDeNPmBRT62qBwYo5unxE/nodx/FDWSkkbJc49gRDNk73Inrdj9Nr15
         BrWJUf26B7TqfUL7505lGfVjBawet8amj8GbPbZiLL+by+4zayYzehuSP7CfDzwqRBLB
         ObAx+6epNlEj3Uj412hhD6+lmAQtxnbb8UKXMgYKwE/wVet2+Zar3tjiKx1MnhmSvZ9/
         /rpxT4vWG/RhXwfDC5FVPKl1WI1qSo4YmKL7dpGW9U8Pc2rO6BPh2plI/8wz+cA+99k8
         HOWg==
X-Gm-Message-State: AOAM532Z664bKTCGC5Nsbxp9zCAsrW3TkaBQGtFVKt6xERubpaXsyod2
        DIetKen7UFeOQK3Ui/jeEy12ngoZVDYizA==
X-Google-Smtp-Source: ABdhPJx0KaimcPkKWfv/oiS6HZvKEzAACDz+JxWJJ2JiTmb4zV7vMvAqDpxpQniZTP+U4YSzoWXV/w==
X-Received: by 2002:a2e:9608:: with SMTP id v8mr8002162ljh.392.1639855590880;
        Sat, 18 Dec 2021 11:26:30 -0800 (PST)
Received: from localhost.localdomain ([94.179.28.1])
        by smtp.gmail.com with ESMTPSA id q4sm1799027lfh.277.2021.12.18.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 11:26:30 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (nct6775) Additional check for ChipID before ASUS WMI usage
Date:   Sat, 18 Dec 2021 21:26:16 +0200
Message-Id: <20211218192616.611878-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WMI monitoring methods can be changed or removed in new ASUS boards
BIOS versions. Such versions return zero instead of a real one as
Chip ID.

Commit adds additional validation for the result of Chip ID call
before enabling access by ASUS WMI methods.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 drivers/hwmon/nct6775.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 57ce8633a725..034347ed51c4 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5038,7 +5038,8 @@ static int __init sensors_nct6775_init(void)
 				   board_name);
 		if (err >= 0) {
 			/* if reading chip id via WMI succeeds, use WMI */
-			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
+			if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp) &&
+			    tmp) {
 				pr_info("Using Asus WMI to access %#x chip.\n", tmp);
 				access = access_asuswmi;
 			} else {

base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
-- 
2.34.1

