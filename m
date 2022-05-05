Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C151BFB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377864AbiEEMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiEEMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:49:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4FE086
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:45:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d22so4262653plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=F7HMG+OVhPOos/cU+pyZ4Uh+EgyQ7cM2dbYtA5UL2Io=;
        b=FliSKDjWtBxb7sHTcZuxqXvrzycO2HY1qnLgfgN0JxJBZoqrNfUBaMen+TDkvlhUV4
         nNH1yczPMbCbdQZszx01TxDN5R7CYc0/qpex13veQqYJbnKd6pn7F+z+Hi+v1bcUjBzw
         dixZ2W+1YVmTRjlHGNp00kV6lcMaZyqV9eKWK1ItGE2jfGzJs85k2PEQkSoNnVUnyR/w
         ik39nS88yAb6Jqw8TBRsY/SUWdjGjLKhCCamMrkmzcC75UyK6WT1eKLZ0pgjTF21uu5x
         EdcoHsuaZaAyaEcdonRTWtd4ia7oxAdlGICgPpLUGzkvTtOiwwJ/cUJyBPx8Kof5NhhN
         BEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=F7HMG+OVhPOos/cU+pyZ4Uh+EgyQ7cM2dbYtA5UL2Io=;
        b=MdcHW5Emf4DiUNU84NCkrV5cKR4m4lPsKMzyXIGy5+Zm/4chkfGcoUkKRxExq6WT5p
         cMo4UjJmtDFpGvPRpGDaFY4/aZZe38/GV7F29OHw5FLMeABjKuqrVmN8+zNI5avPrqtu
         HfSSMx8ItfcDZEvljiyujy0ZluJK+wDhSzmb6FZ0byJFUGnIWQiUwsEBu+FD43sxWMoC
         JbtEeZn560bvSNwAOEd6GN27hUTsKuYSAtyRYwAe18HkrDVPmQUxlaC+cRAB0CAHpbUq
         bkJRmOc9bxs6z5vIYhJNBcMfN4hdfrCZARB7dsaTFcWGZ4r9GdDFxK0KXiXDksfTtMdQ
         HoeA==
X-Gm-Message-State: AOAM532jFhg8jZGSe1ClrVPWNs9/OezL0KOg5Mm2aJ8m02jw3GmF0Am3
        RoOHmCvLyDn4LtgSL1QDXgw=
X-Google-Smtp-Source: ABdhPJzwQrMHYTwtniSHPVkeMU50/jRdLb4QENkxiLwIbU63QlDYPWoRGcR7d0QfrhaLzXg99SB6Aw==
X-Received: by 2002:a17:903:40c2:b0:15c:fd2a:7198 with SMTP id t2-20020a17090340c200b0015cfd2a7198mr22407514pld.0.1651754725679;
        Thu, 05 May 2022 05:45:25 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id jf20-20020a17090b175400b001d6510cbbaesm5230422pjb.46.2022.05.05.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:45:25 -0700 (PDT)
Date:   Thu, 5 May 2022 21:45:18 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v4] mm/kfence: reset PG_slab and memcg_data before freeing
 __kfence_pool
Message-ID: <YnPG3pQrqfcgOlVa@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kfence fails to initialize kfence pool, it frees the pool.
But it does not reset memcg_data and PG_slab flag.

Below is a BUG because of this. Let's fix it by resetting memcg_data
and PG_slab flag before free.

[    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
[    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
[    0.089150] memcg:ffffffff94a475d1
[    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
[    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
[    0.089152] page dumped because: page still charged to cgroup
[    0.089153] Modules linked in:
[    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
[    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.089154] Call Trace:
[    0.089155]  <TASK>
[    0.089155]  dump_stack_lvl+0x49/0x5f
[    0.089157]  dump_stack+0x10/0x12
[    0.089158]  bad_page.cold+0x63/0x94
[    0.089159]  check_free_page_bad+0x66/0x70
[    0.089160]  __free_pages_ok+0x423/0x530
[    0.089161]  __free_pages_core+0x8e/0xa0
[    0.089162]  memblock_free_pages+0x10/0x12
[    0.089164]  memblock_free_late+0x8f/0xb9
[    0.089165]  kfence_init+0x68/0x92
[    0.089166]  start_kernel+0x789/0x992
[    0.089167]  x86_64_start_reservations+0x24/0x26
[    0.089168]  x86_64_start_kernel+0xa9/0xaf
[    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
[    0.089171]  </TASK>

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

v3 -> v4:
	- Use struct slab instead of folio and reset memcg_data and
	  clear PG_slab only if PG_slab flag is set (virt_to_slab() != NULL).
	  
	  Thanks Muchun. Now it looks much better and still works.

	- Remove Reviewed-by: tags as the code changed. Please add new
	  one if the patch still looks good to you.

 mm/kfence/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a203747ad2c0..58dfac1828ce 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -642,6 +642,16 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
+	for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
+		struct slab *slab = virt_to_slab(p);
+
+		if (!slab)
+			continue;
+#ifdef CONFIG_MEMCG
+		slab->memcg_data = 0;
+#endif
+		__folio_clear_slab(slab_folio(slab));
+	}
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
 	return false;
-- 
2.32.0
