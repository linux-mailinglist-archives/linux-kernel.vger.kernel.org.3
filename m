Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901AC5522AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbiFTRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiFTRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:20:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523A15FC0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:20:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o7so22461596eja.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/pb/+vu1mykm31amAQISMIjbDNJsUHRwAlyP6r0cyE=;
        b=UHe2NhMVaJZFDrzNZOzXfMuZCnP76qIenksyZchskn2Xfj5m1qKVD8Dz6H2IC32txg
         9NX9qr3jvjOJ+mcH9UZQ9/ECdNJivqEYSt6A68iH64bfQ+bDqBO1PBA7ocbMgEdVc2BO
         UiBC1qADEIo4isZTbTsZzFAm+rl7VEjy1S5yDvbhjNlE7lTdpE19eVmW7zX6F9hjWFI2
         sHKC5LlTzlb5Qg5VZ6mYrJYC/fbS2iDdj0gkWNs2WNpujb4K4msuQuOg9p9O+y1BUtY0
         rRrCyBq9jTJdLFrnr1uSYO3brIAe64jf+cEhdmtfyc71I7nLyqdhmkWdpXgsTmDlDw8o
         5H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/pb/+vu1mykm31amAQISMIjbDNJsUHRwAlyP6r0cyE=;
        b=GJKVQMK4hGxm460Jk5GZONLFnVO8Wi3ntM4F7nBhNpDGslOhXVudHn2iCQfV0gOVA7
         GSrypCDd5olx17wBI50ctd3noHtjmFT1TB/zgPeZoHQCtEeoc4stuN8JA60KM4C/LIu2
         YmgL214WFABXB+1QX/Htr+4/7n7LiSOWljqvx/09a5b4wJUG0pyN28xQzdLUQ5Pes/+I
         UgzZrvoSXudBRn39dKdVHmL7AzXNGHmXkS212hTqn0zZceaxysVPEjkAAcw6E6kUFcL2
         s/SW8TlfLGBTsrrmIi2th1c6LKUNj+jZF4Vl5UGXyXrpjoEA11/EiTvbZS48pzVtWSSd
         rQwg==
X-Gm-Message-State: AJIora8pcP7/YTR6R3Q2xQx5BKPEkXJl5vxmp6zN/3A1cOmjEDGEgKzF
        2ZLkxmhF12V9x2ygEEbaPfo18qreIN9Gaw==
X-Google-Smtp-Source: AGRyM1spvej+yieow/rrz24Hq0NQN2D6KD3vw7iHTaOuAMkryjKytOza3tFa6SHileJVFVstzuAEog==
X-Received: by 2002:a17:907:d19:b0:711:d10e:411 with SMTP id gn25-20020a1709070d1900b00711d10e0411mr22351087ejc.216.1655745623598;
        Mon, 20 Jun 2022 10:20:23 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:9959:ca73:b489:46f5])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b0072232a898f1sm3409066ejh.103.2022.06.20.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:20:23 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com
Subject: [PATCH 1/2] staging: r8188eu: replace N_BYTE_ALIGMENT with ALIGN
Date:   Mon, 20 Jun 2022 19:19:33 +0200
Message-Id: <28087b76483f10dca1e1c3bdcba5e4b08eecd544.1655745123.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655745123.git.namcaov@gmail.com>
References: <cover.1655745123.git.namcaov@gmail.com>
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

Replace the macro N_BYTE_ALIGMENT (defined in this driver) with ALIGN
because they do the same thing.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      | 6 +++---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index fe3d597fea69..36ea79586992 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -62,7 +62,7 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 		goto exit;
 	}
 
-	precvpriv->precv_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
+	precvpriv->precv_frame_buf = (u8 *)ALIGN((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
 
 	precvframe = (struct recv_frame *)precvpriv->precv_frame_buf;
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 647c38134d2a..24401f3ae2a0 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -74,7 +74,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		res = _FAIL;
 		goto exit;
 	}
-	pxmitpriv->pxmit_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_frame_buf), 4);
+	pxmitpriv->pxmit_frame_buf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_frame_buf), 4);
 	/* pxmitpriv->pxmit_frame_buf = pxmitpriv->pallocated_frame_buf + 4 - */
 	/* 						((size_t) (pxmitpriv->pallocated_frame_buf) &3); */
 
@@ -111,7 +111,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		goto exit;
 	}
 
-	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
+	pxmitpriv->pxmitbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
 	/* pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 - */
 	/* 						((size_t) (pxmitpriv->pallocated_xmitbuf) &3); */
 
@@ -151,7 +151,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		goto exit;
 	}
 
-	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
+	pxmitpriv->pxmit_extbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
 
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 727e1adce1dc..def6d0d6e402 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -32,7 +32,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 		goto exit;
 	}
 
-	precvpriv->precv_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_recv_buf), 4);
+	precvpriv->precv_buf = (u8 *)ALIGN((size_t)(precvpriv->pallocated_recv_buf), 4);
 
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index e430c64e9068..91a1e4e3219a 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -71,7 +71,7 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	if (!pxmitbuf->pallocated_buf)
 		return _FAIL;
 
-	pxmitbuf->pbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
+	pxmitbuf->pbuf = (u8 *)ALIGN((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
 	pxmitbuf->dma_transfer_addr = 0;
 
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
-- 
2.25.1

