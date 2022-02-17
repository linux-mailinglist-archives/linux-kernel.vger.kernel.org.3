Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB54BA5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiBQQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbiBQQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1A9A9A3;
        Thu, 17 Feb 2022 08:27:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so7892591edk.12;
        Thu, 17 Feb 2022 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUSQzyWXxaMbI2StNt6fPks9oaF2ya4dbWkQ8oow7Q8=;
        b=K8tHi1q0F0MS6DAc5fxAjW/gdRCCAZYCmMJAHFtP6RpvEnUE3b+opet9gSno4ViEo6
         OD5z2sgTr7j0w19UzkMRzRJEjVkkEeUm0cyzz9/S6KLeaR7yYwseeDGJID/oIxRWWumZ
         bzeTm5NE5MCoXKR2JgUX8HmyBR6kXcPlfHcOscUqj7Exc81/zR10bMiPf04Yo5JOzmco
         kS2nfSubtHGnBhsrPyxVYUsl2thHNsA3pe5wvSbn07MnoRm94HQ1+R8oYRh/CozHGGcr
         CZUAYygKdfMWE7BX7rcLAQ+IXRaVKcideTLWr/aPR6A6sJ6vG9fLxBMLEesqivBOc1iY
         DnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUSQzyWXxaMbI2StNt6fPks9oaF2ya4dbWkQ8oow7Q8=;
        b=dKZk17kEeKxD9szda2hWk84gsFXTbGgN9S5KUd047p1g9gxVYpO5hutRy/PTmuNcu+
         yPYYPZr6to5jItJXxK2Kw+nu2wR4wMkwrlRe2Yj0KHSFnKai5AdaL6Eke8nyFLbRngYn
         d4cWre1tIkmVA9RnC468PUYpAJ/Z7PPBRl3IlbHSU1nPzKfthtm5jERRJeD/oFytG4GW
         Xw64a18R4I6KSzRxKPO3OXb8W7d3OA3Hc2wKE996U6m+V5qaBHUULcfd35Hp7M9lr1WM
         R0kFgUZXxFHWv/KUd1LL4zIgdBYkM7N6dolPPJ4/ZNQXkAEY94JSk8vb17Qq6ZC5mRjW
         4efQ==
X-Gm-Message-State: AOAM5324qjMSMeOgYhCJfKy3fQ6g7meLwkSRJDgM6+ic2IKqfP4xTOnH
        OjMXc2Vn+nm2m/z6Ngo4M/8=
X-Google-Smtp-Source: ABdhPJwrqGq7kWppBcG1ujF2Syq7eb/BIMxC6J3mTZy1sFxDccRqTGjlc6CR9+J99QAXAutgIc4Ayg==
X-Received: by 2002:a05:6402:2922:b0:40f:7241:74d4 with SMTP id ee34-20020a056402292200b0040f724174d4mr3522116edb.43.1645115245788;
        Thu, 17 Feb 2022 08:27:25 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:23 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 03/13] iio: event_monitor: add linear acceleration modifiers
Date:   Thu, 17 Feb 2022 17:27:00 +0100
Message-Id: <20220217162710.33615-4-andrea.merello@gmail.com>
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

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b94a16ba5c6c..84c90b8fdd91 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -121,6 +121,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PM4] = "pm4",
 	[IIO_MOD_PM10] = "pm10",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

