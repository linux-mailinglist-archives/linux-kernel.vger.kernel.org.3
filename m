Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF8502AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbiDONDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353874AbiDONC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72DA366AD;
        Fri, 15 Apr 2022 06:00:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bv19so15276793ejb.6;
        Fri, 15 Apr 2022 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPSxNSDHQgGlVMg1tM8lN9vUHBMFOTVS8umUM6GB8jI=;
        b=Y0I+oiauERbDc+13+UqLwQy/56ZZqTb359ySoC1oQrP8rFjiHGEyiHeK8XW7JS/3gs
         K0RPOnDx5/ZVsfJQevZGfL37Akf5mGabA0jTV2loWpWFHktgLJ97fa8SV8LpbVRmnDjv
         MkqvVOUQJE9wS8J/xyXRn5+mUsH5M14hBUDTXAHXTtU4UTokoimjQCy+wJcw+PKOgWS5
         7mvGbeL7NbZJcV5f1VIk0NAcMx+Sc0jkUKgUaWk64IY3+cstpeKLWNJNsBa+3+MEnHh4
         6XFwryQ4hsIX44SbtffXFMyVlaY4v5h4gtxZG7CI4iHOX32ZIda3mD7g6lvstGpCQBWd
         viMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPSxNSDHQgGlVMg1tM8lN9vUHBMFOTVS8umUM6GB8jI=;
        b=Qg1aQwPArsj21ESAGfOJHKdtqH0BGIaLBBsAD1vT6q8s+x9WIc7j/Y/DJ/re8DiZ1A
         BY3+UgVgeKOb92SRAPSZ8sqdC41YPKGu3ocPOkEeWEAXLgqvKEacP/DzW8sje0mtAKsv
         P1qlu3dVhzcjf8UJow/7OvaS6UeRfOkFbw98wtEXg7gFX+SwlLhGu58Q4R3WkH6rQBu6
         HKA5jcmoxXPmu8jxYOTGOxfPoT80navEdBCTxFoh3ue232KHhtyPSIbZ7TAoQTt6qlz0
         DTX+5m9qgrBPDpbkHTixEBvMvXyZfzA5vAPtTAimtU89EJhc43nqShNRR8ZSCZsngrfI
         yPyQ==
X-Gm-Message-State: AOAM5330kj3qYPU3IgBeYaUtltWdeveZDMFD/nSlskaaU/1KhICipmPr
        /EXXtb3YJNea+QkHb6l38Vc=
X-Google-Smtp-Source: ABdhPJyY8+EQJdeEK/cKRBcIFV+nz/IqYalQh3Xi4Vu8D/9/kercpjNclTLHrEZnJu7oBw1A1vKdGw==
X-Received: by 2002:a17:907:3f18:b0:6e8:9332:542e with SMTP id hq24-20020a1709073f1800b006e89332542emr5961415ejc.633.1650027627401;
        Fri, 15 Apr 2022 06:00:27 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:27 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 04/14] iio: add modifers for pitch, yaw, roll
Date:   Fri, 15 Apr 2022 14:59:55 +0200
Message-Id: <20220415130005.85879-5-andrea.merello@gmail.com>
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

This patch adds modifiers for reporting rotations as euler angles (i.e.
yaw, pitch and roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d087b2607cc9..aa5f98d3b334 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -137,6 +137,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 0993f6b697fc..4853701ba70d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -98,6 +98,9 @@ enum iio_modifier {
 	IIO_MOD_LINEAR_X,
 	IIO_MOD_LINEAR_Y,
 	IIO_MOD_LINEAR_Z,
+	IIO_MOD_PITCH,
+	IIO_MOD_YAW,
+	IIO_MOD_ROLL,
 };
 
 enum iio_event_type {
-- 
2.17.1

