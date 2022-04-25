Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A150E46F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiDYPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiDYPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:32:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B910F3AC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650900560; x=1682436560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0GDQj58/ILWl4MZTREe62fOIDZzmstbJgN8ixfUIGG8=;
  b=FMxIzJJLnGYiM7yV4jlsWfkdXS0AcFhusS5JEajTcItE2x5xGC7TKjUF
   nYs6BuPq1CFyjt6TUU6iVjp0l2sk+5vmUI/pjPtSQrk6vGu0a5k4U+ieL
   V53SVsKZHLTNGWURGrwBIREn5mAkSZ10E/PVtztETK4gWkKoWMyui/sfI
   nVFrOV18flIx11j/tAamiLpgO/KonM4FCtUEXfQ0BTlpNvn1GUnU3wvPh
   WnWxWonvt02n5MUcoFPKFBXeK3b0IZOYmB7wTaZS/8FF2g3z6hk1XKPjk
   18Iwyy807d1g5xi460Llm1Y9+HeYbrvJxN5gfAMAig1Z9iTli1nH5CJdV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265081905"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="265081905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:29:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="677259037"
Received: from kruparel-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.188.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:29:19 -0700
Date:   Mon, 25 Apr 2022 08:29:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
Message-ID: <Yma9zvvuZGyAeRBG@iweiny-desk3>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com>
 <3990312.6PsWsQAL7t@leap>
 <alpine.DEB.2.22.394.2204201556330.2937@hadrien>
 <2538961.9Mp67QZiUf@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2538961.9Mp67QZiUf@leap>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:07:36PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 20 aprile 2022 15:57:14 CEST Julia Lawall wrote:
> > 
> > On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
> > 
> > > On mercoledì 20 aprile 2022 15:40:10 CEST Julia Lawall wrote:
> > > >
> > > > On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
> > > >
> > > > > On mercoledì 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
> > > > > >
> > > > > > On Wed, 20 Apr 2022, Alaa Mohamed wrote:
> > > > > >
> > > > > > > kmap() is being deprecated and these usages are all local to 
> the
> > > thread
> > > > > > > so there is no reason kmap_local_page() can't be used.
> > > > > > >
> > > > > > > Replace kmap() calls with kmap_local_page().
> > > > > >
> > > > > > OK, so from a Coccinelle point of view, could we do
> > > > > >
> > > > > > @@
> > > > > > expression e1,e2,x,f;
> > > > > > @@
> > > > > >
> > > > > > e1 =
> > > > > > - kmap
> > > > > > + kmap_local_page
> > > > > >     (e2)
> > > > > > ... when != x = e1 // not stored in any location and not passed 
> to
> > > > > another function
> > > > > >     when != f(...,e1,...)
> > > > > >     when != x = e2
> > > > > >     when != f(...,e2,...)
> > > > > > -kunmap(e2)
> > > > > > +kunmap_local(e1)
> > > > > >
> > > > > > julia
> > > > > >
> > > > >
> > > > > I've never spent sufficient time to understand properly the syntax 
> and
> > > > > semantics of expressions of Coccinelle. However, thanks Julia, this
> > > code
> > > > > looks good and can be very helpful.
> > > > >
> > > > > Only a minor objection... it doesn't tell when 'e2' has been 
> allocated
> > > > > within the same function where the kmap() call is.
> > > > >
> > > > > In the particular case that I cite above, I'd prefer to remove the
> > > > > allocation of the page (say with alloc_page()) and convert kmap() /
> > > kunmap()
> > > > > to use kmalloc() / kfree().
> > > > >
> > > > > Fox example, this is done in the following patch:
> > > > >
> > > > > commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from
> > > > > sgx_ioc_enclave_init()") from Ira Weiny.
> > > > >
> > > > > Can Coccinelle catch also those special cases where a page that is
> > > passed
> > > > > to kmap() is allocated within that same function (vs. being passed 
> as
> > > > > argument to this function) and, if so, propose a replacement with
> > > > > kmalloc()?
> > > >
> > > > It looks complex in this case, because the allocation is in another
> > > > function, and it is passed to another function.
> > >
> > > This is not the special case I was talking about. In this case your 
> code
> > > for Coccinelle tells the right proposal and it is exactly what Alaa did 
> in
> > > her patch (which is good!).
> > >
> > > I'm talking about other special cases like the one I pointed to with 
> the
> > > link I provided. I'm sorry if my bad English made you think that Alaa's
> > > patch was one of those cases where the page is allocated within the 
> same
> > > function where kmap() is.
> > >
> > > I hope that now I've been clearer :)
> > 
> > Ah, sorry for the misunderstanding.  If you have an example, I can take a
> > look and propose something for this special case.
> > 
> > julia
> 
> Yes, I have the example that you are asking for. It's that commit 
> 633b0616cfe0 from Ira Weiny.
> 
> Let me copy and paste it here for your convenience...
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/
> ioctl.c
> index 90a5caf76939..2e10367ea66c 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -604,7 +604,6 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, 
> void __user *arg)
>  {
>         struct sgx_sigstruct *sigstruct;
>         struct sgx_enclave_init init_arg;
> -       struct page *initp_page;
>         void *token;
>         int ret;
>  
> @@ -615,11 +614,15 @@ static long sgx_ioc_enclave_init(struct sgx_encl 
> *encl, void __user *arg)
>         if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
>                 return -EFAULT;
>  
> -       initp_page = alloc_page(GFP_KERNEL);
> -       if (!initp_page)
> +       /*
> +        * 'sigstruct' must be on a page boundary and 'token' on a 512 byte
> +        * boundary.  kmalloc() will give this alignment when allocating
> +        * PAGE_SIZE bytes.
> +        */
> +       sigstruct = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +       if (!sigstruct)
>                 return -ENOMEM;
>  
> -       sigstruct = kmap(initp_page);
>         token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
>         memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
>  
> @@ -645,8 +648,7 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, 
> void __user *arg)
>         ret = sgx_encl_init(encl, sigstruct, token);
>  
>  out:
> -       kunmap(initp_page);
> -       __free_page(initp_page);
> +       kfree(sigstruct);
>         return ret;
>  }
> 
> I think that Coccinelle might understand that "initp_page" is allocated in 
> the same function where later it is kmap()'ed. But I'm not able to write a 
> Coccinelle check to find out these kinds of special cases. In these cases 
> the correct solution is not to use kmap_local_page(). Instead delete the 
> alloc_page() and use kmalloc().
>

Sorry about missing this thread last week...

I've lost the Coccinelle scripts I wrote before but the ones which helped were
documented in patches I submitted when Coccinelle was used.

I think Coccinelle can help a lot.  And probably a lot more than I know since
I'm not an expert in the language either.

However, In addition to the example Fabio shows above here are a few other
things to look out for when writing Coccinelle scripts.

1) The addition of mem*_page() functions means sometimes the entire kmap/kunmap
   can be removed.  Check out the Coccinelle script for that.[1]

2) kunmap_local() has ordering rules which often requires some manual
   review.[2]

3) kmap/kunmap is often wrapped in other subsystem helper functions.  I was not
   sure how to deal with that in Coccinelle.  Julia is this easy in
   Coccinelle?[3]


Ira


[1]
https://lore.kernel.org/lkml/20210205232304.1670522-3-ira.weiny@intel.com/
https://lore.kernel.org/lkml/20210205232304.1670522-5-ira.weiny@intel.com/

[2]
https://lore.kernel.org/lkml/20210217024826.3466046-3-ira.weiny@intel.com/
https://lore.kernel.org/lkml/20210217024826.3466046-4-ira.weiny@intel.com/

[3]
https://lore.kernel.org/lkml/20210217024826.3466046-5-ira.weiny@intel.com/

> 
> Thanks,
> 
> Fabio
> 
> 
> 
