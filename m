Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801B4C3C86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiBYDmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiBYDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:41:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B820D50B;
        Thu, 24 Feb 2022 19:41:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso920760wms.4;
        Thu, 24 Feb 2022 19:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=J/nu9vWTGLRLTdhdlJjq+UypSbechtdAVlD7yNR3Zc0=;
        b=BCZB8c7e/DHEUGemalwooiy98uSSrMhSJneLrKy6WlgeP7fnXG5IClsGWSzgU96ve6
         W93b8XVX0g1c4z2hELN5fFfMqSZPALvQC/MsC7xBLFjzJyHx++dFeTNEiaA2//JO0eks
         sjPOArGCgQjRYP7tiMqlr4Cq/khUHc0gAzpOQjTu+eQLFYjvysvTlQ0gJspkFM2W/yKf
         Y6fDYXy2/NnvJ4bHfQD9TDNA6fMntJzCLyFml56syUVgMktLBVNx4URP7oVdMSvr3gmb
         805BMZYJ7Wn4QS8TAFiqvZyz5i5swK0SIoUaHJzSZbVSjQiH2B4Ouw9Chm0UYLOUPOFE
         POTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J/nu9vWTGLRLTdhdlJjq+UypSbechtdAVlD7yNR3Zc0=;
        b=AEyMX0rcILvRCtEpT0WKbF5HH5vehCdbvowD9a6qH4RTsfVrT4IFlT9+Ee6ah46dGe
         mbpoNa0EaeNy0bMRtbC1DAbdeaDWS2r89qWJBuESHdWUwHf8LoYmb39W8yXlIJn17uim
         XEAZy3oyX9KOGY9a3flDBUmEQoHPf0Edgh6US00UGNqmbXwHB+NOpWh8CiT5an2Ph/+8
         fsPW1+7ofMfImz5WQQZkZho7LbwXVSyjIgzdDSGrECXkqnrwL80NsrrMvJLnSne44fzN
         ju5CGF/XQXS5lhlXmcZLb8V/js9dJmkkVIX6mYKXOa58G64CXvE8p5Xl6OurXzuzocQ3
         S8HA==
X-Gm-Message-State: AOAM532GsEPBeZia2V03R6tV5jY3DcN2WkWm4mJOjjyQDZAm3qNdRTB8
        MyivoSyqPLmVejdjM+R4Z8M=
X-Google-Smtp-Source: ABdhPJz5LudkEbRthTuHn7YqZ9Xci1TUSOFUF9uXdTmFeJGCA/TFreHf6pemzbtooj4/rHt3MrNadQ==
X-Received: by 2002:a05:600c:c4:b0:381:14cb:88bc with SMTP id u4-20020a05600c00c400b0038114cb88bcmr893772wmm.132.1645760483226;
        Thu, 24 Feb 2022 19:41:23 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b00352d0e1de62sm1047226wmd.24.2022.02.24.19.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 19:41:22 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] hid: hid-nintendo: check the return value of alloc_workqueue()
Date:   Thu, 24 Feb 2022 19:41:10 -0800
Message-Id: <20220225034110.13341-1-baijiaju1990@gmail.com>
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

The function alloc_workqueue() in nintendo_hid_probe() can fail, but
there is no check of its return value. To fix this bug, its return value
should be checked with new error handling code.

Fixes: c4eae84feff3e ("HID: nintendo: add rumble support")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/hid/hid-nintendo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index b6a9a0f3966e..2204de889739 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2128,6 +2128,10 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	spin_lock_init(&ctlr->lock);
 	ctlr->rumble_queue = alloc_workqueue("hid-nintendo-rumble_wq",
 					     WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+	if (!ctlr->rumble_queue) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	INIT_WORK(&ctlr->rumble_worker, joycon_rumble_worker);
 
 	ret = hid_parse(hdev);
-- 
2.17.1

