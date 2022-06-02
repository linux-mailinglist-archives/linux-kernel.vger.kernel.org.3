Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3653B547
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiFBImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D0AC36B47
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654159321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXuoIf4WN2eU+uzadafzU5Y/KqghoiWZuGnVyJ/94kc=;
        b=NUAjThWeewXnca5+pdlR+yOmQROf6MrACL6WfnyAZV9yeBve8/36DH7j3yPJizWkDxepxN
        UXnRfbDUs10XWLc4exTS1Bv1A6rgH1NTGTstBfFFb6vpLVJVAUCCbQNxNdR8HJODn4USTt
        WpAAehTsiXwtWiEfc1av45UWlkI3H84=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-1k9Suwd9Nu-BdvzM3aZbug-1; Thu, 02 Jun 2022 04:42:00 -0400
X-MC-Unique: 1k9Suwd9Nu-BdvzM3aZbug-1
Received: by mail-wr1-f71.google.com with SMTP id h2-20020adfe982000000b002102da95c71so624329wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MXuoIf4WN2eU+uzadafzU5Y/KqghoiWZuGnVyJ/94kc=;
        b=RLu01RfSCjObf+88FmTftodlee/3dxEdIFRvo5s0Tw7iwQIPstYm4IBLthkL283UNy
         RPRh/33wGUTH6FDFsP/58kbD1+G0pN61+qWxlgn3JadeGCujq/rbahNC0w9A5KhxOAl1
         Yq311Xl55WaWCdJsx2Dz8nXLCMDKg2eLvC7VJbdk2yJFyL9P+Vztei39NRFRskZlzmQZ
         fpZR+afL3uk+s99yMk+9BQHUwRhIumM3Hhn4OPqFutpgq+tjFqcu2LPcWNfmslmoOdiG
         /ty0YlGItu+hFftemcRw33XJj4sASCjsDo7PmSXpBMqhhWD347GWqk9Z4y5tPc7XT6Eq
         s1Nw==
X-Gm-Message-State: AOAM530VfzIAdeh+nKKkxR+7ub+Fs2ahpFiI2cgIL8RqklWQvqunijfA
        TzY1Rgh1nnavPhyfYFmmFSViHrp99wh7HWOMFyZHvidBn/FucoJcY7nwl23AQ6TldTgJrNQ3kHz
        khmZvXau0mhMjFtkYh0Bd9I0X
X-Received: by 2002:a5d:52c7:0:b0:210:ac6:3956 with SMTP id r7-20020a5d52c7000000b002100ac63956mr2733029wrv.379.1654159318924;
        Thu, 02 Jun 2022 01:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy+bZAz9peLrXzAJXRgf5aOn+EaYE5T4t2tfJFaIrD632/2BjAImz3WYzkWCezdMgMv6JQFw==
X-Received: by 2002:a5d:52c7:0:b0:210:ac6:3956 with SMTP id r7-20020a5d52c7000000b002100ac63956mr2733012wrv.379.1654159318692;
        Thu, 02 Jun 2022 01:41:58 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de. [87.161.167.214])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c204e00b003974b95d897sm7542880wmg.37.2022.06.02.01.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:41:57 -0700 (PDT)
Message-ID: <5c041ef1-05ec-f49f-7ada-fa58d5aec8ba@redhat.com>
Date:   Thu, 2 Jun 2022 10:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-3-linmiaohe@huawei.com>
 <20220530160409.c9b17085adb6112d8580f37d@linux-foundation.org>
 <c7d6fec7-039d-2f54-c3b3-95deb7417a73@huawei.com>
 <33d6aec8-b4fc-aa37-27f4-f33984ea33d3@redhat.com>
 <c7d0d606-61ba-9cfc-3c2a-961a88b6c3e5@huawei.com>
 <f30cb41f-474c-91f2-4912-37387b8b3782@redhat.com>
 <1d550b5c-1409-cb9e-5de6-476d515c9a94@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1d550b5c-1409-cb9e-5de6-476d515c9a94@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.22 09:29, Miaohe Lin wrote:
> On 2022/6/1 15:53, David Hildenbrand wrote:
>> On 01.06.22 04:11, Miaohe Lin wrote:
>>> On 2022/5/31 20:58, David Hildenbrand wrote:
>>>> On 31.05.22 04:55, Miaohe Lin wrote:
>>>>> On 2022/5/31 7:04, Andrew Morton wrote:
>>>>>> On Fri, 27 May 2022 17:26:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>
>>>>>>> At swapoff time, we're going to swap in the pages continuously. So calling
>>>>>>> lookup_swap_cache would confuse statistics. We should use find_get_page
>>>>>>> directly here.
>>>>>>
>>>>>> Why is the existing behaviour wrong?  swapoff() has to swap stuff in to
>>>>>> be able to release the swap device.  Why do you believe that this
>>>>>> swapin activity should not be accounted?
>>>>>
>>>>> IMHO, statistics, e.g. swap_cache_info.find_success, are used to show the effectiveness
>>>>> of the swap cache activity. So they should only reflect the memory accessing activity
>>>>> of the user. I think swapoff can't reflect the effectiveness of the swap cache activity
>>>>> because it just swaps in pages one by one. Or statistics should reflect all the activity
>>>>> of the user including swapoff?
>>>>
>>>> I'm wondering who cares and why?
>>>
>>> I thought it's used to show the effectiveness of the swapcache readahead algorithm. If nobody
>>> ever cares about it now, I'm fine to drop this patch. And could these statistics be removed
>>> since nobody cares about it?
>>
>> IIUC, they are printed (via show_swap_cache_info()), which is called via
>> show_free_areas() -- primarily used via show_mem(). show_mem() is
>> primarily used when OOM, when allocation fails and we warn, from the OOM
>> killer, on panic().
>>
>> I am not sure how useful for (OOM ?) debugging the find_success vs.
>> find_total stats are at all. They are from ancient times. In
>> bb63be0a091c ("tmpfs: move swap_state stats update") we removed other
>> statistics that are "are relics of my 2.4.11 testing". Maybe
>> find_success and find_total can be similarly removed.
> 
> Maybe add_total, del_total, find_success and find_total should be similarly removed altogether?
> It seems those can't provide useful info when OOM occurs? And we can thus avoid touching the
> swap_cache_info cacheline.

At least makes sense to me, AFAIKU, these are not statistics one could
easily use to tune system performance because they are not easily
accessile. Maybe simply propose removal?


-- 
Thanks,

David / dhildenb

