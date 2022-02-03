Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113F4A8B88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353421AbiBCSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiBCSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:24:30 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98880C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:24:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id w81so11447082ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1fRhWHaiX3rkmKEuOvxk4MdWU+5ch329S/1ViDgbzuQ=;
        b=KX8rWrzrI4SmeeXMyhAJN94FJ/BtvuLWK+a+fEtNaIBeSUb/nXfmIj+MN9RQ0o7+mQ
         SwQe77+rarjoaurkLkwjWstN1NWmV+xd9D3Wn3XvJSyJukBCZpXcmD/HDqOwApqaTAak
         XGNvn02OrLI5jDtuy9UljW7DOLBN7KMgFEyXf/gf/4VpE4WqqiBa3B4q9wF3v5tDvzFs
         AqHfqKsKQt/6eF0lcKT5E8BYQjGIkPqsswV9TXkfHqhy55m1gPO5L0xwD4gXLybdIrfq
         zJUjnTeaQQUUkGj6vSUElVHZzCuVzQxX9ETcx+/12BQY9watxH97OYFpCpLkWbPlIgZz
         tXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1fRhWHaiX3rkmKEuOvxk4MdWU+5ch329S/1ViDgbzuQ=;
        b=yILDdryFxjGyHYFaM/1l5+CMqIlzHeQ1DsiDqYS3+AEcS8t1dXWj2wmwvRdltf4o4K
         oJSxuWENR7yMtm0vFhU66th5oKk9/50qpXpENtMKDH2UEXNHwNJLCJAy0cjDJy8sGCTL
         Cc27j/P9noSLC1+v2rkGvgBl+m50V6zYUgwpHCwmiBoiQeMdbFv6X/NA7s6de3OmxQyT
         BzfmNpNA5XD/MvvBpNPdivmal8NHhj8jZpIZxHktB53T3lyd52qG8m2s1IIadeTs8eEb
         DbUyOKqeh5FjWQpQLJlGzSgaR0MdPpOi8LUzaHDhkAqESU4TGYdtp0+hEIyJyJphy5wp
         CumQ==
X-Gm-Message-State: AOAM5317WUS6rMOXO0HLvqlXr2GfvRwW6JWnCESBmuUJjfuyqDmTDwWc
        DREFa/2Iu+l0P0MK6oARh5SlLodivGnGTQihbTZEZw==
X-Google-Smtp-Source: ABdhPJwUT60W3ByLAudmauSaRtgoF18uDF+5y3xNpKLwb86Fuj5obEj1Uw0y9+Xke1Xujg5UscpZstiv8/jNzr6gMZE=
X-Received: by 2002:a81:1d8f:: with SMTP id d137mr5310092ywd.383.1643912669833;
 Thu, 03 Feb 2022 10:24:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1756:0:0:0:0:0 with HTTP; Thu, 3 Feb 2022 10:24:29 -0800 (PST)
In-Reply-To: <YfwZ6ne9ND1JaReS@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-2-martin.fernandez@eclypsium.com> <YfwZ6ne9ND1JaReS@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 3 Feb 2022 15:24:29 -0300
Message-ID: <CAKgze5ZVHax5AWP3Q764dSmjAJWncyZbn4ENQCkYs0ahbG9Haw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mm/memblock: Tag memblocks with crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:23PM -0300, Martin Fernandez wrote:
>> +/**
>> + * memblock_node_is_crypto_capable - get if whole node is capable
>> + * of encryption
>> + * @nid: number of node
>> + *
>> + * Iterate over all memory memblock_type and find if all regions under
>> + * node @nid are capable of hardware encryption.
>> + *
>> + * Return:
>> + * true if every region in memory memblock_type is capable of
>> + * encryption, false otherwise.
>> + */
>> +bool __init_memblock memblock_node_is_crypto_capable(int nid)
>> +{
>> +	struct memblock_region *region;
>> +	bool crypto_capable = false;
>> +	bool not_crypto_capable = false;
>> +
>> +	for_each_mem_region(region) {
>> +		if (memblock_get_region_node(region) == nid) {
>> +			crypto_capable =
>> +				crypto_capable ||
>> +				(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
>> +			not_crypto_capable =
>> +				not_crypto_capable ||
>> +				!(region->flags & MEMBLOCK_CRYPTO_CAPABLE);
>
> Isn't
>
>  			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
> 				crypto_capable++;
> 			else
> 				not_crypto_capable++;
>
> simpler and clearer?
>
> (of course s/bool/int in the declaration)
>

Yes! It is. I like that.

>> +		}
>> +	}
>> +
>> +	if (crypto_capable && not_crypto_capable)
>> +		pr_warn_once("Node %d has regions that are encryptable and regions that
>> aren't",
>> +			     nid);
>
> This will print only the first node with mixed regions. With a single
> caller of memblock_node_is_crypto_capable() I think pr_warn() is ok.
>

Yes, you are correct, don't really want _once here.
