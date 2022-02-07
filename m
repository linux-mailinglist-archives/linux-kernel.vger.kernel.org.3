Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061734AC037
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389236AbiBGNv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388005AbiBGNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:47:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F38C043188;
        Mon,  7 Feb 2022 05:47:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u23so1110893wru.6;
        Mon, 07 Feb 2022 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKcb6htcU3nqL3xVplZ7gYiatJOz+PCyFD5n/EZWoj0=;
        b=j+4PquH5vQ/ytXnWXKd7Mwnr1N0q7MxKtLYjcLtMU+rSeTlZIpmk+erwRPZeqpj8he
         0YBS9Pqhl0odXOIzEMcb07bJLy9apH/mcjGsC3/PtN0qZOmLoewHCYkGJS0UzP3zYfsd
         +OdM1CAGbhDgNrJeLyVKCC6mfbKRO4E3S/JywHZJW9LqAFO8gCbht+dSRM6y/gsqa7V9
         pZBbA/0EKyg9uRNCzAIXX+S0DUXLP2STHeavdPG1HfMOGcrAr0lQoetfrjgVD4ZPB0JU
         GAJJUvobv1eRN1zxLWOLG7C9ySibU5HwzIwPB3FE+JJ3Z2kRmriXt/UYCt49htGKCwzP
         vUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKcb6htcU3nqL3xVplZ7gYiatJOz+PCyFD5n/EZWoj0=;
        b=jDUgcRghCtsfDRKH8praX0D7s2xT5KmIGMJedQJFGLaVUrF7yWNGM5PkWDvXqSLDmU
         FXgk7OQYQb/ymfcz0SA/6uKWaToWXti95YbGIS1JiWsTrnR0+NdnjEbNTAXQ0vlivcdj
         ITFYHJb+brADOBEmOZV0uhyhJRRW1xbKGiuWzwM0cjyBXFRcSxPecdg17zJPNrrI0ure
         jvXt2vpVhs1YMhUVQZx0NENTq+APFkQ/v9W0ddi4YnN8384RHARa4L9SZLZiu9NQWUVL
         RzFNFgdj+aBNWxKVI8gYBWYI3V4fJhKl5g+AIFHVK+l7v0DlVap305RuGwyIIrDbwDLo
         Hzsg==
X-Gm-Message-State: AOAM532mDCMp9BMLySkFBCuggSNS3hngf/bT6W4AoF3tkAFEEC8BY5kK
        qqpDXy2iqWS05vFxpfwl0grS8MFr2VQ=
X-Google-Smtp-Source: ABdhPJwYYMhMJYTcuBEPRJVRuqoQJcLpP6bMYyYxlUmAcDxFRMlI5/R0GAvjpeLVSrk9rF217IVB+w==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr5315177wrn.713.1644241673103;
        Mon, 07 Feb 2022 05:47:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r2sm17339250wmq.0.2022.02.07.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:47:52 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] intel_th: remove redundant early initialization of pointer hubdrv
Date:   Mon,  7 Feb 2022 13:47:51 +0000
Message-Id: <20220207134751.337775-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Pointer hubdrv is being initialized with a value that is never read,
it is being re-assigned the same value later on closer to where it
is being first used. The initialization is redundant and can be
removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..f8fa0bd414fb 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1037,7 +1037,7 @@ int intel_th_set_output(struct intel_th_device *thdev,
 			unsigned int master)
 {
 	struct intel_th_device *hub = to_intel_th_hub(thdev);
-	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
+	struct intel_th_driver *hubdrv;
 	int ret;
 
 	/* In host mode, this is up to the external debugger, do nothing. */
-- 
2.34.1

