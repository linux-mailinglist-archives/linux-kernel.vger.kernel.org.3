Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B850C2B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiDVWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiDVWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:21:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD03211BE2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:04:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x12so6469942qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCHSC34arsQtBqUXmCj99wEfbz8l2mnQAFiJJnf/+tY=;
        b=qmfdiGivhoyIkipKSQ76fwohGQ0nvXqS1+nsk1poehqsmrff2+K/16UChzb38m3hQj
         gs1WQKtzgyTq2mMctaVd0Jt2zzr2zG2IqKNCLcM+nEG1TMLoqPiXqLQnEv2Kw/ioeAJK
         ZmU7plVLbatnN/8IoNWr7J+l5Wy6Zii8lL9NIw45KNmoFUNSf8s9KsWY5DStfUeCGP+f
         CI/b9EW51ScAA7B8x06oMrq5b/tsAEYP7ITb4x+lGfSbrvnafuwL1l1jIL13rQqu2E5u
         71ghj+41o4siscitqftFUUVKGxB5KIUTREv6uiiQuexYnJRdpeQnRZcVNkEvG+bQ+Y3D
         kSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCHSC34arsQtBqUXmCj99wEfbz8l2mnQAFiJJnf/+tY=;
        b=DySeeSLjDYj2uvB/zo0j9siFImkLQzpewCJ+lj8Lber5812s5jcr5366JP0OdtKkoV
         LTqrA+7fNbP7ATfiXc9ioStHIEiR5txJNIe7wK9TY3Fuq77qrhxDDn6ODgbIFf6eeFTh
         wJ/xX/OPZMSvOVJJDO328OygpCcAHRp6HwbD1e2tvB2pAhNH877AJkB596PtNeUqDgtI
         giRvdpXrc6qB3UhFx1NkIIhItZrqxPcZMa2TdnZV1uJHpKDse0MTFw52uZa5wNz80hlA
         SUDwlCi7HcE6tFoOtg5p38x9pudw+EIBMh4zOf5jhfUyIK+wQTRXpsG7QNaYUKM+StCz
         c6TQ==
X-Gm-Message-State: AOAM53209xfrzuIQ0sYij9H1uj+jhqnpKRGkADEfJO2s904cbG5ytpo6
        +D9BgpIjdJjzDfcOn7OafVc=
X-Google-Smtp-Source: ABdhPJyz1y2RUabYBwdobyv5hbJm72+B1Hxi8qwHEg8tyJQ5dCwv2+SJtFNrZtoMkdp7DOqnRqQujg==
X-Received: by 2002:a05:622a:1a86:b0:2f3:4be4:42dd with SMTP id s6-20020a05622a1a8600b002f34be442ddmr4886306qtc.55.1650665052201;
        Fri, 22 Apr 2022 15:04:12 -0700 (PDT)
Received: from localhost ([2601:c4:c432:7d0:efbc:f1b5:7b2c:5d4c])
        by smtp.gmail.com with ESMTPSA id h75-20020a379e4e000000b0069db8210ffbsm1440267qke.12.2022.04.22.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:04:11 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3] vmap(): don't allow invalid pages
Date:   Fri, 22 Apr 2022 15:04:09 -0700
Message-Id: <20220422220410.1308706-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap() takes struct page *pages as one of arguments, and user may provide
an invalid pointer which may lead to corrupted translation table.

An example of such behaviour is erroneous usage of virt_to_page():

	vaddr1 = dma_alloc_coherent()
	page = virt_to_page()	// Wrong here
	...
	vaddr2 = vmap(page)
	memset(vaddr2)		// Faulting here

virt_to_page() returns a wrong pointer if vaddr1 is not a linear kernel
address. The problem is that vmap() populates pte with bad pfn successfully,
and it's much harder to debug at memory access time. This case should be
caught by DEBUG_VIRTUAL being that enabled, but it's not enabled in popular
distros.

Kernel already checks the pages against NULL. In the case mentioned
above, however, the address is not NULL, and it's big enough so that the
hardware generated Address Size Abort on arm64:

	[  665.484101] Unhandled fault at 0xffff8000252cd000
	[  665.488807] Mem abort info:
	[  665.491617]   ESR = 0x96000043
	[  665.494675]   EC = 0x25: DABT (current EL), IL = 32 bits
	[  665.499985]   SET = 0, FnV = 0
	[  665.503039]   EA = 0, S1PTW = 0
	[  665.506167] Data abort info:
	[  665.509047]   ISV = 0, ISS = 0x00000043
	[  665.512882]   CM = 0, WnR = 1
	[  665.515851] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000818cb000
	[  665.522550] [ffff8000252cd000] pgd=000000affcfff003, pud=000000affcffe003, pmd=0000008fad8c3003, pte=00688000a5217713
	[  665.533160] Internal error: level 3 address size fault: 96000043 [#1] SMP
	[  665.539936] Modules linked in: [...]
	[  665.616212] CPU: 178 PID: 13199 Comm: test Tainted: P           OE 5.4.0-84-generic #94~18.04.1-Ubuntu
	[  665.626806] Hardware name: HPE Apollo 70             /C01_APACHE_MB , BIOS L50_5.13_1.0.6 07/10/2018
	[  665.636618] pstate: 80400009 (Nzcv daif +PAN -UAO)
	[  665.641407] pc : __memset+0x38/0x188
	[  665.645146] lr : test+0xcc/0x3f8
	[  665.650184] sp : ffff8000359bb840
	[  665.653486] x29: ffff8000359bb840 x28: 0000000000000000
	[  665.658785] x27: 0000000000000000 x26: 0000000000231000
	[  665.664083] x25: ffff00ae660f6110 x24: ffff00ae668cb800
	[  665.669382] x23: 0000000000000001 x22: ffff00af533e5000
	[  665.674680] x21: 0000000000001000 x20: 0000000000000000
	[  665.679978] x19: ffff00ae66950000 x18: ffffffffffffffff
	[  665.685276] x17: 00000000588636a5 x16: 0000000000000013
	[  665.690574] x15: ffffffffffffffff x14: 000000000007ffff
	[  665.695872] x13: 0000000080000000 x12: 0140000000000000
	[  665.701170] x11: 0000000000000041 x10: ffff8000652cd000
	[  665.706468] x9 : ffff8000252cf000 x8 : ffff8000252cd000
	[  665.711767] x7 : 0303030303030303 x6 : 0000000000001000
	[  665.717065] x5 : ffff8000252cd000 x4 : 0000000000000000
	[  665.722363] x3 : ffff8000252cdfff x2 : 0000000000000001
	[  665.727661] x1 : 0000000000000003 x0 : ffff8000252cd000
	[  665.732960] Call trace:
	[  665.735395]  __memset+0x38/0x188
	[...]

Interestingly, this abort happens even if copy_from_kernel_nofault() is
used, which is quite inconvenient for debugging purposes.

This patch adds a pfn_valid() check into vmap() path, so that invalid
mapping will not be created; WARN_ON() is used to let client code know
that something goes wrong, and it's not a regular EINVAL situation.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---

RFC: https://lkml.org/lkml/2022/1/18/815
v1:  https://lkml.org/lkml/2022/1/18/1026
v2:  https://lore.kernel.org/linux-mm/20220118235244.540103-1-yury.norov@gmail.com/
v3:  Add more details and example in commit message.

 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e163372d3967..9b51a290d133 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -478,6 +478,9 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			return -EBUSY;
 		if (WARN_ON(!page))
 			return -ENOMEM;
+		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
+			return -EINVAL;
+
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-- 
2.32.0

