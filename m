Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEB4AB23E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiBFVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiBFVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:13:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A7C061348;
        Sun,  6 Feb 2022 13:13:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id og43so12388415ejc.0;
        Sun, 06 Feb 2022 13:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H15gy/ocJ3lh6QLJW7NZUAAdGXjkh3lMGdqvh2wTFcg=;
        b=Y0/MU4FG+6LgCIomPN00Q09bWAxvZLMzxzYHgX2LiVkVv9St7b7ERcMUULcag+i2B1
         dJ6D1Q+KTLNu+ROBs+8IT+ujxrsWiDDqKL9oqhwJRwe9MUFdQbKZOa9ssa8UZo5t2qfT
         ox9H3ctO/RyntTrwDgJ9QJJkZ4cun/O3KrpjqMOFLu4kcYo5JBcGLFU9KBG4HP7iTp/D
         dD4z4oah/XyjCjIwIi/fUGwvVdi+Zt9FXJtgeDDVcMzRQ9ZVHATszL5YzShdo4pfKsug
         L5fU4AUYgahDKQAVV5OyIO/YFh8AzbepVKbwaajjCM1D+WUaQGzyFOEi7WY1IXRhYWp8
         b+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H15gy/ocJ3lh6QLJW7NZUAAdGXjkh3lMGdqvh2wTFcg=;
        b=fkTxYgMIS13b6JruRVHB58cDkbzFBMRoEV44nvHR9uzOxD8L4GHLEh8ryuytQfqC2o
         V3YEBCqY9qHRz5rsshteakM5/IqvZ7Fq6bHV7q+l38J8T+cO2dNVMFRRvCBtrypeG59q
         2BCkm6kAmAUqEqOQ2Dl1QNeOUBEvIEUNDAYuqxIt0LVhG8WjhlD1sTAZDEYwN9yXmeYj
         CYqPeg1impeQBhaPMUBr0yt07OEqIzOJPb/onAguw/GlmXdlKa2pWdSLfyepTyATIhXQ
         0maWG25sXWWypxCjUNgww5bsW60gaxoztXrSa4ebUSz32VMujfl4BlXegcfDAhQiqASa
         wNYw==
X-Gm-Message-State: AOAM532xO/yzx+xbvKOjljfEYVvpPTbln/LYRpfL/njUDECY1AaJ5I5p
        qr107osF6heiNrdRRS9SXjU=
X-Google-Smtp-Source: ABdhPJwZ4ohwiIIoL1XPwpl7Te3h6v+tUWNTtRaXiz87yedhSc1V3hapNWXVlUJbjzt6cZyqFN5RKw==
X-Received: by 2002:a17:907:3e0c:: with SMTP id hp12mr7519857ejc.685.1644182004124;
        Sun, 06 Feb 2022 13:13:24 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id a4sm1248598edr.33.2022.02.06.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:13:23 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] iio: ABI: document mag_referenced
Date:   Sun,  6 Feb 2022 23:13:04 +0200
Message-Id: <20220206211307.1564647-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
References: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accelerometers that support activity and inactivity
events also support a referenced mode, in which the
gravitational acceleration is taken as a point of
reference before comparing the acceleration to the
specified activity and inactivity magnitude.

For example, in the case of the ADXL367, for activity
detection, the formula is:

abs(acceleration - reference) > magnitude

Add a new event type that makes this behavior clear.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c551301b33f1..41c1e3e1bf30 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1213,6 +1213,32 @@ Description:
 		number or direction is not specified, applies to all channels of
 		this type.
 
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_en
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_falling_en
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to in_accel_mag[_y][_rising|_falling]_en, but the event
+		value is relative to a reference magnitude. The reference magnitude
+		includes the graviational acceleration.
+
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_value
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_value
+What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_value
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_value
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_rising_value
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_referenced_falling_value
+KernelVersion:	5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value to which the reference magnitude of the channel is
+		compared. If the axis is not specified, it applies to all channels
+		of this type.
+
 What:		/sys/.../events/in_steps_change_en
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
-- 
2.35.0

