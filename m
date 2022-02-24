Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D24C316F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiBXQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBXQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:33:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14011B5E5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:32:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d28so526883wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmeV9bgxOIabhJpHOR897CD9xgb87UemODU6yGgV2U=;
        b=kuPalLo0ngHOxMvZ6qIgbB+moVrh17o+Lv9Ez7Ucqyo8MJkTddP+53mAdrQrjT/iIS
         NBbuQpY9+EyL7o0cF9EUX6BiaG/emCBJwgZ7/O8LOzPt3zwXXcdR7BdF3oPNbstEtaWI
         IEpIbLKdf7RuUHHHH74BbrDqcA7itr0BCaBeyWEfVAkr1eXo6yITFooJcpQfXjpLSX/N
         Q00TNT7VNos313AB95PZ1Ztfl68NEuVi3Ghw1As1wnhd+/t9fByKElDKdjKiVesNlmeG
         vgsJyynXcSf5AHf2vzLpP1zEFsoWFYmp1lebeWmVkb4/Y4nnwgoLUfDxWnIwz1JXLLGa
         7GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtmeV9bgxOIabhJpHOR897CD9xgb87UemODU6yGgV2U=;
        b=3UVzJWQwhHuuOKsTEhkKg+5F7Lsf5cAY4cJDiI3QPuz9E2CoovAh7K7MtOodzG6BRW
         o6KCc5ZuuEPR/gL+5yrTACrJyDxfbcGoYD8gh7ebs9GFeRcebUojYaEP4VzOCN4ZinCn
         3IB7BLjkQIzBlTcEcXOUArC1juJPSMRJ56a+mohcVDo+Cus+nJM2V8HaaORgco+2ajaY
         VWjaebh1cR541pw3lBWbZQfUKFLQTmsJEvj5fA7DlAyG54RTJmfAG04Bn8bDGfA8mfQ3
         uItxEqUc31QsjaKi+3QkHDAn9W7/X6AOSMTkjuvaxamLdiSoO7j1wv687DWYav+SMSoi
         bc0g==
X-Gm-Message-State: AOAM532m6eN7ECJjl3pNLXD68spLVjwePGTlMIQ1AEULuNeC73Zh+hX6
        a19NFGwp82hFNsBpeMOmaeq5w+Qr6w745w==
X-Google-Smtp-Source: ABdhPJwiKP+dfsndf3VPpMglOVWrIIfHrXym6SEpHnxWV0ApQvGlhQKCMMsZmT1onUav3oJu2Z4OkQ==
X-Received: by 2002:ac2:5d67:0:b0:442:f135:3bcc with SMTP id h7-20020ac25d67000000b00442f1353bccmr2267428lft.452.1645719756809;
        Thu, 24 Feb 2022 08:22:36 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id v9sm242600lfr.130.2022.02.24.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:22:36 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2 1/3] powerpc: lib: sstep: fix 'sthcx' instruction
Date:   Thu, 24 Feb 2022 17:22:13 +0100
Message-Id: <20220224162215.3406642-1-anders.roxell@linaro.org>
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

