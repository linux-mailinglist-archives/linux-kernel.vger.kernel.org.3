Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978E51420F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349888AbiD2F41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiD2F4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:56:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422AAB8982;
        Thu, 28 Apr 2022 22:53:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id kj18so4717660qvb.6;
        Thu, 28 Apr 2022 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxrBfFItji/WQyP7QlbaCq3BY0YlFKYJeXNKCSHM/Wc=;
        b=a4g4PHFXKbPlz8P62gkAnav0Q6xF8O2QN8tcCzGabzDcKKEti+RNRvh+DffjK+AzAP
         RUibPBaq58KRahwMmAGxsgOlyuVBOukIpNNPAXIBPYnshzetRFr4bCNK0V8rWO4OTCT1
         HYDua9o9RIg0VmKjgPWvEbI8jsmNimhvbRosAKLrmwpfS58alebfmR06sCIkHJH/hYJr
         92aRtKe6lHcGm3y5iBHg9f06sVQV0hM+7RMFyJ9jZ08pbTrlGher9GSm8mVtXAhXk0p0
         eAUd8jeWoXtCUP2SHQIafDsA9LUouEtM1oJsZUhAjqYD9Zovk40PJuEhxGTtXQPFIBvh
         rtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxrBfFItji/WQyP7QlbaCq3BY0YlFKYJeXNKCSHM/Wc=;
        b=xMon3Ex6w4knhoWyesDnm8lruE3aESiab5USPigfXbRdoplDKvb1VWWEiE03fA426v
         lshmQ3dHufWmBFlP0xaIvoVfTPX7I51Ge6dc7/jkJ9KcgseBCkgEh3e/Gml5O/FqyS1q
         SrnLQpUcVvodo+yBZAXY5qP3hjoABJys6/OV67Wd0vOHmk6ZGAANaUiv1D2H6U4bZm29
         Ta1dsSmnS493V+FwFmt7ZY94RaZ1uP0IhhlmUgpXNnfhAl+/wb/F/+f8C20yLfQW7T65
         +/siFiPHwWtcMr3/sv6vWVQ9rikNhsCTJA3QUfTXbWIWpAPef+39P3XOQRB5rA4vsHwl
         oMUA==
X-Gm-Message-State: AOAM533Qom3a3SsO+V47ON9d5Rx733ipc5RMXYz9LRHKmPcjdLkc0YV6
        dKdo6Zm9+hqa0wI3nGVeLIX/rbWgdVs=
X-Google-Smtp-Source: ABdhPJwXvkkzx1CKKLOi/lBuE7+f2p9Lsex00hkFsa3tO/wZLtsLiLTks3itvNptjVBafZ/ojp32Ow==
X-Received: by 2002:a05:6214:c82:b0:446:7a39:41a with SMTP id r2-20020a0562140c8200b004467a39041amr26749899qvr.81.1651211587347;
        Thu, 28 Apr 2022 22:53:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm1273625qtj.28.2022.04.28.22.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:53:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Input: simplify the return expression of da9034_touch_probe()
Date:   Fri, 29 Apr 2022 05:53:00 +0000
Message-Id: <20220429055300.3852396-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/input/touchscreen/da9034-ts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 2943f6a58388..dfb2604381d2 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -298,7 +298,6 @@ static int da9034_touch_probe(struct platform_device *pdev)
 	struct da9034_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct da9034_touch *touch;
 	struct input_dev *input_dev;
-	int error;
 
 	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
 			     GFP_KERNEL);
@@ -344,11 +343,7 @@ static int da9034_touch_probe(struct platform_device *pdev)
 	touch->input_dev = input_dev;
 	input_set_drvdata(input_dev, touch);
 
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
-
-	return 0;
+	return input_register_device(input_dev);
 }
 
 static struct platform_driver da9034_touch_driver = {
-- 
2.25.1


