Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47D5AB1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiIBNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiIBNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:45:13 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E5121403
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:21:15 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id e20so2245989wri.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+NJ6xKhiGbSOGo5cMoVPnj1TJxvE218kMGaZcoDwEd0=;
        b=m/JPw4fBulwRDhBlmisCOmLjjV9F5cNSWJjavJyRZuUBnMdNxSvxn5aOGMkKguq7L7
         oLD2t8+6yxTu1blyBmnaqlpwjFZwhijBdj4G99LCCFv1Pr5W8MGt+/8hfaYFbCtXRBia
         hKSJaXEXbnMPxeUNEV1yPKwScVSRjU34sRi+fyIzqXh4ClW7ANBnoOzfN/2fDGjhNQ3J
         CngPoHO8LFfdB2zUiM62oWycW87dkLaMOJWEjn8f6D8HfDwRA9eGEyo/oA6ixtKjXu78
         TSw4MvXCtAU4e8wr/mrCcsqldn0ARmnjIL6JUHCn0M1/T4ULLuVuofIMgXA8aRCpDqu1
         0TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+NJ6xKhiGbSOGo5cMoVPnj1TJxvE218kMGaZcoDwEd0=;
        b=QufzBWOAQO5hJQj3YcCU0eMTl3k7HIxckBvWG2qqTr1/qojr93xEfLwGBp729DiGFd
         r3oj4xzCv0boHG+HU395l9P3jB/+9M4xel1EUSyPbF9IDbxNhJIbYQDV6vOSRQHujruu
         nXsYkcZYDzTT+ogdwrlgeU3NOe+5IDLa918yXx8wT8gX0nNAiW+g0nBYcP5UNpILB2kV
         D95+0K8xGOl1umaV0kdhfGKpB1V3wJmPuSyOZwbOC73QhiUSWCC4ZsTl43wRGT4UlPEz
         Sjgs2+z39GSIopnYdx/qfQkAE2KltEFynaYC8PFNCtkcQ39kJTiLEuRhuwB9cWzeld0W
         mdzg==
X-Gm-Message-State: ACgBeo0L5f3n0nv6Uq2cbSEgP3g69AgxVRpCXfYVxL4MpgQ0nXU0AY/V
        qwJu8ksqNqJsJ1+va8aJbmDEaQ==
X-Google-Smtp-Source: AA6agR5khwA9O39WiV5uyZO+cy8xHac71GpvkhSdkl6wlAbK5MCCDdhbahjorPKL4lXTWTohP7FFgQ==
X-Received: by 2002:a05:6000:144:b0:226:da62:6d90 with SMTP id r4-20020a056000014400b00226da626d90mr14343238wrx.609.1662124481631;
        Fri, 02 Sep 2022 06:14:41 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b002253fd19a6asm1766253wrr.18.2022.09.02.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:14:41 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/14] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date:   Fri,  2 Sep 2022 16:13:44 +0300
Message-Id: <20220902131344.3029826-15-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cd7c6cf269a1..3e0dbb5e9548 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -278,6 +278,7 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	u64 dma_mask;
 };
 
 struct fastrpc_device {
@@ -2310,6 +2311,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-- 
2.34.1

