Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873CE539EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiFAHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347620AbiFAHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AA615A0BB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654069990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfTQV2dw8hYxGglp3MNiBHOFQe8P3zuj5Ixn98HI0Bs=;
        b=ghJYqy5xw8yLiUPLTWkFZZCzyVF8pO61wWZt/TsalDftxLHEz3skt7WQoRVnfbWoqhVVaq
        pQDaR2HRFBSUFeqk22GKqckzNL2cw/oiUISL5i0CpO9pqUZxOuHK06g+lEy2+8DJerFzad
        ynyFkVzz69VCuAxtlTlFjXWKNNZsCSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-iOoDj4t7OrSJTJkAF1TsZw-1; Wed, 01 Jun 2022 03:53:09 -0400
X-MC-Unique: iOoDj4t7OrSJTJkAF1TsZw-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b003978decffedso2922908wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=WfTQV2dw8hYxGglp3MNiBHOFQe8P3zuj5Ixn98HI0Bs=;
        b=GHZ4NvuiiPMxTW+2gJA4+naRLCIR5WgD5s53RMCFzr25IhJuSK7SbHT+kyA8Yc4tp2
         l6bpvwSgbsXwdg7YIvKexk5VM/eyCBYm+WWjICcBvinu/DgAeP5aVWLVPsOW3xBdtiBa
         U9KxXE0KJ2edFhLu1ggLqN2B7LxADlr9pGrY/o3qRdkJ6GVLcX9UE+EZ33jURXT1F+2O
         SnOjzJz/6ROQ/FIBCRPkH81p6iEBHC09hcJopFmHzwXiS0MXegtw9n1wvoHZCB3GIif/
         JzbQkpR/19ddz9oInxdIjjoVGlA14G9KHcQwXT8htQjJCTaKSOKO6ZtxZ74+x37Z/HVT
         Ae7Q==
X-Gm-Message-State: AOAM530YlhDuRfyQSwELvXmBh9X2GpUzoya7yknPHmlSQ0mlSu7mgeRj
        MHMsqNKl2UaLqVt0NVtwaOrW+RgDW1iu7Y2hHeygJ/bOJbLH989u+zQys/hgll8q0RTI9utM15n
        zb86MjKEcQ0Hmb12vZCOShbN6
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id m32-20020a05600c3b2000b003976311c0c7mr26773654wms.69.1654069988551;
        Wed, 01 Jun 2022 00:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIP/IShrFh9WxWIxXWGHraxlb9iB2vLncW/DvU4dVpsiNbC+hBWi5Buj/lRSq8+rr+RmMzCA==
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id m32-20020a05600c3b2000b003976311c0c7mr26773635wms.69.1654069988286;
        Wed, 01 Jun 2022 00:53:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d61d0000000b0020d110bc39esm810922wrv.64.2022.06.01.00.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:53:07 -0700 (PDT)
Message-ID: <f30cb41f-474c-91f2-4912-37387b8b3782@redhat.com>
Date:   Wed, 1 Jun 2022 09:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-3-linmiaohe@huawei.com>
 <20220530160409.c9b17085adb6112d8580f37d@linux-foundation.org>
 <c7d6fec7-039d-2f54-c3b3-95deb7417a73@huawei.com>
 <33d6aec8-b4fc-aa37-27f4-f33984ea33d3@redhat.com>
 <c7d0d606-61ba-9cfc-3c2a-961a88b6c3e5@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
In-Reply-To: <c7d0d606-61ba-9cfc-3c2a-961a88b6c3e5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 04:11, Miaohe Lin wrote:
> On 2022/5/31 20:58, David Hildenbrand wrote:
>> On 31.05.22 04:55, Miaohe Lin wrote:
>>> On 2022/5/31 7:04, Andrew Morton wrote:
>>>> On Fri, 27 May 2022 17:26:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>>> At swapoff time, we're going to swap in the pages continuously. So calling
>>>>> lookup_swap_cache would confuse statistics. We should use find_get_page
>>>>> directly here.
>>>>
>>>> Why is the existing behaviour wrong?  swapoff() has to swap stuff in to
>>>> be able to release the swap device.  Why do you believe that this
>>>> swapin activity should not be accounted?
>>>
>>> IMHO, statistics, e.g. swap_cache_info.find_success, are used to show the effectiveness
>>> of the swap cache activity. So they should only reflect the memory accessing activity
>>> of the user. I think swapoff can't reflect the effectiveness of the swap cache activity
>>> because it just swaps in pages one by one. Or statistics should reflect all the activity
>>> of the user including swapoff?
>>
>> I'm wondering who cares and why?
> 
> I thought it's used to show the effectiveness of the swapcache readahead algorithm. If nobody
> ever cares about it now, I'm fine to drop this patch. And could these statistics be removed
> since nobody cares about it?

IIUC, they are printed (via show_swap_cache_info()), which is called via
show_free_areas() -- primarily used via show_mem(). show_mem() is
primarily used when OOM, when allocation fails and we warn, from the OOM
killer, on panic().

I am not sure how useful for (OOM ?) debugging the find_success vs.
find_total stats are at all. They are from ancient times. In
bb63be0a091c ("tmpfs: move swap_state stats update") we removed other
statistics that are "are relics of my 2.4.11 testing". Maybe
find_success and find_total can be similarly removed.

data_race() indicates to me that these stats are somewhat best-effort
already.

-- 
Thanks,

David / dhildenb

