Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43D5280CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiEPJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiEPJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:23:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FADF62
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:23:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q4so13850988plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9PJvhEX8P9EwLto+E+6JAbwn0v8MnYujSttxKDDDe0=;
        b=gyHPkeZ1dgLRtMeRxdorI5w1fdjB4J3YmtzSTmkYFa8IUSpX0xpHYUz6U+4twmmwTl
         oDF+u4ROFIAMLF6MCty0pjThUiK0gdwlkvt9L5SPTiudgVu2t/wlq0yMl13jv1blq2q6
         oOe+INfi9zlAWSr541+QEzyXk65XY5HikjzRrzPZIWu+QPlPxHIdQPAkWuKMACxu4NZY
         GKHqQyzG9iUvZM2Mor6GFnuymkeDbA/4SWZicX8d21pEIEP/2Zi0IaWQd0F2H59XSl/F
         OSQwkKKFUA2S3Vs7p2xfbEAw/PjGzSA4GCif8M8MVTJLhEriGYPEAqcEoRVyTdOrJPzD
         6p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9PJvhEX8P9EwLto+E+6JAbwn0v8MnYujSttxKDDDe0=;
        b=S/g6UQo7cNfioIaW5bvaG5DtZZ2kF4mLA7uR40Exwa9xSE6+HoXrh7499SOcks9NLg
         EyWe9U+Pju6dvsCXMfz9cx85auCgTn3dVDYwoFKJU5w8pYRAAAwjiYORhu3PkARwe+ba
         4Pv3KEgg4hii1sz7/eiDRZw9PxC1jRG5LSOhbRwZm+YSJ70dGtltBgPhIA5oqS5pIC0E
         X3a6B7D2GGH8tpzizk2S2PvDSTzWfMJRmN7X6VFuanRoR+ejCq7EXLnDhlT45eC3HN3r
         9wTw0GWcgMZPr6qB75Ku7P3OvrNiaINuH/1qEU1+QI97gycxL0h5sYwOJ3ypnNBz5iRv
         AZsw==
X-Gm-Message-State: AOAM5309WhhL7Jviy0RTMoenw8FxODuFYkUj1yAKcWMuKFW8ZW7clYCO
        RPVdjDlz76epX/SpzSv/9/k=
X-Google-Smtp-Source: ABdhPJwGl7YWcZ8SLmVPhPAWKxynE2PYUESObWv54VNyNT8be9AbTaEW+7OfwtSzHcoQFRJOp91jxQ==
X-Received: by 2002:a17:902:f60e:b0:158:5c4d:d9b0 with SMTP id n14-20020a170902f60e00b001585c4dd9b0mr16947949plg.63.1652692989318;
        Mon, 16 May 2022 02:23:09 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090aaa8900b001dd11e4b927sm8008101pjq.39.2022.05.16.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:23:09 -0700 (PDT)
Date:   Mon, 16 May 2022 17:23:05 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] staging: rtl8712: add error handler in
 r8712_usbctrl_vendorreq()
Message-ID: <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1652618244.git.wanngchenng@gmail.com>
References: <cover.1652618244.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652618244.git.wanngchenng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'status' returned from usb_control_msg() is not equal to 'len',
that usb_control_msg() is on partial failure, r8712_usbctrl_vendorreq()
will treat partial reads as success.

Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
 drivers/staging/rtl8712/usb_ops_linux.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index f984a5ab2c6f..b2181e1e2d38 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -495,14 +495,21 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 	}
 	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
 				 pIo_buf, len, 500);
-	if (status > 0) {  /* Success this control transfer. */
-		if (requesttype == 0x01) {
-			/* For Control read transfer, we have to copy the read
-			 * data from pIo_buf to pdata.
-			 */
-			memcpy(pdata, pIo_buf,  status);
-		}
+	if (status < 0)
+		goto free;
+	if (status != len) {
+		status = -EREMOTEIO;
+		goto free;
+	}
+	/* Success this control transfer. */
+	if (requesttype == 0x01) {
+		/* For Control read transfer, we have to copy the read
+		 * data from pIo_buf to pdata.
+		 */
+		memcpy(pdata, pIo_buf, status);
 	}
+
+free:
 	kfree(palloc_buf);
 	return status;
 }
-- 
2.33.1

