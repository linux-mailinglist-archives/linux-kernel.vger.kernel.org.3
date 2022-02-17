Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE144BA5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbiBQQ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243131AbiBQQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001109D049;
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u18so10609758edt.6;
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1lf4FhtmSrjRervVhT4u2h9DSLojyjyGeKukIuGLl8=;
        b=qA9O4jM8Rpp0h+8je5ee0Y3ZvLuG8MEKeZehi2TTPg4vDluFqwbXuIyxtHN/4SYMPT
         qYyuhYn5jvDdTfiNJW+Bl/YnFh+pDRiK4v2EdjA0KvW52zAZjHQpoC7d8Y5wyDBdqwlj
         EbsZOxN1MxFpp5zlRxb2iYjDgUHH6ICEKYRQeQu1fWgUmgtSxYay0zNSrJCehDYwLoAh
         Yg7mQUSk5kTDMP7STeoiJ/05w0gXMs6BvEsTHIdRin/rCipzA02dWuzo62R2rnVB6BOe
         zmwWzfGQNrMLP+mo+J3FTH5WB8nIgVkHbIEEoFKq1YPov2uvEKuMqmzT/dTn4qpWnQZW
         1Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1lf4FhtmSrjRervVhT4u2h9DSLojyjyGeKukIuGLl8=;
        b=MsC0h9idjGL60Wf0kYN9vGpGhrAthl9VMhNUUvyWh9mFChA+CXzWbZnl2vg/2UUvX8
         pgvO1qSgXR2Q5nMdQQTftz/YOLA9Xoryz2RM9e9P+XBDs7QZcMM8AzPWqJnGP5PccrIj
         LeYWDif2bqx7QrfC6pQpAklstSswrUrAkA3lmtyqFMKV1cfpZdFmv6uOfFmBrDGN+nyq
         k4QyBYZr3/VE4VNe6jrxIj7FC66H2o1dLij1A8Va9dOT3S7mJxQhfKsVhAQpcl6s9Ky2
         dsWP+Oazes7818H/QZWlgY6NGG3NkBrs7D6YKxdqVDLejbnnK7o642UopnXUYfqiLDzS
         yJ0g==
X-Gm-Message-State: AOAM530MZGk2u1VxV8pF8B/5DVLkcXMpADd9wtcLsjKnwQ+lbYBWokrU
        TAsfRHTrGLvzyhy7JGtWJeg=
X-Google-Smtp-Source: ABdhPJwK0dz8/t+csV+CCPJwfyJJVoOWYDkjjszr0PICbEDBT8ZSjFn9mcwd3hdKEwc3pl66vDdcBg==
X-Received: by 2002:a05:6402:518b:b0:412:80a3:fb6e with SMTP id q11-20020a056402518b00b0041280a3fb6emr3588220edd.84.1645115247559;
        Thu, 17 Feb 2022 08:27:27 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:27 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 05/13] iio: document pitch, yaw, roll modifiers
Date:   Thu, 17 Feb 2022 17:27:02 +0100
Message-Id: <20220217162710.33615-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This patch introduces ABI documentation for new modifiers used for
reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b2fb4d9abcd1..1b8d77577608 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2008,3 +2008,12 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings. Units after
+		application of scale are deg.
-- 
2.17.1

