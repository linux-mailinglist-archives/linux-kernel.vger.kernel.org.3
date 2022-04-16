Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5845034A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiDPHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:39:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5BE2F5C;
        Sat, 16 Apr 2022 00:37:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q19so10062298pgm.6;
        Sat, 16 Apr 2022 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nKscqrpjgkCr4xCyAbvUJu6oMzQ5EF2mv6v04Gczg20=;
        b=cCyIYCok9lQbFm/qUBuf5Yjq9KylFP41lC10thE6pw6c4zX7wdN4nyuF2LBW0mR4HN
         BGMmcGcm31xxsmArq1OIUUV870KG+TKWHEJYe2KYiNjhBSpVNnJgu5Eg2jzE7BrKF2hj
         Quv+4ulEuKxzo4yaocYk3VmNPItJeofWVCkWscs5eNAlD0FIfIkIaBCWO5shK3AfVNpC
         FoqGQ2SPLHFH0R7fLtXMOsSR5GHzcEb8OCKPq266n9QDmLG6HPFa8/Si7AVr5BAU0cgu
         RWv/nqG6gr7mDWYdrDYBODWUUFTxvQHNtWnVhvZA4rip372IkrdM2x23Gta3RioxIHT1
         0AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nKscqrpjgkCr4xCyAbvUJu6oMzQ5EF2mv6v04Gczg20=;
        b=G5v0ASxU15TQSal7uTePzEeduki9D6iRJJUNakCv3NExs/J5wmMNfOoOUsCMrpe440
         meL7R9HTt80mU4uor3i5jvHNvpWirrjIVtL8ZXBYu9cU46T61gbqNMJiXtFrpMm0IT4m
         gqyTVXR7zRsU+NhWczdK8/ldL5OOC82h4oqfKb8AK1LkmssfgvUEDUpvNixbGH2EY89W
         mvIGF+5zF0Dz+qpwvMIPE5g+yoUbChjzldzHlIwt1a6KBDysk2PsKZs7Dgwo0htofEzr
         /O+8c41RZoyy/ljGnbFMyGNbN2zkk6wPYeyVGjjaXXYLqKC8XCYTUb+r3Mtt/MJO6SU0
         7d+w==
X-Gm-Message-State: AOAM532CZbGDxC6uNgEKWVe55M8oFpvEpnH6lpVsa2uzr89/+uYZH+UJ
        zuXxZkYZpdESd/VXgq//DNs=
X-Google-Smtp-Source: ABdhPJyb8sbsDC1xiGFNJs/3179OQJAvbFi4c69b/yY+yxKqIynE+XfkTYpuZyK3kGj5G9DqKOKs4Q==
X-Received: by 2002:a05:6a00:1254:b0:50a:55c5:5ff7 with SMTP id u20-20020a056a00125400b0050a55c55ff7mr525399pfi.85.1650094646975;
        Sat, 16 Apr 2022 00:37:26 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id i13-20020a17090a2acd00b001cd498dc153sm7749917pjg.3.2022.04.16.00.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 00:37:26 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alexandrov Stansilav <neko@nya.ai>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] HID: elan: Fix potential double free in elan_input_configured
Date:   Sat, 16 Apr 2022 07:37:21 +0000
Message-Id: <20220416073721.3954-1-linmq006@gmail.com>
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

'input' is a managed resource allocated with devm_input_allocate_device(),
so there is no need to call input_free_device() explicitly or
there will be a double free.

According to the doc of devm_input_allocate_device():
 * Managed input devices do not need to be explicitly unregistered or
 * freed as it will be done automatically when owner device unbinds from
 * its driver (or binding fails).

Fixes: b7429ea53d6c ("HID: elan: Fix memleak in elan_input_configured")
Fixes: 9a6a4193d65b ("HID: Add driver for USB ELAN Touchpad")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/hid/hid-elan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 3091355d48df..8e4a5528e25d 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -188,7 +188,6 @@ static int elan_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	ret = input_mt_init_slots(input, ELAN_MAX_FINGERS, INPUT_MT_POINTER);
 	if (ret) {
 		hid_err(hdev, "Failed to init elan MT slots: %d\n", ret);
-		input_free_device(input);
 		return ret;
 	}
 
@@ -200,7 +199,6 @@ static int elan_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		hid_err(hdev, "Failed to register elan input device: %d\n",
 			ret);
 		input_mt_destroy_slots(input);
-		input_free_device(input);
 		return ret;
 	}
 
-- 
2.17.1

