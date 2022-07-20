Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8357B072
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiGTFnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGTFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:43:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31148CA2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:43:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f85-20020a253858000000b00670a44473e2so83590yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cjGzXKu/st/bF6b6ISAjY+s0vz3froHk5QhAxeX2XPI=;
        b=QfOW8x98cL7o5h/Jnu53QDF7I8O5KqdTpA+EOcAaiUYmvO50VECLLwyM630PMxW4zt
         XxL3Pqwu3Qr8CiGFjxs2KJB+sgM+bePz3ZypCQjy/KixeL+b5cVBwRZG3X2rMf7XHYPI
         eYfhlB9y+VHV4A/sVfvYV+lWv+NOGn3PDmnrNXtlNkJ0J12PTx2ssczvi6YkNfqxpU7o
         KASwQ+GLWeAXAVzQymKCcBhAEWAbSTbjD6s3HSgJ54h9luaqGZKDXr7p62OG4Uu2k91A
         aQFhDbd4ozqVgFpLnDtTfS02DGiOVsDnMjP0W1pzpndAh49lQ5iw0imxgJuWFbAiYf65
         WnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cjGzXKu/st/bF6b6ISAjY+s0vz3froHk5QhAxeX2XPI=;
        b=TUhjkIQ2KHeFCBhITlPJTL8mj+ruBFGXsA+p2XHOnT8zpzMUrKwwSLrCa8Ziv5VBoL
         VNsVo2BWpWBEoexqwLFbilYN2QgzctMM9BItKBP1bjx0rvDsg4Cejb0EzdmjE837URfa
         ryU21XjSiQHemlzrsz87HEVEEx0mljYgFPoUSOflqbq7WycxsvvhwvN0oAgV4GrhCJ34
         wNplBjTu8Y8ypEPw3tXhIRA3LvueOpOw045frzMNXgrolK+v5j4yBZbujJaRLUae6crZ
         YvEOj7Xq/97gUQNgDPXY0Rce4gGufPZfY9bLwLHQodPgybKSu0IjNY4unz2BNPNIHejC
         mvjw==
X-Gm-Message-State: AJIora/sqTzy51YlhL1BoPPWxHOeZSQZM7D/C/T522NOEI4du3u7711m
        tliwbwSACv3GMN0vnkjdfRbgp6MKLa1f
X-Google-Smtp-Source: AGRyM1tdjSlEhj80iAewkNbj14Gu65E+5o2HUgK1NEq6DcM3EsG9TstpwDz79tcYKFDum1DxdkXYKGyg26TF
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a05:6902:10c:b0:66e:445a:ae8b with SMTP id
 o12-20020a056902010c00b0066e445aae8bmr34793456ybh.282.1658295780164; Tue, 19
 Jul 2022 22:43:00 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:12:25 +0530
Message-Id: <20220720054225.1623875-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] HID: nintendo: Fix unused-const-variable compiler warning
From:   Aashish Sharma <shraash@google.com>
To:     "Daniel J . Ogorchock " <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following compiler warning is produced when CONFIG_NINTENDO_FF
is not set:

>> drivers/hid/hid-nintendo.c:405:29: warning: 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
   defined but not used [-Wunused-const-variable=]

To fix this, move the variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' under the
CONFIG_NINTENDO_FF's conditional compilation block.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/hid/hid-nintendo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 2204de889739..69de7504bdbc 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -402,8 +402,6 @@ struct joycon_input_report {
 #define JC_RUMBLE_DATA_SIZE	8
 #define JC_RUMBLE_QUEUE_SIZE	8
 
-static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
-
 static const char * const joycon_player_led_names[] = {
 	LED_FUNCTION_PLAYER1,
 	LED_FUNCTION_PLAYER2,
@@ -1512,6 +1510,8 @@ static void joycon_clamp_rumble_freqs(struct joycon_ctlr *ctlr)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 }
 
+static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
+
 static int joycon_set_rumble(struct joycon_ctlr *ctlr, u16 amp_r, u16 amp_l,
 			     bool schedule_now)
 {
-- 
2.37.0.170.g444d1eabd0-goog

