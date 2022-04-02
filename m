Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15B4F03C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbiDBOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDBOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:08:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDEDFFB56
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:07:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso5073257wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fg7D1iGUfw9j684AaN9ZwUUtm9p5W+5qSKHanyjniig=;
        b=XhKe6RBzOIYGM7e1jgWJtS6NaOo4+4DLXXecjeNVeEgHXKdrxJ54a8D6RAAHjJ5QOY
         BlkaPbXoCClrtXJ5Rl+dzMbMRuL69iFqyY0BlGEa6j7/TXmR7/nEewXOEipQuLbycwIk
         EER4AZGnsSfOtNsL0LkfXOnzds3+z1PJQxYRzwP81AX1QWdDebCsV0KWRSnw+6vtvogF
         RGJiuz0XHVxeTkSCQToYFFxfOD4hKaSZBJZQnk7D3gzEXzm/YPXTNKl87tQ7RD8FIWFg
         BkOTUR5Vqcs+P3DxcqD53+CDLJ/i8yM0CGVjDbEQsxQBmYHYyBnwouSSEkHLUR5Y/cz0
         LmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fg7D1iGUfw9j684AaN9ZwUUtm9p5W+5qSKHanyjniig=;
        b=nLJDSyE9314PlCewNDamvEEQr9cQ3BP5+1fCKHncF4FGmCJYEZnlJY2Ub5017CEwms
         Z10IXeXCDMzX7GckPOUjto+Vgy1y9965bpWr67AU05XwPG4f/xdhXZm9UpZPSfwLogyW
         /iBqMs7sJxxrMKfNBurCH+zCO2y4TJmeXvr/b7KdxiY/Kof9a94BN8i8K/G8AW5ujthD
         dlnjNSpSZFEo2nBrB7PPzpFJetTwduZgQwnzizW5AWYhiEDSzmQFXtVylBRf2HcVt1XI
         LMFe6sp7JPi1yFO2wTamMZRcJvpt/LsrXCrPMuGbNoqyBOJBX/nKWlJzc+CTndMfSXrH
         jzhA==
X-Gm-Message-State: AOAM531inbEhoKkg2lZaK0Wk+VwBcPMof26O5Y8UVJ0374LJKJbpT6Xl
        rgW2HZYxMOtN4ZvOsTVjLHw=
X-Google-Smtp-Source: ABdhPJygcdRjc8ahdcTdoCmXr0p4Hl8GYpF9eDNU5lTcaWSQGrz4m6EBUQgXxO4UOGoIYdwA68lXVw==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr12523721wmk.58.1648908423127;
        Sat, 02 Apr 2022 07:07:03 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm4638195wrq.44.2022.04.02.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:07:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: Remove redundant code from rtw_free_netdev()
Date:   Sat,  2 Apr 2022 16:06:57 +0200
Message-Id: <20220402140657.10549-1-fmdefrancesco@gmail.com>
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

In rtw_free_netdev() there are two redundant tests. The first checks for
a valid pointer to a "struct net_device". This pointer is the argument
of rtw_free_netdev(). The two callers of this function already test this
parameter immediatelly before the calls. The second checks for a valid
pointer to a "struct rtw_netdev_priv_indicator". This pointer is always
valid and, even if it were not, vfree() is a no-op on NULL pointers.

Therefore the above-mentioned two "if" statements are unnecessary and
redundant. For this reason, remove these two tests.

After removing these tests there is no more need of the "RETURN" label.
Therefore, remove also the "RETURN" label.

Cc: Pavel Skripkin <paskripkin@gmail.com>
Cc: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 7a6fcc96081a..fc10eefe04a9 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -116,19 +116,10 @@ void rtw_free_netdev(struct net_device *netdev)
 {
 	struct rtw_netdev_priv_indicator *pnpi;
 
-	if (!netdev)
-		goto RETURN;
-
 	pnpi = netdev_priv(netdev);
 
-	if (!pnpi->priv)
-		goto RETURN;
-
 	vfree(pnpi->priv);
 	free_netdev(netdev);
-
-RETURN:
-	return;
 }
 
 int rtw_change_ifname(struct adapter *padapter, const char *ifname)
-- 
2.34.1

