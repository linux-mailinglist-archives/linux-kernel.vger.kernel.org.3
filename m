Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BD4C6616
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiB1Jug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiB1Jue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:50:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32776A05F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:49:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so9882302pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY+0Ivg1vSA1XaXQW6vtJsA4AuBXBDOS2j2Lb69bvkg=;
        b=lZmlnIMB1KDy7LvolDubvkcCurb9xuAnKdl+OxMKIbygv6rqnQlHsILNhi6QVW2O8/
         SJA7d8a67r7WxA3LU+Z2OA7gD71N/768nJABlTt44CdK6kMdagWENKPn9jVhLegs3EJo
         8bAZzFFzcxCwx0EDJZJQHGnYS88Nqpil3ObHBgTvvGi39Dyg4qsQUe4s0cuw4M5pti1D
         Cz7lqnHBf7pq0BPtluW/Tz5wEcLC+2nstdQDEIlC+cfsv9P9673wgLxoWxW5BD38Vt5i
         VgBgiwp92q+m8bNF7DTEBcrtlqiDlXjvxHKGGEh64aL+Yy3WbS56FeyZchD0r3dZbTYU
         lpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY+0Ivg1vSA1XaXQW6vtJsA4AuBXBDOS2j2Lb69bvkg=;
        b=CrQBCOpB0tVshQN8BVDENIsRkhpH6PZPr7AkkcRm5HvDnGZVPStLjfxUoen+1rm3K0
         QjRXA2t3K3nrbgBEe1v4m0rJpTKHfP6OW8NVsqqkN03c++YbAHIvnz6WW49UGLKElDWd
         RcsnTUJE8FgRQtPSV3ONEPcuhHcEkwlYCRxOi8wkLHX5xp+cUxN3CvM6FAOboy7nm0Kh
         5MwLoYsqWTphrjj3pbcDrHWKoous/OO1+mfbR9Ao9KFVqWyLph0rAt9ubxnZY5pckVC6
         HtKfL7rxhY/VF+3tSzxSmbsfy+58su7f3QetYT/xyReGgK1s1v7tqLkc0C0iW8LyFAuQ
         1n2w==
X-Gm-Message-State: AOAM532lnbC2SIOEyVZnswDC74yMa5bYHWx+RzBWdlDVsoly1gzFYsvs
        BRHrwg4riylL21Pu1IwafKM=
X-Google-Smtp-Source: ABdhPJwGzJ330n6ZAg/LXU5qOTuJRrtSbstxXYxrFqS3j7oOxt4hgVOU1dlCt/sDyAihPht4SFu7oQ==
X-Received: by 2002:a17:90a:9408:b0:1b5:3908:d3d1 with SMTP id r8-20020a17090a940800b001b53908d3d1mr15782855pjo.188.1646041796388;
        Mon, 28 Feb 2022 01:49:56 -0800 (PST)
Received: from localhost.localdomain (5e.8a.38a9.ip4.static.sl-reverse.com. [169.56.138.94])
        by smtp.gmail.com with ESMTPSA id 2-20020a631342000000b0037487b6b018sm9802638pgt.0.2022.02.28.01.49.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:49:56 -0800 (PST)
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     nvdimm@lists.linux.dev, yaozhenguo@jd.com,
        linux-kernel@vger.kernel.org, Zhenguo Yao <yaozhenguo1@gmail.com>
Subject: [PATCH v1] device-dax: Adding match parameter to select which driver to match dax devices
Date:   Mon, 28 Feb 2022 17:49:38 +0800
Message-Id: <20220228094938.32153-1-yaozhenguo1@gmail.com>
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
drivers only match devices by dax_id. There are situations which
need kmem drvier match all the dax device at boot time. So
adding a parameter to support this function.

Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
---
 drivers/dax/device.c | 3 +++
 drivers/dax/kmem.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index dd8222a..a974cc1 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -452,6 +452,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
+unsigned int match = 1;
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
 	/* all probe actions are unwound by devm, so .remove isn't necessary */
@@ -460,6 +461,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 
 static int __init dax_init(void)
 {
+	device_dax_driver.match_always = match;
 	return dax_driver_register(&device_dax_driver);
 }
 
@@ -468,6 +470,7 @@ static void __exit dax_exit(void)
 	dax_driver_unregister(&device_dax_driver);
 }
 
+module_param(match, uint, 0644);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 module_init(dax_init);
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a376220..41ba713 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -214,9 +214,11 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+unsigned int match;
 static struct dax_device_driver device_dax_kmem_driver = {
 	.probe = dev_dax_kmem_probe,
 	.remove = dev_dax_kmem_remove,
+	.match_always = 0,
 };
 
 static int __init dax_kmem_init(void)
@@ -228,6 +230,7 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
+	device_dax_kmem_driver.match_always = match;
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
 		kfree_const(kmem_name);
@@ -241,6 +244,7 @@ static void __exit dax_kmem_exit(void)
 		kfree_const(kmem_name);
 }
 
+module_param(match, uint, 0644);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 module_init(dax_kmem_init);
-- 
1.8.3.1

