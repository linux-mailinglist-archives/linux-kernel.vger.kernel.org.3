Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931048FEA7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiAPT0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiAPT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 14:26:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:26:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id j27so7869552pgj.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+an7IKXCzTHm4c2E+GDMSIDpCDQ46aOoF0DBIs1Sxew=;
        b=oMdJpG1xA/YwY0eaxDCNRpvT2JhA+XDMWTFoCCCOl2dYec0Qczbc8/zbD1RZoxKoWB
         RJ0CwLB9qULgDj1yN8vNwuQZasbwyuabCJjTuI78jQWGDiEnuRMM9HzdQSBq4HVk34+n
         3y/fjCWdW6pEpggH+fbqKdW9YIIOE28BGCC3ps+H6uDUqs8jAirY/0Sg7+XIPeVFFTkk
         zygpFHZaZ+c8LbzkMKQLDTyZGNO4Uv4vZNnGTvkRbOg39zVyyQZWmUSTglYdxUx8w+Dr
         J7I031NuWgqBai2CE4msg04OHLg0URDPC9l8Q3sBeEaKUFHZinSniPTtTUJ5qXa8zZz5
         HqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+an7IKXCzTHm4c2E+GDMSIDpCDQ46aOoF0DBIs1Sxew=;
        b=ldNYMTp9PIimvTyyGGazVB+/WXlWFaf+EG7oOys4dLepojbODPvIF0DQpWdt3Q/D+l
         2FISO07S4tgdeunFuaIDJcYyeP5DuQ1XeAaskfg5hD0pLFFAiZel7qJjs0Wl/T9OA+oJ
         ix+6j76cGDIytFp50BHOXhXbki+7Hcv18PTBGCJfIctyqiJHiqMNJTBkL/7cTdSqknkk
         PguOieDt/x7i9F0iBaU109Pd/fkjuY3e842SAQqHdHkS0PZRaymGtbQY3WF5e+Q2zL5z
         i43Hko2Gep1qT8jRjdZWZIWUtNSk9pEmUxRAjNH2PwwbsECcVy45pSlX4y2hilloDXvZ
         WKpA==
X-Gm-Message-State: AOAM5329aT/CR3NoUB39TX9uk8I9Q792HXzpz8JzfpTGPQad4VSWJDb2
        TAhtO61Nf5XBcgJHmLNJudo=
X-Google-Smtp-Source: ABdhPJyCorLyOHoL+v6+t7fDcnQCr8n8tc4BiS/tIqwyTaIsw6rXyPsQE5JQGABwt26Edn+PmsFP3A==
X-Received: by 2002:a63:338c:: with SMTP id z134mr16055036pgz.459.1642361199173;
        Sun, 16 Jan 2022 11:26:39 -0800 (PST)
Received: from localhost.localdomain ([150.129.206.110])
        by smtp.gmail.com with ESMTPSA id v10sm7773823pfg.19.2022.01.16.11.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 11:26:38 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, martin@kaiser.cx,
        straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Mak <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: handle rtw_init_netdev_name() failure appropriately
Date:   Mon, 17 Jan 2022 00:56:11 +0530
Message-Id: <20220116192611.19224-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
for the device as per the given name format.
It returns a negative err code if the format is invalid. Currently the
name format is specified by the module parameter "ifname".
Warn the user if "ifname" is invalid.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 91792dfd3..875815b5e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -399,7 +399,10 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 			DBG_88E("can't get autopm:\n");
 
 	/*  alloc dev name after read efuse. */
-	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
+	if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0) {
+		DBG_88E("rtw_init_netdev_name failed, ifname:%s\n",
+			padapter->registrypriv.ifname);
+	}
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
-- 
2.30.2

