Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C724B42FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiBNHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbiBNHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D559A4C;
        Sun, 13 Feb 2022 23:38:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jg20so10610428ejc.3;
        Sun, 13 Feb 2022 23:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mR95J2LT/Gbe3zVkCuvHD8OzNfodUwOt0VFxheiVPs=;
        b=oq+uj0YAwVucwdN6fruQ96UOBzwgAnTQQtA6BQAI5pqexaziARwDENWa9kRzSdLsle
         uYg+uRFpb7u4xEtuQxQJ0PO50i63+Qe7kz6fWTK812KY4qZI18ckcmmH+h0ktsv2M+iI
         RwbJKRRpH1caIK8BJmmhKh9ljXx31wyAhaeBG6fTi6hipDtda+s0SS/y83qLjDJhVCeI
         LhwLBAH4UNPNNvFXQbep37Lo5lDt/F+WJZBfWCu+yJCA485IujA7IX73zl64jLU/LMzY
         ZYp+VxNW8rP9IZD16x8muxRwEOkYXgSR9Xj2H4fSiIPSfG+Lu1Zw8NriyztlxmvnNNvx
         b3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mR95J2LT/Gbe3zVkCuvHD8OzNfodUwOt0VFxheiVPs=;
        b=2uWFc8hNeCGiPVSEQMezylj5kq6P29Edu8OZX8SJyrGq/YYDqP1xcOI4JUVdWH25Wn
         tU7KZgJZ9U1LifcdTug6MHb5N0fi/ftbbAeU16mVMZ9mocwn3LghrbMFFtzAN74UhDcA
         yotkbKM6TXRSZCMIL5mhN14m5xc1Zuq4oQmFxxHhTUbWSxHrGhezoHtR5+1oXB8NDE2c
         qkkjLKMVE7HzGlCljnyg5sxkRFRQkOnI1GWDleCAqusgDxEvCJ1GdSbYESc2vh5hVvEu
         2ASbfUKEvFMLvlRsjdsftw4kB95JvZP/sHEsOJbkxU3bkFo3NccWZlbBWNidDtYV5ePx
         5EsA==
X-Gm-Message-State: AOAM533KXId1Nm7KuIkXU9W/62HMjBEy8Tz0VFDKjFLJNuinYBOZYyyf
        P8vRd+w0hSMxUmO3lBhif/alFJCnT/o=
X-Google-Smtp-Source: ABdhPJzSfi774tIJeU3md2VRN1w6gYZZ9dtEmOK96422+bpuCIn88GiYEJybyPuHKniaDqW+Vc/x+g==
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr10125423ejc.360.1644824303095;
        Sun, 13 Feb 2022 23:38:23 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id 9sm2480065ejd.184.2022.02.13.23.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:38:22 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] iio: ABI: document mag_referenced
Date:   Mon, 14 Feb 2022 09:38:07 +0200
Message-Id: <20220214073810.781016-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214073810.781016-1-cosmin.tanislav@analog.com>
References: <20220214073810.781016-1-cosmin.tanislav@analog.com>
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
2.35.1

