Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C14F722D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiDGCmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiDGCmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:42:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1B138346;
        Wed,  6 Apr 2022 19:40:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z128so3815800pgz.2;
        Wed, 06 Apr 2022 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0BS+DlYIFXWqo3Zzeim6fvtNJHwGEjQKRmny/DdPeI=;
        b=lj6OeQgsdULcEtsSutYDsI9wAYtipXM4Vo+YHFr4+Xt1+cgsZTF4/6bem3AhwhMJHs
         bCGdWyDnPcy2lOtnzGBk26IvVhPSuCVcRpy2r8jjtLq1mBqLyGS+8DXeqsCpxkHxjuvn
         UfNFVoIqOnm4n1smOkLhGKhUkkern6DLZh/ug0AZMNZfGc6oULdMGDATfwndNEHU2cP8
         XJ5LhRvZiRq2KMy1OlLp8ZGKsMh6ryGYDgFqw/CurM3tmHkP2T+j1EjZprEjC0vq9lA8
         RB/ORZZIziTJZYylcg+qNJKwSvIgo0i0/CczwjIf8U8ZzLmevfcRGg1sO0fXU7nOI4k3
         5PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0BS+DlYIFXWqo3Zzeim6fvtNJHwGEjQKRmny/DdPeI=;
        b=OBUSg4W8BDWDgS4E/BB1DNKsaQ7vwUZJG17WUbDg5ThEBufGOdTGvcpbkwxC1m74Pk
         8hG1nz3/YW0f5hFeLotwwPncb2mXg1/SzxD1erF1i9g8cZS188ge9HZAcG58aNBfGmB/
         J71cbshm0qlEcryqPRUrEH/sl4PNz1IP35O6Gehdh5RFpYXO6ynolQP/lROhYaTP4A5H
         RXCOGUBnFBzl3NZl0IAYp2Ooc/eitjKBDl4+if5p6F+Geh70T1uYCnnTohvwvZNSDGgy
         OQneSB0+VnTG8sAcrDnA5etZCFx7P32WQr+gAnT2Wc2bukTTYh7paEvATLRNQbPTFVXG
         N3HQ==
X-Gm-Message-State: AOAM530Enbxzfbr/7w9PPZ9a+L9rpBWpT5pwa1EBlAZAu8i4P+Q2NcWl
        yK6ifHV1QNZ0HTQ7P8+9pib2mZciqHtdvg==
X-Google-Smtp-Source: ABdhPJzif8Jcyr1Q316a7UtqQl2OAfR8jsfKZq+llBOYYuCIe+5pdhNZTMccBy0FnO9J14oA9b7n9Q==
X-Received: by 2002:a05:6a00:2887:b0:4fa:e10c:7ca with SMTP id ch7-20020a056a00288700b004fae10c07camr12046138pfb.9.1649299216608;
        Wed, 06 Apr 2022 19:40:16 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.52])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm21577827pfj.152.2022.04.06.19.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:40:16 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     gregkh@linuxfoundation.org, mudongliangabcd@gmail.com,
        oneukum@suse.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] usb: misc: fix improper handling of refcount in uss720_probe()
Date:   Thu,  7 Apr 2022 10:40:01 +0800
Message-Id: <20220407024001.11761-1-hbh25y@gmail.com>
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

Fix this by moving priv->usbdev = NULL after usb_put_dev.

Fixes: dcb4b8ad6a44 ("misc/uss720: fix memory leak in uss720_probe")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

v2: fix a stupid UAF in the previous version.

 drivers/usb/misc/uss720.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 748139d26263..0be8efcda15d 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -71,6 +71,7 @@ static void destroy_priv(struct kref *kref)
 
 	dev_dbg(&priv->usbdev->dev, "destroying priv datastructure\n");
 	usb_put_dev(priv->usbdev);
+	priv->usbdev = NULL;
 	kfree(priv);
 }
 
@@ -736,7 +737,6 @@ static int uss720_probe(struct usb_interface *intf,
 	parport_announce_port(pp);
 
 	usb_set_intfdata(intf, pp);
-	usb_put_dev(usbdev);
 	return 0;
 
 probe_abort:
@@ -754,7 +754,6 @@ static void uss720_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (pp) {
 		priv = pp->private_data;
-		priv->usbdev = NULL;
 		priv->pp = NULL;
 		dev_dbg(&intf->dev, "parport_remove_port\n");
 		parport_remove_port(pp);
-- 
2.25.1

