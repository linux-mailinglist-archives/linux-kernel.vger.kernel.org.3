Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B155E944
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiF1PZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347827AbiF1PYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:24:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADB27FFB;
        Tue, 28 Jun 2022 08:24:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so7809274wml.2;
        Tue, 28 Jun 2022 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcFMAgdziIll53iZkb94h130Il19T6Y6bJm+DbymwFQ=;
        b=JWdJ7nbLyzMBpijhEbXM7MypI0Qlwif+4xUbm0g9g+V/YVYSQIr0HmZpbz0eQcrndB
         mI2sAXvt/7l4TRY8ta671E+/2mL5XMGpL6BwPmet6b5Fb9JOZp+b9w3Bu++slccELRS2
         IcwWVvLlGH7Z/03Hip3s7OmCQialQeepCw7V5W4Uz3c48QUEV7hNO0vyVJP9dZTzfUT2
         zxzWbVANWZSglzHw9Yj8nBHWbXeK7A0AVb3PEgGMABpE85vPtf+LW7Z3/PeBDuMMzN71
         sl+tyLIpNadpjeyYTWTAefP80ypI+HVbHB8PuuMg0MxCz4ee9TaTAUaHHuT/2SIXuMnW
         D4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcFMAgdziIll53iZkb94h130Il19T6Y6bJm+DbymwFQ=;
        b=7Rkq3vQHrdKZSYJZFRp/AOOQhdg9ysMrP82P7Z8s/gXSVYxIkZzLv38iaN+NU/lwzm
         ur6IvFANwJkT/nSHSgIRHOe0avcTbu8Ei9i+dlyUUKtlKU3CRUM+k2amHfvcvR5fW2BG
         n31/KOSaoeBddEAIk3Z4rg/U3fYZIaXIx8e5WBlRzE5LX8SQphSEFzMMFCWM5BqCuV1w
         Nkqcr5JYV6evJx1ciORqRJBgFft/5JM0yunEg+GfNraM5bShh/0SS2zI9n75v9apAFMX
         MVtdxJBA1JEhZ6EzMi6HWqEgKtTjkE7c9JpVK4+r1sKSwnQ/zF7KHA9u93Rq60yTjxgK
         0O2A==
X-Gm-Message-State: AJIora86WNUZpUrNbtus/tMm9lxLfCqfJKcpwnc6Cgi4Ti+CndNdy9an
        zCnIwX5NKBkRHjEBuvGZfK0=
X-Google-Smtp-Source: AGRyM1s/PznpZYnHETKAA6z+rPhfFUEY5Vbrhkca4T46fq9s4fRBlaZnd3AovhnmDAp0qaQq/vgLbQ==
X-Received: by 2002:a1c:ac83:0:b0:39c:87fc:5797 with SMTP id v125-20020a1cac83000000b0039c87fc5797mr162568wme.13.1656429892193;
        Tue, 28 Jun 2022 08:24:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b003973c54bd69sm21564221wmo.1.2022.06.28.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:24:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: clean up for-loop, remove redundant assignment to variable i
Date:   Tue, 28 Jun 2022 16:24:51 +0100
Message-Id: <20220628152451.184416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a for-loop that initializes variable i but does not use it; the
assignment is redundant and can be removed. The proceeding assignment to
pointer fw can also be moved into the for-loop to clean up the code.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 1d605e533e29..576dffa9d2cb 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -3510,8 +3510,7 @@ create_host_acc_pipeline(struct ia_css_pipe *pipe)
 	if (pipe->config.acc_extension)
 		pipe->pipeline.pipe_qos_config = 0;
 
-	fw = pipe->vf_stage;
-	for (i = 0; fw; fw = fw->next) {
+	for (fw = pipe->vf_stage; fw; fw = fw->next) {
 		err = sh_css_pipeline_add_acc_stage(&pipe->pipeline, fw);
 		if (err)
 			goto ERR;
-- 
2.35.3

