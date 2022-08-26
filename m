Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE615A21A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbiHZHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiHZHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:20:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B5BC19;
        Fri, 26 Aug 2022 00:19:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f4so640531pgc.12;
        Fri, 26 Aug 2022 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=j/9iHgs4l5y+aD60Vfb2kB4eAbqEKVoCHwikUayMWBA=;
        b=OuCffG4xvAn209qGHVhLOsExjE4YLkvNQv25x/AYayLrOs/isW6BWvAeUr5OC2LzwN
         XXERUYvlqZUXvZVfhRi0wCk/lrYgU0QGKmvF/JuHttNvsDQq2dsT7ZxPCJp7MkQo/IYN
         Svvyo3mLzqcNabYCIKy25ypW4UH7UkMzxb2SuFjQfV20JrnGtmeXhnHlt9CKeA0q2HKS
         BhlE/cO6uHyEROzp6sQSoLHj/HBTbOkX6+Y3LPa15ERsF2oWJy1G3796pa5FAmhzf78I
         j9qqhKhIwmRXIp5+p/9ZB7w5DDbKr7FWMah2R76fSEh5jxulcwmaqZBUfgNByPaHCEPm
         wvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=j/9iHgs4l5y+aD60Vfb2kB4eAbqEKVoCHwikUayMWBA=;
        b=QrwnmZ7Mou5jG1Kg3q/hYLrNFSnt/+ofmbNSQOEiJ1rzd+EsxSOUelRfQbbTlX+GKD
         1b+ShC/Gfh7iC8qCPNKzL7x7sEJz/7w7hJrNobKdYSfp/XR/c1vO2PQrStDUS+i6otkq
         VcMX508nM1q+Oq1wwrWBrZk85Jd+xYlMRno9oBBG6kc0ygtJhd3+jl46IZhd9EFIPHVW
         LMTitFPfH134mNNqI4+hz5pN4w/Zj2+QZCTDR98YoJpRatXyz/KDWXkKXIuFisEhGwYH
         i8aTopx17QBZbMfqpbCeEQMt+ijFECXwDdcClCH47ApMK71O/ZfbfiQXZbEHn1y/Fa4B
         GdNA==
X-Gm-Message-State: ACgBeo2zU20RMcPeOWbVMGK+EG8i5sGEfziLjI9Z2QvOrGYlkWU5Q5Qu
        GNvnQfr+Wan/jvyoVpbWBvcZVQVoURk=
X-Google-Smtp-Source: AA6agR5bVoNlxs4bGqigbs7h8yaT1ksO0Ug3m4azHCl7Z6fMiPK4W9H7BLRBvynC4bBfLFb/7atjHQ==
X-Received: by 2002:a05:6a00:1687:b0:518:6c6b:6a9a with SMTP id k7-20020a056a00168700b005186c6b6a9amr2626634pfc.81.1661498397946;
        Fri, 26 Aug 2022 00:19:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001730cf6f839sm823490plg.70.2022.08.26.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:19:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] rpmsg: char: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:19:54 +0000
Message-Id: <20220826071954.252485-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value rpmsg_chrdev_eptdev_add() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/rpmsg/rpmsg_char.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 4f2189111494..0850ae34fb88 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -424,15 +424,12 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 			       struct rpmsg_channel_info chinfo)
 {
 	struct rpmsg_eptdev *eptdev;
-	int ret;
 
 	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, parent);
 	if (IS_ERR(eptdev))
 		return PTR_ERR(eptdev);
 
-	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
-
-	return ret;
+	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
 }
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
-- 
2.25.1
