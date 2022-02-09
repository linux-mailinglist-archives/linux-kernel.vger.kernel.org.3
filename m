Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774154AFCEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiBITJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:09:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBITJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:09:10 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3ECC050CF9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:09:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i186so6039224pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 11:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pYUWbzfJmeVU+yHBTh4k3q7SKXv3vTcqq0waIAiryU=;
        b=EJgjFP4oGMq+CvHuGi7utFhaFknN1sr+n3dB62JsNImWWb8PfivoTyky60buWnmgMY
         KvoaTyr5T3sztr6GwkAwLoM8knyG2SKqyQ/0EoOSsGMY6qGFHBj69U0qkfg0fF81P7JN
         hSte0UmATttEoqCTSHD/3fNkDv8bsewC7MdJLsClsc0wP0PifxGuBFI9sWYS1ILdcN8L
         HkbRvimKp5GlfAF5+uQTWDltmedyxHpnI+1gcwhTFFawIlczdExTN4A9jv2iTVwMWqzr
         R4Qhn8Co6KsFc//zQKZiRw7r9Dfdm7W2yb3+hNJ8jhKMEv2l2iz56/5UB4IIehfS7aug
         3bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pYUWbzfJmeVU+yHBTh4k3q7SKXv3vTcqq0waIAiryU=;
        b=k3NC4WN+UnnTefWnZg94i6/fsbquX4kx1zRcu/stbdrvYzvO4jc+GKup9US8vpVnzk
         2SHa3N3JrP0QpvIbOTrV5piquPKk5kmz0zOFwPBsy1y/xHvsvdoAYlMYAGbWFcNUXgPl
         9iS/EO/Svjfs0yMBtZVEIZzn8oGlc7LvtnxElJhUsQJdaMCm7HxJ+JHxDEPRoerebTaA
         liNCoLpzF4pb9rdjYRdrLzL3w+j3Tw7hEft/7F70VUufP4SHlQl0CINvNXoAU0r9R5BI
         ChFkvOeJxcWLESG+k4eJrg7Y70rhZmLS5VVatSJoQcLFGx8X6WeD2w5qnZ6Nvi21lxuY
         csPA==
X-Gm-Message-State: AOAM533pozlvcKTSMjiDuz+/mKVqnJ9xFbJdvZAo5ordlvgPpZkUuqu2
        6PIBBLLoN/zRnYP8paxj7gc=
X-Google-Smtp-Source: ABdhPJwJE0afsJJf6gzTybqCyPkR8isNWbhTReCpgDbp96mFX25X55DS7++D8ydX46QiE95J6DDQhQ==
X-Received: by 2002:a63:c007:: with SMTP id h7mr3103630pgg.422.1644433725854;
        Wed, 09 Feb 2022 11:08:45 -0800 (PST)
Received: from localhost.localdomain ([103.81.93.149])
        by smtp.gmail.com with ESMTPSA id x12sm14255973pgp.25.2022.02.09.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:08:45 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2] staging: r8188eu: keep the success path and error path separate
Date:   Thu, 10 Feb 2022 00:37:53 +0530
Message-Id: <20220209190752.7232-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Keep the success path and error path separate in rtw_usb_if1_init() and
drop the "status" variable.
Also, remove do-nothing gotos.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
v1->v2:
    Just `return NULL` instead of `padapter=NULL/return padapter`
 drivers/staging/r8188eu/os_dep/usb_intf.c | 30 +++++++++--------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 10c33e2ae..668e79a3c 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -336,13 +336,13 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 {
 	struct adapter *padapter = NULL;
 	struct net_device *pnetdev = NULL;
-	int status = _FAIL;
 	struct io_priv *piopriv;
 	struct intf_hdl *pintf;
 
 	padapter = vzalloc(sizeof(*padapter));
 	if (!padapter)
-		goto exit;
+		return NULL;
+
 	padapter->dvobj = dvobj;
 	dvobj->if1 = padapter;
 
@@ -421,26 +421,20 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		, padapter->hw_init_completed
 	);
 
-	status = _SUCCESS;
+	return padapter;
 
 free_drv_sw:
-	if (status != _SUCCESS) {
-		rtw_cancel_all_timer(padapter);
-		rtw_free_drv_sw(padapter);
-	}
+	rtw_cancel_all_timer(padapter);
+	rtw_free_drv_sw(padapter);
 handle_dualmac:
-	if (status != _SUCCESS)
-		rtw_handle_dualmac(padapter, 0);
+	rtw_handle_dualmac(padapter, 0);
 free_adapter:
-	if (status != _SUCCESS) {
-		if (pnetdev)
-			rtw_free_netdev(pnetdev);
-		else if (padapter)
-			vfree(padapter);
-		padapter = NULL;
-	}
-exit:
-	return padapter;
+	if (pnetdev)
+		rtw_free_netdev(pnetdev);
+	else if (padapter)
+		vfree(padapter);
+
+	return NULL;
 }
 
 static void rtw_usb_if1_deinit(struct adapter *if1)
-- 
2.30.2

