Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B884C0A56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiBWDie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiBWDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:38:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686238DB0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:38:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w2so1873532pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ss9CQrenCYzdH6jACZIdZ+kxt5gNMEdsRLw6I3i9fX0=;
        b=iy5enKrskamRDHG9md1KL6LdriZXhQfHRz/GSD8J/gcEaKfg3eHtAZosqmJVbebNId
         B3SG5KNQpBqbrZijZHaYWVzA9ZjJHP0a4PtFEDVLcX4qo+CRoxYoX8CIaUkOl1Byf14W
         7qeYfHpaaFVT1DV9tDvQH0xLnFRFzfDz6hKOVmXJvO7PNkOg0ywF127KhDe8MTHgdPiJ
         fBOUn0tEzk1N0nfN+TWk1AmtxT4R0C4+lme4mNf29A5yTT2tn+qb8kKax5jHek6hclPI
         Nug5OjJ3YCmoLKpKJ4/gmcR59pMun3cLZVyewnkYcwmM6av3TWwQDPB34svSObTtEnwg
         Xz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ss9CQrenCYzdH6jACZIdZ+kxt5gNMEdsRLw6I3i9fX0=;
        b=PfaBi2p9F5GIGW+BK7cJKKaMxnnblNy6j+/MHPil6bfQgmSbs2I+pduBwlh1Xn9D8I
         g/q272GEib9kUNVVRArAcS5rvSYCRB0AAXlFzY6n/QdlGfLbjk2JrzBfjc6+McUqk+Ch
         EFjIHkQ7LhTc+SKXbAD3eg3350pzvAdzNZzysWvs9x8+XZ0yHECteTl2fagidcCeUvJB
         wia1gaWm5HqJFTvnfJxf+InmNoTYYZBtv8w+82DH/C/JacH3yXECDHsfDmnRTUbHb91C
         J5hOJcpEp8aOHMS2Bkz57jQNdrksDCRkZ1ONXYNRmlpR67D0SSbpvP9GDTeq7uear8t0
         zgjw==
X-Gm-Message-State: AOAM530//2exeqAhyFYt4tGVu07nzt+VNG3J3xYtJnqMq0C9770VvLDP
        N8bBFk0QoFxLdYVQWeR9kYc=
X-Google-Smtp-Source: ABdhPJzhF40IC+0CpRZ1jtWjnsQVBe912GBg3fk2d++1drpatXPmO+YGep9hXsTTkCLol03Yo+NM3g==
X-Received: by 2002:a63:6982:0:b0:373:494a:22ae with SMTP id e124-20020a636982000000b00373494a22aemr22108252pgc.624.1645587483892;
        Tue, 22 Feb 2022 19:38:03 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id nr11-20020a17090b240b00b001b9e24b16basm1141248pjb.0.2022.02.22.19.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:38:03 -0800 (PST)
Date:   Wed, 23 Feb 2022 03:37:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 4/5] mm/slub: Limit min_partial only in cache creation
Message-ID: <YhWsF/Bz89LpLa/g@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-5-42.hyeyoo@gmail.com>
 <91cc8ab-a0f0-2687-df99-10b2267c7a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cc8ab-a0f0-2687-df99-10b2267c7a9@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 03:48:16PM -0800, David Rientjes wrote:
> On Mon, 21 Feb 2022, Hyeonggon Yoo wrote:
> 
> > SLUB sets number of minimum partial slabs for node (min_partial) using
> > set_min_partial(). SLUB holds at least min_partial slabs even if they're empty
> > to avoid excessive use of page allocator.
> > 
> > set_min_partial() limits value of min_partial between MIN_PARTIAL and
> > MAX_PARTIAL. As set_min_partial() can be called by min_partial_store()
> > too, Only limit value of min_partial in kmem_cache_open() so that it
> > can be changed to value that a user wants.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> I think this makes sense and there is no reason to limit the bounds that 
> may be set at runtime with undocumented behavior.

Thank you for comment.

> 
> However, since set_min_partial() is only setting the value in the 
> kmem_cache, could we remove the helper function entirely and fold it into 
> its two callers?

Right. We don't need to separate this as function. I'll update this
in next version. Thanks!

> 
> > ---
> >  mm/slub.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3a4458976ab7..a4964deccb61 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4002,10 +4002,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
> >  
> >  static void set_min_partial(struct kmem_cache *s, unsigned long min)
> >  {
> > -	if (min < MIN_PARTIAL)
> > -		min = MIN_PARTIAL;
> > -	else if (min > MAX_PARTIAL)
> > -		min = MAX_PARTIAL;
> >  	s->min_partial = min;
> >  }
> >  
> > @@ -4184,6 +4180,8 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >  
> >  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  {
> > +	int min_partial;
> > +
> >  	s->flags = kmem_cache_flags(s->size, flags, s->name);
> >  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> >  	s->random = get_random_long();
> > @@ -4215,7 +4213,10 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  	 * The larger the object size is, the more slabs we want on the partial
> >  	 * list to avoid pounding the page allocator excessively.
> >  	 */
> > -	set_min_partial(s, ilog2(s->size) / 2);
> > +	min_partial = min(MAX_PARTIAL, ilog2(s->size) / 2);
> > +	min_partial = max(MIN_PARTIAL, min_partial);
> > +
> > +	set_min_partial(s, min_partial);
> >  
> >  	set_cpu_partial(s);
> >  
> > -- 
> > 2.33.1
> > 
> >

-- 
Hyeonggon
