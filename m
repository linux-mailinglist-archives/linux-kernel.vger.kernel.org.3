Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6DD4D2DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiCILLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiCILLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:11:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4616FDE8;
        Wed,  9 Mar 2022 03:10:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t19so1648447plr.5;
        Wed, 09 Mar 2022 03:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TbLlXg902aKOx1jSLgIOuIQvaX7+aR+Xn8kO7bkqzQM=;
        b=Ia69aUXkkvWAwS38X2tv3wkThPwHUGwhI4RELVhbjXXZ1uw85lVlxC8Au5DOwtqzIE
         02kQuTFbS2tfoA3J7PK772M51Jssxgfn4yvDPk/bmbRPEEFCaSO4kXLwfJ9c+PJWiMMc
         Q4s3a+2uIocFTDwWG2c5yA8/9RILQlkHqAIKh6305zb5O06rwMcbgHrZnUtBrVSopc1y
         +i4tk+JAS15OTyWlpLzaK4kYE5xs/yGL8CZVNAblx/PW82VcqJNXSG4aQYYgrINCrQuD
         pKYfUvnN1d/kARy+IQH4Bp9mY1n2gfjfwM9AlpjYAGgVflb/h20GFQQZcZAfyWzncAj8
         Uf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TbLlXg902aKOx1jSLgIOuIQvaX7+aR+Xn8kO7bkqzQM=;
        b=PU+WMmtw6Hdwr7rzXC9KMyhD9rPC1xcG/YRpkl5xyrDMQfTv91T4LYz8m0rJY1Vo/A
         IMYd6ebOYFtDSmYPrha58mvq21Wz4hTAOxUkOaBGPG46fW1etznMmwLzZfFOuHjurSK+
         eUGkk1blCv4sKLyU9vR9On1lTO918vCFX9OpJb6FsYc9mB3wVwrXKo/hEV1g6pIhleD/
         yfV2lhuErZHuV0ASkmr8j2yQS1wG5IuF9msynQDDKtsSvRxf8XGLMGRtNkwd1JB0sBfz
         5KVVTANaRSgfF2UciQAGbjd3NNWjE3WJdvatfgnepuU9sO3nHHoH5rQNY091pKMsORax
         sD7Q==
X-Gm-Message-State: AOAM531rmJp66nH6zwEA2xRQBgvWZYIE/j3Rqjt7VqELWWths68Dd6i5
        sMHEfpx1piSqDQPZ5R0a3H4=
X-Google-Smtp-Source: ABdhPJwtPPzPgrtv2ovP/BwBW7ussm4xufiUnig/ykzL495qNQU15iriIY3F2rAFGkvhfsE1KQX+fw==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr10064505pjb.174.1646824238996;
        Wed, 09 Mar 2022 03:10:38 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k21-20020aa788d5000000b004f71bff2893sm2493560pff.67.2022.03.09.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:10:38 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] usb: musb: Fix missing of_node_put() in omap2430_probe
Date:   Wed,  9 Mar 2022 11:10:33 +0000
Message-Id: <20220309111033.24487-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle() with refcount
incremented. We should use of_node_put() on it when done.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/musb/omap2430.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 7d4d0713f4f0..4a963cfa385b 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -363,6 +363,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	control_node = of_parse_phandle(np, "ctrl-module", 0);
 	if (control_node) {
 		control_pdev = of_find_device_by_node(control_node);
+		of_node_put(control_node);
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			ret = -EINVAL;
-- 
2.17.1

