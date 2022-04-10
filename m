Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C264FAEEB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiDJQeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiDJQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14515835
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r66so12127259pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN6xP3dvTt8eDyyxi0GOR7k7xaEfRxM7p59jD419ae4=;
        b=h9NPejbZZiVsyzDuJB41AHo0EZuxX1138V+yJNlXFfy50OodXO0hQP+E/YgUDwPv/e
         NBEaq+RvL7ZBwasX+sSSXA+IGct0dw4A4fI43uBRInPJYk58MJrWy5wGyJ3LvNfzFmQB
         fqDI1DDoidIKsZo9P6Wokl0ThG07WfVGrMSP7J7ONujW05Bz38wWC49tOUkaJXHRfFhF
         UVZ6+EroYgo6rntyOfW90xgj7684lZBWUsrutg9yBLiYIp1TmDYtwSa4nMeLF51flP7T
         TMk1XFhyxpFT330mI5ZuCedwWlEkfZjMfylRsBqcH9rIOP4LjrINcYZkonlx2tXcl/5l
         KS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN6xP3dvTt8eDyyxi0GOR7k7xaEfRxM7p59jD419ae4=;
        b=mBUVoEMSZJ/PBFFhq4ritcDS9IK5v7wDwpuX4ApRYSbM+MFOrcUdyUrh9lqqXCxxxC
         5rm0Wg8DrVAKkoBX3DkT1SPh91J9huxyzDZ8OceNYQTpY7tPPPKu5mw9mfOfYRgtaX6s
         0MR/VK4l0eCZl3vasx7Oh9/eQL/VjHV6PSJr2f+9zBRdgloGtFb1eIEBVqph79aY8tmc
         V5B0f6NT/6j6BRyP6m1deoFMJt0rPpN/6GQAnM+iL4D3yFXnc2wvyKiBqZP/1INuhAnX
         e37QwcS6Zu39iT1IFHDwBY82Qtlu4+5s/R/OfRYLrKsDd3wyB9L1uQ7fAjIuyCk58xBS
         qhIg==
X-Gm-Message-State: AOAM530WFsSolGmz36fsuLe2B/gW3dpcsVfH93bXwJHYU8iZTwHAZ0GM
        503uC476yhojDO5Yc/dUgAI=
X-Google-Smtp-Source: ABdhPJxIK56wYzdB6oyCxjj2QAgoMYhH9R78QWHe529frT47k3gqhIOYunoTMmgsb0l2DVS5E2ZNvA==
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id w17-20020a656951000000b003810f10ccaamr22824522pgq.587.1649608325970;
        Sun, 10 Apr 2022 09:32:05 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:32:05 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: drop unnecessary wrapper rtw_init_mlme_priv
Date:   Sun, 10 Apr 2022 22:01:16 +0530
Message-Id: <20220410163117.3964-6-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410163117.3964-1-makvihas@gmail.com>
References: <20220410163117.3964-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary wrapper. The logic of rtw_init_mlme_priv can
be moved to _rtw_init_mlme_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 11 +----------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c  |  2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c90f36dee..f2a61c162 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -30,7 +30,7 @@ u8 rtw_to_roaming(struct adapter *adapter)
 	return adapter->mlmepriv.to_roaming;
 }
 
-static int _rtw_init_mlme_priv(struct adapter *padapter)
+int _rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
 	u8	*pbuf;
@@ -288,15 +288,6 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 	return ie + 8;
 }
 
-int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv) */
-{
-	int	res;
-
-	res = _rtw_init_mlme_priv(padapter);/*  (pmlmepriv); */
-
-	return res;
-}
-
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
 	_rtw_free_mlme_priv(pmlmepriv);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1dc1fbf04..b5b1a0e10 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -438,7 +438,7 @@ int event_thread(void *context);
 void rtw_join_timeout_handler (struct timer_list *t);
 void _rtw_scan_timeout_handler (struct timer_list *t);
 void rtw_free_network_queue(struct adapter *adapter, u8 isfreeall);
-int rtw_init_mlme_priv(struct adapter *adapter);
+int _rtw_init_mlme_priv(struct adapter *adapter);
 void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv);
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv);
 int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv,
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index f041c3d87..448ea9533 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -478,7 +478,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto free_cmd_priv;
 	}
 
-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
+	if (_rtw_init_mlme_priv(padapter) == _FAIL) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "rtw_init_mlme_priv failed\n");
 		goto free_evt_priv;
 	}
-- 
2.30.2

