Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA947D282
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbhLVMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhLVMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:54:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4915FC061574;
        Wed, 22 Dec 2021 04:54:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e5so1124851wmq.1;
        Wed, 22 Dec 2021 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ry2r1h/5gPEfjPNAeB20WCeNaM662aOvZ4e55tHa4OA=;
        b=Of03S8B1wQYuhMUfs+mIklxnKsQtHZGPNn+H8z9lAO9iw/tp2DOrPhOKzlYf0U4gGJ
         Q64WLhmin2tcdDkgCgitkeScLf3ca5y1z1hfnsmjNj+EFc9gY+by2xKUR8VgAqwdrMwn
         4WyGaBEjxRF6zTbhC+nEWldYHZM6waRZwzeuiwaD8sAySOsdaN04jFWFf188QOP5XlYW
         Ra8KzPqD3XmNlt1SIwW4uhRNyt3psKWM3sU7MlBNbMg3/919CBEbLBNC8c99yk+sE6uJ
         6XLjyKNVvCqdLxx9bhby6PdGJsJlOXE2z3xWT8QBr6cxczWvMFbmixx+tlQZTZQpw9IJ
         dVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ry2r1h/5gPEfjPNAeB20WCeNaM662aOvZ4e55tHa4OA=;
        b=bnFL5xdoeGZkyo9nYZ1QwDBlytkWYHfI4UEEMjiuog4IYP7OACkKA6OMh1LMwd74EP
         I7eLMLCVR8x4CBrLN6ucr/kUyZ7T+OjagQpevR3N6Mc0Fx7G5uJygorEI6eXk0ddC6pS
         zaZbF6ktEU23xz80xv/Oe624nw5MkNZLI6dt88Q6JdzmdMxbrojMDlHhtfedeQ3iQQul
         2sd4LPch1QV0Q7gmk2HTPGJerPwiPZXXTDmdxJuRpdM+R1Gwobs2tVKpsQT9VS2WIDoc
         m43yVvCuvfL3BMiqigg2bfSCXQNfeG5I93Z17VVWL2OOyaYCpcKxv1jRScV+Kv27jKfk
         k8Vg==
X-Gm-Message-State: AOAM531v7fYmPkG0MIaSyUIPffHOwuGP5Zy7aCjRgKHKfvu8WJ+RYFyC
        ey57EnfNmLoKd1vsiMy/cuc=
X-Google-Smtp-Source: ABdhPJzprnj332k4bcwegE0DW9KLNfliUp/i1yMiDyUr51Ly928Q/8w1laehjVuOpszZf0NxLPt4TA==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr852886wmq.175.1640177648679;
        Wed, 22 Dec 2021 04:54:08 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:26d4:3a00:1de2:a01a:60c3:26d5])
        by smtp.gmail.com with ESMTPSA id v1sm2102249wru.45.2021.12.22.04.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 04:54:08 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86: mm: refer to the intended config STRICT_DEVMEM in a comment
Date:   Wed, 22 Dec 2021 13:53:47 +0100
Message-Id: <20211222125347.13054-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads") adds a
comment to the function devmem_is_allowed() referring to a non-existing
config STRICT_IOMEM, whereas the comment very likely intended to refer to
the config STRICT_DEVMEM, as the commit adds some behavior for the config
STRICT_DEVMEM.

Most of the initial analysis was actually done by Dave Hansen in the
email thread below (see Link).

Refer to the intended and existing config STRICT_DEVMEM.

Link: https://lore.kernel.org/r/f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com/

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 4ba024d5b63a..64ac8a5e928a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -847,7 +847,7 @@ int devmem_is_allowed(unsigned long pagenr)
 
 	/*
 	 * This must follow RAM test, since System RAM is considered a
-	 * restricted resource under CONFIG_STRICT_IOMEM.
+	 * restricted resource under CONFIG_STRICT_DEVMEM.
 	 */
 	if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
 		/* Low 1MB bypasses iomem restrictions. */
-- 
2.17.1

