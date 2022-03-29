Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F324EA446
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiC2ArU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiC2ArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:47:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53559C65
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:45:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j15so31932643eje.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QksWBTlwH9ZfKIIjX7wkZaENf/tKeEzNedvaLHxjbUY=;
        b=Pzmjcl1qDcNCikR1lAoCuELUKcApFAxbUTpyQ7OacZeolCayw7TLgycRuZ/pgDj2bK
         NN1O7zYFWuTpDjL0fcSrrW/9nqEEYClse9Zw/EWTt8mGy0i5KGkBtFJJ0gKZLfJGLE5/
         c5DFVwlK3Qrq2j0tJTHVg/EusTooEz26py8yQhyLu4jQpG/+QTgLIfk5LxffsoOOutmr
         H7Yo22Iltzlb83bFgzgHCp4iFYjAnuxsBKMgSsyR2XfgUnvaMQ4n8yUG0M0hgFKpZQuS
         pBt0NmYmCOAEW6DQQEn25d6ApOOS6yL+eGhrdvXKXmgaBYRe73Wd+l9FssvlGoOgGsK0
         V2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QksWBTlwH9ZfKIIjX7wkZaENf/tKeEzNedvaLHxjbUY=;
        b=DbnmhVnYuxNnPMBvcFLfn6AcbTSdzHP1htluJWhHjWBCZYshS/aBDwd7EJQvSKmZTK
         GSdCB1DhzdbDAvs4U6QivUbiZF5qD1x9J7ORdG3tHTNmHHgGPlr1oddpEcs29VoI3UKd
         vsFYqtYJZYhhsSSbSp87tRdOxqDTQO2nAlLFY9lt7aUg3ayY29TLrbit1gW7undgTYBY
         7VbjgXL90Tfnx1Vt8eKDo2v0XLGcntEHtRNi6I4mjbva0yQu4egt52qez5f5dAe8Mm6C
         CtSp9lPemTTwJMh7hNFGU4b1G8Hmpy69Z7Dif5vG9WpHK85dyqxQw4qjoSNdPr1bJNkc
         B1MA==
X-Gm-Message-State: AOAM531fCs+w2SqJYV72pt/gP2gJnjPt8m7oMlskZJQP1xP6IE2VgY9c
        Lii9Jixjhpg2TVS8q6Wvy8o=
X-Google-Smtp-Source: ABdhPJzp83wf0nZ67DI62vggqtbQK1jlFf7tnRxnEnM6crKDSM1edHWMjEwUDR7FMCRMWMM1MvLtjw==
X-Received: by 2002:a17:906:4786:b0:6e0:c7b:d267 with SMTP id cw6-20020a170906478600b006e00c7bd267mr31528895ejc.115.1648514735878;
        Mon, 28 Mar 2022 17:45:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170907160600b006dff6a979fdsm6554697ejc.51.2022.03.28.17.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 17:45:35 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:45:35 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <20220329004535.27ps6cy4sipisxsu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8ff6f619-e04a-d785-fa9a-6822c04d4ee1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff6f619-e04a-d785-fa9a-6822c04d4ee1@huawei.com>
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

On Mon, Mar 28, 2022 at 03:23:49PM +0800, Miaohe Lin wrote:
>On 2022/3/28 9:08, Huang, Ying wrote:
>> Hi, Wei,
>> 
>> Wei Yang <richard.weiyang@gmail.com> writes:
>> 
>>> wakeup_kswapd() only wake up kswapd when the zone is managed.
>>>
>>> For two callers of wakeup_kswapd(), they are node perspective.
>>>
>>>   * wake_all_kswapds
>>>   * numamigrate_isolate_page
>>>
>>> If we picked up a !managed zone, this is not we expected.
>>>
>>> This patch makes sure we pick up a managed zone for wakeup_kswapd().
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>  mm/migrate.c    | 2 +-
>>>  mm/page_alloc.c | 2 ++
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 3d60823afd2d..c4b654c0bdf0 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>  			return 0;
>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>> -			if (populated_zone(pgdat->node_zones + z))
>>> +			if (managed_zone(pgdat->node_zones + z))
>> 
>> This looks good to me!  Thanks!  It seems that we can replace
>> populated_zone() in migrate_balanced_pgdat() too.  Right?
>
>This patch looks good to me too. Thanks!
>
>BTW: This makes me remember the bewilderment when I read the relevant code.
>It's very kind of you if you could tell me the difference between
>managed_zone and populated_zone. IIUC, when the caller relies on the

The difference is managed_zone means the zone has pages managed by buddy,
while populated_zone means the zone has pages but may be reserved.

>activity from buddy system, managed_zone should always be used. I think
>there're many places like compaction need to use managed_zone but
>populated_zone is used now. They might need to change to use managed_zone
>too. Or am I miss something?

This thread comes from the read of commit 6aa303defb74, which adjust the
vmscan code. It looks like there is some mis-use in compaction, but I didn't
get time to go through it.

>
>Many Thanks. :)

-- 
Wei Yang
Help you, Help me
