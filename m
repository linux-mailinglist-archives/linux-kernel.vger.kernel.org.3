Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0E54CCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiFOPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFOPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 030192F39E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655306722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSV8Fve0PWJWjvGISeUvIz6MGKTc1wSANb5wMGR0pmg=;
        b=amiZr5UC1nInramqDbMkS2BnIxw4xVKb7jikw8W9Ul1/KK0+Wea4bjzh7SlWDmljErkEQ8
        1BdYeOoGbP5mFcHPLuFvgrGhApJnmo5aEi7vZRPr9aWvZkoEEjiDzgWi9a2YComLI3h35G
        E1Bc0n38yf419kMZRn8p4izBKJWcqtg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-aVLJAIv1MJOw7JaCufoBQw-1; Wed, 15 Jun 2022 11:25:20 -0400
X-MC-Unique: aVLJAIv1MJOw7JaCufoBQw-1
Received: by mail-il1-f200.google.com with SMTP id e4-20020a056e020b2400b002d5509de6f3so8609016ilu.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YSV8Fve0PWJWjvGISeUvIz6MGKTc1wSANb5wMGR0pmg=;
        b=aqp67/d/KB8G3FtEQQ+XuO97C5gun1yALhxbxLhCRgOuVLL9uqJewIqWO+97Y3GGAl
         37PJKCY3lO+d0QQRdTuqw9K4IlGIfJyf4aVWgCblc/izpp4Ajp9jBmKPrDgph+PSK/yb
         xw90rynn5Bsi5cZAgh8PmHVTa+rLxxjySYy8EEm40MxPLerb7P3kNfWl7FjBnn0bNMsG
         gTFr8ctIRJ6Grb0PB2cwd4Por6QXkMMV8pfc3hlydYHNgrqbNzA5GSFCsKVHp0YcshXM
         uhpmsDV1+iGbn7Ytg1JBJadek4NHpw1hZX7RnFgly8kKNAQwxVJXhl+KFKzaGZPOmFg9
         p0lg==
X-Gm-Message-State: AJIora+fvRamMsfTHEufjEt64r58esfOSx0ClVNsFglzL53UfIgTo6Jk
        AMy690G/4B8biVqZwlxyJd1mHrilI0EEivCpBTCSQmJH0UanQ1ZOaYOWca8p9kF8BNvkGEVBxEh
        u278x3a5BLELW/Fviawg9zCpt
X-Received: by 2002:a05:6638:3389:b0:331:f5e7:7dda with SMTP id h9-20020a056638338900b00331f5e77ddamr141591jav.93.1655306720032;
        Wed, 15 Jun 2022 08:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slD1TjvGX5JJWBPTslwwpNrUl1Q6gp1EonDIoeya0vuNqPpOHgr5IBRc0spdE9e/6rqYU6cA==
X-Received: by 2002:a05:6638:3389:b0:331:f5e7:7dda with SMTP id h9-20020a056638338900b00331f5e77ddamr141568jav.93.1655306719806;
        Wed, 15 Jun 2022 08:25:19 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638119000b00331f32a48fdsm4372036jas.11.2022.06.15.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:25:19 -0700 (PDT)
Date:   Wed, 15 Jun 2022 11:25:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Collingbourne <pcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
Message-ID: <Yqn53TimQq33BanG@xz-m1.local>
References: <20220614093629.76309-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614093629.76309-1-david@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:36:29AM +0200, David Hildenbrand wrote:
> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
> can try mapping anonymous pages in a private writable mapping writable if
> they are exclusive, the PTE is already dirty, and no special handling
> applies. Mapping the anonymous page writable is essentially the same thing
> the write fault handler would do in this case.
> 
> Special handling is required for uffd-wp and softdirty tracking, so take
> care of that properly. Also, leave PROT_NONE handling alone for now;
> in the future, we could similarly extend the logic in do_numa_page() or
> use pte_mk_savedwrite() here.
> 
> While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
> performance, it should also be a valuable optimization for uffd-wp, when
> un-protecting.
> 
> This has been previously suggested by Peter Collingbourne in [1],
> relevant in the context of the Scudo memory allocator, before we had
> PageAnonExclusive.
> 
> This commit doesn't add the same handling for PMDs (i.e., anonymous THP,
> anonymous hugetlb); benchmark results from Andrea indicate that there
> are minor performance gains, so it's might still be valuable to streamline
> that logic for all anonymous pages in the future.
> 
> As we now also set MM_CP_DIRTY_ACCT for private mappings, let's rename
> it to MM_CP_TRY_CHANGE_WRITABLE, to make it clearer what's actually
> happening.

I'm personally not sure why DIRTY_ACCT cannot be applied to private
mappings; it sounds not only for shared but a common thing.  I also don't
know whether "change writable" could be misread too anyway. Say, we're
never changing RO->RW mappings with this flag, but only try to unprotect
the page proactively when proper, from that POV Nadav's suggestion seems
slightly better on using "unprotect".

No strong opinion, the patch looks correct to me, and thanks for providing
the new test results,

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

