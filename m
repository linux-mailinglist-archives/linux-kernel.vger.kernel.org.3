Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC14B588A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbiBNRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:32:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiBNRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:32:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898876540A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:32:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so11351227wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=COv/JfRRrIlYexTxxYlC5EFg8w0U7LpqChTxU8wlLIc=;
        b=hvyUrRjtSeyQHJIt6u+50oogQzvKDNbcd+ORZ89zqwkqc/9xQMmJJFtDwFBzeSfZhj
         pOOumU2YQseakVQCCfLEthFfGYpgUmTui2yDc6HxkkiN3rKQV+Sa+HhnU4Quu/V6s+IY
         z25KYKjwRj5Xk+UeHJWF8PTcBypbUmRqIn6Nm0VUrBxIl5yvEXHTdic/R3RgVlLwk5r0
         SXYdvBaWEQOlcGcRkZkARuvlH/vUaNcChvf+PNZlCUmbhwMMJhZS3bx4IT386SuyoitZ
         7n/+7d3s1ZGFh7Jta6dFt55hv8qinp9wQ4N0byX3xniq6wdkgci8vX+9QFd0oxWhg3/x
         TC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=COv/JfRRrIlYexTxxYlC5EFg8w0U7LpqChTxU8wlLIc=;
        b=4fU/fNySPmbyqXsIxB6mXeUaUSLhoBgFN19DfBONMh3H/4j+3z0J0fmF0fevRpu//G
         mLal5A9ajtKZttmVMiQtUiPX+sB64eD90bs5fG5RXNgI5R2L2l3LoAWFyQAQ/l/MTHhn
         R/8kyVsFKgllGzZ3alYnHH3/EilCZPj5VJ0FIGXjI8NeImWXtmDfn6x3tdWqROUBGKGg
         LEoPjbfQr/BxAi6sDDyH4RxvBDF0yOZnpR/Ml3XVXavDp5ZVpH4KWxT/5BL4wHbKM8K7
         MR90sVY/KK4wWOEtXMXajrfLcar4dlPylngL2EI3Alk9KxGZQrO3bcjguMMJGWal54gn
         gYcg==
X-Gm-Message-State: AOAM532CjVC8j3UvSpcMGjaCGk+Hq7w0smT2ch8Omwndm8Ik0jnxAgLR
        vN8d5BGXd1C6OSsGe5b+IA==
X-Google-Smtp-Source: ABdhPJz3gAQwwLH43RdxSe/lvVNORXFySKe2lClGwmVl87vWJuPyjhdE2vtSaoCfq3YaoTAGpZFBWQ==
X-Received: by 2002:a05:600c:1c03:: with SMTP id j3mr6316373wms.106.1644859965155;
        Mon, 14 Feb 2022 09:32:45 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.86])
        by smtp.gmail.com with ESMTPSA id a18sm26871528wrg.13.2022.02.14.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:32:44 -0800 (PST)
Date:   Mon, 14 Feb 2022 20:32:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     bp@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH] x86, alternative: bump MAX_PATCH_LEN
Message-ID: <YgqSOyubItnEVRQK@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacement instructions are raw data, there is no need to reserve
space for the NUL terminator.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---

 arch/x86/kernel/alternative.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -35,7 +35,7 @@ int __read_mostly alternatives_patched;
 
 EXPORT_SYMBOL_GPL(alternatives_patched);
 
-#define MAX_PATCH_LEN (255-1)
+#define MAX_PATCH_LEN 255
 
 static int __initdata_or_module debug_alternative;
 
