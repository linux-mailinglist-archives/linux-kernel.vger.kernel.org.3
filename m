Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D44CB578
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiCCDch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCCDcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:32:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365D11D794
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:31:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y11so3670436pfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZtUvw3ZALmibfhioe1cE1cnVZR/Sbit8bfsFXqhXpk=;
        b=R889e/UhGXgW9S0vzeC67QxDykTwNM796kvjr+1ckA60LLU5z7oOpoFl7sZYJ/tfbX
         wcHDWmT0mADRl21Gss+yBSksjIeKQCthjIIhaL64IWZ6tjiSHBr1Vr/s9/knMqEfirdP
         6wmXbhc3wVCh5eNkp8vT2b4DNpWCGO2HJS9qv+7CFIWI7RMU6Y2L4u2GyFd1M7P1v2i2
         yRGc4+j/hioGlpxNYyD+lJIdq80qqSn6zOdNUnojOcuXnQuUoVPh725lNe//9Vb8277L
         0vtQ2hsqKYZeEshvvHthxwk/kfSuLzvTxxbNmg31gIwuFMXAEqqS6+BvcvYom7llqRbc
         Xx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZtUvw3ZALmibfhioe1cE1cnVZR/Sbit8bfsFXqhXpk=;
        b=vexRq3zdwrINDSZOSF7zx1hyD6QdgHycEc7drmfiTrOFJqxeeZVVerQEIzYDE0entA
         LviJ/G1E1F9GrPlZznaifcCiU7QX/BB+m2q8T9RT9YhUCIA9tDUNurIkGZGEp1v+NgRM
         KyrAEo54ZMymQQngu4Rzx3EkWsg3BknXsOYwcx435OZbK8tf3za0HYHdVXVRnJ6PATze
         GU49S5JeL8GdclTd4B3gw14V2MJ369iWygHg65bmAd2DXI3nOKj8bzeWeckHZyYA0LYg
         yQwpZ7PQYEG0SvVHSUrJJhxXWHMFmSiDrrlNx/4MVVTv5Qjj7eze5nYdcB5XAqYARxcm
         2ENg==
X-Gm-Message-State: AOAM530NVbz1PeJ4Ef3XmG+bIJb/SzzgbcAjFbUgguuBZYobs1AOdfL3
        3Hqu+U3PwxQW4LZgEHq+/mnNq54mSArJ6YWp
X-Google-Smtp-Source: ABdhPJwah2kbQNm59hmoFB1LFxz1aX5pX+VgN7aUlOeSs1kAzVW0ZJUqmjy0WCf0givJuFhU4mWDDw==
X-Received: by 2002:a63:e74d:0:b0:372:645d:d9ee with SMTP id j13-20020a63e74d000000b00372645dd9eemr28697178pgk.228.1646278310304;
        Wed, 02 Mar 2022 19:31:50 -0800 (PST)
Received: from localhost.localdomain (5e.8a.38a9.ip4.static.sl-reverse.com. [169.56.138.94])
        by smtp.gmail.com with ESMTPSA id t12-20020a056a0021cc00b004e105f259e8sm626785pfj.152.2022.03.02.19.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:31:49 -0800 (PST)
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     nvdimm@lists.linux.dev, yaozhenguo@jd.com,
        linux-kernel@vger.kernel.org, Zhenguo Yao <yaozhenguo1@gmail.com>
Subject: [PATCH v2] device-dax: Adding match parameter to select which driver to match dax devices
Date:   Thu,  3 Mar 2022 11:31:32 +0800
Message-Id: <20220303033132.27750-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_dax driver always match dax devices by default. The other
drivers only match devices by dax_id. There is situations which
need kmem drvier match all the dax device at boot time. So
adding a parameter to support this function.

Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
---

Changes:
	- v1->v2 fix build errors report by kernel test robot <lkp@intel.com>
---

 drivers/dax/device.c | 3 +++
 drivers/dax/kmem.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index dd8222a..3d228b2 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -452,6 +452,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
+unsigned int dax_match = 1;
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
 	/* all probe actions are unwound by devm, so .remove isn't necessary */
@@ -460,6 +461,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 
 static int __init dax_init(void)
 {
+	device_dax_driver.match_always = dax_match;
 	return dax_driver_register(&device_dax_driver);
 }
 
@@ -468,6 +470,7 @@ static void __exit dax_exit(void)
 	dax_driver_unregister(&device_dax_driver);
 }
 
+module_param(dax_match, uint, 0644);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 module_init(dax_init);
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a376220..2f1fb98 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -214,9 +214,11 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+unsigned int kmem_match;
 static struct dax_device_driver device_dax_kmem_driver = {
 	.probe = dev_dax_kmem_probe,
 	.remove = dev_dax_kmem_remove,
+	.match_always = 0,
 };
 
 static int __init dax_kmem_init(void)
@@ -228,6 +230,7 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
+	device_dax_kmem_driver.match_always = kmem_match;
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
 		kfree_const(kmem_name);
@@ -241,6 +244,7 @@ static void __exit dax_kmem_exit(void)
 		kfree_const(kmem_name);
 }
 
+module_param(kmem_match, uint, 0644);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 module_init(dax_kmem_init);
-- 
1.8.3.1

