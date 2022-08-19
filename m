Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C30599C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348955AbiHSM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiHSMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738827B7AF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so5544662edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VQZuhT+vruVJe9YEYFvuAFzDJPr0QZ5/cyRE3vYoUZg=;
        b=itRnIEhrtNDTKZvVpDRGtBZdEhu1oyR2767o4jHeOyfDYCWG9xd/+3hWwlQslpqWWj
         /8AyCOmbpA+RwFlh33lG7WOPm/gksWLs390tPwrl4FJqInh3C/FPGi7S059mss1bINdc
         t0ohdjXVcCFDe9p3tAPKPHaucze0dMuSG9FQqf510pjeqardYrz0ceCrHP/aHeS1kAdd
         TqLzDjLAvZ5O/5lfR34jTeyd9HAlYlRTctW8N67A/HY4E4JCfFtXk52MtcWTdsbvHziv
         DLxCpWbW9HBPgn2l3Gq2+pbBBKx8vtRzOY9B1eTGR32VPwG2p9/HVbOVupIVq80NTgG1
         LCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VQZuhT+vruVJe9YEYFvuAFzDJPr0QZ5/cyRE3vYoUZg=;
        b=t/p5hGQJ/nAfUnFFrhKCJLlXWp8h01C3nDVgPk6VJKKm2CrBFk9+Dv+jev6Cr+YSUN
         XHvro+dUbe66o4CAn1gxDIN+sScFiIcOYHLF6bnm2b/e+HNmAVp+y2AfzJuNaDHbWrpg
         SKc/TqvQbE2uVevDwG7dDt7sprRzFzt7iO9SX1QIkxNf0hWFDDo+D77y2KQwGPcPuLlT
         qj4wwbfT0hfR/Pbobkgj9DraSuiPWYI6lDo90GfhglS7XuDLlfHGskEnJfgjBcRLL83I
         xjOyk/GKkq9hhej30eg6fzGktaLnpQ7eZgESUkclVlugubQ7+bvOm0RLCOs/jIyum4J5
         yqCg==
X-Gm-Message-State: ACgBeo0Raaic1qgXhfKvxCHDqWXKIaYtmUh6rQFELYrFkSkZLHLmoHgu
        bWWdtmogxYxQjhV4WftnXe8/TQEK/hI=
X-Google-Smtp-Source: AA6agR6eNvZ6APVC+t8pgRuJsvlNBspi+p6fIrSoxbJxZzrXtb1Z3/ACL9/V3LTpX9MKODR+dJxzkw==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr6084087edb.338.1660913681431;
        Fri, 19 Aug 2022 05:54:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/11] staging: r8188eu: move rtw_indicate_sta_assoc_event() to rtw_ap.c
Date:   Fri, 19 Aug 2022 14:54:21 +0200
Message-Id: <20220819125428.8412-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

Move the function rtw_indicate_sta_assoc_event() to core/rtw_ap.c to
get one step closer to removing os_dep/mlme_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c       | 21 +++++++++++++++++++++
 drivers/staging/r8188eu/os_dep/mlme_linux.c | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index a567683c21fd..24eb8dce9bfe 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -935,6 +935,27 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	return beacon_updated;
 }
 
+void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *psta)
+{
+	union iwreq_data wrqu;
+	struct sta_priv *pstapriv = &padapter->stapriv;
+
+	if (!psta)
+		return;
+
+	if (psta->aid > NUM_STA)
+		return;
+
+	if (pstapriv->sta_aid[psta->aid - 1] != psta)
+		return;
+
+	wrqu.addr.sa_family = ARPHRD_ETHER;
+
+	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
+
+	wireless_send_event(padapter->pnetdev, IWEVREGISTERED, &wrqu, NULL);
+}
+
 static void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *psta)
 {
 	union iwreq_data wrqu;
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index ad5f795f6857..37c7f52421ee 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -129,24 +129,3 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 		kfree(buff);
 	}
 }
-
-void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *psta)
-{
-	union iwreq_data wrqu;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	if (!psta)
-		return;
-
-	if (psta->aid > NUM_STA)
-		return;
-
-	if (pstapriv->sta_aid[psta->aid - 1] != psta)
-		return;
-
-	wrqu.addr.sa_family = ARPHRD_ETHER;
-
-	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
-
-	wireless_send_event(padapter->pnetdev, IWEVREGISTERED, &wrqu, NULL);
-}
-- 
2.37.1

