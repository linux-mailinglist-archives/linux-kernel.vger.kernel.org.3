Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5293530059
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiEVDIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 23:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiEVDIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 23:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3181445ACB
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653188888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Gam7sumT5W8pDuiX0Cgy71xdDr4WJ12i+0TurLsscg=;
        b=VTG+3EtW5mnqRnH29IMp45qe/KriHsgsuEVvGv+Lt7o3OcHnwIFUqBcaOaTNEf8csT44Oj
        oIcu1KFjHYMiOcbV2ivBTpidp2OmVJa8nAs5OvF1OXnxUDb0+S3Qe3hqOoCzffQ3ew6Mq+
        b8Nf60MQbnVtvp0hDQGIC/k1t3xUQpc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-aBcYdxJHOsOykZ25peM-Bg-1; Sat, 21 May 2022 23:08:04 -0400
X-MC-Unique: aBcYdxJHOsOykZ25peM-Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEDCB3C01C0F;
        Sun, 22 May 2022 03:08:03 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43D2A40D0161;
        Sun, 22 May 2022 03:08:00 +0000 (UTC)
Date:   Sun, 22 May 2022 11:07:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     lizhengyu3@huawei.com, liaochang1@huawei.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, Bjorn Topel <bjorn.topel@gmail.com>,
        ebiederm@xmission.com, guoren@linux.alibaba.com,
        jszhang@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        penberg@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 -next 1/6] kexec_file: Fix kexec_file.c build error
 for riscv platform
Message-ID: <YompDXEY1MaHElmE@MiWiFi-R3L-srv>
References: <20220408100914.150110-2-lizhengyu3@huawei.com>
 <mhng-33c63a92-49e5-48a0-8f54-797c797ee373@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-33c63a92-49e5-48a0-8f54-797c797ee373@palmer-mbp2014>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/22 at 08:45am, Palmer Dabbelt wrote:
> On Fri, 08 Apr 2022 03:09:09 PDT (-0700), lizhengyu3@huawei.com wrote:
> > From: Liao Chang <liaochang1@huawei.com>
> > 
> > When CONFIG_KEXEC_FILE is set for riscv platform, the compilation of
> > kernel/kexec_file.c generate build error:
> > 
> > kernel/kexec_file.c: In function 'crash_prepare_elf64_headers':
> > ./arch/riscv/include/asm/page.h:110:71: error: request for member 'virt_addr' in something not a structure or union
> >   110 |  ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < kernel_map.virt_addr))
> >       |                                                                       ^
> > ./arch/riscv/include/asm/page.h:131:2: note: in expansion of macro 'is_linear_mapping'
> >   131 |  is_linear_mapping(_x) ?       \
> >       |  ^~~~~~~~~~~~~~~~~
> > ./arch/riscv/include/asm/page.h:140:31: note: in expansion of macro '__va_to_pa_nodebug'
> >   140 | #define __phys_addr_symbol(x) __va_to_pa_nodebug(x)
> >       |                               ^~~~~~~~~~~~~~~~~~
> > ./arch/riscv/include/asm/page.h:143:24: note: in expansion of macro '__phys_addr_symbol'
> >   143 | #define __pa_symbol(x) __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
> >       |                        ^~~~~~~~~~~~~~~~~~
> > kernel/kexec_file.c:1327:36: note: in expansion of macro '__pa_symbol'
> >  1327 |   phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> > 
> > This occurs is because the "kernel_map" referenced in macro
> > is_linear_mapping()  is suppose to be the one of struct kernel_mapping
> > defined in arch/riscv/mm/init.c, but the 2nd argument of
> > crash_prepare_elf64_header() has same symbol name, in expansion of macro
> > is_linear_mapping in function crash_prepare_elf64_header(), "kernel_map"
> > actually is the local variable.
> > 
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  include/linux/kexec.h | 2 +-
> >  kernel/kexec_file.c   | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 58d1b58a971e..ebb1bffbf068 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -227,7 +227,7 @@ struct crash_mem {
> >  extern int crash_exclude_mem_range(struct crash_mem *mem,
> >  				   unsigned long long mstart,
> >  				   unsigned long long mend);
> > -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> > +extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> >  				       void **addr, unsigned long *sz);
> >  #endif /* CONFIG_KEXEC_FILE */
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 8347fc158d2b..331a4f0f10f5 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -1260,7 +1260,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> >  	return 0;
> >  }
> > 
> > -int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> > +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> >  			  void **addr, unsigned long *sz)
> >  {
> >  	Elf64_Ehdr *ehdr;
> > @@ -1324,7 +1324,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> >  	phdr++;
> > 
> >  	/* Prepare PT_LOAD type program header for kernel text region */
> > -	if (kernel_map) {
> > +	if (need_kernel_map) {
> >  		phdr->p_type = PT_LOAD;
> >  		phdr->p_flags = PF_R|PF_W|PF_X;
> >  		phdr->p_vaddr = (unsigned long) _text;
> 
> IMO this is fine: we could rename all the kernel_map stuff in arch/riscv,
> but this is much more self-contained.  It's not been ack'd by anyone else,
> but get_maintainers just suggests the kexec@ list so I'm going to take it
> via the RISC-V tree along with the rest of these.

I ever checked this patch, and thought the renaming of kernel_map in
arch/riscv might be more reasonable, because 'need_kernel_map' is obviously
redundant and looks silly, considering in a generic code. But searching
result of kernel_map under arch/riscv stops me suggesting that.

