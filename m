Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267F559B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiFXOVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFXOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:21:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FBF562D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:21:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x138so18933pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2Nx0BOBB6ekdm1U7bh3Zno30OffMdY3lMdwn3cLPcc=;
        b=PKJY/ZqW6QWjUEvVKvlgmRXCPCKacIUVkYU5gyGwsmqSq3O7KRGzo0mBEGeWO7+8ho
         1hy30InZQVN1m/ELaQQE/bv8C/p7Fo8PQCf77qX2gP6NF+rzQqiRHVvl53gljwNgfLG3
         U4a7pLdloEnAW1lmnlhsARkHq2IW3K3AT9bqgDADEHNqQq7k7WW+LamIPr46IU5x03Z5
         Tf9rcx1tqWQxZWoPzNlt7PglTDNI3fXN1g6QgQQengyaHVeSWOlwxZeBWJHqyKw914XR
         tTtfafREtkDf/9PoKWw69uiZK/eubDtoNFDC5X7Vd8rNWMuJZdCkMcgOv7mQuQ5V9pnt
         B1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2Nx0BOBB6ekdm1U7bh3Zno30OffMdY3lMdwn3cLPcc=;
        b=BrExOQZTke8ndf2TsJI7jzTpMBr3EhIanUUxyyLBDGEkQEgedpVUPl1CSFgOLWnFjb
         AjBekcfuG6l/D3o7Ky4j2eFkYkeO4svNj45d/ibgt0lL2v18wCXn+pagHigcweUEZu/9
         Ygt/oW0yl++I/0tfyuVyYpM5liMC4ezF31PRvJNP9FvKS0QGrJlWCzmytZhbIkI7SstP
         Hf9auwTe3TMWVCHdSSaE+vx4wAizEluwANAbUtSoIC6zyvMoSia9XPBAVwJ+Rdj9e2Ju
         KuLmr9uFs5IF/++9Gid+/bPJoCiPmajlGsgaOpFH9jMg1DEbZqW9+XyM40E7x5/ydIiD
         yKZw==
X-Gm-Message-State: AJIora+ula6XlBgv8t0cE80y9MHGPb3tPZm93fVLbHWrq9AlNhxgYYsG
        0hTMd3j6zUymGdRMJh3bBb+eKg==
X-Google-Smtp-Source: AGRyM1sGZQHqM4vAQ0rT8G3P/TII0MhrjWaVdriD1m7/7FZqm+K2uqzjEL70ZsJ7071YrCWkg3B9PA==
X-Received: by 2002:a63:8c5e:0:b0:40c:95c6:7069 with SMTP id q30-20020a638c5e000000b0040c95c67069mr12361332pgn.148.1656080510066;
        Fri, 24 Jun 2022 07:21:50 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.196])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0016a15842cf5sm1868877plb.121.2022.06.24.07.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:21:49 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     acc@openeuler.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Yang Shen <shenyang39@huawei.com>
Subject: [PATCH v2 1/2] uacce: Handle parent driver module removal
Date:   Fri, 24 Jun 2022 22:21:21 +0800
Message-Id: <20220624142122.30528-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624142122.30528-1-zhangfei.gao@linaro.org>
References: <20220624142122.30528-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change cdev owner to parent driver owner, which blocks rmmod parent
driver module once fd is opened.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..f82f2dd30e76 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -484,7 +484,7 @@ int uacce_register(struct uacce_device *uacce)
 		return -ENOMEM;
 
 	uacce->cdev->ops = &uacce_fops;
-	uacce->cdev->owner = THIS_MODULE;
+	uacce->cdev->owner = uacce->parent->driver->owner;
 
 	return cdev_device_add(uacce->cdev, &uacce->dev);
 }
-- 
2.36.1

