Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3B5448C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiFIK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiFIK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:26:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFD312D140;
        Thu,  9 Jun 2022 03:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D46BB82C86;
        Thu,  9 Jun 2022 10:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D37CC34114;
        Thu,  9 Jun 2022 10:25:58 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:25:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vasily Averin <vvs@openvz.org>,
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
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [next] arm64: boot failed - next-20220606
Message-ID: <YqHKs19RBubUNrve@arm.com>
References: <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
 <20220607162504.7fd5a92a@canb.auug.org.au>
 <CALvZod5XBjw7MZfYSNv-UnE7pHMKTquUNomqyC5T05Qu_ef6Zw@mail.gmail.com>
 <CALvZod4DhM00LXsPty=cnYyv3Ci5YS5otasu_tr9o7ujQekKLw@mail.gmail.com>
 <CA+G9fYve1faH7AmpEa-p_ySb_WCgc4DdjqyS6fSdiJYsaEi=rA@mail.gmail.com>
 <CALvZod72bp9ejY+KghaUGkoXDrOMMbs_ofsopGib=MY4jzhRkg@mail.gmail.com>
 <CA+G9fYu6mayYrrYK+0Rn1K7HOM6WbaOhnJSx-Wv6CaKBDpaT2g@mail.gmail.com>
 <2a4cc632-c936-1e42-4fdc-572334c58ee1@openvz.org>
 <44530040-0384-796e-143f-b7293886753c@huawei.com>
 <20220609101153.GB2187@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609101153.GB2187@willie-the-truck>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:11:54AM +0100, Will Deacon wrote:
> On Thu, Jun 09, 2022 at 11:44:09AM +0800, Kefeng Wang wrote:
> > On 2022/6/9 10:49, Vasily Averin wrote:
> > > mem_cgroup_from_obj():
> > > ffff80000836cf40:       d503245f        bti     c
> > > ffff80000836cf44:       d503201f        nop
> > > ffff80000836cf48:       d503201f        nop
> > > ffff80000836cf4c:       d503233f        paciasp
> > > ffff80000836cf50:       d503201f        nop
> > > ffff80000836cf54:       d2e00021        mov     x1, #0x1000000000000            // #281474976710656
> > > ffff80000836cf58:       8b010001        add     x1, x0, x1
> > > ffff80000836cf5c:       b25657e4        mov     x4, #0xfffffc0000000000         // #-4398046511104
> > > ffff80000836cf60:       d34cfc21        lsr     x1, x1, #12
> > > ffff80000836cf64:       d37ae421        lsl     x1, x1, #6
> > > ffff80000836cf68:       8b040022        add     x2, x1, x4
> > > ffff80000836cf6c:       f9400443        ldr     x3, [x2, #8]
> > > 
> > > x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 : ffff80000ad5e680
> > > x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 : ffff80000af09740
> > > 
> > > x0 = 0xffff80000af09740 is an argument of mem_cgroup_from_obj()
> > > according to System.map it is init_net
> > > 
> > > This issue is caused by calling virt_to_page() on address of static variable init_net.
> > > Arm64 consider that addresses of static variables are not valid virtual addresses.
> > > On x86_64 the same API works without any problem.
> 
> This just depends on whether or not the kernel is running out of the linear
> mapping or not. On arm64, we use the vmalloc area for the kernel image and
> so virt_to_page() won't work, just like it won't work for modules on other
> architectures.
> 
> How are module addresses handled by mem_cgroup_from_obj()?

It doesn't look like they are handled in any way. It just expects the
pointer to be a linear map one. Something like below:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 27cebaa53472..795bf3673fa7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2860,6 +2860,11 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	if (mem_cgroup_disabled())
 		return NULL;
 
+	if (is_module_address((unsigned long)p))
+		return NULL;
+	else if (is_kernel((unsigned long)p))
+		return NULL;
+
 	folio = virt_to_folio(p);
 
 	/*

-- 
Catalin
