Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB76500A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiDNJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiDNJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:42:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393418349;
        Thu, 14 Apr 2022 02:39:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2790259wml.5;
        Thu, 14 Apr 2022 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtL4PfIKAQHImqDfdsnYHC8wpiKIcPT767j29SH/w+M=;
        b=dSuYjD4dOgLzqgimwlqKtIZPGMEpMI5L43hQl49NMM1jYBVO+7ch3hziIXWtKxiDGh
         UI96AezjFgcw+/ZbUfNqEHIKtloVnTMvtG4ZD8AR7EFytcuRLqlUw6Ls4TDFUl8aEQlJ
         dBobHdWK5WpdoZnS0v22whzMGmwOT8cSqmp9nO0K46AE9HfksV8+ULgS+cbZEo039VTh
         2fyFqGUhV+JhY0DoV3QchPE70ZUvFH9KXX2w9qNhiDlkeP9gArhO/uC7rk7f47HjTfha
         lIKu+KsLwa1B/kewIXosYTUOEhDfRp22DldTHqbf+BP+lX3+kjXUYnH29k3SEXY+Ci5C
         kYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtL4PfIKAQHImqDfdsnYHC8wpiKIcPT767j29SH/w+M=;
        b=u24x2riSQnVB01fYn9p5+BUm1COtcm3D7tuztFa52OfHU2ofsqlVzViBwMAYkfXoKp
         SIjhX8BDh3m8u8akjkipE2b0LJNHrfETaD7IoivXDXwmvZ92ibbldN7OHxB8tOnCQ97A
         d4SARzXWa9jl5ggq9ZdZBQO/7Br6JU0TWX73CWXTv1pigFle+InDWctnoqRJJnA9XSn1
         BS7yzvsCNHpned/Nb4NVAhrfeyvTnOw5POV/E7XbdSMbjIBUGDCsHhKbseeXnHLS6ngB
         T4JZzjis9mQ6+PFQPPdc3KTjll5STEpmygDcIA3yUpLN6sToo2vuZj3pqalCg9vweI8n
         XdtQ==
X-Gm-Message-State: AOAM531vxEWWkhg30qh7NdcMQS6IajCupOiACwyBbtrY3HlBVViiQLHr
        Q9StAZeaHQLfRrlvm/d43yk=
X-Google-Smtp-Source: ABdhPJw9xkbW1XNdvckIj25AurBQzfpQUc9bgLajIGEhZ1Qt8HdBmTwwlxBFODE8lW+Nro16pLNO1Q==
X-Received: by 2002:a05:600c:4e8b:b0:38c:90cf:1158 with SMTP id f11-20020a05600c4e8b00b0038c90cf1158mr2788409wmq.107.1649929187578;
        Thu, 14 Apr 2022 02:39:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm1670354wri.45.2022.04.14.02.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:39:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hid/hid-lenovo: make read-only array tp10ubkbd_led static const
Date:   Thu, 14 Apr 2022 10:39:46 +0100
Message-Id: <20220414093946.294449-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array tp10ubkbd_led on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..c7b25a67ab09 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -835,7 +835,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
-	u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
+	static const u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
 	int led_nr = 0;
 	int ret = 0;
 
-- 
2.35.1

