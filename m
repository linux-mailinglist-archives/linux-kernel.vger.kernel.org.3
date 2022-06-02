Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E853B6C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiFBKQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiFBKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:16:04 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A526B2AD5C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:16:03 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv1so3239967qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzxjqF2J+clkv1C/Ss1ttS3MYS0SiTbk/qhbhgsUw3E=;
        b=EnqmVHM5M/sJSDt/hrrfaMv80nKlqhsYRVBw8H6ANe0C4v20n3Z4Wopt/rnheXM3DE
         LnerHLiqpZzR3/xHMeFWPEbtVmFfH3w7EkgOcSZkag1R5hLa9LfngXXTt75DKitKNGqH
         rCWfaMokUawtEB6WHDjg//I1YWTEZPMi+TQcDZBCBk3EuweF0S+CFeDj4DMurnvi9pDY
         MDdI2Y/rV4BB/eHwUEB7NBkwPv9R96zTExDA63tH2ymulJSWJvRrP9Md9I1+8rrH6bTA
         a42iG83wmw8oPYtNgc3lztnWQVv5KDGXswIsglJeM9i87297dI0uJSUh3ZxyCuUVRMfp
         t+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzxjqF2J+clkv1C/Ss1ttS3MYS0SiTbk/qhbhgsUw3E=;
        b=gFrrqrbraI6d2w/E0xMfxV+qLXPuO/AavZ5v2Kx7Fn7cjdPuaGtNUSHKGkqPfTaWit
         VP7ScEc1xee5PSXWITVZHR95L6hH6VEr6rJX/Jkz7AJTCg6eq9OXgEcpoQPCH2CBUfcK
         kM1IzFxG/vik5meLYoXIKmt6ZjcvxvoD+nsg5N8PbkfcUsmf//KmQ3hF4aYLfj+Gp7+L
         YTru6BsaPWQZN60w0OAviixDa5xIpB4i3FtXUYVuEFl+583h9NAeqaYIOiY3MEAgIHtF
         18GEXc5CdDUk0EOw/sR5iVUZ7TjDRPefzege6dbj9Pj2IjJac6B4gwWCE+3/qR6TiECA
         IBLw==
X-Gm-Message-State: AOAM532MSg/VLQQSl8tpayfxu3ppvnMRgJ53vnxMTXBu1uJVeDQK+kII
        GRsQ6B2GYxbkC2kSMGtxawGe3zNLLlIccOWQQ/s=
X-Google-Smtp-Source: ABdhPJwDqO1m8su8g8FVOSpWKvyUROj+Es3VmdUqD+lrIME9DZnyLX8W3rkDom46jCAPqxIf8liIAQ==
X-Received: by 2002:a17:903:18b:b0:162:3dfd:adb1 with SMTP id z11-20020a170903018b00b001623dfdadb1mr4121238plg.122.1654164951798;
        Thu, 02 Jun 2022 03:15:51 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 36-20020a630b24000000b003c14af505eesm2905430pgl.6.2022.06.02.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:15:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Richard Gong <richard.gong@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] firmware: stratix10-svc: fix NULL vs IS_ERR() checking
Date:   Thu,  2 Jun 2022 14:15:43 +0400
Message-Id: <20220602101543.44276-1-linmq006@gmail.com>
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

The svc_create_memory_pool function does not return NULL. It
returns error pointers.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- add Fixes tag.
Link: https://lore.kernel.org/r/20211211051320.2206-1-linmq006@gmail.com
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 8177a0fae11d..132ea721c9a0 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -996,8 +996,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-- 
2.25.1

