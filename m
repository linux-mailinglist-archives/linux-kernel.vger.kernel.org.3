Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D652D3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiESN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiESN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:29:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2CB0419;
        Thu, 19 May 2022 06:29:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u7so5529209ljd.11;
        Thu, 19 May 2022 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBTQmfyssGIfGVPdqVAcjZchb4O4iswNrB7k1hlCZgE=;
        b=KxOheiMGI4R4OBH2DaUj7ci0hkiF/49kSrsprxpwG2C38neR3pB/+hkQWIbeb89Pa4
         LVlPNFgFvMoG6CgoqmUl9eCN+990a6OXoefVlyVGuYJ9I7kSuf4sdBXAJXFo3PX8hMFX
         Hk/ZigYIzFrs/Pk/pz7H1q/BBMswstrwRvA1k9/fqgIQibmAG4FmcY+iB17yAsX2ffd8
         8rqhOZwRR3uCwjyhFr9glGLm5AmojQZoqqQM+jTnYaUzXm77hZwUwLJhsRXgq4xDNawK
         9JMfWDTVSatCmqPTd9VwnzctYsKKnJVX9Q5qAx9zrZkdxzt4wBl+rtRGc27JYpuKARgc
         CW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBTQmfyssGIfGVPdqVAcjZchb4O4iswNrB7k1hlCZgE=;
        b=Hemh55PzDg8pmtITk3mXfQ2eB9WhOsYlZeHqWOMVi17Bp+8rzglYqrctCtB10Bqcfq
         0zYRpznOQ9O9NXdURPYHYCtPJIlM609LxHlDlnZ6EIvhsu4iJr3CuBoYJcBO43Id37LU
         e9HJvdEq00CaGP2/TubcWCeW1Tv6C993OglRtg00x6v2rlhL/Tynad52Fi5/pFyxcYcI
         RbcY5RybWAucN1hdRSrndYRMzksRcUgOmk1fgodM3tV5XiJUNMu/rP8qnT8hrAyg47o8
         QhssdML4yxfJjX5OMN55ggDzGa9mGr8HcLQRDS4M45cauVFOQxfwtmetzeo0QzXqtHpy
         NSkA==
X-Gm-Message-State: AOAM533spYWwIIf9/L+wusRHu6bqIW1wP53tMzCZvC2ch57zmdWwE9iv
        XlN9sLp7VWm07Ndlzvp9y2o=
X-Google-Smtp-Source: ABdhPJwjFMM3+aJiSQbZZeqdKcIN79u+MM8Oz5DCfwJyu0GygNK+7dqGLYSNCx1bmIPljx0hp1koCA==
X-Received: by 2002:a2e:8696:0:b0:253:99e2:ca with SMTP id l22-20020a2e8696000000b0025399e200camr2682093lji.293.1652966959842;
        Thu, 19 May 2022 06:29:19 -0700 (PDT)
Received: from dimich.home ([217.115.104.30])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651220d200b00477c8127e50sm227060lfr.122.2022.05.19.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:29:19 -0700 (PDT)
From:   Dmytro Bagrii <dimich.dmb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmytro Bagrii <dimich.dmb@gmail.com>
Subject: [PATCH] usb: core: Call disconnect() only if it is provided by driver
Date:   Thu, 19 May 2022 16:29:00 +0300
Message-Id: <20220519132900.4392-1-dimich.dmb@gmail.com>
X-Mailer: git-send-email 2.36.1
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

A driver may use devres allocations. Disconnect handler is not needed in
this case. Allow such driver to leave .disconnect field uninitialized in
struct usb_driver instead of providing empty stub function.

Signed-off-by: Dmytro Bagrii <dimich.dmb@gmail.com>
---
 drivers/usb/core/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 355ed33a2179..d7fe440b033c 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -455,7 +455,8 @@ static int usb_unbind_interface(struct device *dev)
 	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
 		usb_disable_interface(udev, intf, false);
 
-	driver->disconnect(intf);
+	if (driver->disconnect)
+		driver->disconnect(intf);
 
 	/* Free streams */
 	for (i = 0, j = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
-- 
2.36.1

