Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0E50176D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiDNPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbiDNOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:21:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48001B82E2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:12:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d15so4720452pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7EpAfNCEgcjmMHpykH3TTrAGaZYl2tMEUW4c00yTRbk=;
        b=h4T2hdpkgg4QKMBMoMcADynwg/A6DzzCrtjGmEgj2Fi82w9eUKnEFLAYzEziAbFt0i
         B7E3lW5t9uDWrEEkQUJHsD+lv0SaRayBvAQTLxIn6Uhx+mhQV6F2ZSlVHp6OU4hNVU8R
         nfD/yqbhibiEMO8Nqlw7mWaRGuFtL3Ox+XPcIsrf3YI2uhW2RUV2PwqBcSjvL3dAOgOM
         eJ6Z+7QZQayQ93Gynm5wF4G7bMV2R4ZSSud0Hu0wriFWWx48MyUwrBw75x5ZjMcwEEui
         7NLq0pAtGiyp/7i8fFh531UY4+fec9AUsXoIdIzEo71L+9kpyS3am+V80rPp0oe0DS9f
         aTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7EpAfNCEgcjmMHpykH3TTrAGaZYl2tMEUW4c00yTRbk=;
        b=sZ5+4nBH8IKmGtqTo15RbHKxJE9A2m04B9IEVMexE29XduUSIwKrKfkXjfC21ytVdo
         D0X117LS8gg2SPuaF0XeZp9rdYG8PPg1e6tQarN7TOxsTGKuqhxLCH2+KW2XHb6HY8W1
         Tb67AZrJ4FFfYyVV/CMCel2JTWh8ZXOE1UFt+9lqGrulZpzrlBtS10pNb/NQsLBqlsi8
         hO88+p+tvXhL520P5cddXJAWVMkTf1HqR03R52gbYbLoRQxZN0j/HDFf8HhajodnlPoe
         zlZoc23iHrQt3cGBuVOcuVyXwvULkoKkotmiBjfb9PBd+QIASwQPiiVegfZYdLBlnlsZ
         OLaw==
X-Gm-Message-State: AOAM530Ab2bQfgAcGfXO2QpUJlpAME+7NR2kiqYBMu6zA6acHE+2Z3ao
        pFmI6Ptd88weZUdCHDK7mfY=
X-Google-Smtp-Source: ABdhPJylqSJGou81MV7kgJts2um3oarMvR48TsZvT5mqcQRgN2bKORRcwc8oFX4yUTHCWE3aj8lLGg==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id e7-20020a170902ef4700b00156646b58e7mr46865578plx.57.1649945548405;
        Thu, 14 Apr 2022 07:12:28 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm137106pfx.72.2022.04.14.07.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:12:27 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:12:23 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the case that "requesttype == 0x01 && status <= 0"
isn't handled in r8712_usbctrl_vendorreq(),
"data" (drivers/staging/rtl8712/usb_ops.c:32)
will be returned without initialization.

When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
is 0, mac[6] (usb_intf.c:394) won't be initialized,
which leads to accessing uninit-value on usb_intf.c:541.

Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
 drivers/staging/rtl8712/usb_intf.c      |  6 +++---
 drivers/staging/rtl8712/usb_ops_linux.c | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index ee4c61f85a07..50dcd3ecb685 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		} else {
 			AutoloadFail = false;
 		}
-		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
+		if ((!AutoloadFail) ||
+		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
 		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
 		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
 		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
 		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
-		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
-		     (!AutoloadFail)) {
+		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
 			mac[0] = 0x00;
 			mac[1] = 0xe0;
 			mac[2] = 0x4c;
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index f984a5ab2c6f..e321ca4453ca 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -495,12 +495,14 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 	}
 	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
 				 pIo_buf, len, 500);
-	if (status > 0) {  /* Success this control transfer. */
-		if (requesttype == 0x01) {
-			/* For Control read transfer, we have to copy the read
-			 * data from pIo_buf to pdata.
-			 */
-			memcpy(pdata, pIo_buf,  status);
+	/* For Control read transfer, copy the read data from pIo_buf to pdata
+	 * when control transfer success; otherwise init *pdata with 0.
+	 */
+	if (requesttype == 0x01) {
+		if (status > 0)
+			memcpy(pdata, pIo_buf, status);
+		else
+			*(u32 *)pdata = 0;
 		}
 	}
 	kfree(palloc_buf);
-- 
2.33.1

