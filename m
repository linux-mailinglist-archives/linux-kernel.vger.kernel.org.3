Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55835212ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiEJLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbiEJLBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:01:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23C1ACFB2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:55:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x23so14614269pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDpr4fgOnvVyQYrFekFWe52UirgkPK8wiEQGbAdUq4g=;
        b=IQ59VPtA88LWqzTp7fRTwZwyfdBWVvFMqHuZ0jsgBBPzROR5O6cPm28KDvKuVB6j1p
         BHnONpOyhh5X4j4B8Ar2QJ90KsSkk2om0KEQyKzgdnPmezHr4ijzfJe8chcXGOlPTLyb
         7HU6hcMDqqRV28YwhMMZhccuscV2hFqEe7nsM799XTMrOfiFmAs3pCTjnL41g427bVCY
         v2iV8u/r+tkzFXPXLEaEB3/sGloqNKxIanhVAYx9wLvWi3xp0nmqoREIbtYzT1ozeTiH
         lvWNzFUrxcZTzCq63zhY53fjjAP174at7Fm6GZioxGxIi8dX7q/09Yt7tcrbVMJW/ysS
         gkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDpr4fgOnvVyQYrFekFWe52UirgkPK8wiEQGbAdUq4g=;
        b=bxppWEMYfoMK4Nt43pwfc8orD62bLITL31UJ+72h0Iso2RAYPXpplpMjd8uTwKasIk
         QxFFeZlHJbexxp+n17o3TkZD2PY7/ryRr7q5i6XsXDxV0zAw7ynWulwJliN3b1kR/LFy
         LYER0NsC+twDysl29hhOjnPwkCn6ZnXvxs27eJYHCd4Dc1jQ+rTVrX2qCXS0D12HEDhD
         VymvscFW/20LhM4ce7TsuTCF/PQ7eP+U3+BfnA7AUtEqyRuJvRizNskYa8/1pf35QF+i
         hWwAbKOasLz4TaNrA3Rg63Z7tDH6oWjXfR3jAH9JVstYdZXDeSZxpZ1IoCNFDIFTRdDQ
         EaOQ==
X-Gm-Message-State: AOAM530Kr7l+VJmPxaE4/8UjsXVSbisjwEd1bYU5lW/XJDaJSC8IoGqV
        YdECBrF1kivGwdXsOp7s9b4=
X-Google-Smtp-Source: ABdhPJxIq7oyNrunIkIE6opFYDusf+6BjoTkzofLq9YkNdo883HyN1gIEhfwWtVNj1Y6Zavx6CNyMA==
X-Received: by 2002:a63:3dc9:0:b0:3c6:4085:9de0 with SMTP id k192-20020a633dc9000000b003c640859de0mr16741051pga.57.1652180155296;
        Tue, 10 May 2022 03:55:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ls6-20020a17090b350600b001dcf9fe5cddsm1526501pjb.38.2022.05.10.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:55:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] dax: use kobj_to_dev()
Date:   Tue, 10 May 2022 10:55:51 +0000
Message-Id: <20220510105551.1352798-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dax/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..f0f45962005d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -512,7 +512,7 @@ static DEVICE_ATTR_WO(delete);
 static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
 	if (is_static(dax_region))
@@ -1241,7 +1241,7 @@ static DEVICE_ATTR_RO(numa_node);
 
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_region *dax_region = dev_dax->region;
 
-- 
2.25.1


