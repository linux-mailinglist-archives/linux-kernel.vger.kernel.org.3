Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2247654430A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiFIFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiFIFTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:19:46 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97F28ABFC;
        Wed,  8 Jun 2022 22:19:44 -0700 (PDT)
Date:   Wed, 8 Jun 2022 22:19:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654751982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DZpV+uN4f8trR7cow66ys5/tS3rIS+dNuOhVPIRE2k=;
        b=W9bp2FmIJi7K+/8TUdK5q7lcneNLnYwU6QHv0HLZeKir4zoJeheew3c5M1dYeCArwMNBpf
        SPPIafp8RWt82YGZWJGk2UBT6UTR3iNh12GFBOuAG9F37WUD2Ukm0TF8mgJ5bNOceGPbur
        WzH074nFiKk3BXw25D/s+lLq0ZlzIVM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
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
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [next] arm64: boot failed - next-20220606
Message-ID: <YqGC5NxDm1WyOHcw@carbon>
References: <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au>
 <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
 <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
 <44530040-0384-796e-143f-b7293886753c@huawei.com>
 <6763271f-6f65-b83a-6892-dbd502368f5e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6763271f-6f65-b83a-6892-dbd502368f5e@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:43:00PM +0800, Kefeng Wang wrote:
> 
> On 2022/6/9 11:44, Kefeng Wang wrote:
> > 
> > On 2022/6/9 10:49, Vasily Averin wrote:
> > > Dear ARM developers,
> > > could you please help me to find the reason of this problem?
> > Hi,
> > > mem_cgroup_from_obj():
> > > ffff80000836cf40:       d503245f        bti     c
> > > ffff80000836cf44:       d503201f        nop
> > > ffff80000836cf48:       d503201f        nop
> > > ffff80000836cf4c:       d503233f        paciasp
> > > ffff80000836cf50:       d503201f        nop
> > > ffff80000836cf54:       d2e00021        mov     x1,
> > > #0x1000000000000            // #281474976710656
> > > ffff80000836cf58:       8b010001        add     x1, x0, x1
> > > ffff80000836cf5c:       b25657e4        mov     x4,
> > > #0xfffffc0000000000         // #-4398046511104
> > > ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
> > > ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
> > > ffff80000836cf68:       8b040022        add     x2, x1, x4
> > > ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]
> > > 
> > > x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
> > > x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740
> > > 
> > > x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
> > > according to System.map it is init_net
> > > 
> > > This issue is caused by calling virt_to_page() on address of static
> > > variable init_net.
> > > Arm64 consider that addresses of static variables are not valid
> > > virtual addresses.
> > > On x86_64 the same API works without any problem.
> > > 
> > > Unfortunately I do not understand the cause of the problem.
> > > I do not see any bugs in my patch.
> > > I'm using an existing API, mem_cgroup_from_obj(), to find the memory
> > > cgroup used
> > > to account for the specified object.
> > > In particular, in the current case, I wanted to get the memory
> > > cgroup of the
> > > specified network namespace by the name taken from for_each_net().
> > > The first object in this list is the static structure unit_net
> > 
> > root@test:~# cat /proc/kallsyms |grep -w _data
> > ffff80000a110000 D _data
> > root@test:~# cat /proc/kallsyms |grep -w _end
> > ffff80000a500000 B _end
> > root@test:~# cat /proc/kallsyms |grep -w init_net
> > ffff80000a4eb980 B init_net
> > 
> > the init_net is located in data section, on arm64, it is allowed by
> > vmalloc, see
> > 
> >     map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0,
> > 0);
> > 
> > and the arm has same behavior.
> > 
> > We could let init_net be allocated dynamically, but I think it could
> > change a lot.
> > 
> > Any better sugguestion, Catalin?
> 
> or  add vmalloc check in mem_cgroup_from_obj()?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 27cebaa53472..fb817e5da5f0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2860,7 +2860,10 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>         if (mem_cgroup_disabled())
>                 return NULL;
> 
> -       folio = virt_to_folio(p);
> +       if (unlikely(is_vmalloc_addr(p)))
> +               folio = page_folio(vmalloc_to_page(p));
> +       else
> +               folio = virt_to_folio(p);
> 
>         /*
>          * Slab objects are accounted individually, not per-page.
> 

It sounds right. Later we can add something like mem_cgroup_from_slab_obj()
to use on hot paths and avoid this check.
