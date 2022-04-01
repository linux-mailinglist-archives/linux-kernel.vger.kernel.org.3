Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47DE4EF9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiDAShL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346939AbiDAShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:37:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC321B7611
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:35:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h4so3950189edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwvsNVubztdYKgXLtsvkx6INUsTkEhAT0Rw4f8IMAMo=;
        b=Xcn8nF2R5LJEHbhs1V1/l/VEgg+pGar5DdZIQ8xwzExhCd/A84R4g77oZby0x19077
         /uJCka7iPlqTiJ029x+CbwGcCwEE2jFye6DjEkl2q80KKzlr7ngt3CTEbaoRv4feSaM7
         Z0dDYsw0wadOXuPR4Jgg96elUr3DG2wZocmySOXbiRXJu5952YSxEw87YPows1xpiN8B
         HRFWOxEH+leHb3skrswnGhFL+CHRBZa1C6VchrIKRJtIU+fFDWFVN1MSqizlyNYS6Eno
         Roil+V+pbnhlJqmdHH38rccM+6/LLvw9L+QxEHLkkE9nVvxvgwnMbdEcSYCnQpd2I3rd
         UCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwvsNVubztdYKgXLtsvkx6INUsTkEhAT0Rw4f8IMAMo=;
        b=25n9D8CM38mEjvSuSyp0vx18HX4iZaCdXf+L8p6nAQIXaqlMgbyhnNmyuxYYkhBRrJ
         Jh5/rO/usvEx5q3qx28csHvrPyJpcO67lgCOln2MCb7VUwHuXy6Okrr48zNPnfBWHhKZ
         hnwJY/LJrX3Fr0GnHwaoeiZLX7DvVkJJ17J43N/8AElt30T6rZTsrWel1olQg/Xdq+eP
         xWDlL72vTS2lz+goQrDWL6/dzceddZSu726mCo23mp5wj+6/Q5nloTzkr03HeQD5rGXH
         k7oHVjCZAHzaJN4SdCYbDzEC4qdfYPKHp37Nz+z9xavCehki2ymzqnuJ2Cb+AdsNpYEM
         j3VQ==
X-Gm-Message-State: AOAM533VzhC+1tOTr/Tx0BnuGBGo0C2n46UxGztdU+tnfyNbj4co3Lzi
        rsgnuEPSI+0N0gEVn3PjQIJ5rDHSMKo=
X-Google-Smtp-Source: ABdhPJwHOb8kRreHG9rzDqQ31EWROiF+cK8Oi1m/wEhs46Appl0tGn8pjrroiFnmjIfLZk6mxRdYdQ==
X-Received: by 2002:a05:6402:510c:b0:419:3fe5:15f with SMTP id m12-20020a056402510c00b004193fe5015fmr22337749edd.274.1648838117280;
        Fri, 01 Apr 2022 11:35:17 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906490700b006b2512921b2sm1296420ejq.48.2022.04.01.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:35:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Date:   Fri,  1 Apr 2022 20:35:13 +0200
Message-Id: <20220401183513.26222-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In function rtw_free_netdev() there are two "goto" jumps to a no-op exit
label called "RETURN". Remove the label and return in line.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 7a6fcc96081a..d680bfba7f5d 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -117,18 +117,15 @@ void rtw_free_netdev(struct net_device *netdev)
 	struct rtw_netdev_priv_indicator *pnpi;
 
 	if (!netdev)
-		goto RETURN;
+		return;
 
 	pnpi = netdev_priv(netdev);
 
 	if (!pnpi->priv)
-		goto RETURN;
+		return;
 
 	vfree(pnpi->priv);
 	free_netdev(netdev);
-
-RETURN:
-	return;
 }
 
 int rtw_change_ifname(struct adapter *padapter, const char *ifname)
-- 
2.34.1

