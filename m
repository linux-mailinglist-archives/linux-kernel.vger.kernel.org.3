Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4E5875A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiHBCyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHBCyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:54:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AEF17E36
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:54:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so12314552pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 19:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VepS0pf6a4atZd971NuWbFl/YxaIYnEeNRklOESYwoQ=;
        b=aIMgFg5Mcp5VAH1+yGXzr6Wiq2zIyP2mAIKIpFmhkSFnrJWTYN0+u/YWcyFdKxpg2N
         P0Grm14hQzdZNpaNQ2NfJroY050rOKORL0QwOljWu5+FIkLI7cvTSmkKg9GAuDnHQ0L7
         9JRAAkbbipcStDA3nG9C42x072PHKd9zo01XVX5ZVuUJDP5al22lsXkhuU2c6OqsD8Ik
         eD0xBQ4xM4Prx98nIriLb+8NaoHolPZShxdz4p39gAvZHvRnfl3nle2h5D1LMUGcAAT6
         R1wkp5gKCphmr+9C8QaVYvJALbLi92drgtGo9fwIWJLWhgzWZxBDpCWwQ3WCxp5jwEAm
         //3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VepS0pf6a4atZd971NuWbFl/YxaIYnEeNRklOESYwoQ=;
        b=L7eGbcmeSWWhlXJYLbHEVM5F1rUeNOBGHkf9uWN9w4KPYZC6CeoCOGZdod4XAW0Pzb
         Io4wHcSBzFUpnj2OrxNE/7Dr6VxZVz0Lwgs1LPMfTaFJ4gniFpSkOsDBjhfS9rOB9rCT
         SxAgEvG2SxPYxJbQElh/uBOMp+AXE5JOhbkalbR/mb0CaDaIDH9AGT+lyLIKdP2zpak+
         49DR4U7fe8rIpWqp6qdQ8+LFktkzePZt1RJdIB+rO61RxJUqSoXuCY1uJHXW4To3FmkQ
         bic0rcZuQdXJE3Zua/JuKpdFQNSXrgrInD4gtEo+uOaMJLhY5bTQH0cHezcG2YrbQMoV
         AtfQ==
X-Gm-Message-State: AJIora9RvcW0FaAd8upuzOIeKhsoTkcq5+iLng4FxTV27UtQMrpZ9E+8
        h+wr9PYClsoB7BIU9HpyflA=
X-Google-Smtp-Source: AGRyM1v71zSrDIYf2Hqz2GlUg2dfTbZQDOwslUWYS1u1LGpDxUyHOairM1PxsNobGHx20I9U413IyA==
X-Received: by 2002:a05:6a00:815:b0:52b:8895:a0bd with SMTP id m21-20020a056a00081500b0052b8895a0bdmr18917138pfk.57.1659408859816;
        Mon, 01 Aug 2022 19:54:19 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d25-20020a656219000000b0041c3ab14ca1sm1836514pgv.0.2022.08.01.19.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 19:54:19 -0700 (PDT)
Date:   Tue, 2 Aug 2022 11:54:10 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 06/15] mm/slab_common: fold kmalloc_order_trace() into
 kmalloc_large()
Message-ID: <YuiR0tWqMY+UDU/W@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-7-42.hyeyoo@gmail.com>
 <2e252179-0ffe-0d9c-9340-77e46f6ffdfd@suse.cz>
 <YufUgFX2shlG5FoR@hyeyoo>
 <0ca2f22a-8247-8419-3f99-4456a4c7344a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca2f22a-8247-8419-3f99-4456a4c7344a@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 03:36:48PM +0200, Vlastimil Babka wrote:
> On 8/1/22 15:26, Hyeonggon Yoo wrote:
> > On Thu, Jul 28, 2022 at 05:23:29PM +0200, Vlastimil Babka wrote:
> >> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> >> > There is no caller of kmalloc_order_trace() except kmalloc_large().
> >> > Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().
> >> > 
> >> > Also add tracepoint in kmalloc_large() that was previously
> >> > in kmalloc_order_trace().
> >> > 
> >> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> 
> > 
> > Thank you for review.
> > 
> >> Hmm noticed a small change in how we call trace_kmalloc() which will now
> >> include the __GFP_COMP.
> > 
> > Good catch.
> > 
> >> I think we could just call alloc_pages() from
> >> kmalloc_large() with flags | __GFP_COMP instead of doing flags |=
> >> __GFP_COMP; first.
> > 
> > I'll consider that in next version.
> > 
> >> AFAICS both kasan_kmalloc_large() and kmemleak_alloc()
> >> will filter it out anyway.
> > 
> > AFAIK not passing __GFP_COMP to both kasan_kmalloc_large()
> > and kmemleak_alloc() will affect their behavior.
> 
> You mean "will NOT affect...", right?

Ah, yes. mistake.

> 
> > - kasan_kmalloc_large() only checks if flag has __GFP_DIRECT_RECLAIM,
> > - kmemleak_alloc() only use it to allocate kmemleak_object from
> >   slab/pool, which does not require __GFP_COMP.
> > 
> > simply calling
> > 	alloc_pages() with flags | GFP_COMP
> > 	kasan_kmalloc_large() with flags
> > 	kmemleak_alloc() with flags
> > 	trace_kmalloc() with flags
> > will be okay.
> > 
> > BTW this is fixed after patch 9.
> 
> Ah, right. __kmalloc_large_node_notrace() does the same  flags |=
> __GFP_COMP; but the tracepoint is outside and unaffected.

I'll reflect your suggestion anyway.

-- 
Thanks,
Hyeonggon
