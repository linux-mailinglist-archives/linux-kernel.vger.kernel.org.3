Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020835450B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbiFIPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiFIPXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:23:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17CF1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:23:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w21so21404666pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV7RC7djtxI0kHw5S5FDRQb2joRqGeuY1mF5zw0phKk=;
        b=lSf0tQldx/w/ULdeiOjWFksRRZOHkwFQ+zi7S6eUMpPE+euTNq3HfakFsiKn+akZgA
         BYsNOZN6AKF8VG7tGzdoYC3XsUS9zpNzK4OTBz8SkU/vOjzA6DCrzImFZh8K5L5045nO
         gtaGCeNE0sEYaJtDzQI5dYct1BCJ/LUA0kDrZ29TbBynMGr3m+1dUjIO/8+rinAeI8Ge
         ZM4yM/D1Q/S8svh4b8VSGnrbrPC6w7hLXcJ2xNJO9bZ0AbME7FRMvC58Wsw5XYedMd43
         VYw31UYqRn0Gr/rFapRiPydIJmWwSdOVdFFbZ/5OT8ysrKDH3W9qbrHeYJTS7UfCRGnm
         J0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV7RC7djtxI0kHw5S5FDRQb2joRqGeuY1mF5zw0phKk=;
        b=ri5AEYXhDyVEcknPKs+OvaCVQx95XEZCnd7nxGgb/HhAc4immX4kQTPDLAhe5oYya/
         Nh/1IEyAe0dRQRM/fUVj2xXEhFzgczdz8UgR59Eq21U0Xz2+tK6uS/TWUKCiSVb0WBcV
         VVSrwz6ITDNO7w4rF6XRGx5KNwRhAGS2J+jpwDQS3TSDt8Xr8RAQihDVnVVYOmbVDbrp
         sookMM5Qvm2LgoR0KgZaaskCtMLsDlX+AlYxNIHf3YeJtbheF48uvU8X7fFb6Xghn5if
         wLmp1s1yW1HQ9GhF6c2QpONL4gAnsPpP8g30XWkCC4dct2cE9RI4WUBZFinoIKZpH/Pq
         z1og==
X-Gm-Message-State: AOAM5335FBgeDuSZsbPKaK7pTMQ4mEm0ejG4fa41kyuwJgka/Ljsc27h
        JK/1CFuGaTTCjAn8F+P42vVHIFCseCZfFh6E2aIuJg==
X-Google-Smtp-Source: ABdhPJy/KwvUBHnh2VRlvCqbK+o5hSwHlwE0i9AJu6gcHX/fyizWfCV7lcs5p6BiMXf7TYQ8FWcrUdEhtuopEnRW2Zg=
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id
 q9-20020a056a00088900b0051091e66463mr40895230pfj.58.1654788216841; Thu, 09
 Jun 2022 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au> <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
 <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org> <44530040-0384-796e-143f-b7293886753c@huawei.com>
 <20220609101153.GB2187@willie-the-truck> <YqHKs19RBubUNrve@arm.com>
In-Reply-To: <YqHKs19RBubUNrve@arm.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 Jun 2022 08:23:25 -0700
Message-ID: <CALvZod4ukk_iSytn7v_aTdU4XQ2Xs7YK8Fq_PogtN9ARGL9urA@mail.gmail.com>
Subject: Re: [next] arm64: boot failed - next-20220606
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vasily Averin <vvs@openvz.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 3:26 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Jun 09, 2022 at 11:11:54AM +0100, Will Deacon wrote:
> > On Thu, Jun 09, 2022 at 11:44:09AM +0800, Kefeng Wang wrote:
> > > On 2022/6/9 10:49, Vasily Averin wrote:
> > > > mem_cgroup_from_obj():
> > > > ffff80000836cf40:       d503245f        bti     c
> > > > ffff80000836cf44:       d503201f        nop
> > > > ffff80000836cf48:       d503201f        nop
> > > > ffff80000836cf4c:       d503233f        paciasp
> > > > ffff80000836cf50:       d503201f        nop
> > > > ffff80000836cf54:       d2e00021        mov     x1, #0x1000000000000            // #281474976710656
> > > > ffff80000836cf58:       8b010001        add     x1, x0, x1
> > > > ffff80000836cf5c:       b25657e4        mov     x4, #0xfffffc0000000000         // #-4398046511104
> > > > ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
> > > > ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
> > > > ffff80000836cf68:       8b040022        add     x2, x1, x4
> > > > ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]
> > > >
> > > > x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
> > > > x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740
> > > >
> > > > x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
> > > > according to System.map it is init_net
> > > >
> > > > This issue is caused by calling virt_to_page() on address of static variable init_net.
> > > > Arm64 consider that addresses of static variables are not valid virtual addresses.
> > > > On x86_64 the same API works without any problem.
> >
> > This just depends on whether or not the kernel is running out of the linear
> > mapping or not. On arm64, we use the vmalloc area for the kernel image and
> > so virt_to_page() won't work, just like it won't work for modules on other
> > architectures.
> >
> > How are module addresses handled by mem_cgroup_from_obj()?
>
> It doesn't look like they are handled in any way. It just expects the
> pointer to be a linear map one.

Yes, that is correct.

> Something like below:
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 27cebaa53472..795bf3673fa7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2860,6 +2860,11 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>         if (mem_cgroup_disabled())
>                 return NULL;
>
> +       if (is_module_address((unsigned long)p))
> +               return NULL;
> +       else if (is_kernel((unsigned long)p))
> +               return NULL;
> +

How about just is_vmalloc_addr(p) check? It should cover modules and
also arm64 using vmalloc for kernel image cases.

>         folio = virt_to_folio(p);
>
>         /*
>
> --
> Catalin
