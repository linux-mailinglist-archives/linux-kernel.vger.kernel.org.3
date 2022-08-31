Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E515A80A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiHaOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:52:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C616CC325
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:52:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y127so14668417pfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Gf8tbj4RpGeuppvSON/HSM0Glqk0yYviXDuhJFMb/GU=;
        b=cQxyBMvvozNYynus3zxZ3j6RzXSBCpn5FoAJ+nxKz3VHiS1lPZzxADwXlYRuG0lI3B
         iubXtay3v5e612hUHNMRi9pO3BoM7+V6nua4ccIirdwdAWV5GDmbXNB3aaP0GSgTpuWP
         nHW/4r7u39B3y081Hzdd0igqeAx9v0A/y+Tn0jf9CDsHJTsjTTvOjhaKnfYTW5kkLBrn
         KNgAj1LflkiZ/CvLjcjVtD6gnblQiNy2KksOanc3Da332hYVeyFKkr7EDZqsgSRqLj4T
         /auCOgZbeBvfyH8YPAadjtSdky6NohdNqcDfIs6cFywfY1K96K97eYQ7qGIxabWIC7/8
         VmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Gf8tbj4RpGeuppvSON/HSM0Glqk0yYviXDuhJFMb/GU=;
        b=XKduJq2LcyXfak4c9mTFRIii7O52EntkErP+Pr9CFP75DEHc4op6aGfXvDGdHOJYsq
         uOrb2D74D0l33L6EEwgSKcHwcCPgR+Y82OQmcI+yb1UObIyncItfHYgkpAwuSnza2loH
         50UkcY0U/G5oKb1ezdxx6eJ4nKiIt39ZjKDEN2FkC8mh1FwisqdA04Rt6d3boS0k/+c+
         I25r7Veir2K9/WZmlzaIhegSxOn4CAxK4tCQcakSkjfDZh3drR4U0XmS6B3HmkfW4tr8
         3ZfdsMZILyD0YQCOaExSXLZQ99F+rWB5bUwEf42gsS1FdHLVonjK+2Chr3cqGMqUyBjT
         cqGQ==
X-Gm-Message-State: ACgBeo2cFc7YpCrUvh7iA9IGORrQWHy2em0zVdgrly+4KL+QUMehPVWV
        lUPYQIuyxVycPn457Uvpo5Q=
X-Google-Smtp-Source: AA6agR7awV28A8GFlOqP8EMOm3gwrL/ylD9ZFMMEnI72iN/QFjWSAFyzuqanhGFK9yCQXMTjstNzFQ==
X-Received: by 2002:a65:408b:0:b0:42a:55fb:60b0 with SMTP id t11-20020a65408b000000b0042a55fb60b0mr22418817pgp.431.1661957543649;
        Wed, 31 Aug 2022 07:52:23 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id i63-20020a626d42000000b00537b8aa0a46sm11571093pfc.96.2022.08.31.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:52:22 -0700 (PDT)
Date:   Wed, 31 Aug 2022 23:52:15 +0900
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
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Yw91n/AzjmAXmdh8@hyeyoo>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829075618.69069-2-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> kmalloc's API family is critical for mm, with one nature that it will
> round up the request size to a fixed one (mostly power of 2). Say
> when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> could be allocated, so in worst case, there is around 50% memory
> space waste.
> 

[...]

>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
>  	void *freelist;
>  	struct slab *slab;
> @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> +		set_orig_size(s, freelist, orig_size);
>  
>  		return freelist;
>  	}
> @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> +		set_orig_size(s, freelist, orig_size);
> +
>  		return freelist;
>  	}

Maybe we can move set_track() and set_orig_size() to after slab_post_alloc_hook().
something like alloc/free hooks for debugging caches? (and drop orig_size parameter.) 

Thanks!

>  
> @@ -3182,7 +3228,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   * pointer.
>   */
>  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
>  	void *p;

-- 
Thanks,
Hyeonggon
