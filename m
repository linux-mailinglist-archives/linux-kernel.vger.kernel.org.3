Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2D514A94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiD2Njs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348019AbiD2Njk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:39:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B026CABB4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so7295291pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6JfYichFyXFsf3r/4znwUIKw3e8Xt3i1DYSf+5mskE=;
        b=uiu5RLuEB7qSCoidGIQkJZQf2tXs/EuKorStHUYGrE3Q5/xwMjpvGCmRYxjgJA6Ctu
         75nC7BuohPGVHhHiVloQeiByLs8cb+N0Ed8rJ3utK+A6gQToV+GujF6l5qKhJ6c7EtGn
         NGGslCeqHkUhC439mUKObKU0nONs9Y2XDO0mRRIdYkuP+YXoGmTiT18RjaEEpxX9bPsh
         AAQJ8XZb1PV/10ty6IAIC9mYDPdZ84ojotFDfykLySr4Rl5A0JazS0rcCBaq64jgtFXH
         n+rOZQhRPeLRzNBkYnF0c08yntciuvNCXpZK09/v/tg0M7w22eVyLTCmchLVjWICGks9
         yfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6JfYichFyXFsf3r/4znwUIKw3e8Xt3i1DYSf+5mskE=;
        b=UZZS5Y2hy9TOYaNcipVDsaEbj/RpL8Mh8XYxB0FkO1S5ALBFP3Ftd2br05Akbu7tfO
         bR+JElVenKaUwoVwu85feWhjxfof8+KuhfCDnYNcGBtzvYOq5nSo+Rz1kNEXmwXA8Inr
         De1o6PiSBFXi3IZp86uDScDV0Q/e/SrqvOy9yT4CpwI7PrOMa8tPMVwBV198Vk+LKMsb
         /GQFcWqRjFJliquxHqv42P8lM9oiIMeEW5ChEhoql2w7EAzW8BdjXulHTMzO9ZLHE3k0
         J560C2dHs8M39Hq4A69tzMUs/zPL8PMq+2Hnhg3c4T7jM3iOOQ/6dgzShmOYEFqB/alS
         THPA==
X-Gm-Message-State: AOAM531TwC8uz0H04N8uEXfo39OU8gvEcUaaEPa0FRrX4E8FG2Qo/YeJ
        M+/zorCfn1Do3tJX20ESNQKreA==
X-Google-Smtp-Source: ABdhPJx+W1PxtRy+jGpbbBvOatDdA/DNvTfTbEwQM2M30hTFb7Isln+pU5bpMFj6BaOrsgTZDYJFuQ==
X-Received: by 2002:a17:902:ed89:b0:15a:d3e:ada6 with SMTP id e9-20020a170902ed8900b0015a0d3eada6mr39276616plj.94.1651239381708;
        Fri, 29 Apr 2022 06:36:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 01/18] x86/mm/encrypt: add the missing pte_unmap() call
Date:   Fri, 29 Apr 2022 21:35:35 +0800
Message-Id: <20220429133552.33768-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paired pte_unmap() call is missing before the sme_populate_pgd()
returns. Although this code only runs under the CONFIG_X86_64, for
the correctness of the code semantics, it is necessary to add a
paired pte_unmap() call.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index b43bc24d2bb6..6d323230320a 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -190,6 +190,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	pte = pte_offset_map(pmd, ppd->vaddr);
 	if (pte_none(*pte))
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	pte_unmap(pte);
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-- 
2.20.1

