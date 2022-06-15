Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865E54D203
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349843AbiFOTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbiFOTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3625031353
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655322736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRLwzrcO75eUkj7xSmsgTB+2q1qWebaIXpEC9jk4So8=;
        b=Ogu6nhQ13tKLMrDnM1qkFk5UHUVy+sehHrQ8qtpVCmpz9N9yjqt5jRF/Ep3ZgyoKcC5XN7
        xogaMt7jQZ6vik+tGkCFEGKgd+xkKTwggLqACildC1+IkD6sqGxG91ZDxN7Pqkwy7I3QDt
        pbMqTuPRdmaKasPfG4Xw0PtPwy0KoUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-E6l0hePEN_iRQSw2LdiPWA-1; Wed, 15 Jun 2022 15:52:14 -0400
X-MC-Unique: E6l0hePEN_iRQSw2LdiPWA-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so1745350wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=YRLwzrcO75eUkj7xSmsgTB+2q1qWebaIXpEC9jk4So8=;
        b=B+jN/NSYhmWSJL55F+bgPhLJ/34hLO+UTIRkdx4VcNh0RYcMq7baipji/nRhwwy3qT
         zEMYUK0sKqFEEXG1UzUMldWHZGDU6fk2xSiNzyhIlrs3DXpHHcki0vvXJo+pvxj898z4
         ZY6Wg8ubTQGGtLFHGFdNQ4vrGXXMYNxWdKNuaPT7WOALr74Vau1yUkFYW4i4ePEDHICV
         XNxwv/E4dyioOYZW8uEJ6rFScOs5krVbDN6rBcgM2J65Q2pAXz0do8m+4B7rS0MBVfuV
         HcA0x+2G5tbd7mr75roLQJYq5Oca0tVZrTXnSe8Zn//4NXbdBcVJ/40NTkMn6PCONinM
         jQ2Q==
X-Gm-Message-State: AJIora8iMya2kYn+XE+gnst7xdRLzqN15F5iYtSDMNioHlwPfZDrF8JC
        Nd2wa29ndkUSbpGRdDYRKyLvzRFUcmR/dFWBgjnG4oocfg90XuAYajO9mqdh3OIXQf+jtN2+v9w
        Sik/xmZL0Zt6pZvg+nlv7LSM2
X-Received: by 2002:adf:f385:0:b0:213:bb0e:383a with SMTP id m5-20020adff385000000b00213bb0e383amr1320017wro.481.1655322733545;
        Wed, 15 Jun 2022 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLuCrcc2dD7oeLp1sOoZuvyfwuwYmCD090QJLv13+V/Kkg/fUSiN7SqNEnaj6HOVRhsUTsgg==
X-Received: by 2002:adf:f385:0:b0:213:bb0e:383a with SMTP id m5-20020adff385000000b00213bb0e383amr1319996wro.481.1655322733286;
        Wed, 15 Jun 2022 12:52:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6449000000b002101ed6e70fsm15466874wrw.37.2022.06.15.12.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:52:12 -0700 (PDT)
Message-ID: <3f190cd4-df87-feeb-bae4-56348498fa82@redhat.com>
Date:   Wed, 15 Jun 2022 21:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
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
References: <20220614093629.76309-1-david@redhat.com>
 <Yqn53TimQq33BanG@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
In-Reply-To: <Yqn53TimQq33BanG@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.22 17:25, Peter Xu wrote:
> On Tue, Jun 14, 2022 at 11:36:29AM +0200, David Hildenbrand wrote:
>> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
>> can try mapping anonymous pages in a private writable mapping writable if
>> they are exclusive, the PTE is already dirty, and no special handling
>> applies. Mapping the anonymous page writable is essentially the same thing
>> the write fault handler would do in this case.
>>
>> Special handling is required for uffd-wp and softdirty tracking, so take
>> care of that properly. Also, leave PROT_NONE handling alone for now;
>> in the future, we could similarly extend the logic in do_numa_page() or
>> use pte_mk_savedwrite() here.
>>
>> While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
>> performance, it should also be a valuable optimization for uffd-wp, when
>> un-protecting.
>>
>> This has been previously suggested by Peter Collingbourne in [1],
>> relevant in the context of the Scudo memory allocator, before we had
>> PageAnonExclusive.
>>
>> This commit doesn't add the same handling for PMDs (i.e., anonymous THP,
>> anonymous hugetlb); benchmark results from Andrea indicate that there
>> are minor performance gains, so it's might still be valuable to streamline
>> that logic for all anonymous pages in the future.
>>
>> As we now also set MM_CP_DIRTY_ACCT for private mappings, let's rename
>> it to MM_CP_TRY_CHANGE_WRITABLE, to make it clearer what's actually
>> happening.
> 
> I'm personally not sure why DIRTY_ACCT cannot be applied to private
> mappings; it sounds not only for shared but a common thing.  I also don't

TBH, I think the name is just absolutely unclear in that context.

> know whether "change writable" could be misread too anyway. Say, we're
> never changing RO->RW mappings with this flag, but only try to unprotect
> the page proactively when proper, from that POV Nadav's suggestion seems
> slightly better on using "unprotect".

write unprotection is a change from RO->RW, so I don't immediately see
the difference.

Anyhow, I don't like the sounding of TRY_WRITE_UNPROTECT.

I made it match the function name that I had:

MM_CP_TRY_CHANGE_WRITABLE
-> !pte_write()?
 -> can_change_pte_writable() ?
  ->pte_mkwrite()

Maybe MM_CP_TRY_MAKE_WRITABLE / MM_CP_TRY_MAKE_PTE_WRITABLE is clearer?

Open for suggestions because I'm apparently not the bast at naming
things either.

> 
> No strong opinion, the patch looks correct to me, and thanks for providing
> the new test results,
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

Thanks Peter!

-- 
Thanks,

David / dhildenb

