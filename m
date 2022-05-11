Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5749D522E36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiEKIWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiEKIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:22:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004FA2E6B3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:22:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 204so1362857pfx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ok9rm5eSTA5NSL17Rhwq9EtRVWax1XY2Vi3Ds9AAgoI=;
        b=1kOoitGokYdgXjsF0flRyn8o7fugnSK/+ThmSsEeyuc8Enzq/2hd03m5qRiq9Ddz3J
         D1C5Ojry6Yl5nxjnZxEcZwN8oPaZrWH/tzk6KJZx0uKnrpvGOyteBoMwR17maxPhuDRw
         NffRsYiQHTkoTmRR9n8SOQ8eK5jk+5TQL5rrvPque8hUwxph2iJq5AY7LJyFEfyezb9D
         KaK2IaqLfcA4jSN+AE8+vPh71imDXpesFT5ZM9xoUlwFWTnymsWlhfWb5LdJUj3Lgv3F
         /3HGDMUPcz8RhIYOm3lVGBBQmQ9Ij4OE7H9TVztToRykZSK6Ekyssd71dyPgZdV+wCud
         r6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ok9rm5eSTA5NSL17Rhwq9EtRVWax1XY2Vi3Ds9AAgoI=;
        b=4a/vFw8DNJhsfwqvRyNcpkS+MfPjkN/BHWkBV8pk55d+K+Fw8cKlyjEP9xB9QaABtb
         IIPz+yd9MBnCxeFo57vIS9QSWKZi39FLlz1XCjtFG8rQqer/eo6KyLHUzzLufFn48yGI
         AWzDhWyXBLk8ZNejPIeRuc8fXWxM0IXSrSrAp/zMvAYhZRzc/Qv0PjhDku5HhKQ5vPXg
         bRXuM3Tta+WahGbzh4Rp6vBVfxOCeBjr2oALLlDZOK07NSZB33muz0LwOShqba5u3nE6
         aMuz7+HyJ23rj3HrlfA8idnhc5BmAWmRq9TN/mZZKEpYV4tycYqL7N4H0Sko5Jy4jBtc
         OjMw==
X-Gm-Message-State: AOAM530Se87psR+1wQesC80xtihWrO2o8S5kt85FrPMosvrQVPPNLTSg
        errHUR5lQHOgqwseggk1HQFQS60vvwPsHQ==
X-Google-Smtp-Source: ABdhPJyI3XwnQck5yj0j+Fts4bxAMxiOgAF+ugKSbXj5JQ/HxpiYyfhMeBXr1WNEXRZRkmxuF6q2Xw==
X-Received: by 2002:a65:6e9b:0:b0:3c5:f761:2d94 with SMTP id bm27-20020a656e9b000000b003c5f7612d94mr19725021pgb.79.1652257330292;
        Wed, 11 May 2022 01:22:10 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id c20-20020a62e814000000b0050dc7628130sm1035498pfi.10.2022.05.11.01.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 01:22:09 -0700 (PDT)
Message-ID: <7aceb944-4c53-8cc8-473d-fc8a9da0ef11@bytedance.com>
Date:   Wed, 11 May 2022 16:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH v2 5/5] mm/memory-failure.c: simplify
 num_poisoned_pages_inc/dec
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
 <20220509105641.491313-6-pizhenwei@bytedance.com>
 <20220511082011.GC211620@hori.linux.bs1.fc.nec.co.jp>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220511082011.GC211620@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 16:20, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, May 09, 2022 at 06:56:41PM +0800, zhenwei pi wrote:
>> Originally, do num_poisoned_pages_inc() in memory failure routine,
>> use num_poisoned_pages_dec() to rollback the number if filtered/
>> cancelled.
>>
>> Suggested by Naoya, do num_poisoned_pages_inc() only in
>> action_result(), this make this clear and simple.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> 
> I found that action_result(MF_MSG_UNKNOWN) in try_memory_failure_hugetlb()
> does not follow the rule, so that could break the counter.
> I don't think this is the issue in your patch, so I'm fine with this patch.
> 
> I'll submit a fix later for this, which will add hugetlb_set_page_hwpoison()
> in the path.  That will have a bit non-trivial change because we need do
> this in hugeltb_lock.
> 
> Anyway, thank you for this work.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

A million thanks to you!

-- 
zhenwei pi
