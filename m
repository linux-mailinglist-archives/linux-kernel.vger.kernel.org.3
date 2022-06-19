Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C713550D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 23:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiFSVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 17:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiFSVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 17:03:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC9658C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:03:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so14348490lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=stFDvED2lOpvuI58rxdqCsj7yH4mZGe0nB/hKuOE8cw=;
        b=Q3d1CzB2/awpEEBbKHzPtDLoIR98Fyv8QWVxmR+hsCJ7TKVDW+QOg+7HP/Q0ZaBXXx
         BY7/FAi+1v2fUrmMSazSwZSUdkRoRnlZ/ROtVMhUFRzqnwoP568hHLCevS1Pb5suCOCS
         6uL36A8fHBzMVomC5hwsY7J8fmuk8XTwF+qr4eacEl1EBKtI/ryW6zycP89IruAQXnmr
         Qp9XRICc/Ql9OWsQ8BB//nY+5QCqmAtyCgewYPC3Upit/jejTA0W0TYwTIgIs9SHYx/3
         /cC8v82VCmXB5Phbeq0xe3wh57d/vmD9enqhFmCZ4JXFR9rVMyVXEoiBQ8X/1ETbg0Kr
         /M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=stFDvED2lOpvuI58rxdqCsj7yH4mZGe0nB/hKuOE8cw=;
        b=f8Psy3H+XQn/uhbt3mQmP/RQZd4LCtx76WQgp3dpkw1owJHbJ3P52Q7Aqxfra59CfM
         O3P8hOfydzn8UcPGyrjHTzi0jYpfh5+OHsZXx1pwccFPuQX9lhW5uDw+Sp80LEelaye6
         jWC1ZbztfA6fZv86X1jfo2hLrxaz1kL06fOXgeGU4Or14E3JHd7J4nChiVNUVAQNP9iJ
         hbnDlpZKmnGTJehkK0GbZwSZcvwfXhlIfPolP5afEvAVDFGoC67bV5MpecQE+FuSle6l
         yKXH8o+E2EbTtDklIz5yZA43RitHSxY5CA0pBrCNYnLI4OSPuzj9MwM702U2kOYERYXe
         jFjw==
X-Gm-Message-State: AJIora/uOt07Q3h6/esJk3aECQxZmGCi2GDqeoFi5lCkivqlyhPIuBvG
        95CUuaMjDOGa72CC54hO8Ks78G4/4ZPy3mbSaFI=
X-Google-Smtp-Source: AGRyM1u/bJkWel/g/09LJ7hvw2H/TeoMFA0EHDnebY1qMFMIVO2d5rinjOmJYO2lPqYQ97iSc1KEqg==
X-Received: by 2002:a05:6512:238f:b0:47f:6fc3:f268 with SMTP id c15-20020a056512238f00b0047f6fc3f268mr1026393lfv.148.1655672628464;
        Sun, 19 Jun 2022 14:03:48 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004790b5a0b22sm1490923lfr.239.2022.06.19.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 14:03:47 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 19 Jun 2022 23:03:45 +0200
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com, hch@lst.de
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
Message-ID: <Yq+PMWlARgDhv8uL@pc638.lan>
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 26, 2022 at 10:18 AM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Accessing to vb->va could be deemed as use after free when KASAN is
> > enabled like bellowing. Fix it by expanding the mutex's range.
> >
> > [   20.232335] ==================================================================
> > [   20.232365] BUG: KASAN: use-after-free in _vm_unmap_aliases+0x164/0x364
> > [   20.232376] Read of size 8 at addr ffffff80d84af780 by task modprobe/300
> > [   20.232380]
> > [   20.232395] CPU: 5 PID: 300 Comm: modprobe Tainted: G S       C O      5.4.161-android12-9-03238-gd43329d103de-ab20547 #1
> > [   20.232401] Hardware name: Spreadtrum UMS512-1H10 SoC (DT)
> > [   20.232407] Call trace:
> > [   20.232419]  dump_backtrace+0x0/0x2b4
> > [   20.232428]  show_stack+0x24/0x30
> > [   20.232443]  dump_stack+0x15c/0x1f4
> > [   20.232455]  print_address_description+0x88/0x568
> > [   20.232465]  __kasan_report+0x1b8/0x1dc
> > [   20.232474]  kasan_report+0x10/0x18
> > [   20.232486]  __asan_report_load8_noabort+0x1c/0x24
> > [   20.232495]  _vm_unmap_aliases+0x164/0x364
> > [   20.232505]  vm_unmap_aliases+0x20/0x28
> > [   20.232516]  change_memory_common+0x2c4/0x3ec
> > [   20.232524]  set_memory_ro+0x30/0x3c
> > [   20.232539]  module_enable_ro+0x144/0x3f0
> > [   20.232547]  load_module+0x54c0/0x8248
> > [   20.232555]  __se_sys_finit_module+0x174/0x1b0
> > [   20.232564]  __arm64_sys_finit_module+0x78/0x88
> > [   20.232573]  el0_svc_common+0x19c/0x354
> > [   20.232581]  el0_svc_handler+0x48/0x54
> > [   20.232591]  el0_svc+0x8/0xc
> > [   20.232595]
> > [   20.232602] Allocated by task 297:
> > [   20.232615]  __kasan_kmalloc+0x130/0x1f8
> > [   20.232625]  kasan_slab_alloc+0x14/0x1c
> > [   20.232638]  kmem_cache_alloc+0x1dc/0x394
> > [   20.232648]  alloc_vmap_area+0xb4/0x1630
> > [   20.232657]  vm_map_ram+0x3ac/0x768
> > [   20.232671]  z_erofs_decompress_generic+0x2f0/0x844
> > [   20.232681]  z_erofs_decompress+0xa8/0x594
> > [   20.232692]  z_erofs_decompress_pcluster+0xeb4/0x1458
> > [   20.232702]  z_erofs_vle_unzip_wq+0xe4/0x140
> > [   20.232715]  process_one_work+0x5c0/0x10ac
> > [   20.232724]  worker_thread+0x888/0x1128
> > [   20.232733]  kthread+0x290/0x304
> > [   20.232744]  ret_from_fork+0x10/0x18
> > [   20.232747]
> > [   20.232752] Freed by task 51:
> > [   20.232762]  __kasan_slab_free+0x1a0/0x270
> > [   20.232772]  kasan_slab_free+0x10/0x1c
> > [   20.232781]  slab_free_freelist_hook+0xd0/0x1ac
> > [   20.232792]  kmem_cache_free+0x110/0x368
> > [   20.232803]  __purge_vmap_area_lazy+0x524/0x13e4
> > [   20.232813]  _vm_unmap_aliases+0x290/0x364
> > [   20.232822]  __vunmap+0x45c/0x5c4
> > [   20.232831]  vfree+0x74/0x16c
> > [   20.232841]  module_memfree+0x44/0x7c
> > [   20.232850]  do_free_init+0x5c/0xac
> > [   20.232860]  process_one_work+0x5c0/0x10ac
> > [   20.232869]  worker_thread+0xb3c/0x1128
> > [   20.232877]  kthread+0x290/0x304
> > [   20.232887]  ret_from_fork+0x10/0x18
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmalloc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d2a00ad..028d65a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2081,7 +2081,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
> >                 return;
> >
> >         might_sleep();
> > -
> > +       mutex_lock(&vmap_purge_lock);
> >         for_each_possible_cpu(cpu) {
> >                 struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
> >                 struct vmap_block *vb;
> > @@ -2106,7 +2106,6 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
> >                 rcu_read_unlock();
> >         }
> >
> > -       mutex_lock(&vmap_purge_lock);
> >         purge_fragmented_blocks_allcpus();
> >         if (!__purge_vmap_area_lazy(start, end) && flush)
> >                 flush_tlb_kernel_range(start, end);
> > --
> > 1.9.1
> >
>
Is it easy to reproduce? If so could you please describe the steps? As i see
the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
glance i do not see how it can accessed twice. Hm..

--
Uladzislau Rezki
