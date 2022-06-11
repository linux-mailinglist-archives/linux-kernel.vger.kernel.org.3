Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5A547638
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiFKPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiFKPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:49:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA62E8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:49:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x138so1978037pfc.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lsyXcbGVnnHp+ZTNPftnqBlou4cClChxNQXmkWFyJdY=;
        b=nPcPHBg2LkXgICUCt2NPzN7d60V1Vh6guMz6DvIQ5NVBuAPZOv1UcCoUe7vLUqS3lr
         +RK9vgjy53GiYCoS1zFlK7ocFevJ5JhfAYV+7DYOMv/+lsX11UKUMknOAWBYEF54834p
         GkIw+PTm67eJRd0v+ZDJdscRwY6ZRg+Kahk1l/hNTNfyQS3z2B941AOrNRShZY59TBep
         ooTcQZF5CWUa6Y+i+2scykCeAQCNRuerXdmH/LUgOOjjoCNANa/OcX/HYnS8bCNTIXcy
         oCbpvRnwLPEHoXR9oyNVTF1Tgy/uGm4JDLoBkedBtCexnB2fj4zZwLB06SYNDglfQxTB
         2KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lsyXcbGVnnHp+ZTNPftnqBlou4cClChxNQXmkWFyJdY=;
        b=n+P7tpyyWV1sL2dVFBCYr+B4XfhAnZfg1hSjVSjwbWot5tXCI1sIYZFXJ89eJB1eiV
         6mPUzjhorLJsfNeOmk8uq1onMbAzyh6xzgjZ7CMa0DuA8Qexoq8jbi4VV7FfsqnSIOZM
         DuXlNfIs4bQJblnoyoCQb9nGMpPbxR3JX1nuEumbJOMIfk2d/F2iobCqbQLvK0BFVBmT
         j7LfrNh7KCV4fvYAbH4E09zRMk3nlsfw8rGq8cK2kqHQWBTjRGvRsoPlDykpxMVyOkxa
         Q8/QIJE6pnc90IdMe4GrU1HQHkO9PWWHqiLz7Pf0LXsJ6q/u025cVXMC9YeyMPFrT3iV
         kFdg==
X-Gm-Message-State: AOAM531APwT+uIkBLb7ZFLReNjt2QtKIdW7xkv/Cq8GmPvM+dKm7oOMw
        wIRySr2xME2M+XZEk3efBrG0nwJw0jEzhw==
X-Google-Smtp-Source: ABdhPJxgLUe7jHqK+3Z6z6ZPnrXY8lJGa0zEqsh99jnkBDi/EeyQBdZhDkayKW8xzfRmElRifbtvew==
X-Received: by 2002:a63:f242:0:b0:3fd:8a04:df6 with SMTP id d2-20020a63f242000000b003fd8a040df6mr31834881pgk.300.1654962565866;
        Sat, 11 Jun 2022 08:49:25 -0700 (PDT)
Received: from [10.139.0.6] ([199.101.192.70])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a928600b001df239bab14sm1609621pjo.46.2022.06.11.08.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 08:49:25 -0700 (PDT)
Subject: Re: [PATCH] mm: fix is_pinnable_page return value
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shameerali.kolothum.thodi@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220611133442.15290-1-zhangfei.gao@linaro.org>
 <YqStDm5sdDL6YXn8@casper.infradead.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <9379fcb3-43c8-d13d-a425-a55204380db9@linaro.org>
Date:   Sat, 11 Jun 2022 23:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YqStDm5sdDL6YXn8@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/11 下午10:56, Matthew Wilcox wrote:
> On Sat, Jun 11, 2022 at 09:34:42PM +0800, Zhangfei Gao wrote:
>> Commit 1c563432588d ("mm: fix is_pinnable_page against a cma page")
>> Changes from
>> return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
>>          is_zero_pfn(page_to_pfn(page));
>> to
>> return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
> Mailing lists can be read as well as written.
>
> https://lore.kernel.org/linux-mm/165490039431.944052.12458624139225785964.stgit@omen/
Oops, I am stucked in debugging the qemu hung issue, not noticed it has 
been fixed.

Thanks Matthew.
