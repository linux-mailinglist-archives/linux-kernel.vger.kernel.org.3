Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA2494D76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiATLzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiATLzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:55:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493BFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:55:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u10so775448pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBGAbS36Cu/DRNsByqcVoGCvd4pnVZblBCfn5Y7gWTM=;
        b=AMdPM6FJpGrkBuCx0khA9Pj8qLRApfeO+uAsNB0inNoVdAuk+tfeXbeftTzR44gcvU
         bdBlun8qhXZwGip0gGo1N3/tpSd67IxfCMaiMTF6xjFyP/u0cetwHAYcT0d23v7rz66A
         9oj0NcEWyEcQm3JEZXlpnR+JpDMHn60KBvuTGRiuMup4doKM9fCczjPXHDVJXQTaAyAI
         iFjFq4wGcBXfbPlbtAU7rY4i+i9arEueBhOxXqkuTnus5UOXGTu9/aAncjEcWuUdumYk
         WhIuMr+M2jHjjigZWj+IpQR2uVoWl9cdzkJOn/C422Cy+BdQcYQ2U7zFJyesJerOtOoH
         +Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBGAbS36Cu/DRNsByqcVoGCvd4pnVZblBCfn5Y7gWTM=;
        b=cAOzSvoirqUAwOdzkfMAXwqjHbBYzDc/BxLMR3nCxCiw47VDZqTV7EFVYu869tE0f/
         6/ArUbb4f/6z78dtPD7l6XKdfMsQadsftDoekfZCURsa44FPT2oseBL8VedDZ2fEyouk
         wax+s4NCSZWVvGZwvCz0w2Do8SDbsSxP2pDMOVnsP40tGArnA7gZslg02SizeRAoySpN
         iyeTeuwlyCknCPADreG/1Y3m6VZSXgc9wWB7x3AywFLTt37ZTevXHFxmvVOrCaseRQCE
         SY+9YR+pvgtkqGyeOza3jOTykEbsdC+roYIYL4Vctl/AarKLb/mb979tdkcKiHeCwzCD
         Qphw==
X-Gm-Message-State: AOAM532KgdcqEmBqSLdAdv2t7NhhF8XBDeTUdSnTO+hrIZWEMbnafM0n
        vMiGZR29ztPNZv3mnfNHVzE=
X-Google-Smtp-Source: ABdhPJxC6dUGvfZJKSNHkL+mV7ctdX6T3FqkmQZbzGKvHbUikv4GTxaGKkzsUxmPZ1ZUzCBs5byQuw==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr32061059pge.487.1642679749860;
        Thu, 20 Jan 2022 03:55:49 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n4sm2254234pjf.0.2022.01.20.03.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 03:55:49 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Mike Waychison <mikew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dmi-sysfs: Fix memory leak in dmi_system_event_log
Date:   Thu, 20 Jan 2022 11:55:42 +0000
Message-Id: <20220120115544.12239-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().
The callback function dmi_entry_free() in kobject_put()
will call kfree to handle the pointer.

Fixes: 925a1da7477f ("firmware: Break out system_event_log in dmi-sysfs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/dmi-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 3a353776bd34..d764fa578d66 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -458,7 +458,7 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 				   &entry->kobj,
 				   "system_event_log");
 	if (ret)
-		goto out_free;
+		goto out_put;
 
 	ret = sysfs_create_bin_file(entry->child, &dmi_sel_raw_attr);
 	if (ret)
@@ -468,8 +468,8 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 
 out_del:
 	kobject_del(entry->child);
-out_free:
-	kfree(entry->child);
+out_put:
+	kobject_put(entry->child);
 	return ret;
 }
 
-- 
2.17.1

