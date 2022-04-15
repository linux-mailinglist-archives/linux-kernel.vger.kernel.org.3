Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97F1502A56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353905AbiDOMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbiDOMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:39:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5605C9B6B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650026230; x=1681562230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w+XDpmr+jFjSlmGjB+amwAH4Rfhi8cJjFE5vaPuGp/A=;
  b=nZVRkW3Mzlz8ujnN8mdXSq/a1tM7WoT9oYtziNBR5ckhucS565lDFQpH
   EFb1ZCZUU4Lc9q2hK9DXmf0b5+s8XJD5C1qz4kLun7AyX3qWXUb6hn6lF
   1qh599tEFL6kqSgR06JCpxyhSX4IyO7kqRSsh30k6VIAZbu1THzaJ6AsM
   lauOcIqQdahrFeiHWdd3TOveichah7hrLwnxhqva+uaMAfk+A6jJo402e
   fVPpFUgAc1FsP9o1uw+lbuhXGG2wjqWXUM+A3ukbchf2RgnAYAAck+A3p
   B3W1qR3kbWnLgCIZ3jmYtdapoD/nR+lxD4gEIhR05R3p5S3EaYu9m8PgI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="326051050"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="326051050"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 05:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="508930396"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 05:37:09 -0700
Date:   Fri, 15 Apr 2022 05:37:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhangfei,

On Fri, Apr 15, 2022 at 07:52:03PM +0800, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/4/15 下午6:50, Fenghua Yu wrote:
> > Hi, Zhangfei,
> > 
> > On Fri, Apr 15, 2022 at 06:14:09PM +0800, zhangfei.gao@foxmail.com wrote:
> > I download this patch from:
> > https://lore.kernel.org/lkml/YllADL6uMoLllzQo@fyu1.sc.intel.com/raw
> > git am to either v5.18-rc2 or the latest upstream without any issue.
> It is my copy paste issue.
> 
> I have tested, nginx woks well.

Great!

> 
> Other than the following issue,
> Each time /sbin/nginx will alloc ioasid but not free.
> which I think it maybe nginx issue or the mis-usage, will ask there.

Which nginx/openssl function is supposed to call kernel sva_unbind? I couldn't
find the function in nginx tree.

If nginx doesn't free ioasid, it will cause ioasid leak and memory leak.

> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thank you for your testing!

> 
> > 
> > > It should work for arm.
> > > 
> > > In fact I have a similar patch at hand but pending since I found an issue.
> > > 
> > > I start & stop nginx via this cmd.
> > > //start
> > > sudo sbin/nginx                    // this alloc an ioasid=1
> > > //stop
> > > sudo sbin/nginx -s quit    // this does not free ioasid=1, but still alloc
> > > ioasid=2.
> > > So ioasid will keep allocated but not freed if continue start/stop nginx,
> > > though not impact the nginx function.
> > > 
> > > stop nginx with -s quit still calls
> > > src/core/nginx.c
> > > main -> ngx_ssl_init -> openssl engine:    bind_fn -> ... -> alloc asid
> > > But openssl engine: ENGINE_free is not called
> > > 
> > > Still in checking nginx code.
> > > 
> > > Or do you test with nginx?
> > On my X86 machine, nginx doesn't trigger the kernel sva binding function
> > to allocate ioasid. I tried pre- nstalled nginx/openssl and also tried my built
> > a few versions of nginx/openssl. nginx does call OPENSSL_init_ssl() but
> > doesn't go to the binding function. Don't know if it's my configuration issue.
> > Maybe you can give me some advice?
> I am using openssl engine, which use crypto driver and using sva via uacce.
> nginx -> openssl -> openssl engine -> sva related.

I'll do more nginx experiments.

> 
> > 
> > I test the patch with a few internal test tools and observe mmget()/mmput()
> > works fine in various cases.
> OK, thanks

Thank you very much!

-Fenghua
