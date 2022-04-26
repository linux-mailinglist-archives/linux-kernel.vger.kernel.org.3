Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6075C50FE70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350690AbiDZNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiDZNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8A4606EE;
        Tue, 26 Apr 2022 06:11:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y21so11180654wmi.2;
        Tue, 26 Apr 2022 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKx1b0NvaH8kFxQ+EHOs4rlt+iCsdN+kGeGJ6aw9S7o=;
        b=q5N23yzWReKYDuPWUdb3XxejFd1czu527/p8vkDdTP+nIGeefwXlG+jP9E58h8BftB
         thH0khlCmf5Y5OxJfsMFrMls2+WXaYqw5ICpAVRNYiROMnZGSQ+c7XOb9rdNc2t3yhqN
         N5MOs2qOkxQMpC3GCShZETrrmx+KA3993QU37lzvRyq3Rc2Scl5WsLWwJL/N+sZjvmkd
         gtrjAItXTpDBZzc0iSsAOPGFI4r1q2ZlvFzK55eib+OsnQqX94ODupOdkUWhhGMoxXrt
         G1pVSqrPQRwX6FlZ7cjDDJYDcFsbe7KDlbB1eXEgqXZp97hYhUKfaSNl1mGKsNZFrE5R
         wCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKx1b0NvaH8kFxQ+EHOs4rlt+iCsdN+kGeGJ6aw9S7o=;
        b=KD6WrYEmHLNOdFt75ZbAYLtXhzhvUoZ7hKVXQrm6tdYqEazxRBl0hozAxpcH5Wp5js
         ATskbn7uf5IdJvopfgKN8FJ98AfgPkJBWmgJX/4VHseAFdo5ZaWEbbeMmIWTYmVKb+et
         x11i1AhRHXeCPX42ygNTpNzi0Kaq7zP9Ez6Ekby7UutbHz1q5WNzz+kO0ehv8ITNNptZ
         E0Jc0UvqSYLaNnAQjk/UUQ2y/NIaciQDjzmbwNVbhe/HUK7jTf+5YLncKDjC7l8XXrup
         qeWPRFt1TI7brHZVNL3/NQxwbqHyRqiEUe3LUtLatDMi5eb3TQp5R5ZMkNX2MM6ULMXt
         v35Q==
X-Gm-Message-State: AOAM530Y4Ss22cNR5sZS18JbTJy/fpzKesOJrC6Iin3WyqxwVW3qtxxS
        siW5p7EXZ9aftOmoeIcP/wo=
X-Google-Smtp-Source: ABdhPJycgzh2YWj8/8RXhbr1tCXWVaqLVJ3qu/HSZrxHcwgZTHs/rpGRoVFpUy5cmHQWeunEm1NqSQ==
X-Received: by 2002:a1c:43c6:0:b0:38e:bb4c:6e1a with SMTP id q189-20020a1c43c6000000b0038ebb4c6e1amr30519041wma.111.1650978668676;
        Tue, 26 Apr 2022 06:11:08 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:08 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 01/14] iio: add modifiers for linear acceleration
Date:   Tue, 26 Apr 2022 15:10:49 +0200
Message-Id: <20220426131102.23966-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

Add IIO_MOD_LINEAR_X, IIO_MOD_LINEAR_Y and IIO_MOD_LINEAR_Z modifiers to te
IIO core, which is preparatory for adding the Bosch BNO055 IMU driver.

Bosch BNO055 IMU can report raw accelerations (among x, y and z axis) as
well as the so called "linear accelerations" (again, among x, y and z axis)
which is basically the acceleration after subtracting gravity and for which
those new modifiers are for.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2f48e9a97274..d087b2607cc9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 472cead10d8d..0993f6b697fc 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -95,6 +95,9 @@ enum iio_modifier {
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
 	IIO_MOD_O2,
+	IIO_MOD_LINEAR_X,
+	IIO_MOD_LINEAR_Y,
+	IIO_MOD_LINEAR_Z,
 };
 
 enum iio_event_type {
@@ -115,4 +118,3 @@ enum iio_event_direction {
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
-
-- 
2.17.1

