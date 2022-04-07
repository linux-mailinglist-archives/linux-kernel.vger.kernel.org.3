Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882894F7EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiDGM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiDGM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:29:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD49527C0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:27:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h19so5316802pfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e4vDhMzvy3YOkQ9zBYte/XQ0KAaKC9sgRay0l4XcsQ4=;
        b=Bqewqm4sEfX65AFnOPS0H7hoOh025r+5pYa8XlINcT2djuUhGa6YdGxA9fbeqTDjyg
         KNtHn/NyR4r8d1UtL+8HCu4ZpWyiP9m8nMNO03pun9+9VycNNhbAm+kV+OdaSmYBIG/2
         hUS/5hyIarlKQ8/ItJ8HSwmZvo+skzd3cQqErxhDDrFnII7RLenCkb+HhEO7SUE8qZy7
         a/KoPg3mdOYv/v1mngtLvR7tSu5EKLzMuaNP+yUg78pVzp8wra7ZbIL5ZZAhfuPOnJd9
         n09rOzspRyLAXyB4z8aS6blEAkmGjgvVil66LuisUz6u+DUJA8sR4XtiZgfvc5dGa4KV
         Q5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4vDhMzvy3YOkQ9zBYte/XQ0KAaKC9sgRay0l4XcsQ4=;
        b=jmsLhe015ofVkBJAI0//TWVO1/Pzy1C69sjpPVXPLOSuYOUOFtYhW2PULUARmVsAZQ
         vd0YW274R8QGHAPMPJzcIkzm1PK4YH8sgxWVn73RclUD+/vAYkGneBKfVFOFnDBX1Zqw
         m4gP3dGO1PK9eGVhgyYA+xcjsb3P+h5RJD2XEaQWrLaKUlEtzWh20/6s+yqlDkQ7PUDR
         2Ewt75SFAxnFyUfiOqpOimNs5BAlci+5oU64Mx2bHQUJM0e8ZcR5B/Qh3/CDEUkznYfN
         GZNgG/tbndjtHEQUljYqVjbj+4cqJ6yP60wl1SGWf9tBQzA0hWNXhG7LvB6ZkQoheTTX
         k3Cg==
X-Gm-Message-State: AOAM5330vV+iTN2AREy+EY7jZpx2LDhe05UNh6BYRd1crLfw6wgvumbp
        c7CyPh8puFyhMGHVMiqFCKo=
X-Google-Smtp-Source: ABdhPJwOlATfxqxS2ks4E6hH4T/LM8RgkhDLs8dUgp/0TaEV149xG1yRI4wgWT+SoUXPa+Z/j0poHw==
X-Received: by 2002:a63:5317:0:b0:399:58e9:882b with SMTP id h23-20020a635317000000b0039958e9882bmr11120930pgb.306.1649334422001;
        Thu, 07 Apr 2022 05:27:02 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056a00300900b004fae1346aa1sm20786357pfb.122.2022.04.07.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:27:00 -0700 (PDT)
Date:   Thu, 7 Apr 2022 21:26:53 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Message-ID: <Yk7YjeXDYRJwt7zb@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-9-catalin.marinas@arm.com>
 <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yk6lz0UYyKIv5ibI@arm.com>
 <Yk6sWNBSwNRbLdfZ@hyeyoo>
 <Yk6wSNz38Bv1lrmB@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk6wSNz38Bv1lrmB@arm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:35:04AM +0100, Catalin Marinas wrote:
> On Thu, Apr 07, 2022 at 06:18:16PM +0900, Hyeonggon Yoo wrote:
> > On Thu, Apr 07, 2022 at 09:50:23AM +0100, Catalin Marinas wrote:
> > > On Thu, Apr 07, 2022 at 03:46:37AM +0000, Hyeonggon Yoo wrote:
> > > > On Tue, Apr 05, 2022 at 02:57:56PM +0100, Catalin Marinas wrote:
> > > > > --- a/mm/slab_common.c
> > > > > +++ b/mm/slab_common.c
> > > > > @@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
> > > > >  	}
> > > > >  }
> > > > >  
> > > > > -static void __init
> > > > > +unsigned int __weak arch_kmalloc_minalign(void)
> > > > > +{
> > > > > +	return ARCH_KMALLOC_MINALIGN;
> > > > > +}
> > > > > +
> > > > 
> > > > As ARCH_KMALLOC_ALIGN and arch_kmalloc_minalign() may not be same after
> > > > patch 10, I think s/ARCH_KMALLOC_ALIGN/arch_kmalloc_minalign/g
> > > > for every user of it would be more correct?
> > > 
> > > Not if the code currently using ARCH_KMALLOC_MINALIGN needs a constant.
> > > Yes, there probably are a few places where the code can cope with a
> > > dynamic arch_kmalloc_minalign() but there are two other cases where a
> > > constant is needed:
> > > 
> > > 1. As a BUILD_BUG check because the code is storing some flags in the
> > >    bottom bits of a pointer. A smaller ARCH_KMALLOC_MINALIGN works just
> > >    fine here.
> > > 
> > > 2. As a static alignment for DMA requirements. That's where the newly
> > >    exposed ARCH_DMA_MINALIGN should be used.
> > > 
> > > Note that this series doesn't make the situation any worse than before
> > > since ARCH_DMA_MINALIGN stays at 128 bytes for arm64. Current users can
> > > evolve to use a dynamic alignment in future patches. My main aim with
> > > this series is to be able to create kmalloc-64 caches on arm64.
> > 
> > AFAIK there are bunch of drivers that directly calls kmalloc().
> 
> Well, lots of drivers call kmalloc() ;).
> 
> > It becomes tricky when e.g.) a driver allocates just 32 bytes,
> > but architecture requires it to be 128-byte aligned.
> 
> That's the current behaviour, a 32 byte allocation would return an
> object from kmalloc-128. I want to reduce this to at least kmalloc-64
> (or smaller) if the CPU/SoC allows it.

Yeah I agree the change is worth :) Thanks for the work.

> > That's why everything allocated from kmalloc() need to be aligned in
> > ARCH_DMA_MINALIGN.
> 
> I don't get your conclusion here. Would you mind explaining?

What I wanted to say was that, why ARCH_DMA_MINALIGN should be
different from ARCH_KMALLOC_MINALIGN.

I thought the two were basically same thing. Instead of
decoupling them, I thought just decreasing them in runtime makes more sense.

> > So I'm yet skeptical on decoupling ARCH_DMA/KMALLOC_MINALIGN. Instead
> > of decoupling it, I'm more into dynamically decreasing it.
> 
> The reason for decoupling is mostly that there are some static uses of
> ARCH_KMALLOC_MINALIGN as per point 1 above. The other is the
> __assume_kmalloc_alignment attribute. We shouldn't have such assumed
> alignment larger than what a dynamic kmalloc() would return. To me it
> makes a lot more sense for ARCH_KMALLOC_MINALIGN to be the minimum
> guaranteed in a kernel build but kmalloc() returning a larger alignment
> at run-time than the other way around.

But yeah, considering the problems you mentioned, it seems unavoidable
to decouple them.

Thank you for explanation and I will review slab part soon.

> Thanks.
> 
> -- 
> Catalin

-- 
Thanks,
Hyeonggon
