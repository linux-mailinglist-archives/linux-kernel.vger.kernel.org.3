Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926150DE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiDYK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiDYK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:57:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC883011;
        Mon, 25 Apr 2022 03:54:56 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d19so10445759qko.3;
        Mon, 25 Apr 2022 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jp4XLXB+yuFIyEeNeA7P4d0RwkNykKV21HzQvLnUYDI=;
        b=WvoIZbMKGUK6CAV3ViG2gZsOpJ9sDx9/EXvYDMk6k4AKGTTYFByX8z7U6qJMjkzfno
         SLYTZynKNW5fKDVYAketkQIdbSakw1+wq/5l21KeFKPqjRfOS8YQZr+JMDCxu3YnkE2k
         72T0/FcP6YlFZN2VXFe4bQyBVAFwSFktTtWe7yDaWP/DVFK81XphtBORNqm/He0z/4Xi
         W4/bRbtQ4NSyRdHWvEtp9sA35ad/OLGs/byCwlqcjUoym9oP0qnKb0/CI8J9Wez2tFlD
         Yvxje1XIzolJerN7DOcEkg/krw5FXz1+Zm8nv7SuTljcHiaBAcxz5IX8u/RRIU6JElxu
         C/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jp4XLXB+yuFIyEeNeA7P4d0RwkNykKV21HzQvLnUYDI=;
        b=bGR3b3pAcNSY2k5S/QqnwSpPi/NQRct+IdBUkiOMB753HDN73eMQmZMrRqNSAerLmw
         bgDNCyNIMuTQCXjY2ooqF54Slm5FWduCcNwzfepasX+UybPx3WdThVdxh6GWlPVc/AFl
         PWKBSmqZtjGkvG4rIOTK63LV27rnGCivqRsOHUcSMn//j/B13XYOIbq+AOb00seOZiFK
         OtZT+ELKItlvYpZix6SXejvYzaG98ORWHeWNDLhsaZ7zbFpFr+/JQCBZAMj5ChZD4OqN
         TPN9R2nDnpmthpZmODdIgqI/lFVB1WxjCdOeBr/gGyAiPIlaxFSQlbwEcRm/dSLYCIxa
         TZoA==
X-Gm-Message-State: AOAM533j2SX/cNbflBc+2jY2ELV8eIeRTtJTAQkUxXhIC45agqjo5heI
        YDkHjYPhOgxBF9DC4Hm4OmA=
X-Google-Smtp-Source: ABdhPJyDBcW0PosEENTQ3sDnBnPDKMXjaubTO3wpbz5ZLuwfqkkTwpFfSQbEl1mu/+AxQkwsFMixpg==
X-Received: by 2002:a05:620a:280e:b0:680:d1b9:6b0 with SMTP id f14-20020a05620a280e00b00680d1b906b0mr9704297qkp.391.1650884095232;
        Mon, 25 Apr 2022 03:54:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k14-20020ac85fce000000b002f344fc0e0bsm6521472qta.38.2022.04.25.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:54:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     corentin.chary@gmail.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:54:46 +0000
Message-Id: <20220425105446.3515663-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2104a2621e50..c840e83947d6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2529,7 +2529,7 @@ static struct attribute *asus_fan_curve_attr[] = {
 static umode_t asus_fan_curve_is_visible(struct kobject *kobj,
 					 struct attribute *attr, int idx)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct asus_wmi *asus = dev_get_drvdata(dev->parent);
 
 	/*
-- 
2.25.1


