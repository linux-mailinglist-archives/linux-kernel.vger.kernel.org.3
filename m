Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D44C3ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiBYBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiBYBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:08:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714C2C64C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:07:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f10so3326073qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmpWNXteUzVTbNYEU6Qa76g7YMtYPs+CYkqOGTVLu6E=;
        b=XUcgz3qAQCNU5oUmiGDepPTHObKouehD7vOd+akhJdcRYvSwqLm9hxbNv7dLNzsvw1
         xVLMRnZr8A9lEgvJYQUJR9+wWZEdgiAOujvh2XgZ+gIKdZU160jRIjCJJaNR16vV1iWw
         XGHwBMKD//3FTia2P8krGxrQbKUmezZJgy6If23tk2xgZ9GI+yYcwDwqUidV2lbSof3g
         PLDDKj8bK3a3jejWFfHT8Ai+yFh73SkRju72+ZaYkAEPLnou1LUDIWBIKI1aNhJhsSCo
         Oud2e3Yl2v+TYUM6CgQvwPWNm1SkNYDLFfDZF2oJdJNZ1Sj89zM0Ns5vVEDTqKglv90Y
         lwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmpWNXteUzVTbNYEU6Qa76g7YMtYPs+CYkqOGTVLu6E=;
        b=3zKRzgZ12zRfUhL7GP9xWeSSIJlBEZZr+orUnzeZXgOEK5vrjmrHaala/XNO+rPqJZ
         sbsQ094Ze0iZqRcQsD0GXusrACcPKSxiOzmRKQS6D56kV3xOugJZT794jJ6Mbpt+j0zj
         4lImmUdzD+IWVs+mYHa150GPIO9aH4DcfwiglFcCNEr5i+WV+eBs+pmyLBsQzwL0p2ew
         N29OP7N6yu97nFbmk7WIWtK3EGSPRBjxmwWpeutCewbpJd7cTqMvtFTDHzkbwfCvkl0a
         WL/IycRpnxerJDiUdzmHKoB1WdTg/pn7wwBarhv+eHL0uiOpmh5M4F+22gxhUq7JCDqc
         cvwg==
X-Gm-Message-State: AOAM531NTUyb58yvmXyOdVBqrj47KeAB7Qv2LykVDGzrWeWbenfl7x3u
        Vccmv8Sfa/DNruJ0UECbwgY=
X-Google-Smtp-Source: ABdhPJxM7Nd9VDWfi96k/1ejXcy5rfq9AQ1PnzId1Bxbi2C3gSS2vGdhuwpSZ+3Z8YcmCbbPWKDVTw==
X-Received: by 2002:a05:620a:787:b0:508:b18a:e109 with SMTP id 7-20020a05620a078700b00508b18ae109mr3441749qka.471.1645751265610;
        Thu, 24 Feb 2022 17:07:45 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a165200b002dda08f1371sm697215qtj.0.2022.02.24.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 17:07:44 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     oss@buserror.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V2] platforms/83xx: Use of_device_get_match_data()
Date:   Fri, 25 Feb 2022 01:07:37 +0000
Message-Id: <20220225010737.2038781-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.
v1->v2:
	Add a judgment on the return value of the A function as NULL

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 arch/powerpc/platforms/83xx/suspend.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index bb147d34d4a6..6d47a5b81485 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -322,18 +322,15 @@ static const struct platform_suspend_ops mpc83xx_suspend_ops = {
 static const struct of_device_id pmc_match[];
 static int pmc_probe(struct platform_device *ofdev)
 {
-	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
 	const struct pmc_type *type;
 	int ret = 0;
 
-	match = of_match_device(pmc_match, &ofdev->dev);
-	if (!match)
+	type = of_device_get_match_data(&ofdev->dev);
+	if (!type)
 		return -EINVAL;
 
-	type = match->data;
-
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.25.1

