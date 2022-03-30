Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11A34EC65F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbiC3OWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346711AbiC3OWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:22:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D46CC526
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:20:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id yy13so41870335ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSLzOGMxEvvyo6gGgJ7FGfOzffbKy7/GUIrJjlVgWa0=;
        b=ELFo3+o8KDemiGVchNQxQzoY3zDxN6fO7nCgyV8fY1+tx/vrLTrxVjcr8+YiDsEmp9
         +EavM7n60DwW3Q9Q0cvAQBeNYei7G7fCT1IvLPipue4EWfPp2mjOrsAw/fReXylTsWSx
         9xopAWfskCcpia3vlEjiyJdp4a03j+s+gEr8bztqc2sufCCaPnfnkqS4APFlbnL8LT30
         IQJ0StGzmDZKDx08QW18PTIjG/4HRe5QgadJNZ0uQksHYzmtzPJ9uurG8HKflBq5A0rT
         YTN2flItJHfIUkGjZAY9e5rNFiBAJPAO2q1XeVNkKV1T9hqT0GG5Em9VQiJDB5pueoEX
         eZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSLzOGMxEvvyo6gGgJ7FGfOzffbKy7/GUIrJjlVgWa0=;
        b=rlL04eAOqKYxAKUh3QfdHbMfFD5718CkD0HCUgAnd3e6PC3mQJZkJqOCAKFG1VDUHU
         Jfq6hf6DzTw6x2zN/QrSiNCudwUo8S7KjQnPffiJLQfvcyje8Mv67fjI31UPcVOJZAh7
         3v/772ZxRkurVcsUTzTS9+Iz/4yVATcxh637tiSthaTaZ7P0V54XmtaJpWaVTI1Ku9F9
         l8fs3dEJUTR8XEfEzwGCY8p6lhXMDeiWGnx9WB9qrzvzbSaxL7sC7pzJfezTyKSF/m2U
         x8CVE1kn52kioQdtonKDM/zde3zpYZg+LiLAAW4onuC0+91GYCan8RprFYnsf10tdb3J
         QKOw==
X-Gm-Message-State: AOAM532OvS3XVzgn/F7XNa+OdoY0USIsb9+g7LO2DRgAsOhG8TL0X3Is
        CiPPXkbeih8LXVU4+NICYt4=
X-Google-Smtp-Source: ABdhPJzi/y7HKs7Tj0aBKYVBZAJTOc1N8jxQTpuHQaAGPWERzoylB6JodP6vwCSbxrc3fbodS+Lyaw==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr14990434ejc.769.1648650053290;
        Wed, 30 Mar 2022 07:20:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id go40-20020a1709070da800b006dfc3945312sm8499650ejc.202.2022.03.30.07.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 07:20:52 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:20:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [Patch v2 2/2] mm/vmscan: make sure wakeup_kswapd with managed
 zone
Message-ID: <20220330142052.3g5n4cl6lqyekhan@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220329010901.1654-1-richard.weiyang@gmail.com>
 <20220329010901.1654-2-richard.weiyang@gmail.com>
 <a9844884-c591-b26b-abe2-953c896b8c95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9844884-c591-b26b-abe2-953c896b8c95@redhat.com>
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

On Wed, Mar 30, 2022 at 09:39:42AM +0200, David Hildenbrand wrote:
>On 29.03.22 03:09, Wei Yang wrote:
>> wakeup_kswapd() only wake up kswapd when the zone is managed.
>> 
>> For two callers of wakeup_kswapd(), they are node perspective.
>> 
>>   * wake_all_kswapds
>>   * numamigrate_isolate_page
>> 
>> If we picked up a !managed zone, this is not we expected.
>> 
>> This patch makes sure we pick up a managed zone for wakeup_kswapd(). And
>> it also use managed_zone in migrate_balanced_pgdat() to get the proper
>> zone.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
>^ I'm not so sure about that SOB, actually Andrew should add that. But
>maybe there is good reason for it that I'm not aware of.
>

I see Andrew has added this for v1.

Maybe I should remove this since v2 has some minor adjustment to v1. :-)

>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
