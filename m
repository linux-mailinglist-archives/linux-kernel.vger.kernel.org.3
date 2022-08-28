Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5F5A3D44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiH1LKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 07:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiH1LKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 07:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4E16599
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661685014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xdc5yjDQJtdeC1xQqflsPRd7xjOX2OaEJE9/AMTpio=;
        b=ZspRXn8Yxaf+2CLlFZDOSgnAM3K+/Ke3Vr0yj3P8TmOQO9ur5Ta0ty3otV1RiFhK+i5umg
        YNnkc/ej/7kZ2sdfA5eCF1FUe/JJzWSMbNqceFpQBfEfUSKi/IZg/gVo3to2uk/qWg7z3t
        lsKDJDiEqEiGeljoYS2maYq4d6+0JQ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-v66h8T_SM0ytnqYJL7TA-A-1; Sun, 28 Aug 2022 07:10:12 -0400
X-MC-Unique: v66h8T_SM0ytnqYJL7TA-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6804A3C021B1;
        Sun, 28 Aug 2022 11:10:12 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B6A02166B26;
        Sun, 28 Aug 2022 11:10:11 +0000 (UTC)
Date:   Sun, 28 Aug 2022 19:10:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "hch@infradead.org" <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
 <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/22 at 07:03pm, Christophe Leroy wrote:
> 
> 
> Le 23/08/2022 à 14:32, Baoquan He a écrit :
> > On 08/23/22 at 05:33am, Christophe Leroy wrote:
> >>
> >>
> >> Le 23/08/2022 à 03:19, Baoquan He a écrit :
> >>> On 08/22/22 at 06:30am, Christophe Leroy wrote:
> >>>>
> >>>>
> >>>> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> >>>>> On some architectures, the physical address need be fixed up before
> >>>>> doing mapping, e.g, parisc. And on architectures, e.g arc, the
> >>>>> parameter 'prot' passed into ioremap_prot() need be adjusted too.
> >>>>>
> >>>>> In oder to convert them to take GENERIC_IOREMAP method, we need wrap
> >>>>> the address fixing up code and page prot adjusting code into arch_ioremap()
> >>>>> and pass the new address and 'prot' out for ioremap_prot() handling.
> >>>>
> >>>> Is it really the best approach ? Wouldn't it be better to have helpers
> >>>> to do that, those helpers being called by the ioremap_prot(), instead of
> >>>> doing it inside the arch_ioremap() function ?
> >>>
> >>> This is suggested too by Alexander during his v1 reviewing. I tried, but
> >>> feel the current way taken in this patchset is better. Because not all
> >>> architecutres need the address fix up, only parisc, and only few need
> >>> adjust the 'prot'. Introducing other helpers seems too much, that only
> >>> increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
> >>> method for people to understand and take.
> >>
> >> I can't understand. Why is it difficult to do something like:
> >>
> >> #ifndef ioremap_adjust_prot
> >> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >> {
> >> 	return flags;
> >> }
> >> #endif
> >>
> >> Then for arc you do
> >>
> >> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >> {
> >> 	return pgprot_val(pgprot_noncached(__pgprot(flags)));
> >> }
> >> #define ioremap_adjust_prot ioremap_adjust_prot
> > 
> > My thinking is we have four things to do in the added hookers.
> > 1) check if we should do ioremap on ARCHes. If not, return NULL from
> > ioremap_prot();
> > 2) handling the mapping io address specifically on ARCHes, e.g arc,
> > ia64, s390;
> > 3) the original physical address passed into ioremap_prot() need be
> > fixed up, e.g arc;
> > 4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
> > and xtensa.
> > 
> > With Kefeng's patches, the case 1) is handled with introduced
> > ioremap_allowed()/iounmap_allowed(). In this patchset, what I do is
> > rename the hooks as arch_ioremap() and arch_iounmap(), then put case 1),
> > 2), 3), 4) handling into arch_ioremap(). Adding helpers to cover each
> > case is not difficult from my side. I worry that as time goes by, those
> > several hooks my cause issue, e.g if a new adjustment need be done,
> > should we introduce a new helper or make do with the existed hook; how
> > 
> > When I investigated this, one arch_ioremap() looks not complicated
> > since not all ARCHes need cover all above 4 cases. That's why I finally
> > choose one hook. I am open to new idea, please let me know if we should
> > change it to introduce several different helpers.
> > 
> 
> A new idea that would have my preference would be to do just like we did 
> with arch_get_unmapped_area(). Look at 
> https://elixir.bootlin.com/linux/v6.0-rc1/source/arch/powerpc/mm/book3s64/slice.c#L638 
> and https://elixir.bootlin.com/linux/v6.0-rc1/source/mm/mmap.c#L2131
> 
> Instead of having the generic that calls the arch specific, make it the 
> other way round, have the arch specific call the generic after doing its 
> specialties.

This sounds good. I made a draft patch to change code in generic code
part, just showing what it looks like.

Both arch_ioremap() way and the arch sepcific call the generic way look
good to me. Just it will take less effort for me to continue the
arch_ioremap() way. I would like to hear Christoph's opinion since he
introduced the GENERIC_IOREMAP method and suggested the earlier
arch_ioremap() way and change in this patchset. 

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 68a8117b30fa..4bc3e18c475f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1047,35 +1047,18 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
-/*
- * Arch code can implement the following two hooks when using GENERIC_IOREMAP
- * arch_ioremap() return a bool,
- *   - IS_ERR means return an error
- *   - NULL means continue to remap
- *   - a non-NULL, non-IS_ERR pointer is returned directly
- * arch_iounmap() return a bool,
- *   - 0 means continue to vunmap
- *   - error code means skip vunmap and return directly
- */
-#ifndef arch_ioremap
-#define arch_ioremap arch_ioremap
-static inline void __iomem *arch_ioremap(phys_addr_t *paddr, size_t size,
-				   unsigned long *prot_val)
-{
-	return NULL;
-}
-#endif
+void __iomem *
+generic_ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 
-#ifndef arch_iounmap
-#define arch_iounmap arch_iounmap
-static inline int arch_iounmap(void __iomem *addr)
+#ifndef ioremap_prot
+#define ioremap_prot ioremap_prot
+void __iomem *
+ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 {
-	return 0;
+	return generic_ioremap_prot(phys_addr, size, prot);
 }
 #endif
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
 #ifndef ioremap
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 7914b5cf5b78..87d51003dee6 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *
+generic_ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)
 {
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;

