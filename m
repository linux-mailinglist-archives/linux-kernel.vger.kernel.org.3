Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1796E4EE5B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiDABdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbiDABdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0202D1EC98D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648776695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur4bX7kLocMyHlMkWd6be/nI5FhdYUXpSu22PLx25Yc=;
        b=aqZ+EIXIA4O/Mqq2bl8PAmSC5TQiRkElAuUSLFqwRgI6MCxv2odbLTWaxSDXX8xRWQH/22
        up+gjHVBxM2qSaRO02nk7jY6lkbTrt+7TF6aTBq1euUTn6TcE2M/RUEEb4zU6UokAKqwVk
        j0lG7naEid0NMOINgosXmMtZeGGSQkQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-8rcCG8FzORiYSYiZJc9eHg-1; Thu, 31 Mar 2022 21:31:34 -0400
X-MC-Unique: 8rcCG8FzORiYSYiZJc9eHg-1
Received: by mail-pj1-f71.google.com with SMTP id k11-20020a17090a658b00b001c9ef91ee64so433592pjj.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur4bX7kLocMyHlMkWd6be/nI5FhdYUXpSu22PLx25Yc=;
        b=A3Iy6i65e07fei9C1caseaE6GPXQVvVTrolXFJxMJs9+scAXePCh5+7HkN/3SRfjYE
         Bxn/EtXBTc0DkTe8V/yLesEGNdS+nvDXzjW8oDTywmTtC0A4wE/K/cAV3flMm0ZvHElR
         df6QScT/0saGszW3hlpu7LdOpN6rWo2LCHtikB4OlUL9cKPTv/Md0TePWMYrTB+5QpMz
         /kMxIJXFzmm03KrnpowixHeozTsh+1cn6DurGdO778M0x1/lPQIBFb3SWqj1PRF5AlTR
         NbEuh/CQ7L7IMw/2z30WtEAiaHN3RPpiqkG46ixWNR6dHB4sCE0iG1lbyAQ/EqlUNTzQ
         tfBA==
X-Gm-Message-State: AOAM531sxB08rTm/3l/ptpSJH9aElj77Hn/4K8zruaCy7Q6E/y4ZF88y
        jbifpJrLj+G3+eMo4IgmeM+5giWmDKfdz4dmjn8iimU75ezJYguw24wRmO7NZu22S8ABm4mefd9
        s6NmvJxT72OCogVo0uJyoyTGn
X-Received: by 2002:a17:902:708b:b0:156:1a0a:5c3d with SMTP id z11-20020a170902708b00b001561a0a5c3dmr7767915plk.18.1648776691480;
        Thu, 31 Mar 2022 18:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytKI0smTf2h5pDtZ1Ru/oJPC2Djio4Q2XzblwlhHZObk3685LSZ1jxpUWN1pqTW4oEpdgQqA==
X-Received: by 2002:a17:902:708b:b0:156:1a0a:5c3d with SMTP id z11-20020a170902708b00b001561a0a5c3dmr7767892plk.18.1648776691177;
        Thu, 31 Mar 2022 18:31:31 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm544181pjy.35.2022.03.31.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 18:31:30 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/3] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Fri,  1 Apr 2022 09:31:18 +0800
Message-Id: <20220401013118.348084-4-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401013118.348084-1-coxu@redhat.com>
References: <20220401013118.348084-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a problem faced by arm64 is if a kernel image is signed by a
MOK key, loading it via the kexec_file_load() system call would be
rejected with the error "Lockdown: kexec: kexec of unsigned images is
restricted; see man kernel_lockdown.7".

This patch allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .platform and .secondary_trusted_key
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

