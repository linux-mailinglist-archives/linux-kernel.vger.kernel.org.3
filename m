Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71564DD73E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiCRJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiCRJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A08502C3DF8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFnb1M2EIoVuc/P5RSzyYqF5MQJZi0h79OModGmGN0w=;
        b=NkjnqsgnBe+SuBaQ8wNBwpkWhGbHghAsQzObTQHDdYJU8u2R0wtmV/XqcL4ReKN6cSlPLm
        SDBm/M363soEohRBd8/HDckakY/t1ZwnlRxM8YB96VjFGQNRznF2GvKp/0mA8uQ52aI9tn
        QT/5xJ9RVCkkcP0Qd+WoPmTZZ6svAk0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-BIdr0IOIP5CYKsVMHRo7-g-1; Fri, 18 Mar 2022 05:41:16 -0400
X-MC-Unique: BIdr0IOIP5CYKsVMHRo7-g-1
Received: by mail-pf1-f197.google.com with SMTP id x123-20020a626381000000b004f6fc50208eso5018662pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFnb1M2EIoVuc/P5RSzyYqF5MQJZi0h79OModGmGN0w=;
        b=GehuzkM8pGh5gu7oniGOCzhlbOcrRegpXgAlE2eThdKJmfOQTImQb9QvhTRNGXuk6p
         SU+uW1YIJr7yqfqrydBrsMFMCKB1xBpd3MYA9tbTmNwcdi9HGTO54nvtDHjVeqkqw439
         w1ErE9IZ/IKYIYEjrfYYf7GZlJFJf+vEw7OHVFMO203WC2oquJs691g8IcLLIbS1+/lp
         a8Ik5Ry8RtiwawqzCLYuZhE106SwazL7ynVlIbtu94X5Q5qFlApHnJWNU7U/+EsBWtEv
         nEenNDzfrRCGutfU+BDkNfzmrry7ssbegMsgdrrL2fvIhk6kkb7z4S6s3X6bplkTntaW
         OsZw==
X-Gm-Message-State: AOAM531FFvx5EWKqlWovzRh6vUu5rvd5mtaHf2hu87TzEpQVy8RYBmC0
        C2E8fTQ5x5WPCbxGRam7P3KWeoaHa+Cr0v0HAVPopzPkgxLCAud1D6aDeBQ+9Mc2xdb6SOLZ6ay
        3jhlAoNrIaxEhcpFa609Y6QH1
X-Received: by 2002:a17:90a:2dc6:b0:1bf:654e:e17f with SMTP id q6-20020a17090a2dc600b001bf654ee17fmr10153825pjm.64.1647596475807;
        Fri, 18 Mar 2022 02:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSZE86KXD2JeC35ujxrinCaDl8UVUyVWu0d7AoIhInD1hZpGVEB0gCt6zGlQQDIot8DU43WQ==
X-Received: by 2002:a17:90a:2dc6:b0:1bf:654e:e17f with SMTP id q6-20020a17090a2dc600b001bf654ee17fmr10153807pjm.64.1647596475545;
        Fri, 18 Mar 2022 02:41:15 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm7788102pja.23.2022.03.18.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:41:14 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/3] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Fri, 18 Mar 2022 17:41:01 +0800
Message-Id: <20220318094101.274950-4-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318094101.274950-1-coxu@redhat.com>
References: <20220318094101.274950-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform
keyring.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..51af1c22d6da 100644
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
@@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.34.1

