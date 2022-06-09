Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4A54486D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiFIKMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFIKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7391D0BC4;
        Thu,  9 Jun 2022 03:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18AC061D28;
        Thu,  9 Jun 2022 10:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FBCC34114;
        Thu,  9 Jun 2022 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654769521;
        bh=IVNlOmdDGOUhLFAR3nMIzH30XrHdkBsJEHd4SHkHy+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhlUSxnfqr0u9JH7JbuMdZrEG4QsD6BUNaeNixZyQEzJMe3i1KaBrT7YovYLrYDju
         di83tadCSFZwPXQnB1q+h4vGM2TctQ76ZM1gThy3w8+A1eETccBhkl3Af2POKnmP5P
         CoO7tIs9BK7N7pbqYiJJGb8gQDM1z9MhHFjslQeRB/i6bGJGlc9bZo1cBq3nyhWw8C
         bQHBnxH43LxJxyqcrwxEwdhYUUtDorw984yXTKhlWXckHpAfu4fnj7uH0/+GzPw8Sv
         2DG1VZ7HJQRYdD/3nCg6gFN9LkpGguOFjg43y0muhNrCXZ9GloCwq44NNlAcsQcAN/
         Foiy1l4SyhOmA==
Date:   Thu, 9 Jun 2022 11:11:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [next] arm64: boot failed - next-20220606
Message-ID: <20220609101153.GB2187@willie-the-truck>
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
 <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au>
 <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
 <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
 <44530040-0384-796e-143f-b7293886753c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44530040-0384-796e-143f-b7293886753c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:44:09AM +0800, Kefeng Wang wrote:
> On 2022/6/9 10:49, Vasily Averin wrote:
> > mem_cgroup_from_obj():
> > ffff80000836cf40:       d503245f        bti     c
> > ffff80000836cf44:       d503201f        nop
> > ffff80000836cf48:       d503201f        nop
> > ffff80000836cf4c:       d503233f        paciasp
> > ffff80000836cf50:       d503201f        nop
> > ffff80000836cf54:       d2e00021        mov     x1, #0x1000000000000            // #281474976710656
> > ffff80000836cf58:       8b010001        add     x1, x0, x1
> > ffff80000836cf5c:       b25657e4        mov     x4, #0xfffffc0000000000         // #-4398046511104
> > ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
> > ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
> > ffff80000836cf68:       8b040022        add     x2, x1, x4
> > ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]
> > 
> > x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
> > x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740
> > 
> > x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
> > according to System.map it is init_net
> > 
> > This issue is caused by calling virt_to_page() on address of static variable init_net.
> > Arm64 consider that addresses of static variables are not valid virtual addresses.
> > On x86_64 the same API works without any problem.

This just depends on whether or not the kernel is running out of the linear
mapping or not. On arm64, we use the vmalloc area for the kernel image and
so virt_to_page() won't work, just like it won't work for modules on other
architectures.

How are module addresses handled by mem_cgroup_from_obj()?

> > Unfortunately I do not understand the cause of the problem.
> > I do not see any bugs in my patch.
> > I'm using an existing API, mem_cgroup_from_obj(), to find the memory cgroup used
> > to account for the specified object.
> > In particular, in the current case, I wanted to get the memory cgroup of the
> > specified network namespace by the name taken from for_each_net().
> > The first object in this list is the static structure unit_net
> 
> root@test:~# cat /proc/kallsyms |grep -w _data
> ffff80000a110000 D _data
> root@test:~# cat /proc/kallsyms |grep -w _end
> ffff80000a500000 B _end
> root@test:~# cat /proc/kallsyms |grep -w init_net
> ffff80000a4eb980 B init_net
> 
> the init_net is located in data section, on arm64, it is allowed by vmalloc,
> see
> 
>     map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
> 
> and the arm has same behavior.
> 
> We could let init_net be allocated dynamically, but I think it could change
> a lot.
> 
> Any better sugguestion, Catalin?

For this specific issue, can you use lm_alias to get a virtual address
suitable for virt_to_page()? My question about modules still applies though.

Will
