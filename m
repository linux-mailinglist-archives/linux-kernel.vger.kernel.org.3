Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3735635E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiGAOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiGAOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:17 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8872EC4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:37:03 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 8697BB002C1; Fri,  1 Jul 2022 16:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1656686220; bh=8Wxm73UmmLHbOCjpZAmjhNsfORK12itldNucpTrigH0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KRVgSWmi0JL9+POJHf7ZUTzfyXa5xNcZv1AcqaybbjpH5oZfLoqIv2wyOFnbeHB+P
         Ew15h0MaxktmLPVttReMUE1+tBEicirLMIVvWaGtKyVf9mzom1ZxHiYyKHwqfp/Z1h
         CN2TRH7x9D5Bjacv5KmiDx9NaPjbTgFXCdxzS69Ot1r7HPn+SG1dMz14seMBY6wpnm
         9vqeWZLHRwMO1DmxSGOmiaDe3Q12taUjxYtCD/9QqEdvSArs9gRDX1QISEZb0A8NfV
         +R3HkojAef1HnELIlOFUE0d1DJV+Gmg6LPrMFYfCHimoQ3sENKR+TVu50K6Di2gmVo
         pwT+HrlsGL+UA==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 8558BB00128;
        Fri,  1 Jul 2022 16:37:00 +0200 (CEST)
Date:   Fri, 1 Jul 2022 16:37:00 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
In-Reply-To: <20220701135954.45045-1-feng.tang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
References: <20220701135954.45045-1-feng.tang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022, Feng Tang wrote:

>  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {

It would be good to avoid expanding the basic slab handling functions for
kmalloc. Can we restrict the mods to the kmalloc related functions?

