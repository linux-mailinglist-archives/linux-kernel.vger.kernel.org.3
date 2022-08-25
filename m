Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA85A0CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiHYJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiHYJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:31:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB7694EC7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:31:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id io24so4741123plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FkF/ieW9DrmFPlYn4kxhbKZWUjDQxs4hOhq1nOWUbV8=;
        b=v6DiykumEFWXgdqMcMhIspfDE1oja9wFVIrnV8rqLwVwlnY39s+EM5gzT9vhmoBeLo
         v6VwF77QU0XGq5IBHzHQZKNHBfq/yAcsBgDuE1tGHxpG8CCU0YwxK/4ljpdJb6+5YF82
         VXR5kUA7A0IHQG+kJc8soAaPclxYNsbm98MqP6J03BSWjz1Jd0EedEHmyjQn1vf6WSMz
         SZhGOyJ61vUsjs2XzLlvTfNpQQIePS1f/2ofHVhTxICx1JkcOAmgbCD9IfwDNze4WNon
         FJ9Zsx23eV0KGVkqm+Sz1DhRhI9a/jeETIL+KNiQffsbqBsbWJwDOm1FwkQtWlP9Td7V
         7keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FkF/ieW9DrmFPlYn4kxhbKZWUjDQxs4hOhq1nOWUbV8=;
        b=N0Zyna1NlzCcoM3iN9YO8BN4/4W7Ybkj+S80A2f6xqz3iivMInvA3XW90oE1xY2HuZ
         FsndaWe4roJJJH4Z3eAPKeV0rYbD+QtIQIGVLRub0aqVAIrlIeINzVinx80qnFH35ez2
         wAgyjyBOChKL2qLjEtQMbKtEY4iJVzxipfi6VMI2DpxnYNEzKKVqbZgxQ0S4XRzI2jGF
         Zx96yc4kZRUCcgUTbxYxLO7RZ2KWHN48V/pLXlNNJ2Bz24pQ5WMGw7WD1Tey3HOtc1wQ
         VbSn/zWUhnDWBYRxTpzWFOc+7D+ry/h8XWz7j56Jr3F+PHi6eyuOUxW9KyGbjByd81nD
         C1Gw==
X-Gm-Message-State: ACgBeo1Lx8ZFZQ0ohlT6HMyxwOqi0Yjydi3MnrZAtK+LMK9SvgOCQeLt
        a+ibLqtuA1WmuY9a1u1NSq2QcA==
X-Google-Smtp-Source: AA6agR64FNDVCcY/q1Ls1c6co+VRCiun2r+tsha4TZ/3lAU+XvQ+Fla9eV7HgK3GzB4+tLAwjARlyw==
X-Received: by 2002:a17:902:9894:b0:172:ca00:f305 with SMTP id s20-20020a170902989400b00172ca00f305mr3136942plp.107.1661419903738;
        Thu, 25 Aug 2022 02:31:43 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b00172f4835f53sm7205389plf.192.2022.08.25.02.31.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 02:31:43 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     mhocko@suse.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, corbet@lwn.net,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, yuanzhu@bytedance.com
Subject: Re: [PATCH v3] page_ext: introduce boot parameter early_page_ext
Date:   Thu, 25 Aug 2022 17:31:30 +0800
Message-Id: <20220825093130.98332-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YwcgoZfw4RhZ1Bl6@dhcp22.suse.cz>
References: <YwcgoZfw4RhZ1Bl6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Aug 2022 09:11:29 +0200, mhocko@suse.com wrote:
>On Thu 25-08-22 14:31:02, lizhe.67@bytedance.com wrote:
>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>> problem. It seems that we cannot track early page allocations in current
>> kernel even if page structure has been initialized early.
>> 
>> This patch introduce a new boot parameter 'early_page_ext' to resolve this
>> problem. If we pass it to kernel, function page_ext_init() will be moved
>> up and feature 'deferred initialization of struct pages' will be disabled.
>
>will be disabled to initialize the page allocator early and prevent from
>the OOM mentioned above.
>
>> It can help us to catch early page allocations. This is useful especially
>> when we find that the free memory value is not the same right after
>> different kernel booting.
>> 
>> Changelogs:
>> 
>> v1->v2:
>> - use a cmd line parameter to move up function page_ext_init() instead of
>>   using CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> - fix oom problem[1]
>> 
>> v2->v3:
>> - make adjustments suggested by Michal Hocko
>> 
>> v1 patch: https://lore.kernel.org/lkml/Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz/T/
>> v2 patch: https://lore.kernel.org/lkml/20220824065058.81051-1-lizhe.67@bytedance.com/T/
>> 
>> [1]: https://lore.kernel.org/linux-mm/YwHmXLu5txij+p35@xsang-OptiPlex-9020/
>
>the changelog is usually not part of the changelog and goes under ---

Thanks for correcting my mistake!

>> 
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>
>I still have few comments below before I am going to ack. But this looks
>much better already.
>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>  include/linux/page_ext.h                        | 11 +++++++++++
>>  init/main.c                                     |  6 +++++-
>>  mm/page_alloc.c                                 |  2 ++
>>  mm/page_ext.c                                   | 12 ++++++++++++
>>  5 files changed, 36 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index d7f30902fda0..7b5726828ac0 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1471,6 +1471,12 @@
>>  			Permit 'security.evm' to be updated regardless of
>>  			current integrity status.
>>  
>> +	early_page_ext [KNL] Boot-time early page_ext initializing option.
>> +			This boot parameter disables the deferred initialization
>> +			of struct page and move up function page_ext_init() in
>> +			order to catch early page allocations. Available with
>> +			CONFIG_PAGE_EXTENSION=y.
>
>For admins it would likely be more easier to understand something like
>following
>	early_page_ext [KNL] Enforces page_ext initialization to earlier
>			stages so cover more early boot allocations.
>			Please note that as side effect some 
>			optimizations might be disabled to achieve that
>			(e.g. parallelized memory initialization is
>			disabled) so the boot process might take longer,
>			especially on systems with a lot of memory.
>			Available with CONFIG_PAGE_EXTENSION=y

Great, I will use this description in my v4 patch. It is much more easier
for us to understand. Thanks!

>[...]
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 3dc715d7ac29..bf4f2a12d7dc 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -85,6 +85,18 @@ unsigned long page_ext_size = sizeof(struct page_ext);
>>  
>>  static unsigned long total_usage;
>>  
>> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> +bool early_page_ext __meminitdata;
>> +#else
>> +bool early_page_ext __meminitdata = true;
>> +#endif
>
>Why should default depend on DEFERRED_STRUCT_PAGE_INIT at all. This is
>just confusing and I do not see how it serves a purpose. We might grow
>more optimizations which would prefent early page_ext init.
>
>Let's just have default false and only enforce with the parameter. This
>is more predictable and easier to understand.

Yes, this is confusing. Without depending on DEFERRED_STRUCT_PAGE_INIT, the
logic here will be more clear. I will remove it from my v4 patch. Thanks!
