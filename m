Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B33508E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381108AbiDTRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiDTRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B64D64F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650476102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKAkPbXEzZV1qW7Yf+K43ZjoPL2L8btAjUFH9iivH88=;
        b=hzyHL+4shNnTqYE2zK2ntSpIHQ/vmmYKdni5nMsqeWljXt28We1xZqmANcFFy92Yucu8Ol
        zGgwMnRTi6iOUZU4lM1cDjlMmxjzdi53d+4cUg0HrMGpXztGdelvwZCIe87J812nGikxrc
        efiQRpbY9gIYcaKAJceW/bE3IWLC5Ug=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-7sfD_bbvO5yWfwj68A2r6A-1; Wed, 20 Apr 2022 13:35:01 -0400
X-MC-Unique: 7sfD_bbvO5yWfwj68A2r6A-1
Received: by mail-qt1-f197.google.com with SMTP id m11-20020ac807cb000000b002f33f7f7d69so1460852qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OKAkPbXEzZV1qW7Yf+K43ZjoPL2L8btAjUFH9iivH88=;
        b=5QWumtay+Pzy6egSqQa91sA4DffNG2+x6Q5GC8cP0hUoRJFqhldnFZ2La4F76T8yY4
         8AmFaHo+sCbllmaL15EhTHXKMiKbDwFk1j9PuevOO/nNktOWtoiIMJdmegGYQAfc08Dz
         AAeSzmBr9KKHU5Km/XDKG7nysuilYiVEYaoT5XlWCqTWdX5W7HmmtVh3m2/iliY3FX6m
         quMQ7H+nIO2U/SaWCf4otE6P2xwJrFdmaRLKXz33YC9rDFRiphu9UIfasbxJydwohajs
         vBWNZoyix2aYwGo0Aig9HDwj9X6n3ohoQm2JMNLhJR+nJpwqDZslsiZGW+taecmUG2pO
         4oMw==
X-Gm-Message-State: AOAM531zMKLsuVS8Jjrlb1J95EDhHWnh/4/FTj2m+j6TIlHlwaR/GV7Z
        wnZiN9HTNjuCpI/h6whPJVoen+WvYgw4FAVnbLv572XXcDzqHmv5Ot9adRU/K+EssgYx/BxN3SO
        bDuC4/IciUcqCE+2mkxaIIMVu
X-Received: by 2002:a37:bc7:0:b0:69e:e276:6bb1 with SMTP id 190-20020a370bc7000000b0069ee2766bb1mr1750870qkl.167.1650476100026;
        Wed, 20 Apr 2022 10:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnLjVdFYI/13G+bE3rTsQ8NB67Vc1qHeY1rAUEDrVf2oy9SKMyiCXWuHubCyzVvInKsh2p5g==
X-Received: by 2002:a37:bc7:0:b0:69e:e276:6bb1 with SMTP id 190-20020a370bc7000000b0069ee2766bb1mr1750863qkl.167.1650476099801;
        Wed, 20 Apr 2022 10:34:59 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm1959757qtw.7.2022.04.20.10.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 10:34:59 -0700 (PDT)
Message-ID: <bc9f5209-5c59-c921-d85e-e2e54b2375db@redhat.com>
Date:   Wed, 20 Apr 2022 13:34:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
 <Yl8Dk+a1YDwupLMv@cmpxchg.org>
 <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
 <YmASIHjTVndHHoL4@cmpxchg.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YmASIHjTVndHHoL4@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 10:01, Johannes Weiner wrote:
>> My swappiness=0 solution was a minimal approach to regaining the 'avoid swapping
>> ANON' behavior that was previously there, but as Shakeel pointed out, there may
>> be something larger at play.
> 
> So with my patch and swappiness=0 you get excessive swapping on v1 but
> not on v2? And the patch to avoid DEACTIVATE_ANON fixes it?

correct, I haven't tested the DEACTIVATE_ANON patch since last time I was
working on this, but it did cure it. I can build a new kernel with it and verify
again.

The larger issue is that our workload has regressed in performance.

With V2 and swappiness=10 we are still seeing some swap, but very little tearing
down of THPs over time. With swappiness=0 it did some when swap but we are not
losings GBs of THPS (with your patch swappiness=0 has swap or THP issues on V2).

With V1 and swappiness=(0|10)(with and without your patch), it swaps a ton and
ultimately leads to a significant amount of THP splitting. So the longer the
system/workload runs, the less likely we are to get THPs backing the guest and
the performance gain from THPs is lost.

So your patch does help return the old swappiness=0 behavior, but only for V2.

Ideally we would like to keep swappiness>0 but I found that with my patch and
swappiness=0 we could create a workaround for this effect on V1, but any other
value still results in the THP issue.


After the workload is run with V2 and swappiness=0 the host system look like this**:
               total        used        free      shared  buff/cache   available
Mem:       264071432   257536896      927424        4664     5607112     4993184
Swap:        4194300           0     4194300

Node 0 AnonPages:      128145476 kB	Node 1 AnonPages:      128111908 kB
Node 0 AnonHugePages:  128026624 kB	Node 1 AnonHugePages:  128090112 kB

** without your patch there is still some swap and THP splitting but nothing
like the case below.

Same workload on V1/swappiness=0 looks like this:
               total        used        free	  shared  buff/cache   available
Mem:	   264071432   257169500     1032612        4192     5869320     5357944
Swap:        4194300      623008     3571292

Node 0 AnonPages:      127927156 kB     Node 1 AnonPages:      127701088 kB
Node 0 AnonHugePages:  127789056 kB     Node 1 AnonHugePages:  87552000 kB
								^^^^^^^

This leads to the performance regression I'm referring to in later workloads.
V2 used to have a similar effect to V1, but not nearly as bad. Recent updates
upstream fixed this in V2.

The workload tests multiple FS types so this is most likely not a FS specific
issue either.

> If you haven't done so, it could be useful to litter shrink_node() and
> get_scan_count() with trace_printk() to try to make sense of all the
> decisions that result in it swapping.
Will do :) I was originally doing some BPF tracing that lead me to find the
DEACTIVE_ANON case.

Thanks,
-- Nico

