Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54F4CCB86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiCDCFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiCDCFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:05:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC113EF9C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:04:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z2so6454519plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 18:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37PPdgMmKnfPsfL5uOEtSFfmQ8JkeKrQDV3j6+N2u9U=;
        b=HPOrSZZ3DE6oUUEP3y0f2LG7xe8GNPBmnBQEPzpcaFLAvc60HUgHVHBFFDKyaI+x/e
         PgX68jAVJ6KoWMghFqU/1dulNOdmeYPXLTT5s5f/xQ/D3zK9JWIcDvZ/uh8D2aXXrxRX
         CPw8B6wlLXJv3w2gKLPhQ1HL/ocDgZtFos8VRtV9wH08cTAX7gUvyfkd9DhJcxzSvP03
         ScHd0KJ0/GROpR2CJo/PYizdPxXU3EfE0gD/bswX/n4izVxhBzJHIpEUKTJd5iHX/YgN
         hK0CM72x6QxkT1SKmI2vbwSe63Q+qVsaYqKlyYr00OsgNu+pxUcOquN4PDuF35j36rC+
         uqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37PPdgMmKnfPsfL5uOEtSFfmQ8JkeKrQDV3j6+N2u9U=;
        b=P9d6KOdYzx1Llk0nRAGS7JdWP0aGE0m+wAthkoKuHAM3fuPc3BDcXyTIhd6uJajnKd
         lSdg88TRb51G/1gcJczu7FLlecFb+8HxuBbG4GQPcUS+8yx5fJ9XPy3ETv/WGu5XbVXp
         Ett02BFYFefwP+ob7vvaIGMYYXNjILx15I8nHMxPJD/cURX8xCmmP4+0hQLWlkMXbVva
         QnhNkbSgUa+lcGTQcIb8rsyXTkrxhts6mhnBSaPwab1WzsoWz+fJdD9DGSEPRj4mq7S5
         fI5evhSvtZZlp+lPnopDjLbGTsjL9eLx0mnuoCbXOwmXWThitlsCve6+dBZFdERkKIif
         +w9w==
X-Gm-Message-State: AOAM533eWTRrvVnwaV87L+nyUjmgNj8erWTiGkOS4Q1C1Gs2o82iFPY3
        jnT4ER4mrzksDsRGJzjq0z4=
X-Google-Smtp-Source: ABdhPJy+B1BOPYNfRN21A1KP8RrfDYkxJ9M+HpMGVI0mFR4n/SIz5oIElLzSYQSUDkPEbgWixMYT7w==
X-Received: by 2002:a17:903:41cd:b0:150:25f6:72d3 with SMTP id u13-20020a17090341cd00b0015025f672d3mr34933204ple.162.1646359453287;
        Thu, 03 Mar 2022 18:04:13 -0800 (PST)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id na8-20020a17090b4c0800b001bf191ee347sm1902747pjb.27.2022.03.03.18.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 18:04:12 -0800 (PST)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Coiby Xu <coxu@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v3 3/3] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Fri,  4 Mar 2022 10:03:41 +0800
Message-Id: <20220304020341.85583-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304020341.85583-1-coiby.xu@gmail.com>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
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

From: Coiby Xu <coxu@redhat.com>

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
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

