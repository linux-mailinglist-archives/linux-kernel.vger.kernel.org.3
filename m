Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C66502AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353881AbiDONDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353889AbiDONC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8306366AD;
        Fri, 15 Apr 2022 06:00:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so15248878ejd.9;
        Fri, 15 Apr 2022 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/IsAmy95v6Y5F9dwTI7MsiIUeU/tADUMkgMK1n/xpc=;
        b=g9eDZZav229dBXLB8mdTF3wixBvTe6ubEoSSfM9sjz8nr8RG+H5D32KRu7AswaxmeZ
         2kIbZjDi/Gp8epxuYrlzlVyaL7h5b4/ROGqIt1S0QbICkxuYz2c39jos8X3Fx5l9rKi8
         sjsfDkUk8ndfEE6rn310pgnKMgT2tC5+2IRYPtl3TE1h0rbG6GW2RyQaG6ljEt9aJCZO
         XFVoCEm1yHn4VUF8KV3L+r+HV7lPwmHgHmlImzIzXrL7xyPuqjwTLoD8mbQNI9WCoLwH
         zsBCReZ0TA3zQ3zpSKqdgvcUFk5WTVHm9U7VOTRDKuum8McGC/JPm8yG7E08zygYvvG7
         /mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/IsAmy95v6Y5F9dwTI7MsiIUeU/tADUMkgMK1n/xpc=;
        b=Vadw0sQ0+vjd/55xg138byWMkVaEw0B6gsa72YNd3T+g2XSbwr1iFrvuFbEXS7Pq02
         oXrwfyGI4qoALe+F+5UJ2SckUeGzeBRfVTE/yJvxIPWVZ3M247E8qhKGVbhFzykMyJ3U
         nEumLcK8NFbxmC69d9ig3wDylp91OOCa1bN+RbIrFO/aySS4U7Tq+R0p/zxYH2QyHtzv
         7lmQxhMnE54UBpdjbcm5wpC+1l7PWk1VqcYRE6phDQMmO3wGKiBNWRM3+DtMSWTb/0qI
         bIaoOOt8fMyiD/+kOEq4QkBXJ9LXu+kWAtMPZmfApGgHtltqonJp0gWQ30T1gN+CsS10
         xkmQ==
X-Gm-Message-State: AOAM533J9AumT50ess2yokX7p++L7ShzOlP1fdBgvIEBG6E3zARIrEzk
        wR5JETWhTWPesJ2XcrB2pZHm64xZDW608A==
X-Google-Smtp-Source: ABdhPJys0ZQ9HFR166sB4kpgHYi3ZnGFUJe8zxstjc/R3tP/qrh3GSgfOuRzBiWg8MQBvrDVtDjlkw==
X-Received: by 2002:a17:907:2d0f:b0:6e8:b710:a68 with SMTP id gs15-20020a1709072d0f00b006e8b7100a68mr5991523ejc.510.1650027629440;
        Fri, 15 Apr 2022 06:00:29 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:29 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 06/14] iio: event_monitor: add pitch, yaw and roll modifiers
Date:   Fri, 15 Apr 2022 14:59:57 +0200
Message-Id: <20220415130005.85879-7-andrea.merello@gmail.com>
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

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 1fee44abb836..ee3f78c47655 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -125,6 +125,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

