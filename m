Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11F5309C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiEWHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiEWHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:07:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B2E0E3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:00:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s28so19738384wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKnNzGCx87x63I8h/gwYuHzFIrPdoxH6GKC0KDIqEo8=;
        b=K1Qbu4LN4uTSgtI2f+EwwHTK17ZwUKdpUB+44EazVoGCE3gAwf4WcSamCf+z//ik71
         VjU+ape8fK6TZy57aLcVjEW/OJIVyeWkauRLHhOLpymMxmoTE1sRdEGTu1VnwJRymeON
         GwCbJMw76qSYvQSDrpaXCnj0taljv1ZFbOA3CMzlEv5tdZbvPAwBKF0vntRCUvZVpqAU
         o9v3sB5mEWuIwXAb5g8OcT+MzlzNf7NRVtb0CLp+T5nf/VUTSvGky3Gl11CtTJbq2bPR
         MUdlmgCP4Z95Nrb8mPDeBjll7zo679+3VY14PFJf6S3sJo0+0HuFIYLrRWoRY2MDOQR1
         h2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKnNzGCx87x63I8h/gwYuHzFIrPdoxH6GKC0KDIqEo8=;
        b=ZZ4NXLqcZwo6tY3oXOGdtwCnMChnQzgu/hPB7C7czxZwAyxLR0Ju1hy3i2o1TflJ3J
         +5BQz4natLnRMAMbjK+jdSI0S4tsM5nrNtjyfmrH07JTYcrN51biE/Teu8t1DdaJyaXq
         ArL1dqQ1udBJnp2L7uZ9io+6m1ys3r0LJmElerCTI0ZqmhkadMB14tUd5bveGTYcoe9p
         aSffWWeR92JwtbPEnheIHcah4IwaZVxcvOAutLimGZ3z0m62V7S9t+RaFvvXI3Jm+Yq0
         l5h7nSq+9jwQCbxAsh62e1bsLxFi2lJKFKiuYd1IaldQvycFzIlWh+apppVDo1SbJZ49
         m+oA==
X-Gm-Message-State: AOAM530vOSEGwU0nGuGIRc2JuUTUKin8nWAyq4INjn96ri/TtMfkj367
        IswoZmzfCiPehu14FPsLiLg=
X-Google-Smtp-Source: ABdhPJzxVVJfQdTIdKqAqKFnD0HZqlbRwAPf9YDWKBc83FR8g+9DH/H3FcukagCoRtRevHtOOSh5ig==
X-Received: by 2002:a5d:64e9:0:b0:20f:dcf7:2173 with SMTP id g9-20020a5d64e9000000b0020fdcf72173mr3225598wri.332.1653288983444;
        Sun, 22 May 2022 23:56:23 -0700 (PDT)
Received: from giga-mm.. ([195.245.17.24])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b0020c6a524fd5sm10690243wrb.99.2022.05.22.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:56:22 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     soc@kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: ep93xx: Make ts72xx_register_flash() static
Date:   Mon, 23 May 2022 08:56:16 +0200
Message-Id: <20220523065616.325052-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.36.0
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

... and fix the warning/error:

arch/arm/mach-ep93xx/ts72xx.c:154:13: error: no previous prototype for function 'ts72xx_register_flash' [-Werror,-Wmissing-prototypes]
void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
            ^
arch/arm/mach-ep93xx/ts72xx.c:154:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
^
static

Link: https://lore.kernel.org/lkml/202202140141.HRZ3WZwi-lkp@intel.com/T/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index e70bac011407..d3de7283ecb3 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -150,7 +150,7 @@ static struct platform_device ts72xx_nand_flash = {
 	.num_resources		= ARRAY_SIZE(ts72xx_nand_resource),
 };
 
-void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
+static void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
 				  resource_size_t start)
 {
 	/*
-- 
2.36.0

