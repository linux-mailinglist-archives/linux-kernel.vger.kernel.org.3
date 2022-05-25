Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590D5334AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiEYB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243469AbiEYB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:27:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30E21805;
        Tue, 24 May 2022 18:27:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f21so5571317pfa.3;
        Tue, 24 May 2022 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qvTKL8ZXv4FVA5yjJ0dBHo6+DhI3Qqo9ICLeJSP7Tw=;
        b=IjxZTeNXts6OWkdEk9hAPMJhdu84YYOMJFP/oqNevf8iNResCkObp9S+Mr843X0txM
         9mMHg01fiNFhpBGYez/Hkicuc5UHJLOMrmDjnn2rzU8KebyENWyGeVKBZN5Sq95ohBib
         Piu+HCT+lpd2KVK3wBoOPA9kVFomrQNmL7hu9Mwld+YJnQxcHh9rReuiSvxKQtLGvsP4
         khV4C1Z+g3nrQISmrq63wbL2KNftQfLtGl88SMeGd5aCynmWvj4Ldc7HdfVHOuc9Qg62
         drqXSBpZCEUpQhdpN8MtY79Mmq83Qos8cHJ0UcQ/qlvW60g5FRXL3HngCTmMhc/6i6C1
         aPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qvTKL8ZXv4FVA5yjJ0dBHo6+DhI3Qqo9ICLeJSP7Tw=;
        b=MYTQuAPL5/z1THf/5qcefOuTZ20m+d1fCYh0lXv9/nKFnQmbobyxImLxK0YtYHdDrm
         ++pVcfY2ljr1y1fSeYOMNFssprJ9oMi8vSqmfHFCt3DiH3SDYYdZse9p++VO+MO3XwgC
         r6JQTEx/V+vJaaKEScCvE5jtfTxhT/T32HKmZRuhUl9vDCLgzcOFBALTOEAHr/hFyaOT
         6meL5HWyMWombehqN4ca8vVpN3NGyWsC7+pdl9MqPfx7dIOVsvgxQjeC0awMPVZgwrQD
         dbnvg6CUeKqDy+RVstcIB+m7EAX9zgghN0KKRyRNIJ7039VoZVJL1U+Yb1rrerT9ujJL
         tX+Q==
X-Gm-Message-State: AOAM530l114siuBIXh5B9UTgGIuYbnqwbCf9Rw37WCu3xAA3h072HVjU
        1ry2GqjK+9mLKibdMfp2kvw=
X-Google-Smtp-Source: ABdhPJxUsdbx4EalygyNUYXagirdX4dG4xcCS/ZaXCIBmWC8eXR5TRthaRPf+AvTbESUwLa0v6lcsA==
X-Received: by 2002:a05:6a00:15c5:b0:518:a654:1bf8 with SMTP id o5-20020a056a0015c500b00518a6541bf8mr11512454pfu.23.1653442021451;
        Tue, 24 May 2022 18:27:01 -0700 (PDT)
Received: from localhost.localdomain ([103.167.134.51])
        by smtp.gmail.com with ESMTPSA id c78-20020a621c51000000b0050dc76281fdsm9897978pfc.215.2022.05.24.18.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:27:00 -0700 (PDT)
From:   zhanggenjian <zhanggenjian123@gmail.com>
X-Google-Original-From: zhanggenjian <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai@kylinos.cn, zhanggenjian123@gmail.com
Subject: [PATCH] MIPS: Export _machine_restart to modules
Date:   Wed, 25 May 2022 09:26:24 +0800
Message-Id: <20220525012624.388023-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: huhai <huhai@kylinos.cn>

modpost complains once these drivers become modules.
  ERROR: modpost: "_machine_restart" [drivers/char/tb0219.ko] undefined!

Fix it by export them when that symbol is =m.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: huhai <huhai@kylinos.cn>
---
 arch/mips/kernel/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 6288780b779e..f3420a871087 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -24,6 +24,9 @@
  * functions.
  */
 void (*_machine_restart)(char *command);
+#ifdef CONFIG_GPIO_TB0219_MODULE
+EXPORT_SYMBOL_GPL(_machine_restart);
+#endif
 void (*_machine_halt)(void);
 void (*pm_power_off)(void);
 
-- 
2.27.0

