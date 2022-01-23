Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5989497443
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiAWSSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiAWSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:18:36 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F94C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:18:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p37so13751397pfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM0mMzefnSfZje8daSUkdPFi8UkMvseVamFzoxFU/CQ=;
        b=IVrpsy/tjwu0SUk9J+FsWyANxgvEcSBSx88SqsySONb7XLsdhdErMEkGSlPbPrwezu
         qCSxGGQaZire7aSWgQRB4kwjbweDZKy2B7O9IL/DNzJ/tS+4lajPiESJJ6EQ7vuneAj3
         pFqz7ATwHq2S5BdvA+ZGIzd17UjvLWTMqUdB1VM7bYRgjm8EhSL88eXBQZfpscahRj6Y
         Ny28p4SHvptgYDqvSxznzqytARJi3bIaEV17cQMxWYODRWPxYkjTPhpXTFR8XJk1VUya
         apiQFrOUEEKfbPW5WwzAfbC4OwoYPDviVPvfH0mWjithQOtZlIE6ng3vcN5Bl9hLfR0h
         XyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM0mMzefnSfZje8daSUkdPFi8UkMvseVamFzoxFU/CQ=;
        b=iCr4qCFtfKYFlAGO0/sj5IN4p5ATR57Lu0VtJKylExJuT7nd/xlxJX/gj1RqDNtYcP
         P+lnfzfu/FWfpaIDShEbV39Q2IC15eLEDjGk7DH4DJ9ldlAnKxqv3OInPCTSRkP6bn1K
         bTloHxbo56Q1AtrrKuat8fps56x0UMDAsJLVa5xPiuAY3IcXAZ8g8Oqn4/lv3Zj7BDuf
         cBQvkhilFKJqZR8po8C44P6KZRQhwH6w+bRqGfnmKmY5HI2qiiapDaBPuklizBFKGPvG
         Hhkh9ni4L/SN7PFtowLiy2DQDtYlH0VhGHWp68rhrz495B20w+muJk8aL2ClaSQ9yJ3n
         NbnQ==
X-Gm-Message-State: AOAM531gUeiYJcEX7zaRVNmZ4UiAiTiYeAn+guzaTvFWD5cr9ppQtzjI
        39+phAZ+sUxOe8mPkE8cp30=
X-Google-Smtp-Source: ABdhPJxNugxrCfpZDi11NGkw2Bzh4uFDeQ7gOSmsfifv+0dTKuSstL00nrlFPomTYwAyQorNFtz8DQ==
X-Received: by 2002:a62:3003:0:b0:4c1:6983:f1c3 with SMTP id w3-20020a623003000000b004c16983f1c3mr10974880pfw.20.1642961915949;
        Sun, 23 Jan 2022 10:18:35 -0800 (PST)
Received: from localhost.localdomain ([103.85.11.151])
        by smtp.gmail.com with ESMTPSA id h6sm2634220pfk.110.2022.01.23.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:18:35 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Mak <makvihas@gmail.com>
Subject: [PATCH v2] staging: r8188eu: handle rtw_init_netdev_name() failure appropriately
Date:   Sun, 23 Jan 2022 23:47:35 +0530
Message-Id: <20220123181734.10402-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
for the device as per the given name format.
The name format is specified by the module parameter "ifname".
It returns a negative err code if the format is invalid. Handle this
error appropriately.
Cancel the timers ininitliazed by rtw_init_drv_sw() before calling
rtw_free_drv_sw() and then proceed to free the adapter.

Also, if register_netdev() fails then goto free_drv_sw instead of
goto handle_dualmac.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
v1->v2:
    free the adapter and netdev instead of warning the user about 
    allocation failure.

 drivers/staging/r8188eu/os_dep/usb_intf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 91792dfd3..85b5d0bd7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -399,7 +399,11 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 			DBG_88E("can't get autopm:\n");
 
 	/*  alloc dev name after read efuse. */
-	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
+	if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0) {
+		DBG_88E("rtw_init_netdev_name failed, ifname:%s\n",
+			padapter->registrypriv.ifname);
+		goto free_drv_sw;
+	}
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
@@ -409,7 +413,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	/* step 6. Tell the network stack we exist */
 	if (register_netdev(pnetdev) != 0)
-		goto handle_dualmac;
+		goto free_drv_sw;
 
 	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
 		, padapter->bDriverStopped
@@ -420,6 +424,11 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	status = _SUCCESS;
 
+free_drv_sw:
+	if (status != _SUCCESS) {
+		rtw_cancel_all_timer(padapter);
+		rtw_free_drv_sw(padapter);
+	}
 handle_dualmac:
 	if (status != _SUCCESS)
 		rtw_handle_dualmac(padapter, 0);
-- 
2.30.2

