Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC764D108B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbiCHG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiCHG5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:57:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741C3D1C1;
        Mon,  7 Mar 2022 22:56:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n2so6713933plf.4;
        Mon, 07 Mar 2022 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WGEDjomgTIAfweWu7avOEAcbJjxPD8+Y4IRBGqyTSs=;
        b=dy1nFUgJ/b+z32FJwqyUfd7xd5jlSvl/9LlZ8hNMpeM1uf4qwzJ6+yYSOV/tT7zMwZ
         28NOTbJyeiNST9tkD+lM6obBQK43PjS2EyrYSVvuxWNQ5WTj32xvWvaf93aCPht939Wj
         alJDrQ3LUDYVjUENg0NkUpZqw5w4cGM/rbxBNzDRNxCQUr/ulPndrWdLTiVTfhbX+baq
         puztxakZHcR47C0xaqDCWERdE3uK/ANAKXPl0OCARlDfQKMKjXRTs9l4wd06UAQgqz8l
         WuFOXYeFBFDNglLnJuZWPm5Xc9aaFoc/6Ia4wYnD30r1abokHkY0HTPv3H88qVzjdXA6
         4PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WGEDjomgTIAfweWu7avOEAcbJjxPD8+Y4IRBGqyTSs=;
        b=MVsWxhhepyTQhM9L6jqwC1bHBWGLdFM3AMXVmx4zl9/KMcvOw8EAulLLVbepqrr4Wx
         0NToCoHB8mK5zuBG2NKhPwKRWr9MWkAZ19FGG17y9hzZET7HOI06/GASJPwGRINStmov
         VRIBk2WHJwJadEASQaCDF825Bgb1NomScqTxOGucCh9dhVnvHs+cv8HV7obIiE+t2PxT
         qMP5paGBWh5HBzaZAXh5bRgkFgND0W+dIF98CKAD/+94zqOzrqJl2lAW8j/zL+08jim4
         3I1Rc+9CtJ5CEKNKYe8k+wi6rhSPm379+szz7W2TJGnRnWDX+bbPr8HJUCHb7K1lzu1u
         D9Bg==
X-Gm-Message-State: AOAM53168TWlTQSnFTvwRnQhHaKz8PRxIfFFLaFyhG7KUW/o8hw/ynRb
        C2LQTQFTXH6ke59I++tBVtk=
X-Google-Smtp-Source: ABdhPJwTmQ0ZyBwYlxQ17dCaJY6Fx0xeJsqQRjSWPOJG8kUIIuni3WnX7I2Ay9o02oczHccDwQJUbQ==
X-Received: by 2002:a17:902:c947:b0:151:a988:f3de with SMTP id i7-20020a170902c94700b00151a988f3demr16012133pla.104.1646722587079;
        Mon, 07 Mar 2022 22:56:27 -0800 (PST)
Received: from ubuntu.. ([115.27.208.93])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f701135460sm6474236pfm.146.2022.03.07.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:56:26 -0800 (PST)
From:   Yeqi Fu <fufuyqqqqqq@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyz_cs@pku.edu.cn, Yeqi Fu <fuyq@stu.pku.edu.cn>
Subject: [PATCH 2/2] usb: typec: fix memory leak
Date:   Mon,  7 Mar 2022 22:56:17 -0800
Message-Id: <20220308065617.90401-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yeqi Fu <fuyq@stu.pku.edu.cn>

Resource release is needed on the error handling branch
to prevent memory leak. Fix this by adding kfree to the
error handling branch.

Signed-off-by: Yeqi Fu <fuyq@stu.pku.edu.cn>
---
 drivers/usb/typec/class.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index ee0e520707dd..e210109c696d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2099,6 +2099,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	port->cap = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
 	if (!port->cap) {
 		put_device(&port->dev);
+		kfree(port);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -2106,6 +2107,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (IS_ERR(port->sw)) {
 		ret = PTR_ERR(port->sw);
 		put_device(&port->dev);
+		kfree(port);
 		return ERR_PTR(ret);
 	}
 
@@ -2113,6 +2115,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
 		put_device(&port->dev);
+		kfree(port);
 		return ERR_PTR(ret);
 	}
 
@@ -2120,6 +2123,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
 		put_device(&port->dev);
+		kfree(port);
 		return ERR_PTR(ret);
 	}
 
-- 
2.30.2

