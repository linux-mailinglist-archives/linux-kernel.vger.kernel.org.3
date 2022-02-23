Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ABF4C14E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiBWN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiBWN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:59:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8048B0A50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:58:45 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f11so17005990ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmeV9bgxOIabhJpHOR897CD9xgb87UemODU6yGgV2U=;
        b=GymnIA83ywZadcnbrH4WXAA1AYMSMwQQFG+f6+MJGcGzXs93QyC+I3pkZAYZUY1t7n
         BB4H1PhCoHA3ERxhhsMdBWyONDAMvWvgnq8s1XgGDFMk/XFgO6POiisIUkVULMiiR28d
         L457MenKKJCMf59k6BkSgvmwgqFqc27/fA+obvrgeubI2hNPDP5drUQvxWtD3a2FINm1
         aX5NL8q3McFgAd3fuku73JiC0o/muPvfaOzg852LwuWz6Qn1TjH3hwkO70YTCYzGhj0H
         7a4g8JAUsH993rQyM3gjS5Slv40OhdGEud634eHKE81XX0ZC+Tq+m1r67d/6B0KrJaou
         AAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmeV9bgxOIabhJpHOR897CD9xgb87UemODU6yGgV2U=;
        b=ZJr2f4/VqD07qeGnawUFYvOHqmrHeqJ8iMg4d3HQwEek82lJInDWPb1lJv5Z52yNgJ
         CDKEJ6xhpCHGrUlJR0iIl9PwdNHsi79bzU3yssJvIj6SZWW03ZBxYkHTIFqSeOkB+Akr
         UrEZrchBKrgJvPRCyfKtQoU8eV47ZQY+w5hibwH8H4NUA0lKmi//d6WZW0OICp/kczOz
         gavQcpSLxS7RpRuBOzNMF+H4FBcw9CEGbE3+tmCA9aTUWvMY6b5+lNOMVnB9l17Grwin
         0XOSYsezIGpYFyue62gxVyA0TnC5CPCllMNfxIOChdnQcZP7Szls1qu3MDty8+ehpL3q
         F31Q==
X-Gm-Message-State: AOAM531TIAywZWjfYXRrZtfHTzoU2Z9reS+1ne8sMJxAoobG26Wd6zoD
        IDy2jWRb4N44vOrPFHZH9MA8gg==
X-Google-Smtp-Source: ABdhPJxdhGGNcfhWILNWBQG+bDluWfBg0UF4vCKHIstcbc31RJ6jCLB737+rgRuExlH3ou4RVu/I5w==
X-Received: by 2002:a05:651c:1597:b0:246:6331:c697 with SMTP id h23-20020a05651c159700b002466331c697mr696830ljq.265.1645624724041;
        Wed, 23 Feb 2022 05:58:44 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id w10sm1649505lfu.200.2022.02.23.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:58:43 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] powerpc: lib: sstep: fix 'sthcx' instruction
Date:   Wed, 23 Feb 2022 14:58:18 +0100
Message-Id: <20220223135820.2252470-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there been a copy paste mistake when added the instruction
'stbcx' twice and one was probably meant to be 'sthcx'.
Changing to 'sthcx' from 'stbcx'.

Cc: <stable@vger.kernel.org> # v4.13+
Fixes: 350779a29f11 ("powerpc: Handle most loads and stores in instruction emulation code")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/lib/sstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index bd3734d5be89..d2d29243fa6d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -3389,7 +3389,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			__put_user_asmx(op->val, ea, err, "stbcx.", cr);
 			break;
 		case 2:
-			__put_user_asmx(op->val, ea, err, "stbcx.", cr);
+			__put_user_asmx(op->val, ea, err, "sthcx.", cr);
 			break;
 #endif
 		case 4:
-- 
2.34.1

