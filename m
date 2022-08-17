Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37104597566
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiHQRvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiHQRvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:51:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C387DF4A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so4339972plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vTaJzQMO9aQaSOztqsBCXeGz2f0zGMSY5MlxCdWwSg8=;
        b=DsN5uK3Qx9r++HxQBJ1lui6N+wacnFiEazIAmLmiNiJDzWhBbfTpscZgRt/kD1x3en
         bRDEE9ZT90xgeszZQsGk10Pbbyt1Wh9jIfDK5GWOevKkz1sV2wcROYowHFyAAUr1ktRl
         cDjMwxZi9tvYjoZxsJYItha//CYf4pky7QjHPihJxQMRcwKZXKnuRZwW7IklnqWJ5F0j
         Oh1NFSHD2aqrtBjfaGUrCgaCqgyTx9/ng+2z00GNd9t5kOO0MN7JA4JWxgjuCKecwhI0
         oTO9VtQxlWYw4R3nfLrvSjhZFRdo0/Bo4HaS6MJ1/7+cbFZQ8Zox/IAPPG6gFVRSjzjc
         X08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vTaJzQMO9aQaSOztqsBCXeGz2f0zGMSY5MlxCdWwSg8=;
        b=S7PcbuuJyAsQ8yU/LX4NeGRMQpygZbBb/YXN6X0Mvd2ByaO2qaXM9KvA2Zh6HPTZ6S
         zz8yAtqcmNyUN4BE1af5OQtsq9OxhQhBzEk/u4Q6Bm9HYqMdJvjlZ1UwU8siVNiRK7eX
         y6kbo53tU9Jr5YYKiZL1nbt+q5AkPJwy1odhXLptVtbD+KD5toCkBjGMb4XMty1lkwBO
         E8SmNqMa0NjrVN42Yprsg6qVdUfNXcPeJm3h4saamZ1lRXEK28AeONqO4goQV+DOlH8w
         4A5hPueN7p7rNmowBG5Nq7jtRN69yet1bRYDrn2GSbyhU3MT41YwnpHMtpAYDfubmIZl
         38Qg==
X-Gm-Message-State: ACgBeo1GG2qP+PH837DJ9/KoGjNIAMbYP1IRbhWkiim8dPf5zMZSZsEy
        8pulcG0Bt9oQJHf6bj3oA1KI0g==
X-Google-Smtp-Source: AA6agR6ao0Kwumx3g2Nz2iTxby04cWRKempFAOIikTUj3O8i7DqI/uRvjT4Uk3NgWfTcXdY6DLo6Yg==
X-Received: by 2002:a17:902:f548:b0:16f:9649:be69 with SMTP id h8-20020a170902f54800b0016f9649be69mr27156844plf.134.1660758698082;
        Wed, 17 Aug 2022 10:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b0052f0a616a87sm10734127pff.168.2022.08.17.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:51:37 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v4 1/3] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Wed, 17 Aug 2022 10:51:32 -0700
Message-Id: <20220817175134.15084-2-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817175134.15084-1-nate@yocom.org>
References: <20220817175134.15084-1-nate@yocom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds correct VID/PID for this XTYPE_XBOXONE compatible controller to
xpad_device[] table.

Signed-off-by: Nate Yocom <nate@yocom.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..c8b38bb73d34 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -131,6 +131,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
+	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
-- 
2.30.2

