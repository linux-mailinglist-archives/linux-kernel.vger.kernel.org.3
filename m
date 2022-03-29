Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB414EA449
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiC2Ane (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiC2Anb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:43:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211722030B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:41:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pv16so32012203ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0b52Q/UfwrxflFU9LmcGLJ4e39trW7MxqP3FSaolBUg=;
        b=Tpg/+5VbOWVkwV19w/jrJOoTY65GPvHxwUlxOD6jI+i+KG/1Hxf0Br1p09PoWg/LI1
         2XcB7Bb2dgSuJeEvypwrTy5k7SArTutGzL5c5J+kS3nnZOlAwZgYJVV2PObN027BL9H+
         NCJ3qc6maTMo9f9FBf2KiYSYB6qI/tVS4L7zcIb6aK9gZmb6ichssxz6zOeXN5CdirEP
         GciT9gyOQOlnzD8ygNbzOkxSsHSRkwnfyqWg6Wu39jD0dGvY+ckFhc56Fo/dYuW5GN1P
         AM0tv/kfOb2duaeB1GzOkyKZ5i77NtjwWxwdmEq0rB1l4C31lwcIo1VVofFLSEzxCaw8
         +G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0b52Q/UfwrxflFU9LmcGLJ4e39trW7MxqP3FSaolBUg=;
        b=nw9rSqHMngmDo+xmOgAXzZzDfaQrKUjmbLAFXAztLmX2H0Thq6+Ps9wEv1jVygA+co
         dxNK/GwiEN7QNQVm+2vgzALGfbysOjp5OtSgg7wfbu/niq9H7MPPatyO9BWNHC9sNIp7
         hosHujkCYi59A9wqT6aizM7O0iQkOOxb90O/vqR0iUKvXHIcE07tkjNz4SvAgGHKOKb1
         m+jNd30NO1wmJZO62jFF4kw5wHTlLrecO4fXymkCcbO/ki1dQtoYj2VIFN6loAQwkkZw
         U+H+ZTwdXQH8fOdfLGG4Uxt+/MNQigtpYj5EuHeA1yUODySGlTf4w2FE2FoNk9N7tFJ7
         yvbg==
X-Gm-Message-State: AOAM530wVGJQRMMIk6kXGE+GlsDeDVo8Pojj4UeLkdDsa2E9Scpdq0y7
        resCZJnrywyM8ucLZlNEppA=
X-Google-Smtp-Source: ABdhPJwPndap81VB5uO0DtCc4P4BgJYATuwNHYUdQYc2RrXQgVYeFQKvM0nHI5W0ahLm43JHcpKOaA==
X-Received: by 2002:a17:907:7214:b0:6dd:e8fe:3e9 with SMTP id dr20-20020a170907721400b006dde8fe03e9mr31480515ejc.51.1648514507859;
        Mon, 28 Mar 2022 17:41:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm6513592ejc.99.2022.03.28.17.41.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 17:41:47 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:41:46 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <20220329004146.2xdswvrm2qu7f47x@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:08:34AM +0800, Huang, Ying wrote:
>Hi, Wei,
>
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> wakeup_kswapd() only wake up kswapd when the zone is managed.
>>
>> For two callers of wakeup_kswapd(), they are node perspective.
>>
>>   * wake_all_kswapds
>>   * numamigrate_isolate_page
>>
>> If we picked up a !managed zone, this is not we expected.
>>
>> This patch makes sure we pick up a managed zone for wakeup_kswapd().
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/migrate.c    | 2 +-
>>  mm/page_alloc.c | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 3d60823afd2d..c4b654c0bdf0 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>  			return 0;
>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>> -			if (populated_zone(pgdat->node_zones + z))
>> +			if (managed_zone(pgdat->node_zones + z))
>
>This looks good to me!  Thanks!  It seems that we can replace
>populated_zone() in migrate_balanced_pgdat() too.  Right?
>

Yes, you are right. I didn't spot this.

While this patch comes from the clue of wakeup_kswapd(), I am not sure it is
nice to put it in this patch together.

Which way you prefer to include this: merge the change into this one, or a
separate one?

-- 
Wei Yang
Help you, Help me
