Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B853784B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiE3IzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiE3Iyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:54:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62978EE6;
        Mon, 30 May 2022 01:54:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b135so10008828pfb.12;
        Mon, 30 May 2022 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYBYMOHWPwPYs/2nNps1d9NnldHCf0XNTNqDfqRqx2I=;
        b=ZEYtSyxDW1QgJcM2jxTgM19Mb918TJlGvkTWlT744P2ti3gTPT7OgJdOJSI9+rllaN
         Ocr0A70a5RIFnehQ4QfkHmJwn7sFOujJeI9qoyf10Jue/jUVoqyuJ79+RzxRdQSjQmI2
         G5uFckb/9Lgx118cqYAlazrh15VO3oQ0qrcpwzrtOgQh1DjfW8SIEJkOc+1vnH+XZC3S
         WOBcqV9WkeggrPswvkCBL//88qivumVSseTHEFm0nbCkn+XjI4Qhm2O3zorH5qeA2YQO
         cJfJLsBlpwGK1vSODGXrqVlDK/scbsz7DmMEWzNXMats2lfWilgUs7IcnluqVKqW3zIc
         Fg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYBYMOHWPwPYs/2nNps1d9NnldHCf0XNTNqDfqRqx2I=;
        b=WNgcK6uNPo0dNSJrORxN79jCJFgy/crgDj01cwwkl/rZEg92/Jw4a9cY5att6E0It+
         9iqxfdTMrhDuOcsF35UZUrIOJ6W8RzLVB6Ksmtla/z22tBw6Na3LLeHN3areCMkYs12o
         lfql3BSXPXO6GbNsUbk/Y8vCaTOCQT8pe5J1ky0Wabqc4kz1Ba7UZ/w8odLHQKlSdI2T
         Uf8nvNoG5qPOqIhg5MmdlFbqdci/DAeLCoAUGSe5iujJAgWhLoYz8KOZccul5cO1IOqw
         N+S5IMuU8Ayioo4nQUmVeM16r35Bpwq0Q5acW1rrQk+7abhi9SGN9DsP1m72GrupDTE2
         KlRA==
X-Gm-Message-State: AOAM5315rLb94LFmWyPOXzAr88neQmJlODwTS1Blf4sL6ZIG7WUGIfCs
        tG0UAc8RdsYIYx93vkI8fsY=
X-Google-Smtp-Source: ABdhPJxuQM96citbVhxAsdnyrLhmfEYcT6KHwgM3rh8JSyzhanYLe/b1aQnK8wJPTwImXkdZWk9G6w==
X-Received: by 2002:a63:eb45:0:b0:3db:b166:c518 with SMTP id b5-20020a63eb45000000b003dbb166c518mr47580692pgk.316.1653900861339;
        Mon, 30 May 2022 01:54:21 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o10-20020a17090a5b0a00b001df6173700dsm6249833pji.49.2022.05.30.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:54:20 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] usb: dwc2: Fix memory leak in dwc2_hcd_init
Date:   Mon, 30 May 2022 12:54:12 +0400
Message-Id: <20220530085413.44068-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_create_hcd will alloc memory for hcd, and we should
call usb_put_hcd to free it when platform_get_resource()
fails to prevent memory leak.
goto error2 label instead error1 to fix this.

Fixes: 856e6e8e0f93 ("usb: dwc2: check return value after calling
platform_get_resource()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f63a27d11fac..3f107a06817d 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5190,7 +5190,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		retval = -EINVAL;
-		goto error1;
+		goto error2;
 	}
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
-- 
2.25.1

