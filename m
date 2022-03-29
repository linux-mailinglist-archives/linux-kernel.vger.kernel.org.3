Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE27D4EAB75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiC2KkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiC2Kjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:39:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D94C1C8F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so34246498ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kRd1utQ0XFLJLhNu07hetcx0o+NgkTYajwaCfJlOY4=;
        b=WHElOZQLfB6m1vby6aSvUz16LlOEJkDm8RPH65tmFunekK7r4qddOcpBI7251A4EEk
         Enhr1RCbTJy77Mji41VhJmafNeJAPuTkEhBxeumFwq1UC3i1I7moEXRHEHbUoPqwEq1J
         PIkY0kwoO4/+o4yAn91gT9yLhi2MKM/Cu6miHD+v6vlyELY6pLA9204KpiCW550+2dxU
         tcntQhCNaVvGfBnNZinmbNKch6fc6c7nlxEldX6fUZYcBxzoQoXADfAX41nKInlfVPif
         5KalSEaWMnBFe41yDlubpuKEkIA/lnTFNAJrudwEb9T4zw9vyZu7uoTz7XuGQJ1MsWQc
         Hvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kRd1utQ0XFLJLhNu07hetcx0o+NgkTYajwaCfJlOY4=;
        b=ufSJtMkau/7yiJ1RjkHjHBCfNsz1yjcdVf8mVb0gl3/xPVELcirbFp8m2L52XQuxH1
         OuaSiQQruxXUpxOWP7bIvAuF5dD/jH7nr1Q1RqwVhqHZxESgWBWDixYbU4QHFWC6I9u4
         m3zQyXMGQLt3a2jYkI8RaqPxJ7vw5IlK9xs2dkBLPb5lhip26Mo4uhE/Rd+4L5Glkgkc
         zeZn2vhsbBkkWeeVp+3aZD4t9TAiFfrdJyK/3h5tph0bCVhn0KRzz2in+IUUUKhWHPzO
         7z2tjlca9mFvt8PWLY/ZqaDoMwo0S10DqZhQ7AMrOqUlxwO2WmFl213nZxHtKvfuxZ9N
         d2CQ==
X-Gm-Message-State: AOAM530g4OqJ9G9FqRM0xVxO60NChl4YG5aRDwL/LdP3FV4r1c41nxq6
        MvnRTiilguSStarlIZIpUeM=
X-Google-Smtp-Source: ABdhPJwU2bo+W22b/KjKue5Z6njLOH+Ry09AX9c9Z8ISBv/rBusj2oMODp3UlkouaJTZ3cdYfpelTQ==
X-Received: by 2002:a17:907:6e04:b0:6e0:736b:d786 with SMTP id sd4-20020a1709076e0400b006e0736bd786mr33015803ejc.667.1648550286892;
        Tue, 29 Mar 2022 03:38:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006e03017d60csm7058151ejc.54.2022.03.29.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:38:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: refactor rtw_usb_bulk_size_boundary()
Date:   Tue, 29 Mar 2022 12:37:53 +0200
Message-Id: <20220329103756.6740-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329103756.6740-1-straube.linux@gmail.com>
References: <20220329103756.6740-1-straube.linux@gmail.com>
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

Using ternary operator to set a variable to true or false is not
needed. Convert two such uses of ternary operator in
rtw_usb_bulk_size_boundary() to just use the condition and return the
value directly instead of using a return variable. This shortens the
code and improves readability. While at it, remove an unneeded line
break from the function head.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 14526fcff4ae..3416c8baceb6 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -47,19 +47,14 @@ static inline void rtw_reset_continual_urb_error(struct dvobj_priv *dvobj)
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
-static inline u8 rtw_usb_bulk_size_boundary(struct adapter *padapter,
-					    int buf_len)
+static inline u8 rtw_usb_bulk_size_boundary(struct adapter *padapter, int buf_len)
 {
-	u8 rst = true;
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
 
 	if (pdvobjpriv->pusbdev->speed == USB_SPEED_HIGH)
-		rst = (0 == (buf_len) % USB_HIGH_SPEED_BULK_SIZE) ?
-		      true : false;
+		return buf_len % USB_HIGH_SPEED_BULK_SIZE == 0;
 	else
-		rst = (0 == (buf_len) % USB_FULL_SPEED_BULK_SIZE) ?
-		      true : false;
-	return rst;
+		return buf_len % USB_FULL_SPEED_BULK_SIZE == 0;
 }
 
 #endif /* __USB_OPS_H_ */
-- 
2.35.1

