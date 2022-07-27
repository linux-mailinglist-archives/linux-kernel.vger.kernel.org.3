Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DE5826E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiG0Mo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiG0MoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:44:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEE41D29;
        Wed, 27 Jul 2022 05:44:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h132so15816910pgc.10;
        Wed, 27 Jul 2022 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61MY3tDSvVgD04JOJxEP0zr1/RXcFL/FfIHd+Kzl4K4=;
        b=ag5utitOE65WpVT8I/rHpTuCcNar1WuznNQm6BvbWYG2viQdMPDg3RYcMvCMDeWu5q
         /d19TlZPkCjNuHs98DQLUsQb6ZtuhLNQwMIsA+JMygAdnrs+Zc2KIJdlR7n61opJl0S1
         /1LVwSMtpw0a1l8yl2z4yS+XOsZlNHh7alz7ZtGtSPGI29pAUYAq0pxF2HUHO/V2GMFM
         8CF9u7gT90D3ZmfSLle6z2CQZPDmBPY+s9R+2s+h39/t/CqkwwtxGnDJOJlN0pGvvNYb
         SzXb9MZXmcAFaAAiD9qQ3MJmNlBeTMnjNk9c2Fuerg/5xsP8C/l76ZXWrYcPYNTn7RaG
         8P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61MY3tDSvVgD04JOJxEP0zr1/RXcFL/FfIHd+Kzl4K4=;
        b=sfXBvpKTr8T8DgzkaUFpsSZAGBkPRen2PlknDBxcnTozbsVtOUqqiS5JyY1+LgDdXv
         GAQfGJNbhRMkecPQaO5mvDm9BbfxNxMfT9NRyn3hxMMj5lr0dGZYLXFXwI42WexbVPrd
         emOSnyFqI13oipxYCcHBQKkVUBC4LO5HiHM16PxqLEJI7f+bDRgd8yrIkZwfusTUvBI5
         WYhD81WygiJJ95nWqttrjdT4S/xCGX1DMR01qZOKXyJRulA8UqZwrEb9qQzousUk0dtk
         xW/pMUfUAHlQ2d/9TBuhkehRsCC1TzbEoi7aiB9CS5MvDOAmRW5SrMLyFaYywVLqeghh
         iySQ==
X-Gm-Message-State: AJIora+pzh024vuEi5cdosdb0QZM3TsPw5gB1H5pK+gp9oWdQP2WBhS2
        uNXpXwOhUEKCUAznZbctttY=
X-Google-Smtp-Source: AGRyM1ueIKtNFolYt2sxuwrKTSWeVwn+M2m4QS1lKusyZklUVHECu1+E1LQi3C0AaI9f1xmqa5wZPA==
X-Received: by 2002:a63:6947:0:b0:41a:1b7:5dd9 with SMTP id e68-20020a636947000000b0041a01b75dd9mr18958636pgc.316.1658925862519;
        Wed, 27 Jul 2022 05:44:22 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b0016d9e53c138sm4073579pls.17.2022.07.27.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:44:22 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: usbsevseg: convert sysfs snprintf to sysfs_emit
Date:   Wed, 27 Jul 2022 20:44:15 +0800
Message-Id: <20220727124415.8340-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Fix the following coccincheck warning:
drivers/usb/misc/usbsevseg.c:170:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/usb/misc/usbsevseg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usbsevseg.c b/drivers/usb/misc/usbsevseg.c
index 4bc816bb09bb..c3114d9bd128 100644
--- a/drivers/usb/misc/usbsevseg.c
+++ b/drivers/usb/misc/usbsevseg.c
@@ -167,7 +167,7 @@ static ssize_t text_show(struct device *dev,
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_sevsegdev *mydev = usb_get_intfdata(intf);
 
-	return snprintf(buf, mydev->textlength, "%s\n", mydev->text);
+	return sysfs_emit(buf, "%s\n", mydev->text);
 }
 
 static ssize_t text_store(struct device *dev,
-- 
2.34.1

