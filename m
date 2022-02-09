Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE14AF8BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiBIRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbiBIRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:48:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045BCC05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:48:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c8-20020a17090a674800b001b91184b732so3391864pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4NxIfE5pVavXfL1FvTbYlzlRXtKoW9v/Q8Zml6o1ow=;
        b=FnHlQw2mxdJHKxT0xdfJqo6x7F6mCMHP+mESAoq+Oa4dV2IB/I7ZUOQUZOw1FLno89
         9Dtdwba6ioD6tXAJAYWwXkBX5VQzA3nUPQnzMnFepNLmIiAGtgwsXirfDwNZiURC4XBE
         NaZF0Np4P5GAp4XynEqfImAOUC551BywtCm6Jb1/Bt5Ih6EtrI/9w0B+3lfcEYt5liFI
         wSMzY2wax+3G7vSc5A9QHVyf2tJU/Y8gqKtTWHfB2+InN/Giab3C36UCc39UBn3W6+ga
         +A/1CwVifby6nYBItpT9UhgoZmHIru6GUGmnFB40CGSnCwzPzfoO1Jw0MLf9fN7Vi2Nl
         hmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4NxIfE5pVavXfL1FvTbYlzlRXtKoW9v/Q8Zml6o1ow=;
        b=pdw4YiLhh/vd476+vl45SksoUvTkwJH7F+BwmChROz6g9yxjgrTKM+66F4JUNBxWEQ
         ts9J3Oe9bYFD61Y8WzqVCz7HC5xF/W9XQ1zs4+yGV5GUKOY3BC9ygMrh1V+LW2yLEh8W
         /qygn3iFDkng/LfhDOfbC0GhX7mXfjl85yz0Es2FMlCMlC7NvHs1AIdHhQlQvCAUFCp9
         9Bkj4/l/4Jr5Cnfbhp4DMIGmp30EqcdaAzdu5IQHqWDmee+wZdCQ6jQQPPF0RyO3Xjyd
         czv5MImxaatJjnql0gelLibTRjTmUN6WslILZp9d7nqFWLQEEuRskitwqFNosEHvvQAC
         HI5A==
X-Gm-Message-State: AOAM531Wp1Ax+J+bkcjtrsk/26po7qQdhzXCnAzjZexwv+aHApGyQOFY
        pwLLoqcKr8Ub9sCNtG8d9HY=
X-Google-Smtp-Source: ABdhPJwnlnoPjrXv/TYJhYQI1J991VOpPfXmw8K6wxRRZH6kwpEpihX53uyGeXjWIgW3By2YdnafPQ==
X-Received: by 2002:a17:903:2083:: with SMTP id d3mr3235951plc.174.1644428907530;
        Wed, 09 Feb 2022 09:48:27 -0800 (PST)
Received: from localhost.localdomain ([103.81.93.149])
        by smtp.gmail.com with ESMTPSA id mw14sm7462786pjb.6.2022.02.09.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:48:27 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: keep the success path and error path separate
Date:   Wed,  9 Feb 2022 23:18:19 +0530
Message-Id: <20220209174819.5068-1-makvihas@gmail.com>
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
 drivers/staging/r8188eu/os_dep/usb_intf.c | 29 ++++++++++-------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 10c33e2ae..4ddf3a95a 100644
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
 
@@ -421,25 +421,20 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
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
+	if (pnetdev)
+		rtw_free_netdev(pnetdev);
+	else if (padapter)
+		vfree(padapter);
+	padapter = NULL;
+
 	return padapter;
 }
 
-- 
2.30.2

