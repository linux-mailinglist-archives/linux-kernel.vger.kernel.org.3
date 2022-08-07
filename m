Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC758BC4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiHGSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiHGSPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63626474
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so12815702ejp.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1gpPfsIodgVIm9G1P/vlOiWdjuJeR0qp5ZcVhGWLIY=;
        b=ilNRWUIP5/wjwpue37LpskO1atBfOqpfrMJvdwKfooYdaBha//xLc5rvf7cQYQ+55n
         tmKQm1lri9ijUzyhz9tSQMTbYZxntl+clNUotA4ihpNwFpaevpTXRNpgCSqfMpxJc/v/
         /kjMuy6ntVq8HeMy3rZixPWUrXHIxA6np/KlHucaoyd9QqhOUG7Bxq7FNuGuZQhUC0vF
         oI4NcrDNayFYmEAlvJx2vfTvfPAHionobX2EpI8F67A92silFUHaPNGYrRuBjMmAAMAP
         EH1HjErNwCKfHbzj/KCaeKqtFP4GKYqPwQy07foy0VebrWWuwKgazjXTBj6Vjh2caFR8
         3pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1gpPfsIodgVIm9G1P/vlOiWdjuJeR0qp5ZcVhGWLIY=;
        b=bqgZc1u6QW7Q4/9H376QAn1+s7S+MQz4VmzXwdzEVw6DWfVyoOosQr98Ae8PXsAOPw
         8IkuZXvKqvpqBbM+PQKCFtmYRN/3Vm0O0EACRDf0jsM8JMvyUEkdPb7jp8H6NqAJevLK
         HEZ0gwBVVQQSZialseiBMreFvkrofKtu/w0/YC0sboovLi/CFUpfP9pTyHMLRZxNTrJx
         l9U6Z6eX/U6GmgsNrpX6racn4mQiR46ZDbCoybPQlpsyyAV+G0vMDvJI+fO3EHpEjzno
         ErGMlsSiO5a2HSyIYt/bGxKTKlcuaLrbyHoERp9amYLhLNlCVyzlchBxzHRGLYPuL4RS
         FgZQ==
X-Gm-Message-State: ACgBeo243aGjPPiaeFuIsW9Tb/U8B5/5Wi405kTiFz6F1QaCxBNmr39a
        G/UFI0oqQi3Y0g8isT0eoWM=
X-Google-Smtp-Source: AA6agR5wlbk8paOgeHLrs/Tr+hb1rk+jzDakLxQCMn+54H/5X/x8IIyjFumMB5cDJjCjbYZHLui3DQ==
X-Received: by 2002:a17:907:7d91:b0:72b:4d74:f4f6 with SMTP id oz17-20020a1709077d9100b0072b4d74f4f6mr11228474ejc.314.1659896149366;
        Sun, 07 Aug 2022 11:15:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: merge rtw_os_recvbuf_resource_free() into rtw_recv.c
Date:   Sun,  7 Aug 2022 20:15:34 +0200
Message-Id: <20220807181538.8499-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807181538.8499-1-straube.linux@gmail.com>
References: <20220807181538.8499-1-straube.linux@gmail.com>
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

The function rtw_os_recvbuf_resource_free() is just a wrapper around
usb_free_urb(). Call usb_free_urb() directly in
rtl8188eu_free_recv_priv() and remove rtw_os_recvbuf_resource_free()
to simplify the driver code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 2 +-
 drivers/staging/r8188eu/include/recv_osdep.h | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 8 --------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 2d4baca804e9..7a97c090f297 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -159,7 +159,7 @@ static void rtl8188eu_free_recv_priv(struct adapter *padapter)
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		rtw_os_recvbuf_resource_free(padapter, precvbuf);
+		usb_free_urb(precvbuf->purb);
 		precvbuf++;
 	}
 
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index ca8a613508fd..b9dc32c20cfd 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -20,7 +20,6 @@ int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
-int rtw_os_recvbuf_resource_free(struct adapter *adapt, struct recv_buf *buf);
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
 int _netdev_open(struct net_device *pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 1e14b6d49795..abdb42ab649b 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -26,14 +26,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	return res;
 }
 
-/* free os related resource in struct recv_buf */
-int rtw_os_recvbuf_resource_free(struct adapter *padapter,
-				 struct recv_buf *precvbuf)
-{
-	usb_free_urb(precvbuf->purb);
-	return _SUCCESS;
-}
-
 void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 {
 	union iwreq_data wrqu;
-- 
2.37.1

