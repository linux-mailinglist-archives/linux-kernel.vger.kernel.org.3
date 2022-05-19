Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1226952DF53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiESVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiESVbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:31:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88685A2C4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:31:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so11257503lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPFf0tNJ9TcAsqzaRoxwP3QEC+KOutDOVLlGLkFc3YE=;
        b=tEDqIBtGim9VFJUtpQYVVRcVm8mkzCeCKxCMX64+jD42a0rsXZqDazbcKcTPcrZmuu
         /wTbxDFpuA+6YDQj4Jrb8Sylpc95GlD/7vTEf9uqW1QzbArTxgDbe7RTsO0wTgw78JRF
         GJlXuicgTXApHoT04Ax0EYCRP/8N+wCDAzABNBNZIYJ2BxrH2qr0Zgzo1HA+ZBGukaIZ
         JdSop5WnA2JpAkrOmm5eDThPBplyl+kWIVS2+xHkEiNFzvYm/uxT2gL9LVelM7M+iCvv
         rqSpU+8ebAGjc0Xat0r1y8vN56BvBd2gOsM1sVVAWEtHAkmESpOacDFbPkXpedZo5SI1
         togA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPFf0tNJ9TcAsqzaRoxwP3QEC+KOutDOVLlGLkFc3YE=;
        b=M8nWIYZ9ZzG7bTSxTy/ZdPyfqc5uA6PqfsS3CPDhoy+nzIauYucBKTirQbYB+KilX0
         9yDtGHGkt1NnAmRrGSeVQRvmF9519not5OBHXKMPTrhOO21P3glau9VBCjJ0IU51+4Rf
         iC9rFgQzMgUVjYomL+CCTWtDLDoC8h4hY1daRqHBMo3e+g0/vpWIFR7Ukr7Wl+l0qn3Y
         jiywSN+EcyxtQzjfym0goxvWD3juYN4G50QNMuUP/mOfSVp6QamM50VL5VQohwKRk/ph
         5ymK/Ao4N4glTlz2IsXg3saBI6Keaz7E6j9hvZ2ZOaZ9yqzZAkMRBZbmqrJIm6T+T6Kh
         FsYw==
X-Gm-Message-State: AOAM531+Itzsy7hBhwsscbsw0N+BQQXkB5AAv12bmBmqDJ1IJmQWB6Oa
        3Ycxj4JbG0953aUQ2AAg9i7ucg==
X-Google-Smtp-Source: ABdhPJyPhECntn4TKpqgUQQjodV+0kEWuleyBXxpov9qv2MpkiRX31qk6q5CLjQuj5NC4NIlcOTTwA==
X-Received: by 2002:a19:6005:0:b0:477:bb1a:b2eb with SMTP id u5-20020a196005000000b00477bb1ab2ebmr4689782lfb.335.1652995908990;
        Thu, 19 May 2022 14:31:48 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512104b00b00477ce466e59sm134555lfb.153.2022.05.19.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:31:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] HSI: cmt_speech: Pass a pointer to virt_to_page()
Date:   Thu, 19 May 2022 23:29:43 +0200
Message-Id: <20220519212943.778610-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
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

A pointer into virtual memory is represented by a (void *)
not an u32, so the compiler warns:

drivers/hsi/clients/cmt_speech.c:1092:35: warning: passing argument
  1 of 'virt_to_pfn' makes pointer from integer without a cast
  [-Wint-conversion]

Fix this with an explicit cast.

Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hsi/clients/cmt_speech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index e014ef36d872..8069f795c864 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1089,7 +1089,7 @@ static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
 	struct cs_char *csdata = vmf->vma->vm_private_data;
 	struct page *page;
 
-	page = virt_to_page(csdata->mmap_base);
+	page = virt_to_page((void *)csdata->mmap_base);
 	get_page(page);
 	vmf->page = page;
 
-- 
2.35.1

