Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7556AEE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiGGXOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiGGXOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:14:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9B27FD5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:14:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s1so28299809wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=IHvyQzKUsj6cmYt0GoU0JO/vGfv/QZ0SGCghTNipvbOxddWPTpllfdqd6WPZzJ5yfS
         nmpXVBhxWR3VLak28+xTua7DJ7ThAUcOcyyIJ0I/BJa+3tLiKD4P35J0LBuXePIy8fyg
         acNnxmifaxhC9p/P6L5kRGRaNWrosuFX8g67kNSObnRuamv1OdAteTf1Qrves5CowcCq
         xqEa/TaraYD8x9YnR1+vADPqqsDoNkjbqKUuQri+vRSylWapjeZmU3qnHHoSJZWjZGzS
         o8/cRY+egbj9YuTOrmSWcqzvzems3cK2Oq6dGGFnS/LhnvQnuyG0rq/KU9shqeDo87E8
         7pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=RAecPae/XuLvCNdS5+dTdHdku24XI0IpYM29NuQWK9gKcEJVualJFY3DYXphv0NW4y
         gQVbtvEqnlSGuPWMlPutM38HkiEfqS22z/2aughdchiKYxA5Ilv31r5V8JppAysLzaE8
         IrWzrWGO8vsL8USHAvNZBh6IUAR8GVWelP0F9Gu7GbHWSmjlTvA8cUbwsfVZ3GkGt7aW
         hHt1vbux8jhUNpDq+U7AGXOSKxmd+RNJB6LQ8sKFTYEfc90yvcS6pR31hWAerl236IIm
         pkmJ8QarLYYrlJyO0Zb6C1Pzs0CWQ4zDvkDYLs5rsJQMVAbYy7ECXmPISQ0PfywPt/y3
         prqQ==
X-Gm-Message-State: AJIora/4FpcfBRxayA0IZylpiXfkHWUE9HUF5l91L99ow1ZDPafC8dIA
        wP9YsX2d1BquNb4OCbHwkEcPlPa3vc0=
X-Google-Smtp-Source: AGRyM1uBioqFu9xhYE1r6Pp52kKGi0yIK42RApLLOjdIK5CTwaDJdYl19OuGfydqU02oB42al4MyKA==
X-Received: by 2002:adf:facc:0:b0:21d:8c8f:4b51 with SMTP id a12-20020adffacc000000b0021d8c8f4b51mr267095wrs.307.1657235657684;
        Thu, 07 Jul 2022 16:14:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a033177655sm201922wmq.29.2022.07.07.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:14:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date:   Fri,  8 Jul 2022 01:14:12 +0200
Message-Id: <20220707231412.1404-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

With kmap_local_page(), the mappings are per thread, CPU local and not
globally visible. Furthermore, the mappings can be acquired from any
context (including interrupts).

Therefore, use kmap_local_page() in kexec_core.c because these mappings are
per thread, CPU local, and not globally visible.

Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: A sentence of the commit message contained an error due to a
mistake in copy-pasting from a previous patch. Replace "aio.c" with
"kexec_core.c".

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..6f98274765d4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 		if (result < 0)
 			goto out;
 
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
 		ptr += maddr & ~PAGE_MASK;
@@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 			memcpy(ptr, kbuf, uchunk);
 		else
 			result = copy_from_user(ptr, buf, uchunk);
-		kunmap(page);
+		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
@@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			goto out;
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
@@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 		else
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
-		kunmap(page);
+		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
-- 
2.36.1

