Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06D502AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353884AbiDONC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353845AbiDONCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2736695;
        Fri, 15 Apr 2022 06:00:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg10so15277574ejb.4;
        Fri, 15 Apr 2022 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29kCXmwo2u1Er8ko36SvdYgCgJQmCwCSFQr4e60M0d0=;
        b=N1zj3zGsKaz38rLKJSLF7CFulZtyuk7SzaajDOQYddndqWkCyRIB1f46EA+ZmQegAA
         sKEGbfdv8yPv9BPgyPJ3NPSMxujD/6rDkvS4ahCUPNXSgR8eGVB3BsE/NbGtwulc/qqK
         +aXYETMJx2qvOYbg2Sbpf5mIJutAjdW3rIITVh/bhYhHroxCPU/Suy+3VY3Ce+ZFkWGu
         hBhfRRWbIH02JbpAN2zFRQBUEkohuKvSiNXi7QkF4Me2xamPVMDbYGKVFyEKj7atjQaL
         SbdeEuOu7E04Jb0ge09jK9XTsjH29/da+TO+lrB9IaN57H5GRkT7U+UXWkvfTZtTmUwY
         RZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29kCXmwo2u1Er8ko36SvdYgCgJQmCwCSFQr4e60M0d0=;
        b=g/ECiUbZPcYHYBdqbT8TizmPQ76yCWfa0rDuNYhO6djRiqyRcME6Y4W/aMVKak59Kf
         ZysDroQmT8aYM4UYZNF4Lj+HBHniFYwHvnXc09MgxNa+oWsH9dY2elpXE+LNyZI97u82
         OgU8JeYLM04CQr7T2VUNoD5LJoNzYSdaNrOtHUoLFy2fgzGRXJ/fuTA55eZee45b5viO
         cWHWZZ1lUEP3XP/k+CyOnY799A3MX1eAjG3O7+goZnm6EYf3u4JwtZ/WbKj+Q6s5KdcJ
         Onl4WWD32n/+kQwANjHMTvFzjqqIes7fxrNHTLLTGSSCXwC0cgGmrmB2LNzMQz6vJKlS
         vRpA==
X-Gm-Message-State: AOAM531GkOcUby1cmOaVj2o/L7U/wIe1rnxRT0b+E8fow74EDuqyfdU6
        BMpmQSD7P/VWBTZA9MBi0tDG2tTzoMMHkg==
X-Google-Smtp-Source: ABdhPJx7amnUFsd/EoReRaAj+KQMYTNsLVh/34ugeb+f75bGtvd3RqQ3OVV8RLjV1gYiM0anO1Ts7A==
X-Received: by 2002:a17:906:314b:b0:6d6:da31:e545 with SMTP id e11-20020a170906314b00b006d6da31e545mr6375946eje.125.1650027624384;
        Fri, 15 Apr 2022 06:00:24 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:23 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 01/14] iio: add modifiers for linear acceleration
Date:   Fri, 15 Apr 2022 14:59:52 +0200
Message-Id: <20220415130005.85879-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

This patch is preparatory for adding the Bosh BNO055 IMU driver.
The said IMU can report raw accelerations (among x, y and z axis)
as well as the so called "linear accelerations" (again, among x,
y and z axis) which is basically the acceleration after subtracting
gravity.

This patch adds IIO_MOD_LINEAR_X, IIO_MOD_LINEAR_Y and IIO_MOD_LINEAR_Z
modifiers to te IIO core.

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

