Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC25242CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiELCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiELCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64EEA134E6B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652322858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=fNp08zysk0ZKHqvGnESP/EJgu+pTCuVV4Ktavi8TI5z0i1uEBDlyfOWyL2lEyumCOkyJe/
        skIQZBDEQQBIhVOWTUCSC3qyoYA76wIjK21Q4J9reuFzfbhfMlnQS7BMKg2oztuV+JqvUT
        xyOc5aA51ZOZMWOxZF+yGFQ/BJsPgUw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-s7i3gK1RMWCMuSLOFaEOqg-1; Wed, 11 May 2022 22:34:17 -0400
X-MC-Unique: s7i3gK1RMWCMuSLOFaEOqg-1
Received: by mail-pj1-f71.google.com with SMTP id pt10-20020a17090b3d0a00b001dd200e709dso3875325pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=XYZjkIb8an8lVxpFGrSTPoQq7eE2GIVlpIH13fGNQVRC/MqlCBZk+4aETH0V1Bm//+
         a1aAXPq44r6lHsoX4K7kbYDx9pDIiMVfRN2wePPC1j8r7sWAvP2Eq3sYE809BCfEv9et
         oqL6AiLbFvZ2Qxw/Nt8kb0d3/XNZTPRgb+eXCbF4jdr53ngnkM9lpHoni2GmS2AOCm21
         2ZLSSIME0NwTzdPBn2aj2Py/Az43MbJpA3M45pkr0wRbwTcYJLOoBd5Df2HdB20ZFjDy
         tr/WDin2guF6ECLW9xGGC119XyDgI7AsixyxijkcLsC22+i5mgYSvCmsUDzwv6wB7s7k
         Igzg==
X-Gm-Message-State: AOAM530PBmEGlBuPE3nEShwp0NPpcsRNoakdemLsT5wE3vn1AhpB+QjR
        ad08/PRqKV6GD7XTQp2SD9RlfB4xmnywhliqiUcYNK6asqujqqd8m5wXqenIHH5rqSLTAzuU/W7
        dkX97GmdlSJ4Ma3U2ieajXk+0
X-Received: by 2002:a17:902:e2d3:b0:15f:249c:2002 with SMTP id l19-20020a170902e2d300b0015f249c2002mr11088908plc.159.1652322856315;
        Wed, 11 May 2022 19:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9LkeoNzgkhvJe2G/nNW6B61+lIVcB9AUrQUpNwSPTqFnrd5nuO38SjXptMGMSRgAnNekqVQ==
X-Received: by 2002:a17:902:e2d3:b0:15f:249c:2002 with SMTP id l19-20020a170902e2d300b0015f249c2002mr11088880plc.159.1652322856077;
        Wed, 11 May 2022 19:34:16 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f34a00b0015e8d4eb1d8sm2551452ple.34.2022.05.11.19.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:34:15 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 12 May 2022 10:34:01 +0800
Message-Id: <20220512023402.9913-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512023402.9913-1-coxu@redhat.com>
References: <20220512023402.9913-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a problem faced by arm64 is if a kernel image is signed by a
MOK key, loading it via the kexec_file_load() system call would be
rejected with the error "Lockdown: kexec: kexec of unsigned images is
restricted; see man kernel_lockdown.7".

This happens because image_verify_sig uses only the primary keyring that
contains only kernel built-in keys to verify the kexec image.

This patch allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .platform and .secondary_trusted_keys
keyring.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..5ed6a585f21f 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
-- 
2.35.3

