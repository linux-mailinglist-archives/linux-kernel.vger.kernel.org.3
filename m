Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6674CB4E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiCCCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiCCCZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:25:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41D22503;
        Wed,  2 Mar 2022 18:24:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so5526433wra.12;
        Wed, 02 Mar 2022 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bs5ojZXXlLRZXUwC3XJKXaFe2NaCdMkJfCggibvm1pE=;
        b=jg6O0SzIZvQ0dZtavnIktpzmUozBQixShvJVM1Tj6K+wpAtQ5EK0DJTQyMjBbwV345
         kefreXsEKX7onCIiawRPSREjXf/ZFEhxeW1itTQRt9flzXy6Ea08VxuGwfM5XPC7hBey
         M8WBmKlICVK2wr6G2D32vIb47E58EKZ+pGPnMx8n+QEUkOp3Tu+nk/gSpS7tNXFRNtQy
         po1UCpox9K93LsPPlD7eyun4WJ/3GCpGnAf9xmOwfuXUo8/pWyuohd+xmAmpECwXMpcH
         6e3CkeyNHwyBl2Cc1ep4jobHnQXfRKbRj/vfUnCTo+D4HTlUUVG95K1EhoM2QImvUWWq
         HxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bs5ojZXXlLRZXUwC3XJKXaFe2NaCdMkJfCggibvm1pE=;
        b=r5F4aq40arOjSG8sBAspmlBCjf9MoMRdbo6u4MDIdyCOROt44O5osXXm9Ijce/lpHL
         Yuz2Y6dvrdbcJjN86BO9x/vx0cO9FEBo1PkT95umtevB+XSqWxfOphWwTO5rxu+wzbQq
         1tPFuEiwlHOUNRMHUG8QsZYf0IJeSvaCThSzwfD+U4lUzsK2hH6OxAtA+TXUhQzLVTC9
         XvHMjra2iK79NqVyewibmWssMkp19+iufAjel5u608HOa4DjQmtt6hbxCOJQNnBBfVRV
         ZSy9JwAnVy7E3LEUN9o0fwANCAn4gQBp495XpNX3d1nLzgDOyos7zIu9k5t5M38hGuir
         7Ptg==
X-Gm-Message-State: AOAM533291S45gGKT67nme9M57HWQIkeyBn5KvjyHa0K90pJ14IdhalQ
        ZJVSAna0HxtZd03k1Q+8oo8xWQuAqTY86Q==
X-Google-Smtp-Source: ABdhPJwbyH4tQeCUC2s0hLlopCdEpRq6dM05TWo/TQpenI+bJUoLyRDH0qdHpgrQ4DqTGI6KLBB0IQ==
X-Received: by 2002:a5d:4f03:0:b0:1ed:9eb4:9e45 with SMTP id c3-20020a5d4f03000000b001ed9eb49e45mr24240589wru.464.1646274273857;
        Wed, 02 Mar 2022 18:24:33 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.48])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm620979wmb.22.2022.03.02.18.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 18:24:33 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] platform: x86: huawei-wmi: check the return value of device_create_file()
Date:   Wed,  2 Mar 2022 18:24:21 -0800
Message-Id: <20220303022421.313-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function device_create_file() in huawei_wmi_battery_add() can fail,
so its return value should be checked.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Fix the code format.
  Thank Hans for good advice.

---
 drivers/platform/x86/huawei-wmi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index a2d846c4a7ee..eac3e6b4ea11 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -470,10 +470,17 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
 
 static int huawei_wmi_battery_add(struct power_supply *battery)
 {
-	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
-	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+	int err = 0;
 
-	return 0;
+	err = device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
+	if (err)
+		return err;
+
+	err = device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+	if (err)
+		device_remove_file(&battery->dev, &dev_attr_charge_control_start_threshold);
+
+	return err;
 }
 
 static int huawei_wmi_battery_remove(struct power_supply *battery)
-- 
2.17.1

