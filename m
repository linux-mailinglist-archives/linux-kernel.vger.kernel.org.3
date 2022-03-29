Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373694EB748
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiC3AAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiC3AAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:00:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E211A824
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:59:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so38265459ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbCzJfln3VqMM3D8LXGLhg65sP9l5FOJf1oTlsWIEkc=;
        b=UxK9BwFdx+NtfkRowsHUY2uy2BdczHjejvZGksCdFIqMauZ6RAecwBRXXfSqYbinuH
         uhmw/4W4mpStLdpF2rw8s9GhpFzipietHCq7CJ1a3b2CXLD4AFjSV6z7VYnKVb1SqiVC
         BZo7ZffpZG5A6WKqwBfDFYeJmMA/t9IwFulJ2mLen7c+ihvtxChCFusK0u6GZaaGW/b/
         Qecrq9pMx46kvD+Xw3zdV9QcCWFCOv1ZgVqyRj+qgC1Odwgw6ydIjaWggOSjgNHqbgKw
         0HEMGyfpnWOhBiT/BGCntZgxlH6Tob+k1gi3FM+vzS8r/0PPOxhF4tbQoGRFscHOWjs+
         DTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbCzJfln3VqMM3D8LXGLhg65sP9l5FOJf1oTlsWIEkc=;
        b=DOAoOdclwP97dT1A5WBynTHlQSVnVJqoWK77JGwdMvMrhUbUEfE+vowZZ5WidS2MVp
         pmlTySCBoMIC+a1upzZqv17rf3jbxeX2JE1211wLVGCA+nDxIh8JBzvFU8d6AipUa/uh
         dlIPhlJLmO0YEV1o+o3g2vYxSa8BV6jqGFKdbwowFuhbYlfVfJRkymYW7SwCNeOWNHeD
         O5qURrIZZZvUkYTfVCeA5+Onaz83mEDuR5herdBlP0JG3uG0QRT7J5Alc13hxoL642O5
         jvK8DBaHq4Ga+ssMtmgE5+KFfGlQ52UJ+8Ht6WEqhf3Fw0h/XebEacOp1CNT+bAqahYT
         mMDQ==
X-Gm-Message-State: AOAM531qaOkRWuFWQK/9RzKpRURhWHCTmBcsmyfDqOiQGL/yE4DfEe8e
        3U9ARmAzBdMxj+I8g3o2w/8=
X-Google-Smtp-Source: ABdhPJwPUU34aRSvV0n1CShYWuJFkXrvLHDh1Zd8NAWwoi08dOwN46Km3ovGkTkOhQZf9qG+uiwztA==
X-Received: by 2002:a17:907:c06:b0:6e0:9149:8047 with SMTP id ga6-20020a1709070c0600b006e091498047mr6064002ejc.765.1648598341805;
        Tue, 29 Mar 2022 16:59:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm9206295edb.47.2022.03.29.16.59.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Mar 2022 16:59:01 -0700 (PDT)
Date:   Tue, 29 Mar 2022 23:59:00 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
Message-ID: <20220329235900.3slpqbgjqgjv4y2e@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <20220327024101.10378-2-richard.weiyang@gmail.com>
 <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329004146.2xdswvrm2qu7f47x@master>
 <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20220329015230.hneciyfxoxtvfytl@master>
 <YkJte/L4jZv47FOO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkJte/L4jZv47FOO@casper.infradead.org>
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

On Tue, Mar 29, 2022 at 03:22:51AM +0100, Matthew Wilcox wrote:
>On Tue, Mar 29, 2022 at 01:52:30AM +0000, Wei Yang wrote:
>> @@ -1985,14 +1985,13 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>>  			continue;
>>  
>>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
>> -		if (!zone_watermark_ok(zone, 0,
>> +		if (zone_watermark_ok(zone, 0,
>>  				       high_wmark_pages(zone) +
>>  				       nr_migrate_pages,
>>  				       ZONE_MOVABLE, 0))
>
>Someone's done the silly thing of lining up all of these with spaces,
>so either all these lines also need to be shrunk by one space, or you
>need to break that convention and just go to a reasonable number of
>tabs.  I'd do it like this:
>
>		if (zone_watermark_ok(zone, 0,
>				high_wmark_pages(zone) + nr_migrate_pages,
>				ZONE_MOVABLE, 0))
>
>but not everybody would.
>
>> @@ -2040,16 +2040,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>  		return 0;
>>  
>>  	/* Avoid migrating to a node that is nearly full */
>> -	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>> -		int z;
>> -
>> +	if ((zone = migrate_balanced_pgdat(pgdat, nr_pages))) {
>
>Linus had a rant about this style recently.  He much prefers:
>
>	zone = migrate_balanced_pgdat(pgdat, nr_pages);
>	if (zone) {
>
>(the exception is for while loops:
>
>	while ((zone = migrate_balanced_pgdat(pgdat, nr_pages)) != NULL)
>
>where he wants to see the comparison against NULL instead of the awkard
>double-bracket)

Matthew,

Thanks for your suggestion, I would change this later.

-- 
Wei Yang
Help you, Help me
