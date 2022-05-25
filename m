Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED77533AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiEYK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiEYK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:29:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45689939B7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:29:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 137so18573713pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mwbhkmbOQkKuVwJYKsie0YEoqqvQobqGsqV+qfDL6OU=;
        b=xtA2d4yqOYjJy4H8+xdeaKzfApG+eB/GsavG4nkDp3U04W8EMcQnDrqiTkYeSzj5kE
         yjW6uCwlJzS4bdpY5KlPyLhELrgvv8+CtOLKvKZEpkq2ij65waqIHUxAkU8O/ejp52mv
         DKm08hB9XEbWRgaMKTYGPjAhcdfH9jn7cOhxKftwveb0FZrSqq/iQg23GR+B+EEaBqR1
         n0RkQvAVqTqarplotOMN8KnAc73zD4/kNAjNQjuSd4vveAhcVlAerGU7oG6ZExe7Xed7
         Mi2nHpKYc1rdfX7+Uq52KAXev/lwam+HlrqcndWodP1NqvU8GCNsuDQzI5Ai+MOJF2Fz
         Oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwbhkmbOQkKuVwJYKsie0YEoqqvQobqGsqV+qfDL6OU=;
        b=N5pMFcqZxkMUcTcnWCTVu+pBE5dPO416yX9OOPgtKucWhyT8by/N3Oh6SQeFe9V+zn
         9xHOKCQAAt82Xej/+zP5udZ1rpqgf1q89yFVPQX+9z752IkF0uaYAqf/rcZ2h7jW7kXi
         BNbk1l9siyqYvJbv1ngfkk4QoL3J2U6dPpXbMdw3UfmD++9ZdlZCR+J39MdwWE8DMASa
         B89X7b8Ukh1m7d1C64mNiGlx41oZLra4B2vzXeThWFtCqEKzua+15J71mpZ3pZOA6B+I
         sVog/HE+bBCKimlmcZZIcSaA3kPVIaFqbLHf/twER5kKSI58OxBfYvt9d3VxADD6DHMy
         IjYQ==
X-Gm-Message-State: AOAM5306Y32ZJBD4Fsr8jIZg9fz+sXDbxEhjUT5IwmLv3eMgI1GllR5T
        Flf72dn/ZK+REaBuddmw46Ymrw==
X-Google-Smtp-Source: ABdhPJyyUkpUS70lsBTh3iCgyLIi9m3EkuTK+WJ/k+EtWQWimHC75rY1eiMSz3Z3XxMrWlAm48AYFw==
X-Received: by 2002:a63:5211:0:b0:3db:1c36:fc37 with SMTP id g17-20020a635211000000b003db1c36fc37mr27205801pgb.572.1653474559765;
        Wed, 25 May 2022 03:29:19 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902d5c300b0015e8d4eb2b9sm8946714plh.259.2022.05.25.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:29:19 -0700 (PDT)
Date:   Wed, 25 May 2022 18:29:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <Yo4E+mk3/XlQJ6Pw@FVFYT0MHHV2J.usts.net>
References: <20220429123044.37885-1-songmuchun@bytedance.com>
 <86fdbde5-a010-9473-2f5d-807c86620509@suse.cz>
 <Yo2R3VA1LIwx10FM@FVFYT0MHHV2J.googleapis.com>
 <b34a75ac-389a-3965-9c56-0b18adc8440d@suse.cz>
 <Yo3zmQLzHqdeyr3V@FVFYT0MHHV2J.googleapis.com>
 <970bbb88-3fc7-d2b9-6bb5-9c315888a889@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970bbb88-3fc7-d2b9-6bb5-9c315888a889@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:09:19PM +0200, Vlastimil Babka wrote:
> On 5/25/22 11:15, Muchun Song wrote:
> > On Wed, May 25, 2022 at 09:34:58AM +0200, Vlastimil Babka wrote:
> >> On 5/25/22 04:18, Muchun Song wrote:
> >> > On Tue, May 24, 2022 at 07:05:31PM +0200, Vlastimil Babka wrote:
> >> >> On 4/29/22 14:30, Muchun Song wrote:
> >> >> > Most callers of memcg_slab_free_hook() already know the slab,  which could
> >> >> > be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> >> >> > another call of virt_to_slab().  For bulk freeing of objects, the call of
> >> >> > slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> >> >> > Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> >> >> > those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> >> >> > freeing in slab_free().
> >> >> > 
> >> >> > Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> >> >> > slab_free() for slub to make the code clearer since the logic is weird
> >> >> > (e.g. the caller need to judge whether it needs to call
> >> >> > memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> >> >> > of memcg_slab_free_hook() like fixes of:
> >> >> > 
> >> >> >   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
> >> >> >   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> >> >> 
> >> >> Hm is this commit also fixing such bug? in mm/slab.c __cache_free():
> >> >>
> > 
> > Sorry, I think I have misread it and misled you here.  I mean commit
> 
> My bad, I should have said "this patch" referring to yours, not "this
> commit" which could refer to ae085d7f9365.
> 
> > ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> > is a bug fix, this commit does not fix any issue since __cache_free()
> > will be called from qlink_free() and __cache_free() will call
> > memcg_slab_free_hook(), so there is no issues.  This commit is totally
> > an improvements for memcg_slab_free_hook().
> 
> Ah, I see, indeed. The un-quarantining in kasan went through
> memcg_slab_free_hook() before your patch. But yeah it's better to do it
> earlier as the freed object's user is who charged it to the memcg, and is no
> longer using it - no reason to keep it accounted while in kasan's quarantine.
>

I couldn't agree more.

Thanks.
