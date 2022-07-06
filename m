Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A5569207
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiGFSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGFSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:41:40 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D814006
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:41:39 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 189so16004377vsh.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mx+gg3QeKmgimEFCxkgENq8mFFJCcPLK3Tpa8KBdXZQ=;
        b=5ImEhxj9zI5QeixgMRy2oCb09ZTGtoB6sy1iCWHZJEwpEb/2tcEQxNADRv6npBljpf
         RBFko9PzIovMhvzHZ+vyuSY9vlzgMgLtBESaw2zseX/uky3RQSPesFJA7iiB5rqdAelc
         QqO/eolI+l+BGzAnaeiSqx+J2cXRfnGkBXNCoX8Cocg4mvfcLmEDIYihPzYg3lL4e6fH
         c31WF1yoKJqHG4OJKSXfh3bZjjACv8KSKvVqBdHOm2zFuV0N1e9b1eTWMLU8SyRimOVg
         qN9LUzsND3dfxynncyS+fU3Q3Yv20MOwuTJjyZFc71LvOjkWOc9oJIOSzCqOcTAZh26S
         Pc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mx+gg3QeKmgimEFCxkgENq8mFFJCcPLK3Tpa8KBdXZQ=;
        b=DUAz/oyEyA9f+0QPdgbqytauqiLQn3ZKwNtiXIJFX+da/6tRCX3/rvIOlYJr1l53Y3
         FsrHmWnDuJIc7VxkI3pnom/C6wRP2SSIjc4iwiyl8T4ZdZLXaHjqoHWpJUl1x51YpjhH
         73DckD4xNpANRwbpKpwwfuOIlYmeI+tRJg3YJukNhZs5176da0AIb+oOUBbEM0KW5/Pz
         0umhebOFz4AHB4wh7VRGDtHz82bRMycjc/11eu8ednizlr2x/vH/XFPNutxBkbCSWGte
         ywdR9n9/DE+wca58HMnEPoKSN5fX6oOagSclK89cGg5jn2/b+V8jRY+IJe4QjnZz5MB0
         RxBA==
X-Gm-Message-State: AJIora8Et+t7K1ZlrU18NOJ2/bEQriRPcVTZSNZE0PPoSFYzGgJRNuWe
        O+MH3j2rEGBudjOrprmvYe0uiw==
X-Google-Smtp-Source: AGRyM1s5ukynxxAouwTdeCJdufFu6R51/gQaW1DL+UIgufieP8aySiDkibXdqieMtaA8i4QJFxT64Q==
X-Received: by 2002:a05:6102:244a:b0:354:4eaa:f176 with SMTP id g10-20020a056102244a00b003544eaaf176mr22415969vss.45.1657132898361;
        Wed, 06 Jul 2022 11:41:38 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id j12-20020ab06cac000000b003828662fb30sm6052225uaa.39.2022.07.06.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:41:37 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] drm/ssd130x: Fix pre-charge period setting
Date:   Wed,  6 Jul 2022 15:41:33 -0300
Message-Id: <20220706184133.210888-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix small typo which causes the mask for the 'precharge1' setting
to be used with the 'precharge2' value.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 08394444dd6e..f4886e66ff34 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -350,7 +350,7 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 
 	/* Set precharge period in number of ticks from the internal clock */
 	precharge = (SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep1) |
-		     SSD130X_SET_PRECHARGE_PERIOD1_SET(ssd130x->prechargep2));
+		     SSD130X_SET_PRECHARGE_PERIOD2_SET(ssd130x->prechargep2));
 	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_PRECHARGE_PERIOD, precharge);
 	if (ret < 0)
 		return ret;
-- 
2.34.3

