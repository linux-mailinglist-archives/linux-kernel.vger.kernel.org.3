Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172F515C92
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiD3LyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiD3Lx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:53:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA81183B6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:50:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e24so9169406pjt.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lt3kuWafWjkHObNCFDZ+lBWwcdfVn/Z+mxQOXhxUeu4=;
        b=HbL5cUVwwiqUAl9N5LPUP5WdnwClowGeLSRI7zzPqMzBFMcLs3GwOVufjwlQDwzApN
         RRmdMPmBNr92Qxn7BcmZrNAU46ogXz3lTtFOPKEng1n4jhbfqxd3m5nzDu87RzIcTmC4
         hp11otctlfZ1Q0LYyLe6pIg962H7Nl7FixeS7lKc/ydB0epPrmiyRk/aVANLjBxTlw7M
         /szdmk7ks9TOakYMblDX4MMfJaMiB7PWLkECzanHZfEZakU8UarE9nGfULWgUi18m8W/
         KVRsNxFz3JroMgXmuxiD3XLGDrWNm7OUuaDw75ZKjWwQXO0s9f/J4j4oa+WEkfWzGyR8
         xc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lt3kuWafWjkHObNCFDZ+lBWwcdfVn/Z+mxQOXhxUeu4=;
        b=o7Bc9PYX7RRNBWYHZAJFFYd/VXGs6yeZpD0xc0sATWc3SYfdVY5FbpGwraCd+wKWFN
         Q136kS44bNtTK8tlcwLH2FeAVwob14rg3ZqG67K4nriO5vaofPcmrmLijP98p9pIYenO
         hWJYK7UWctyL1/MMdoVZ5QdE4jvXwFW4eXRYVRcUQWZQW9mwsbrERfJD8JBi6J0kwHg3
         iOPbyflw7RFEfzR3fN/TPC/tXhoERHqzaW5qCExwc8nmay0bQR8IHLCzPljuhwejpkru
         KreyEx5yyGJHoJilXLRa31gJFx74lJkRQBeOdJS5heXKS+05G+iQB/3lSVROmvm2MS2g
         fIDA==
X-Gm-Message-State: AOAM5309/ODlmTL/SWqPfYoVgXKPbnPHNHmJFPn7emQ+Q3u5CAwdYGzM
        gjJxSWVUQSA9cPWnT6OSXro=
X-Google-Smtp-Source: ABdhPJwUDChBL6ttxA7eM5VtrLee1rKvGG5pkPwJq5j/3gHZU/EKsOWzGxmenXKel4CWLBWw1pKBAg==
X-Received: by 2002:a17:90b:4b4b:b0:1ca:bfdb:edce with SMTP id mi11-20020a17090b4b4b00b001cabfdbedcemr8791309pjb.85.1651319434180;
        Sat, 30 Apr 2022 04:50:34 -0700 (PDT)
Received: from ip-172-31-27-201.ap-northeast-1.compute.internal (ec2-18-183-95-104.ap-northeast-1.compute.amazonaws.com. [18.183.95.104])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a6ac600b001dbf2aac185sm5956570pjm.1.2022.04.30.04.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2022 04:50:33 -0700 (PDT)
Date:   Sat, 30 Apr 2022 11:50:28 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <20220430115027.GC24925@ip-172-31-27-201.ap-northeast-1.compute.internal>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-14-42.hyeyoo@gmail.com>
 <5f47bb6b-d7f4-13fc-8d09-e80c9a5185ba@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f47bb6b-d7f4-13fc-8d09-e80c9a5185ba@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:10:00AM +0200, Vlastimil Babka wrote:
> On 4/14/22 10:57, Hyeonggon Yoo wrote:
> > There is not much benefit for serving large objects in kmalloc().
> > Let's pass large requests to page allocator like SLUB for better
> > maintenance of common code.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Some nits:
> 
> > @@ -3607,15 +3607,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
> >  {
> >  	struct kmem_cache *s;
> >  	size_t i;
> > +	struct folio *folio;
> >  
> >  	local_irq_disable();
> >  	for (i = 0; i < size; i++) {
> >  		void *objp = p[i];
> 
> folio can be declared here
> could probably move 's' too, and 'i' to the for () thanks to gnu11
>

Right!

> >  
> > -		if (!orig_s) /* called via kfree_bulk */
> > -			s = virt_to_cache(objp);
> > -		else
> > +		if (!orig_s) {
> > +			folio = virt_to_folio(objp);
> > +			/* called via kfree_bulk */
> > +			if (!folio_test_slab(folio)) {
> > +				local_irq_enable();
> > +				free_large_kmalloc(folio, objp);
> > +				local_irq_disable();
> > +				continue;
> > +			}
> > +			s = folio_slab(folio)->slab_cache;
> > +		} else
> >  			s = cache_from_obj(orig_s, objp);
> 
> This should now use { } brackets per kernel style.
> 

Yes. will do both in v3.

> > +
> >  		if (!s)
> >  			continue;
> >  
