Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDD58ABA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiHEN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbiHEN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D8A28708
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659706143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3pUkP8F2wwkxpI6wSj/WufO86VZtAeN7QIk6SEWPI+k=;
        b=Wd4f6JyVSk+qzTGcvB9/36UHvf0gM7BVex6fpN60/QK+ZZZltGC282iVyMA9L7mJ9EZmX5
        fiXEnOwbk3yiFpe+COZT1spNB7PGPBd++YjEkHTtUhKfggXix7M7GCjPnoGCiHEM/Ex2ug
        jy4xt7eY81B15kHd86oQ4hOKWOxaDyc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-EFaCpBEYPean2qbKw1F0SQ-1; Fri, 05 Aug 2022 09:29:02 -0400
X-MC-Unique: EFaCpBEYPean2qbKw1F0SQ-1
Received: by mail-yb1-f199.google.com with SMTP id j11-20020a05690212cb00b006454988d225so2106431ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pUkP8F2wwkxpI6wSj/WufO86VZtAeN7QIk6SEWPI+k=;
        b=AvJ7xAj3RJc2UEIbLHJ5Ri1T4fvnRFRssFmqhKBbHm0v6deTZLULo7PChM3O0gA23G
         antQnCXeA0Y4lPArXtk12JUKfggEE8H17TFe29EW0YSUmBjqfrLO+Gjw7F1jl6Sw6tCj
         2OS5gEcPPAxh4xHaAIUBKToeSMS43VgqhfdjJ43jqXgOirPXGH1FT4jOqCFSEJrM98kN
         CxC8+C/hZmsGA4cbC3YWFn8Sm6WkHPG2tnl/LWmxsQock+eutiISx8vtQ5V86I7sLGjO
         d2UyUIbeauPk2hlscJBdsSq7Qi+bCRVFqf4kkGzcvxUxAmLdJDviF1p0fD8r6Cgz9trJ
         zouA==
X-Gm-Message-State: ACgBeo2kk/tJNT8RWy2/0cKnG3rtnjFAY9XBmYSJ3IEw5f6xcxOPni+R
        Z7rQv7ehj37mD+vh7M4kZlV844KIhHF9RqnsiYB8ZargVlM6hwKBMj6zVALEsChyz5p4hQaSrX1
        PZtepPx7r/xmzBKYGIVH2lh9DRGAQb2FL8zaNBcCF
X-Received: by 2002:a81:ad58:0:b0:329:5b1:106e with SMTP id l24-20020a81ad58000000b0032905b1106emr6263374ywk.371.1659706142100;
        Fri, 05 Aug 2022 06:29:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7DLqDHBbBKQycilyOCrJuZlbRaMCFGuqDCTAHE4BNwfZ/FWNzRNUkdsx1aNbZZqRbeikf6ck3B+zP64CEF7jM=
X-Received: by 2002:a81:ad58:0:b0:329:5b1:106e with SMTP id
 l24-20020a81ad58000000b0032905b1106emr6263360ywk.371.1659706141852; Fri, 05
 Aug 2022 06:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
 <Yu0TdPm3CUT6gq/J@FVFF77S0Q05N>
In-Reply-To: <Yu0TdPm3CUT6gq/J@FVFF77S0Q05N>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 5 Aug 2022 15:28:50 +0200
Message-ID: <CA+QYu4rVHTa29uhaC+yzYc=GKN7ZXxKUx0skvhwsyghxg81=Sg@mail.gmail.com>
Subject: Re: [5.19.0] [aarch64] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 at 14:57, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Aug 05, 2022 at 11:47:57AM +0200, Bruno Goncalves wrote:
> > Hello,
> >
> > Since commit "c1c76700a0d6" we started to hit the following call trace
> > on aarch64 VMs when looking at journalctl log
>
> For everyone else's benefit that's commit:
>
>   c1c76700a0d6 ("Merge tag 'spdx-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx")
>
> Could you please include the commit title when citing a patch?

Thanks for the extra information.

>
> ... did you try to bisect this?

No, I didn't bisect it.

To add more context here I meant that c1c76700a0d6 ("Merge tag
'spdx-6.0-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx") is the
first commit that we tested that hit the problem.

The last commit that we tested without this problem is b44f2fd87919
("Merge tag 'drm-next-2022-08-03' of
git://anongit.freedesktop.org/drm/drm")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1

>
> > kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
> > bytes, linear)
> > kernel: ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
> > kernel: ------------[ cut here ]------------
> > kernel: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
>
> IIUC that's:
>
>   WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp)
>
> ... and IIUC that's fixed by commit:
>
>   11969d698f8cda31 ("cacheinfo: Use atomic allocation for percpu cache attributes")

I believe this commit is already included in the tree.

We've also reproduced it using latest commit "b2a88c212e65" ("Merge
tag 'xfs-5.20-merge-6' of
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2a88c212e652e94f1e4b635910972ac57ba4e97

Thanks,
Bruno

> Thanks,
> Mark.
>
> > kernel: Modules linked in:
> > kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0 #1
> > kernel: pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > kernel: pc : __alloc_pages+0x1a0/0x290
> > kernel: lr : alloc_page_interleave+0x24/0xbc
> > kernel: sp : ffff80000803bb90
> > kernel: x29: ffff80000803bb90 x28: 0000000000000000 x27: 0000000000000000
> > kernel: x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > kernel: x23: 000000000000001e x22: 0000000000000000 x21: 000000000000001e
> > kernel: x20: 000000000000001e x19: 0000000000040b20 x18: 0000000000000014
> > kernel: x17: 6e69206562207961 x16: 6d2079676f6c6f70 x15: 6f74206568636163
> > kernel: x14: 20646e6120555043 x13: 6574617275636361 x12: 6e69206562207961
> > kernel: x11: 6d2079676f6c6f70 x10: 6f74206568636163 x9 : ffffa4f6617fd5e8
> > kernel: x8 : ffffa4f663ed0440 x7 : 0000000000000007 x6 : 0000000000000000
> > kernel: x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa4f663c53532
> > kernel: Call trace:
> > kernel:  __alloc_pages+0x1a0/0x290
> > kernel:  alloc_page_interleave+0x24/0xbc
> > kernel:  alloc_pages+0x10c/0x16c
> > kernel:  kmalloc_order+0x3c/0xc0
> > kernel:  kmalloc_order_trace+0x38/0x130
> > kernel:  __kmalloc+0x2e8/0x350
> > kernel:  detect_cache_attributes+0x9c/0x110
> > kernel:  update_siblings_masks+0x34/0x270
> > kernel:  store_cpu_topology+0x7c/0xc0
> > kernel:  smp_prepare_cpus+0x34/0x108
> > kernel:  kernel_init_freeable+0x108/0x1b8
> > kernel:  kernel_init+0x30/0x150
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ---[ end trace 0000000000000000 ]---
> > kernel: Early cacheinfo failed, ret = -12
> > kernel: cblist_init_generic: Setting adjustable number of callback queues.
> > kernel: cblist_init_generic: Setting shift to 2 and lim to 1.
> >
> > test logs: https://datawarehouse.cki-project.org/kcidb/tests/4712644
> > cki issue tracker: https://datawarehouse.cki-project.org/issue/1485
> >
> > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/605193135/build%20aarch64/2816138306/artifacts/kernel-mainline.kernel.org-redhat_605193135_aarch64.config
> > kernel build: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/605193135/publish%20aarch64/2816138315/artifacts/kernel-mainline.kernel.org-redhat_605193135_aarch64.tar.gz
> >
> > Thanks,
> > Bruno Goncalves
> >
>

