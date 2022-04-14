Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676805003C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiDNBqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiDNBqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E78C04
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZWiQAF9GRIP7WU8AYwYkyBhsIYEfbcorZXD7uAiyqQ=;
        b=aFW65Cp9B6fSGMVo6hPBII3kNnb33LH3KjcDPMzAmihRkqaUBX0mHCqKtZNQnNLy2S5KgC
        bCqXOxhbAtwCKTTEVvDVbxtvgWmjWBXt/EcvpoZxnFQBhBldYsWY7BRs30iOvfzSNhl+Bv
        edaVdj4cwJSh3fXTczEg1CQMlwQxi7w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-CSy5sQv7NDmj6Gq7nq9sAw-1; Wed, 13 Apr 2022 21:44:20 -0400
X-MC-Unique: CSy5sQv7NDmj6Gq7nq9sAw-1
Received: by mail-pj1-f72.google.com with SMTP id v14-20020a17090a0c8e00b001cb778cc439so2058037pja.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZWiQAF9GRIP7WU8AYwYkyBhsIYEfbcorZXD7uAiyqQ=;
        b=issUe+GBeH2WL7rEYcGm1NLtKyRyCdXd++rSLO0WP/fRPNyyydXtOcdN3M9UTKXC4d
         0RXMIMMTXWt1bSw5YQJO+wPkRBxLzxKXJrxRbdquDOsFlO4zzZfL8vljy4lnSZMKSNxd
         SWCCkh1AQ5vZd9a6xaMgBDG0q4U4n+L0y+P8CuLAo9EJdc24FtiYBbz2L2gkX6Oa0b+X
         K9a/+1SVsF1lQTqsqRK2zv1hHRIu1HFfI63Nc4/XdqhbLbGOzbbViKOBKGOlqPN6RgVX
         liLIV2cxDlAjQK85c0oRuBoAEYfgKRfvYWXde8kFRT1EY1o48oFO3A3rMJMzq1IMu9Wb
         UcdQ==
X-Gm-Message-State: AOAM532xAjkO9AK/xKp1hHeVQiwHYV0TwR1Pm1IKfElEFbzloKKg7ubS
        cde3QJxRLGE3hH5Y4+Xcabf2V3dWw4bUhNjMi71wHw5LUKJvXIEVD8DUHmDfDkLymUk5ChpoCXL
        S6HIci/xfYx4HgOarP37eSbVQ
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr1694824pjv.23.1649900659137;
        Wed, 13 Apr 2022 18:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdzkDNxJ5ETNGa8+WNGA9rufymeL8qpXrk4exAuId9yogv97m9d/zBf7JK2uUxgm00wjeIBg==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr1694808pjv.23.1649900658928;
        Wed, 13 Apr 2022 18:44:18 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm334069pfv.47.2022.04.13.18.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:18 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 14 Apr 2022 09:43:43 +0800
Message-Id: <20220414014344.228523-4-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
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
2.34.1

