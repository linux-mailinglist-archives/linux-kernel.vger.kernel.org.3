Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26B588735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiHCGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiHCGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:14:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1802181B;
        Tue,  2 Aug 2022 23:14:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so7346207pfk.1;
        Tue, 02 Aug 2022 23:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nJ75P0tAumV9AP6iO78CS0E4eXETLbR7d1PbS0GXBu4=;
        b=TpeQc8iBjtJg7fQW9AKixpeMOnscRkCmzpQWqwuDsvm7dlcTPonHP7GH3Zw6cazUOm
         K+BBj0Bggq42KPk5b3cbZ/YKjbg0V8cqxXo45sTIkmmEPDD1SZbEdlBeFZ/HGFd1mio1
         TpdpeD050+lWS7D0fuDca2xY1YZx/RsOpFiq+SNNdzYxFzH1VahVbUVVRUWj6eNcCFNl
         zARv3vU4qnK/6sOEbeicxAKuJu49hM8z8i0WVjjer7J8fEkZemcYYIbP7n6dJbqnTJc3
         GXGaGM74WTutwcQWevUdR1m/COXsRTXH/SrciHr7YD7Dv3cnQjTb867p86L7JlrENeNK
         a2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nJ75P0tAumV9AP6iO78CS0E4eXETLbR7d1PbS0GXBu4=;
        b=LQITV/GVHoH8Mwl76Soz8NbIrbLLm7ejWoPCk8u8FMKxaUyKPeDUpyaepfHUNy79ll
         S3DqIhrHBf+rLyvwIJdXNDXnbY0zJtBNkTT62wvifPEMQixUvrHuqk6ct32MqoG0C9Q3
         iyJg7JqKAWrKT5323E9U+GGcrM1hM8/OWZKGh5ZhJqLufaze40n1wBQa3/wL7EwF3761
         zfWhEgjuzYFJYTCfi7CRANArvGX+nTaXGhwZpG6rYXZ4orPqAwipiVkslmFh26rpW2He
         Awc29ZmCQ2TLQnNwK73Gi5ZzXS9GT4nPOzpdxCrq5fZPimJcQQHdfXoMnPx6rz08uwXx
         GPYw==
X-Gm-Message-State: AJIora9IJf0kyfB+t6+sMINVC0dpR5kxhm8hAf3/3V0lckQXUVHz/17h
        jQ4dpl6MkJm8ARin9Iq8d6+Uv+Oom00=
X-Google-Smtp-Source: AGRyM1sPy+HzqQJ1a6Dk4YfBnddtTo4P8B7l/KylM9jKZXlvgSrPSHp/c7aY6ad1IaRoaPCL1NKvyA==
X-Received: by 2002:a63:535f:0:b0:41a:ee1c:a15f with SMTP id t31-20020a63535f000000b0041aee1ca15fmr19821674pgl.265.1659507296802;
        Tue, 02 Aug 2022 23:14:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0016d95380e8esm857926plg.140.2022.08.02.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:14:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] USB: apple-mfi-fastcharge:using the pm_runtime_resume_and_get to  simplify the code
Date:   Wed,  3 Aug 2022 06:14:52 +0000
Message-Id: <20220803061452.1650472-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/usb/misc/apple-mfi-fastcharge.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index ac8695195c13..1bf9a67f4cca 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -119,9 +119,8 @@ static int apple_mfi_fc_set_property(struct power_supply *psy,
 
 	dev_dbg(&mfi->udev->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(&mfi->udev->dev);
+	ret = pm_runtime_resume_and_get(&mfi->udev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&mfi->udev->dev);
 		return ret;
 	}
 
-- 
2.25.1
