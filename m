Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785751B5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiEECUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEECUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:20:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BD48391;
        Wed,  4 May 2022 19:17:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c11so3096895plg.13;
        Wed, 04 May 2022 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvK1oEM6KjezJqxZAQccrrlAj7Q7lGbQGzhJauB66Kc=;
        b=JaNNX8vQNXTxTRidslur+hjuVCZByyJo1AaJtI7UHjfkYpYrQeSMb1YOZ/cM0eC9zM
         eAWExvxlhUl/+7HwJd5GcK4fpxlz0Bg6Cn3kEg3S7mGu5HoO73mQcF02Og36F4J6A56K
         ur/MT5b6O7CYzDFmMbrQY2rK/kGLuSozZWyCyGuH01Zb78rUdQySI5ewSED4oB/gZEO1
         qF7sVyNX2TqPYXnDmd4L+7sghmf/JM7BT3W3zblxVq+18UaujlO/jTipx8p1K4mWK8Q+
         puSLJOjl6z9FIrxAkEpSqXZC2i/msGLTdrwzRsPbfV2igGn66CzCY2AWmPuk2KiEv8et
         xANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvK1oEM6KjezJqxZAQccrrlAj7Q7lGbQGzhJauB66Kc=;
        b=aymiRaVDeL8P/+Zu/K2S9Grh5jdFAfVjKQPaW9PmgaTWqydgoKHnGGfNu9jCjEdCOF
         GeX4DkxQblCpfftQ9Nft1dQZwIx84QkRMdeZb0qZu6stT/KOZeYq0Re7/vpCDzg/ai5L
         eBxZ8mkUQgPEhG1JWOpkFSzCt/tkaom5NuPWkVcmwWOKxPTvR9FdJDGpdHhFyVirwxuR
         K+k7HzFEA+w7EP5X5ijgAF0GPDFX2azYPP/a/SxycUC1OBzgqgs6mV0JfujhZNPYeaio
         4ZVzSvV5p4WoTT9qOvTmcTaSuquhpcbAZQj8UVsf1C/gnAqEwH0NVyJLYQs6U61fqPSs
         ndrQ==
X-Gm-Message-State: AOAM5313J+MaM6nzomhCdEfv2eRqiqqph6y8/RcAoXQp/8Ky5mfqBypl
        C8D1tifc2APeoideY9PrGK62ApfxdCM=
X-Google-Smtp-Source: ABdhPJyUNdfLMyfx0nTA4vph3BqzY4vAyUclmLRXLSoXTqOuwTZy8UavVq8pUwOqSidvb1dyBX3/Ag==
X-Received: by 2002:a17:90b:1808:b0:1dc:8904:76a1 with SMTP id lw8-20020a17090b180800b001dc890476a1mr3221470pjb.202.1651717027932;
        Wed, 04 May 2022 19:17:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a19de00b001dc8eca6536sm234219pjj.4.2022.05.04.19.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:17:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jarkko@kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/sgx: simplify the return expression of sgx_drv_init()
Date:   Thu,  5 May 2022 02:16:59 +0000
Message-Id: <20220505021659.54210-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 arch/x86/kernel/cpu/sgx/driver.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index aa9b8b868867..dffb271f4edb 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -148,7 +148,6 @@ int __init sgx_drv_init(void)
 	unsigned int eax, ebx, ecx, edx;
 	u64 attr_mask;
 	u64 xfrm_mask;
-	int ret;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
 		return -ENODEV;
@@ -172,9 +171,5 @@ int __init sgx_drv_init(void)
 		sgx_xfrm_reserved_mask = ~xfrm_mask;
 	}
 
-	ret = misc_register(&sgx_dev_enclave);
-	if (ret)
-		return ret;
-
-	return 0;
+	return misc_register(&sgx_dev_enclave);
 }
-- 
2.25.1


