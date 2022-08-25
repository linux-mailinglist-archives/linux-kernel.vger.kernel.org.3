Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6695A08C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiHYGVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiHYGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:21:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E09FAA0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:21:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t5so199054pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N0Kam/r+6J/z7kUybT3q/5t+alB2JmkG99SLjn1j3Rk=;
        b=oF/Ad1kg9nAylTheyNzvM7JmKBx7AcLCQbAbFg15yzyJGO2DYMYbhDTdN0+ZYLKCed
         TxH2ByMLSail1ctqcrTe/zaSrMb0E3lfvjrmjkikPEly9D7UFFgyoYVi8ebRaQsJSoqu
         8X6RFVI4nGdhJOVUX9dSQZtZ+dRKapTvzq5d8O7xZbB+YOPr8X95vGVZN3NnovHaw6gJ
         ecYE+c5Vu5ZjRIACsMjAo8mQBViAycXcdk0pPjpFhpY8wA9CPXLlH4Wseavb7zH6tSF3
         r4wwxm1rWBLvb4KRUZEQ9at8aunC4szIRIvYG4llojhgmUcp25lYqua0i0ekFZhjmEzX
         6LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N0Kam/r+6J/z7kUybT3q/5t+alB2JmkG99SLjn1j3Rk=;
        b=tBV3D5158rvIZBGKw+dWaxGlnOzi0REZMjXAAoIq5EYWK3rlR1JkUyLa4SuFa0HkZg
         T5tnyImo5xoq7Ufz6OaujzO0XVUZB/X5X/rhdRx8XZMRRDjm17HAGB5iuZTFYjxSxe20
         JLbgcnbnCoxJRSQdTzFFP9zipX2WrS/HH8ud5d4zmC45hCCj3vI58wyoHhwwR+W1tNIU
         98gk2gl01R3VZCDlfmrYQXKD8CuTyHELugUckA7E8hmawJ+tUlhIVKqYwGu3m2v3oOV4
         SC3ToBGZB1az34335+2J5guY0/mq1mmucFl3RUEJekuIFKm+cMpw5lY3MoOFMOMJsIWm
         n0XQ==
X-Gm-Message-State: ACgBeo1MipCz3yU5PB1CcCLiYR3bK4QkT7/xpfsUbO0+dgj4Ai3Z9IOE
        chUjOjHLgx8Pwricm7KH5uoUuQ==
X-Google-Smtp-Source: AA6agR4i+iJk8hmig2393bFwU6Fl0ZUVI7TJobcxPnJSj1qc0BGRUcQ3+Zwm9PlJG8Fj9Dm0dfJc4w==
X-Received: by 2002:a17:903:2310:b0:173:10e1:3a76 with SMTP id d16-20020a170903231000b0017310e13a76mr2463156plh.160.1661408503463;
        Wed, 24 Aug 2022 23:21:43 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090a8c8200b001f1694dafb1sm2560522pjo.44.2022.08.24.23.21.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:21:43 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     mhocko@suse.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, corbet@lwn.net,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, yuanzhu@bytedance.com
Subject: Re: [PATCH v2] page_ext: introduce boot parameter 'early_page_ext'
Date:   Thu, 25 Aug 2022 14:21:29 +0800
Message-Id: <20220825062129.92091-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YwXczj8Dh0uI0EA9@dhcp22.suse.cz>
References: <YwXczj8Dh0uI0EA9@dhcp22.suse.cz>
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

On 2022-08-24 8:09 UTC, mhocko@suse.com wrote:
>On Wed 24-08-22 14:50:58, lizhe.67@bytedance.com wrote:
>[...]
>> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
>> index fabb2e1e087f..3e081cf8a1ec 100644
>> --- a/include/linux/page_ext.h
>> +++ b/include/linux/page_ext.h
>> @@ -38,19 +38,22 @@ struct page_ext {
>>  
>>  extern unsigned long page_ext_size;
>>  extern void pgdat_page_ext_init(struct pglist_data *pgdat);
>> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>> +extern bool early_page_ext_enable(void);
>> +#endif
>>  
>>  #ifdef CONFIG_SPARSEMEM
>>  static inline void page_ext_init_flatmem(void)
>>  {
>>  }
>> -extern void page_ext_init(void);
>> +extern void page_ext_init(bool early);
>>  static inline void page_ext_init_flatmem_late(void)
>>  {
>>  }
>>  #else
>>  extern void page_ext_init_flatmem(void);
>>  extern void page_ext_init_flatmem_late(void);
>> -static inline void page_ext_init(void)
>> +static inline void page_ext_init(bool early)
>>  {
>>  }
>>  #endif
>
>Why do you need to make it CONFIG_DEFERRED_STRUCT_PAGE_INIT
>dependant?

Yes it is unnecessary. Thanks!

>[...]
>> diff --git a/init/main.c b/init/main.c
>> index 91642a4e69be..3760c0326525 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -849,6 +849,8 @@ static void __init mm_init(void)
>>  	pgtable_init();
>>  	debug_objects_mem_init();
>>  	vmalloc_init();
>> +	/* Should be run after vmap initialization */
>> +	page_ext_init(true);
>
>you can just 
>	if (early_page_ext)
>		page_ext_init();
>
>>  	/* Should be run before the first non-init thread is created */
>>  	init_espfix_bsp();
>>  	/* Should be run after espfix64 is set up. */
>> @@ -1606,7 +1608,7 @@ static noinline void __init kernel_init_freeable(void)
>>  	padata_init();
>>  	page_alloc_init_late();
>>  	/* Initialize page ext after all struct pages are initialized. */
>> -	page_ext_init();
>> +	page_ext_init(false);
>
>	if (!early_page_ext)
>		page_ext_init();

I think we can use an inline function instead of 'early_page_ext' here. The
reason is that if CONFIG_PAGE_EXTENSION=n, 'early_page_ext' is undefined.
Thought we can #define early_page_ext as false, it is ugly.

>>  
>>  	do_basic_setup();
>>  
>
>and without the ifdefery it all becomes much more simple.

Yes it becomes much more simple. Thanks for all your advices! I will take your
advices and send a v3 patch.
