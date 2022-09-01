Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A75A957F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiIALOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiIALOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:14:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2B10A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:14:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so2191580pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ufr8PAssJ+2sWuqaSL6pKbz4KHa/ife9dK3QD3JLZ8o=;
        b=FZFkoAn5Qj3iMquDiobhmdQ1WqC4oHtU9ev9hPhR4WMv2XDmvKGtUiHCvt5haHUzqV
         pCjbIDtdgN0qywPIoZkY3BlxMr31VKG3G/ATmfvuNmMnEbmojhqYTS211h4LdF+eIASr
         GLrP4nxDgCSbKwu5HsI/q8csl62iUkzs+u8T3Hsf1nHD+usru9gcx2l80w8CuDRS6CpR
         FPnGGb+cymuzRYtDVhGHfnDCSM2S9m7JTrxjLyHiVOUKTmA2xPFo1/+Wc+4cjCEkllfp
         1P9w+CO0+LPmDKDJ5W8q727qM6xvTAaKp4L6ti4i9ZRutfJqKmFBaawrYFqK1Gc1p6jl
         5z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ufr8PAssJ+2sWuqaSL6pKbz4KHa/ife9dK3QD3JLZ8o=;
        b=k7oP3p6V8uGwWAWF8v2QU3MZQq7ZrNbdhnJ5jcOvNbGiZFo/PpgZlX2NT12VLHpAXu
         3fXDs5bwrOxOJitJ8IsQvE1+AEUuVbQqOG3G/i8CHaFsc/QqFlxWxoEIhCMZOrBA22Q3
         6qj1arXNq5+5CUbcWyViwwX0R662nZVY0o4cBGhzeN45Zze0ly/6ztaov1lHQFr+8Djh
         QvKhPWt+QEI8gbzn/hfNZtfGqvqKiF4JskT9K3gMLM9MfAAs/NQLX4TbprIitDhxHE8x
         FQRiOH24T4T9Z2kQgffF16Xr+BQHKi4ujDZRAwrANKSIvUiTDrjzNuPi/kJ/cFDQVcgs
         wdWA==
X-Gm-Message-State: ACgBeo3009Yt+388I+NX6NBtMMYGc0FOBJAo+LRQJPXsj8uBBwG6KCjB
        fZHSSUkl1vAEssxZT/VfaHI=
X-Google-Smtp-Source: AA6agR473z2XsZDuSP3GEB4toXIH1U46RZm70j2kETytAk/cD8+xGcuwjrc3D0TpSt+EZVrj1KYh0A==
X-Received: by 2002:a17:90a:c095:b0:1fd:5bee:8a17 with SMTP id o21-20020a17090ac09500b001fd5bee8a17mr8337646pjs.147.1662030888190;
        Thu, 01 Sep 2022 04:14:48 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027e4f00b0016ed20eacd2sm13483551pln.150.2022.09.01.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 04:14:46 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:14:40 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxCUIM4BWVZD6fnk@hyeyoo>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <Yw91n/AzjmAXmdh8@hyeyoo>
 <YxA9etTqGsaogfZ6@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxA9etTqGsaogfZ6@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:04:58PM +0800, Feng Tang wrote:
> On Wed, Aug 31, 2022 at 10:52:15PM +0800, Hyeonggon Yoo wrote:
> > On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> > > kmalloc's API family is critical for mm, with one nature that it will
> > > round up the request size to a fixed one (mostly power of 2). Say
> > > when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > > could be allocated, so in worst case, there is around 50% memory
> > > space waste.
> > > 
> > 
> > [...]
> > 
> > >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> > >  {
> > >  	void *freelist;
> > >  	struct slab *slab;
> > > @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >  
> > >  		if (s->flags & SLAB_STORE_USER)
> > >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > > +		set_orig_size(s, freelist, orig_size);
> > >  
> > >  		return freelist;
> > >  	}
> > > @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >  		 */
> > >  		if (s->flags & SLAB_STORE_USER)
> > >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > > +		set_orig_size(s, freelist, orig_size);
> > > +
> > >  		return freelist;
> > >  	}
> > 
> > Maybe we can move set_track() and set_orig_size() to after slab_post_alloc_hook().
> > something like alloc/free hooks for debugging caches? (and drop orig_size parameter.) 
> 
> Yep, we discussed this during v3 review
> https://lore.kernel.org/lkml/442d2b9c-9f07-8954-b90e-b4a9f8b64303@intel.com/

Ah, I missed that :) Thanks!

Considering the added cost (should be low) and races with validation,
I think this approach will cost more than it get. Sorry for the noise.

p.s. I think I can review this series in few days.
Thanks for your efforts!

> Will revisit this considering recent refactoring and the following
> kmalloc data redzone patches.

> Thanks,
> Feng
> 
> > Thanks!

-- 
Thanks,
Hyeonggon
