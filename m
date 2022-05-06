Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7A51DD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443803AbiEFQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348771AbiEFQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7956D97E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651854506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Afy3LRmgbTX/W4kOJBv51V2x19c9yS1eYu85zuJRd9c=;
        b=gWUvg6N7La++DUgnKPV9d+0zxmCQI4hNRcCQX0n3lsONKH/Ji0geA+1aMkEgF1rWIRpMdv
        ZYnEqX+awXtUsqJhhRVeBfQNtf8dmziNpD6E1Eie81HVuYA4/o+3zOyis8f1BDHPoSnIDv
        nxf0ER7wAwZpbQS5dv7oxowX1EO0urA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-2i-8go06MgSme212aB9cKQ-1; Fri, 06 May 2022 12:28:24 -0400
X-MC-Unique: 2i-8go06MgSme212aB9cKQ-1
Received: by mail-qk1-f200.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so5252260qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Afy3LRmgbTX/W4kOJBv51V2x19c9yS1eYu85zuJRd9c=;
        b=zcPlAhHvMWRFxoNEpKpHAverqEEujYRdK54tzTrC4qFjsTs9TJ5kJ9MC8qYapaZjjl
         h47c2URzHifrv2nNxdbN/yo4UEKq7qRUmPQdTkm/lYqU+3pYOTfw133MGa0uuvuViCeo
         0BY/jQDx/Rulk1tPWWUygVzWzsJwK4T8kO514DHMxukeo+dqCMofa9J0DImIe9cjZbc5
         JZ9pNaYBJK0AsSYb0Ik8DrGspQPQorz1GBYyRAmm/f4WX6SCiwCjrWtRKyBiXqWaseNs
         6xUWy8f1gPaV7acfcbFa48Hmch0ItrOnb0eUQxM/5LRJuid0b8LGEm7GOuIG8mqGCve6
         YmbA==
X-Gm-Message-State: AOAM530XkBtFrRnGz7JB1+Lw4cMtB9YRLj0SWw4J43BLZXi6wp496h7C
        J0UUOmDAA5FEYyF5+Cys1fNidZ4lQkrtLUF+vygCzWsVjJ7uRGcK+3jB+S5o8r60uUlnFZaGmby
        YEMDIrgrbjaqOA0DDvpD60GhQ
X-Received: by 2002:a05:620a:4405:b0:6a0:30b7:7d5b with SMTP id v5-20020a05620a440500b006a030b77d5bmr2843343qkp.482.1651854504221;
        Fri, 06 May 2022 09:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9mEOuQZwJEmFcxWadpmKCBaw0BWvAOMjoo5GmSP6daGuDLSFXPHz5F/LLg72a11CQ2+pb/A==
X-Received: by 2002:a05:620a:4405:b0:6a0:30b7:7d5b with SMTP id v5-20020a05620a440500b006a030b77d5bmr2843324qkp.482.1651854503954;
        Fri, 06 May 2022 09:28:23 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
        by smtp.gmail.com with ESMTPSA id l1-20020ae9f001000000b0069fd35d2abcsm2638745qkg.112.2022.05.06.09.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:28:23 -0700 (PDT)
Message-ID: <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
Date:   Fri, 6 May 2022 18:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.22 15:38, zhenwei pi wrote:
> 
> 
> On 5/6/22 16:59, Naoya Horiguchi wrote:
>> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>>> In the memory failure procedure, hwpoison_filter has higher priority,
>>> if memory_filter() filters the error event, there is no need to do
>>> the further work.
>>
>> Could you clarify what problem you are trying to solve (what does
>> "optimize" mean in this context or what is the benefit)?
>>
> 
> OK. The background of this work:
> As well known, the memory failure mechanism handles memory corrupted 
> event, and try to send SIGBUS to the user process which uses this 
> corrupted page.
> 
> For the virtualization case, QEMU catches SIGBUS and tries to inject MCE 
> into the guest, and the guest handles memory failure again. Thus the 
> guest gets the minimal effect from hardware memory corruption.
> 
> The further step I'm working on:
> 1, try to modify code to decrease poisoned pages in a single place 
> (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).
> 
> 2, try to use page_handle_poison() to handle SetPageHWPoison() and 
> num_poisoned_pages_inc() together. It would be best to call 
> num_poisoned_pages_inc() in a single place too. I'm not sure if this is 
> possible or not, please correct me if I misunderstand.
> 
> 3, introduce memory failure notifier list in memory-failure.c: notify 
> the corrupted PFN to someone who registers this list.
> If I can complete [1] and [2] part, [3] will be quite easy(just call 
> notifier list after increasing poisoned page).
> 
> 4, introduce memory recover VQ for memory balloon device, and registers 
> memory failure notifier list. During the guest kernel handles memory 
> failure, balloon device gets notified by memory failure notifier list, 
> and tells the host to recover the corrupted PFN(GPA) by the new VQ.

Most probably you might want to do that asynchronously, and once the
callback succeeds, un-poison the page.

> 
> 5, host side remaps the corrupted page(HVA), and tells the guest side to 
> unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA) 
> dynamically.

I think QEMU already does that during reboots. Now it would be triggered
by the guest for individual pages.

> 
> Because [4] and [5] are related to balloon device, also CC Michael, 
> David and Jason.

Doesn't sound too crazy for me, although it's a shame that we always
have to use virtio-balloon for such fairly balloon-unrelated things.

-- 
Thanks,

David / dhildenb

