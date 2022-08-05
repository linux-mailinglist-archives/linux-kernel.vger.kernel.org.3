Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44958AFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiHESi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiHESiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC0E4140B9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659724733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uK4+oi5oIGJwNOgxAXrTWoMoN2KMAV9Kemuupkrqsv0=;
        b=VIradF4xiOr6W3TwS8Xdwj6loGzNpbD5MUqc5xffarcDSIuppgEfy8ELodNSK3tSSeaVf/
        MFUXUI+sPTIXYYQAeHi8oD3XVjUeUA+l8Xi5scddfCfSJyoyvdjmwRIyPAUzn/989YrgK1
        BdHOKqSPzbTcAjUL2nl3nWD8u9PgSoY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-DyuMX3JlNr2YnbDtej6QTg-1; Fri, 05 Aug 2022 14:38:51 -0400
X-MC-Unique: DyuMX3JlNr2YnbDtej6QTg-1
Received: by mail-yb1-f197.google.com with SMTP id z7-20020a25ba47000000b00677405b2d2dso2703684ybj.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uK4+oi5oIGJwNOgxAXrTWoMoN2KMAV9Kemuupkrqsv0=;
        b=cNIaE/y1EGPpckAvBPEig8b2sdRUC4ZfR3InN9NpmPfd/aj8Y7Q/fHhIF8wwYy8714
         4mtWCGId3rcVGicS1QBa59SKXkz7Cr0kD1dH456nvaaBREU2h30jLusdoWwIMHReyAiw
         T/ggPnRvFaMuJLZZEpSZjgjFBHmgoEjXe9OArVYDTuMVdyb3HYvUBzXspOdFR5iX/HQn
         /pqLlwk32hZMBSdh8RMUW/BtRnzZ9GAIoERX/1F11Xo70w6lMwS3m+BuO2WxJHCHB8Gp
         Lw/Nde3pkaANqtd9rJahIKvcSxwtHhYWPbt8JnsdWQ4NjeZcUujT4KUvNDWtcIbg1/7l
         chXw==
X-Gm-Message-State: ACgBeo3685amJJYrYWTRMCgYpZKvVVsdZE4NGIfD7dM3zGUu910l278f
        KHOXKNhD5VNnzTDVN+5ghy6i36TqJbCWC6mAtQAO5ybaoDd8DRkq9CPcOf8C2I+fR/D1OJpXRio
        hRrEjPMTmp3hFdXDi8TOC2s+KXwEOUcp5Apzek7Do
X-Received: by 2002:a05:6902:10c:b0:671:68b7:ab41 with SMTP id o12-20020a056902010c00b0067168b7ab41mr5904296ybh.608.1659724731037;
        Fri, 05 Aug 2022 11:38:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Cb5r33s0VoKon813UFONZh+fVw8UBFB4ggBcW6cIe6+PtylN7eD3mjXrWS+4M1Ebj+oz+ZzrFvvh7UHyWGFo=
X-Received: by 2002:a05:6902:10c:b0:671:68b7:ab41 with SMTP id
 o12-20020a056902010c00b0067168b7ab41mr5904278ybh.608.1659724730792; Fri, 05
 Aug 2022 11:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
 <20220805135955.5to2bm6ou35p5zsy@bogus> <20220805150820.3q4kwrlh7qrt7poa@bogus>
In-Reply-To: <20220805150820.3q4kwrlh7qrt7poa@bogus>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 5 Aug 2022 20:38:39 +0200
Message-ID: <CA+QYu4qq3Op4=dJcRWGDTqyt6Md4vQfRBaafLtC+h7n5sFYM9A@mail.gmail.com>
Subject: Re: [5.19.0] [aarch64] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 at 17:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>

Thanks for the fix, it works well.

[    0.003840] ACPI PPTT: No PPTT table found, CPU and cache topology
may be inaccurate
[    0.004588] cblist_init_generic: Setting adjustable number of
callback queues.
[    0.004595] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.004707] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.004779] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.004908] rcu: Hierarchical SRCU implementation.

Bruno

> On Fri, Aug 05, 2022 at 02:59:55PM +0100, Sudeep Holla wrote:
> > On Fri, Aug 05, 2022 at 11:47:57AM +0200, Bruno Goncalves wrote:
> > > Hello,
> > >
> > > Since commit "c1c76700a0d6" we started to hit the following call trace
> > > on aarch64 VMs when looking at journalctl log
> > >
> > > kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
> > > bytes, linear)
> > > kernel: ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
> > > kernel: ------------[ cut here ]------------
> > > kernel: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
> > > kernel: Modules linked in:
> > > kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0 #1
> > > kernel: pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > kernel: pc : __alloc_pages+0x1a0/0x290
> > > kernel: lr : alloc_page_interleave+0x24/0xbc
> > > kernel: sp : ffff80000803bb90
> > > kernel: x29: ffff80000803bb90 x28: 0000000000000000 x27: 0000000000000000
> > > kernel: x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > > kernel: x23: 000000000000001e x22: 0000000000000000 x21: 000000000000001e
> > > kernel: x20: 000000000000001e x19: 0000000000040b20 x18: 0000000000000014
> > > kernel: x17: 6e69206562207961 x16: 6d2079676f6c6f70 x15: 6f74206568636163
> > > kernel: x14: 20646e6120555043 x13: 6574617275636361 x12: 6e69206562207961
> > > kernel: x11: 6d2079676f6c6f70 x10: 6f74206568636163 x9 : ffffa4f6617fd5e8
> > > kernel: x8 : ffffa4f663ed0440 x7 : 0000000000000007 x6 : 0000000000000000
> > > kernel: x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa4f663c53532
> > > kernel: Call trace:
> > > kernel:  __alloc_pages+0x1a0/0x290
> > > kernel:  alloc_page_interleave+0x24/0xbc
> > > kernel:  alloc_pages+0x10c/0x16c
> > > kernel:  kmalloc_order+0x3c/0xc0
> > > kernel:  kmalloc_order_trace+0x38/0x130
> > > kernel:  __kmalloc+0x2e8/0x350
> > > kernel:  detect_cache_attributes+0x9c/0x110
> > > kernel:  update_siblings_masks+0x34/0x270
> > > kernel:  store_cpu_topology+0x7c/0xc0
> > > kernel:  smp_prepare_cpus+0x34/0x108
> > > kernel:  kernel_init_freeable+0x108/0x1b8
> > > kernel:  kernel_init+0x30/0x150
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel: ---[ end trace 0000000000000000 ]---
> > > kernel: Early cacheinfo failed, ret = -12
> > > kernel: cblist_init_generic: Setting adjustable number of callback queues.
> > > kernel: cblist_init_generic: Setting shift to 2 and lim to 1.
> > >
> >
> > Thanks for the report. I will see if I can reproduce by forcing the absence
> > of PPTT which is something I haven't tested after I fixed hotplug issues
> > reported with my changes.
>
> OK I was able to reproduce this easily by just saying PPTT doesn't exist
> on my system. Not sure if my recent changes made this issue show up easily
> or it existed even w/o my changes but it is stupid issue :(.
>
> Can you check if this fixes it for you ? I can post the patch once
> you confirm. We assign negative/error value to unsigned int and then
> the number of leaves ends up with that value because of wrong comparison.
>
> Regards,
> Sudeep
>
> -->8
> diff --git i/arch/arm64/kernel/cacheinfo.c w/arch/arm64/kernel/cacheinfo.c
> index 587543c6c51c..97c42be71338 100644
> --- i/arch/arm64/kernel/cacheinfo.c
> +++ w/arch/arm64/kernel/cacheinfo.c
> @@ -45,7 +45,8 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>
>  int init_cache_level(unsigned int cpu)
>  {
> -       unsigned int ctype, level, leaves, fw_level;
> +       unsigned int ctype, level, leaves;
> +       int fw_level;
>         struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>
>         for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
> @@ -63,6 +64,9 @@ int init_cache_level(unsigned int cpu)
>         else
>                 fw_level = acpi_find_last_cache_level(cpu);
>
> +       if (fw_level < 0)
> +               return fw_level;
> +
>         if (level < fw_level) {
>                 /*
>                  * some external caches not specified in CLIDR_EL1
>

