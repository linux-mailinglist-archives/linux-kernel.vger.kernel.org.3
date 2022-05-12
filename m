Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E2524444
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346742AbiELEc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbiELEcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:32:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00EB21719D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:32:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so3755530plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Uc4xBWgLXbLJMyH+huZ6Mz3VJQ2nWjRyAfnIg3aZiQ=;
        b=oxcVRMOM881LdBYCU30dlLdCih7eOom1/eJBRocu7FvqlnMUWhM4x4n4Y/EwJE1olU
         VQII192HRJNlZfi6N6rZ9u851ZpOc8MWvkNr3PewicA8pryF4PBL4W5P+zkm9gqgeddI
         TTnTDZeGoArtP3U8jmz74bncxK60Xld7Fb7s8YPiO/fucxmyN7yBoOm9BQi2mdD82s5p
         kl83J0VASbqv5ZpMPiMuYjmAUImuiUhW9FSHzQWcuCSlPOZA10eq1J0KvpsIrcg3npPX
         E9VFtr7LHp5izVioeknY/Itlne5s/x750DuIO6Y1ARwojNt4v4a43fqppUtLdlKXB+hX
         4f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Uc4xBWgLXbLJMyH+huZ6Mz3VJQ2nWjRyAfnIg3aZiQ=;
        b=VTUGQJ4Ik6OB32erVO5QcmzBhIa1yzB8kXw7yN7QYWc7Tg8qaJ6l09QXOvxWzwcAMW
         ErQShyrORUOMu4vKUC/tndkFAUfXpESajBYgIzL5iGQY2oZcVRs5DL4ic5WqDiLxH51f
         PhUXTxNNMh8SPBA/4QUnEVU0xEGjEyR1ClSgpqOwgd3G0r6lbN69b4Ysdm/u6CZhs4Ra
         k/n4MSgPV1jauuJTYiQVdLSeii8zZX5gGJPNb4XpMsQoqX7QXGMv3zzn6hEaFodfgjSJ
         OKgIcxPztQ6fSqSPb6FITBFL7i5w0A3aBH7JMqBw6kR+9he0PKFtjnh1oZZ8BexWnWea
         q+gQ==
X-Gm-Message-State: AOAM533IOc+yjNEQwS9Fx2CWJ+jQRc+q+gWo2JES9SDvAvQOJYLDbQsg
        6LviXpjK2eVW7NJPPfJJy5LHTZIRjdlJXuyn110=
X-Google-Smtp-Source: ABdhPJxMOc2HWrWVi1oHSB01QOZcOR8Nqm5Dh9k+Q40lirt3i16jlPiGR102+ferGO+gxf1iQhIhOw==
X-Received: by 2002:a17:902:ba97:b0:15f:16f9:30ad with SMTP id k23-20020a170902ba9700b0015f16f930admr15778824pls.12.1652329972039;
        Wed, 11 May 2022 21:32:52 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u21-20020a17090ae01500b001d5e1b124a0sm798724pjy.7.2022.05.11.21.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:32:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: ti: omap-usb2: Fix refcount leak in omap_usb2_probe
Date:   Thu, 12 May 2022 08:32:33 +0400
Message-Id: <20220512043238.63252-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 31a775877f6e..98133e5fc9de 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -421,6 +421,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		}
 
 		control_pdev = of_find_device_by_node(control_node);
+		of_node_put(control_node);
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			return -EINVAL;
-- 
2.25.1

