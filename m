Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319A14F5BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbiDFLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiDFLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:07:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1F3AC69F;
        Wed,  6 Apr 2022 00:34:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j185so410868pge.4;
        Wed, 06 Apr 2022 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaSJT2MCORoc9l270zc/rNeGHG600CBndNh2jLqXI2k=;
        b=ppfS2WNYcwLufDsPKLXAx0fCo7eYSEfFh+IH5vDLoBEPMdw97YFayX3c4LgtAkcRnD
         1J6kH0fEJsM2DRUc7/PzeAMzqK2jaCzCj/ljEljC1fzO1XBkM8YWdGtxFCH02yR85Fof
         W+mLJidp62PnWFWKWHUvtlK30yLq3GmLpo6wsH7TugiuFINsCivuYbUNyItmNXqUVXSO
         rXN4QCvorksTyjnYy08HwdesuarmOmXS+MNxEWxPPk4c8rS6H5fX5bnxH1RLFwHQa0sl
         U/lSsF5XSRSQ8bJX72eF6qDtG59BQjB6L5sl7j8Q9dJOTu2Iy0WmPs7vaYP4XWOAtEAj
         IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaSJT2MCORoc9l270zc/rNeGHG600CBndNh2jLqXI2k=;
        b=Dhszl4y/gz4dwZmDU9RYmCjNWbm4qVtJtGHa3PMoKXhbGY1Xk4sRWGrP8zOyMdYqL2
         8NUkTIu8cmIo6G2xnipMIfEM3el3ObrInFB/YQGUe16OFUzDmePGxY0RaZ5wsApu5TfU
         DUIZnPDkeS00enFA82Wkq+4pG/RECEWTaviEH79OXrvptQQQl+Ef7kre/Oesq3ZSvU8q
         Joxc5kTA/e/JSlzie6ISoKOfKSl+QF/EBzykLkxGn2DguPRGl4DIAvE5YvbzzHeyPxzT
         iJ4dzwGFr4u3B1uddUqbSCnhiqixVULNvppeD8EspLxZuiv1faEE3ZDi9JSGNQUUvEjP
         C7dw==
X-Gm-Message-State: AOAM532C0QHDUREx2+V6f4QCKVtIdhYLip5URrlRwp1oSrm24RXTkj0Q
        /0kwziyOlLtQp4m2XvIkRQoFL618WLAPQA==
X-Google-Smtp-Source: ABdhPJx5n2SsuCYq++4duH8bR2nQD5ny18Q1nL2tT3MCmtYaXaDLHs/KliV8ysxui67oQZJvDoAWUg==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr7567585pfc.39.1649230440906;
        Wed, 06 Apr 2022 00:34:00 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a454a00b001c96a912aa0sm4819711pjm.3.2022.04.06.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:34:00 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     gregkh@linuxfoundation.org, mudongliangabcd@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] usb: misc: fix improper handling of refcount in uss720_probe()
Date:   Wed,  6 Apr 2022 15:33:49 +0800
Message-Id: <20220406073349.22203-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

usb_put_dev shouldn't be called when uss720_probe succeeds because of
priv->usbdev. At the same time, priv->usbdev shouldn't be set to NULL
before destroy_priv in uss720_disconnect because usb_put_dev is in
destroy_priv.

Fixes: dcb4b8ad6a44 ("misc/uss720: fix memory leak in uss720_probe")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/misc/uss720.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 748139d26263..e243c155511e 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -736,7 +736,6 @@ static int uss720_probe(struct usb_interface *intf,
 	parport_announce_port(pp);
 
 	usb_set_intfdata(intf, pp);
-	usb_put_dev(usbdev);
 	return 0;
 
 probe_abort:
@@ -754,13 +753,13 @@ static void uss720_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (pp) {
 		priv = pp->private_data;
-		priv->usbdev = NULL;
 		priv->pp = NULL;
 		dev_dbg(&intf->dev, "parport_remove_port\n");
 		parport_remove_port(pp);
 		parport_put_port(pp);
 		kill_all_async_requests_priv(priv);
 		kref_put(&priv->ref_count, destroy_priv);
+		priv->usbdev = NULL;
 	}
 	dev_dbg(&intf->dev, "disconnect done\n");
 }
-- 
2.25.1

