Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33C5AABDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiIBJxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660CD124C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so1966553edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ey0K4wQnhegdgAeyU9dIk00TcYC9S5EHVHT72Ibu5sU=;
        b=oADDvJMm0G3cTIlJG7zJ3VyZ7WisOx61oK8b5QI5OcqUY9fdTFAky58nZ3d4UmX3x+
         42OepF39qhDu6/WTH9IdodwDYDVQvYzybbQjNP+Yyj8EY9FRm920lb7jlJDrpAc2RYiq
         O3zD1OH6ON1sdMnbZdzVIUZrvYjrjRcmlQIV3JqjGDiB055mNJXEZ2xRudpTCstpJfyp
         oHVjERJDdlTN3pdtCXepRsapJKpyC0Zs95jVuDCGJ5EgZAeJB2zaBXTex7m+LQs/CuxM
         OqXvC1OY3/aqNOSG9fiE0hFSZ3ACcxuP+vIasFVcCoPB3zu1UKtgYUnVG11F1GCuaawA
         eh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ey0K4wQnhegdgAeyU9dIk00TcYC9S5EHVHT72Ibu5sU=;
        b=gb91BJ4n9YYfeguJRHqoDxD9A1wPutEeidqhE01KRYS3LVRe1pGF7YH2tG+ssjQvfj
         wenUpllhOmtx8M1dNmHitGEDgIPNdbgLtkf2WnWcYFxtKgPw5aPorwjzISahYxy9E5vP
         vuejpo7SADbH5HmbLNDwFLf6QhN0Z8Ciduq1YMKr2afP3L4SCxImVO3tdvIU2unnRXES
         KTftkuA3pARvqcWn4bp2rNrNlCJUTjMCAALQmsr0HMZ0ralKHlWO40vktZXdLHj3Uj6x
         MdPVqW7LZB0XoFx896ZRZZNE5PV88cRpWx+xglAsAk5verIWec3QtT4R+pNmI3EVe5OU
         qabA==
X-Gm-Message-State: ACgBeo2YfNsevQ7hTlW+EzVCHZ2bWXf7lGOiWApxozHojaWEt/BRa1yX
        krRFGwHUL5Yt4XHGuXUND68=
X-Google-Smtp-Source: AA6agR5R1BncknwGK1xi0WV/APgOv2OQIdbs7lZp4U4k5D5NiNrxABPmB9Vzieel1NVMX8gt4bE47g==
X-Received: by 2002:a05:6402:34c6:b0:43d:8cea:76c0 with SMTP id w6-20020a05640234c600b0043d8cea76c0mr33115562edc.268.1662112356261;
        Fri, 02 Sep 2022 02:52:36 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:35 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 03/10] staging: rtl8723bs: remove rtw_change_ifname
Date:   Fri,  2 Sep 2022 11:51:53 +0200
Message-Id: <975cd771e5b6573b84b31690895d140cbdaeb5e2.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Delete function rtw_change_ifname because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  2 -
 .../staging/rtl8723bs/os_dep/osdep_service.c  | 50 -------------------
 2 files changed, 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 0bbbdebdf157..bb4650f0b297 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -493,8 +493,6 @@ static inline u8 *myid(struct eeprom_priv *peepriv)
 
 #include <rtw_btcoex.h>
 
-int rtw_change_ifname(struct adapter *padapter, const char *ifname);
-
 extern char *rtw_initmac;
 extern int rtw_mc2u_disable;
 extern int rtw_ht_enable;
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 4fbfa75c05d7..f09c1324c39c 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -108,56 +108,6 @@ void rtw_free_netdev(struct net_device *netdev)
 	return;
 }
 
-int rtw_change_ifname(struct adapter *padapter, const char *ifname)
-{
-	struct net_device *pnetdev;
-	struct net_device *cur_pnetdev;
-	struct rereg_nd_name_data *rereg_priv;
-	int ret;
-
-	if (!padapter)
-		goto error;
-
-	cur_pnetdev = padapter->pnetdev;
-	rereg_priv = &padapter->rereg_nd_name_priv;
-
-	/* free the old_pnetdev */
-	if (rereg_priv->old_pnetdev) {
-		free_netdev(rereg_priv->old_pnetdev);
-		rereg_priv->old_pnetdev = NULL;
-	}
-
-	if (!rtnl_is_locked())
-		unregister_netdev(cur_pnetdev);
-	else
-		unregister_netdevice(cur_pnetdev);
-
-	rereg_priv->old_pnetdev = cur_pnetdev;
-
-	pnetdev = rtw_init_netdev(padapter);
-	if (!pnetdev)
-		goto error;
-
-	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(adapter_to_dvobj(padapter)));
-
-	rtw_init_netdev_name(pnetdev, ifname);
-
-	eth_hw_addr_set(pnetdev, padapter->eeprompriv.mac_addr);
-
-	if (!rtnl_is_locked())
-		ret = register_netdev(pnetdev);
-	else
-		ret = register_netdevice(pnetdev);
-
-	if (ret != 0)
-		goto error;
-
-	return 0;
-
-error:
-	return -1;
-}
-
 void rtw_buf_free(u8 **buf, u32 *buf_len)
 {
 	if (!buf || !buf_len)
-- 
2.25.1

