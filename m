Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81B564B59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiGDBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGDBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E686401
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
        b=daa5dcZjjfddAH185hg0yr7ELDqins7Q1RY+3mYK/tnscIF9PgUA5EvH4zjgrMkfp0cZfM
        nAMGYneppMBFbKemYOo0hTJ7w/6CVjUTZCYLVyHRhyy76DIQSnVScmaFKVWQxgVVmL3Xsg
        Izh66graHUEkSv3VrSxFkS92GR9Goao=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-AGl7YH3lNf-FOUcN0E4ZCg-1; Sun, 03 Jul 2022 21:52:46 -0400
X-MC-Unique: AGl7YH3lNf-FOUcN0E4ZCg-1
Received: by mail-pj1-f69.google.com with SMTP id q8-20020a17090a304800b001ef82a71a9eso1509666pjl.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
        b=XBjlXUmagpo4y03DhYKaKzywj5sw8HIKgjB9mIfmFmdlwfBQNJ9ddUv86FCzvvAYaJ
         YXtElNsPb+deusB7nOjywDMD4j/5RKp1CxCSN3ivhtLR38GY9uWwDxtcn1PrAzv+MeY0
         zy6J95IpSnDHRnnIziwnAJVoE3utiLCl389KspXccjj2TfBloN+ynxaUkqtge3ZvSIqk
         21CHsn3J8NCdEb59aZxmSJN9q2u2Om2c38yidT2iIXsnTYb/kerdTi1kGKQzbXdEYrYY
         Jck3MmygBq1n7zZZcgAvjJ5lYLzJ9AikuRdOO3A1cmZ5FsWWSKB/orO786ffe40CtLIE
         yzrw==
X-Gm-Message-State: AJIora/fnPhCQ/k/l7ias+AGaq9auhXuhfl8niVMOReDBhmbLQIWkEVG
        ucvbaYGI3OyZZaKoha7cBR0l+yy5wv7Hgg6SEH+7ffnrDO1pR19mUAX7E9rm9ootINNxxwxcAKN
        h/Na2UafK4Ij3ZxHExrv13m5W
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512583pjb.216.1656899565176;
        Sun, 03 Jul 2022 18:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vccVgOsoxySyE6jc8B09IaJFFIALoQ7zprfH6mR3bc+DIDyQRm0eLU55vBwyS03zmcKniWuQ==
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512561pjb.216.1656899564976;
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a621c0c000000b0050dc7628178sm19752005pfc.82.2022.07.03.18.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Mon,  4 Jul 2022 09:52:00 +0800
Message-Id: <20220704015201.59744-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

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

