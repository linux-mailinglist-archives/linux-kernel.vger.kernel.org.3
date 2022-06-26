Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1A55AFFD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiFZHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiFZHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:45:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF6513CD1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 00:45:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s185so6276603pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eI5KlH8jvd2AEJBKlQ3J4jXLlokaOXyX+ZrVY++9vk=;
        b=YmxDu6n74rkBICZ6OVQ14dYA1c/vmpv+9puClWEMW3wgBcX3L7S7yMOyr1wITpWnJA
         Ok4/ZWXkcp+nNo3VnBk0jdgV2Jo8tdXMPi6jrYkW30OBf7O+/Qog6siMYDnnb9+ESjce
         HiEEskIDqz1nnnewCMykc+ilDNofnFwx8dR3rArY2kg9ovfM9Lz/hJ5ZUer65Sm6D7sM
         KmUa7OGuyNjAu8mTfQ0H6aZ2MMTLUwNbQwcuQnUmNdHOwIi9Ol6UOYXerR3OJfRjWJI3
         PFSTP1qJmc05sb8NziC83TqhxhQ/U5m7BZsqoEYu1/fuhFGoVIPqjJ8amZ9t9AcNljay
         C+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eI5KlH8jvd2AEJBKlQ3J4jXLlokaOXyX+ZrVY++9vk=;
        b=nyb7+DxB3LQScT4jrE4Igf/Sywz+s6oY9gnVBPPlOf6CR1RXtir8ikVVZPun5KdOKn
         Y6kqMMuIjGPaxhbMGL12B/zJaYeqe7H9z+rJV4vT20CEA1KE8e+Rngw6rPwLkN7YWzXy
         Oem7GSWdFVKfpo+L9C2Nek9QhXKUaVpJr3oTymWox5McZQcdG/R8Ai2/ncaFcT+f3Iak
         maTmeKehj0v1Y1rCe/8rtTIOJVjtYPpY7DX9QnhYDSl2fklU19J1afwfmwY5RzSQ+Nt8
         h3QxnH+4/Q564e59pedg8tgCO8cHGFM7LShiVs+3qIfAKfiugTdn8A1nIVsNYr10giWW
         ouog==
X-Gm-Message-State: AJIora/u1t6vfiRZXAAzJ8+UwqDv9uTr6uDrAqkK8kdcN/EZLS+KYEJ4
        BzgxXWI6NXJeRORWAfdJaRs=
X-Google-Smtp-Source: AGRyM1suBXCRt8KBt367wr5hGvoxdwUh1ZPYvZlbV4zhU6zLaOTIG0PeXbdd+COlxiEO7UpR7QEiRw==
X-Received: by 2002:a65:6745:0:b0:3fd:fd52:85bc with SMTP id c5-20020a656745000000b003fdfd5285bcmr6888172pgu.350.1656229530012;
        Sun, 26 Jun 2022 00:45:30 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.148.21.74])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027e4500b0016784c93f23sm4715873pln.197.2022.06.26.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 00:45:29 -0700 (PDT)
From:   SebinSebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, skhan@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Remove null checking before freeing functions
Date:   Sun, 26 Jun 2022 13:14:11 +0530
Message-Id: <20220626074417.661312-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/staging/r8188eu/os_dep/usb_intf.c:376:2-7: WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 68869c5daeff..f5f1119b5444 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -372,8 +372,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 free_adapter:
 	if (pnetdev)
 		rtw_free_netdev(pnetdev);
-	else if (padapter)
-		vfree(padapter);
+	
+	vfree(padapter);
 
 	return NULL;
 }
-- 
2.34.1

