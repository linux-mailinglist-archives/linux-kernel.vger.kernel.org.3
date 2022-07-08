Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41856B2FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiGHGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiGHGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:54:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F953336F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:54:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso976482pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0p61jryZuWaf1iGD9+TAoIkONnO1xU2zlDvB4A/KVzs=;
        b=GLmvoPsbiHtgH2eGzPxYNLXxZX0qe5xIG4Sy0HP38kF1R2Szz+cWEZYv1i8PCqPCPr
         cJEl8ppu7J542D283nq0toeQeCT358Xa/Qy8y7+5LUfHx7YstzBHbj+a83Cm+z1bYLzH
         nSzxH0/MPOEfJJDox+A9pskztk8Esdqs0exLhxgyBlis9od3dI3s8270aXKlqwu/hWdH
         Bs+pR0T5/zPwkMmlt4VzVJDmrQn0zSvCthA82trIHb0xza6OFn/fCCPdYhx5DfClZhxX
         +yLWROGc5B64Ctxzevsdf3mruBDw4kut0yo4zz72+UApJY63FTgVnBpOhyiUOdfRlGw+
         cMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0p61jryZuWaf1iGD9+TAoIkONnO1xU2zlDvB4A/KVzs=;
        b=M7Tbj5vjehCV3q9ZavdZWxW1YFdtQceDqEp4TBPLuLo1WVouH7ajnL4PwP9pJtOsZH
         kvBxGNh0Peo6JkhiHLr3aV3HAyDd3DOjPeNV+VEHCk05ZTiCf+SvOMMHE5sqvvK0GsxN
         vUEy9K3M5sRK6zNfdT8B2BJrQc8Hfw42GycY1FvTy6lqnSYF03bb+ECB33FYhjX96sGN
         knazq/5JT7PS9/uSk943PjOwpV/tdoIQmlloOF4hKto4+tgPCiPi9Tgcvn1OZlYXqtDC
         JbLOhT7ChzS2AGyQltJ8V5n4rEdUAuvzGhMHEmqhU4CztfEuG3Ply07l0beZcYska54t
         x/Bg==
X-Gm-Message-State: AJIora+K54wyDDvDLSHQonMbyoT97AWmZMm6wmp2a9UZL/0eT1Z2BffI
        5xfbUjJDMGZhTYCHBhtzKuE=
X-Google-Smtp-Source: AGRyM1vrwPHyFjhMroybc7pp8FAWHGkAkseJUTPhLVf+GmUICbMKlCZgjY9v+SEeF2Bwe/0f8u0MLw==
X-Received: by 2002:a17:90b:4b11:b0:1ef:d1e4:b302 with SMTP id lx17-20020a17090b4b1100b001efd1e4b302mr8473989pjb.73.1657263242274;
        Thu, 07 Jul 2022 23:54:02 -0700 (PDT)
Received: from localhost.localdomain ([129.227.148.126])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016bdf53b303sm10913397plh.205.2022.07.07.23.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:54:01 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] nvmem: fix possible integer overflow in nintendo_otp_reg_read()
Date:   Fri,  8 Jul 2022 14:53:46 +0800
Message-Id: <20220708065346.30727-1-hbh25y@gmail.com>
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

bytes of type size_t is passed to words of type int in
nintendo_otp_reg_read. This can lead to integer overflow.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/nvmem/nintendo-otp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/nintendo-otp.c b/drivers/nvmem/nintendo-otp.c
index 33961b17f9f1..eb614c31a6b4 100644
--- a/drivers/nvmem/nintendo-otp.c
+++ b/drivers/nvmem/nintendo-otp.c
@@ -50,7 +50,7 @@ static int nintendo_otp_reg_read(void *context,
 {
 	struct nintendo_otp_priv *priv = context;
 	u32 *val = _val;
-	int words = bytes / WORD_SIZE;
+	size_t words = bytes / WORD_SIZE;
 	u32 bank, addr;
 
 	while (words--) {
-- 
2.25.1

