Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F404E30A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352532AbiCUTTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352538AbiCUTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ABF925EB2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647890280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvhBps1UXtsrc+nGVheIq+OQ/K59QvLDMVnB+No/i7I=;
        b=AgQD6PVigewuCHQjOGkGKUwEvAlhsLyITdgn8tMyS5Nu3YCwZuIKVc28qPdEKAFpuucDPG
        x55EqpoUcyR1YakkHtCYveJI7JvxIjZRHvIwuRnoo7Pcwaowh8npENBaS/5MMCYwtAvxcX
        5659j+cP7yN7qrG5jBnUTDZA9kfxDPI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-AyFv3_pKOx2CvG1jURIx6Q-1; Mon, 21 Mar 2022 15:17:59 -0400
X-MC-Unique: AyFv3_pKOx2CvG1jURIx6Q-1
Received: by mail-qt1-f200.google.com with SMTP id t19-20020ac86a13000000b002e1fd2c4ce5so6844095qtr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uvhBps1UXtsrc+nGVheIq+OQ/K59QvLDMVnB+No/i7I=;
        b=1vU8Humxnn9YruITJ9E6ji2f96/3pf7cOEDKhWuKf/chKX+B2QN/x51ddBo9PDrOec
         Bz1Ralz+SxWeXQRl74eVTtu4om05/Wn/vuW59AIxmw9fh3CZCyYhNon/W/B6dl51iDXn
         /vCIhiu8pGWif0cK59dseFTLfhEVFE4ffbJqTHpelT/rmQd209AuS0D0IbiAA43UjiB7
         aELR5ZPuClaihbEujRoEDqieQl2vpTHlqhG5Od9rATvY2ilphslQcaABwA+b+Po5ZNuM
         dRPgTLfQgP+SCkw1gNKGkhkQO+qaZppk2SljA7bDp5X8quIlSgpfqVSoEqSWtkXBFxGu
         C9dw==
X-Gm-Message-State: AOAM530EYy/ew9UgPMZ5MU/KvBtYPrw6AXQ+/xa7WXM/gjScg1CzJhkh
        VZ5o9guJ0Bwsgi0UumvTabp0+2742KvZi5bf12eWdYQq+1C87314FoxHVXDNaxvxu5/zpWuw8x/
        +TXUF3UBA5A32n3UCquzcugZ6
X-Received: by 2002:a05:622a:50d:b0:2e2:1006:35b6 with SMTP id l13-20020a05622a050d00b002e2100635b6mr6045833qtx.536.1647890278919;
        Mon, 21 Mar 2022 12:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT6OD/Y0C23YFhyuuCC1pdsNk4eMbxjtnCENsX9okSWpzu6X4wl532+Yylnnt9cpM9agH2sw==
X-Received: by 2002:a05:622a:50d:b0:2e2:1006:35b6 with SMTP id l13-20020a05622a050d00b002e2100635b6mr6045807qtx.536.1647890278574;
        Mon, 21 Mar 2022 12:17:58 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a0b0100b0067d3ac00982sm7944596qkg.57.2022.03.21.12.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:17:57 -0700 (PDT)
Message-ID: <cf736b49-57e3-51df-56af-5b71d0304e4a@redhat.com>
Date:   Mon, 21 Mar 2022 15:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
Content-Language: en-US
To:     Justin Forbes <jforbes@fedoraproject.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, kernel-team@lists.ubuntu.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Brian Geffon <bgeffon@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Sofia Trinh <sofia.trinh@edi.works>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Donald Carr <d@chaos-reins.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        kernel <kernel@lists.fedoraproject.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220309021230.721028-1-yuzhao@google.com>
 <20220309021230.721028-6-yuzhao@google.com>
 <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
 <CAFxkdAouXr5Qn9asFge0P-HqA4aAk56yqP4xEiaWYRioJ1ssyA@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <CAFxkdAouXr5Qn9asFge0P-HqA4aAk56yqP4xEiaWYRioJ1ssyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 14:58, Justin Forbes wrote:
> On Mon, Mar 14, 2022 at 4:30 AM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Mon, Mar 14, 2022 at 2:09 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>
>>> Hi, Yu,
>>>
>>> Yu Zhao <yuzhao@google.com> writes:
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 3326ee3903f3..747ab1690bcf 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -892,6 +892,16 @@ config ANON_VMA_NAME
>>>>          area from being merged with adjacent virtual memory areas due to the
>>>>          difference in their name.
>>>>
>>>> +# the multi-gen LRU {
>>>> +config LRU_GEN
>>>> +     bool "Multi-Gen LRU"
>>>> +     depends on MMU
>>>> +     # the following options can use up the spare bits in page flags
>>>> +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
>>>
>>> LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
>>> by LRU_GEN?
>>
>> LRU_GEN doesn't really care about NR_CPUS. IOW, it doesn't impose a
>> max number. The dependency is with NODES_SHIFT selected by MAXSMP:
>>      default "10" if MAXSMP
>> This combined with LAST_CPUPID_SHIFT can exhaust the spare bits in page flags.
>>
>> MAXSMP is meant for kernel developers to test their code, and it
>> should not be used in production [1]. But some distros unfortunately
>> ship kernels built with this option, e.g., Fedora and Ubuntu. And
>> their users reported build errors to me after they applied MGLRU on
>> those kernels ("Not enough bits in page flags"). Let me add Fedora and
>> Ubuntu to this thread.
>>
>> Fedora and Ubuntu,
>>
>> Could you please clarify if there is a reason to ship kernels built
>> with MAXSMP? Otherwise, please consider disabling this option. Thanks.
>>
>> As per above, MAXSMP enables ridiculously large numbers of CPUs and
>> NUMA nodes for testing purposes. It is detrimental to performance,
>> e.g., CPUMASK_OFFSTACK.
> 
> It was enabled for Fedora, and RHEL because we did need more than 512
> CPUs, originally only in RHEL until SGI (years ago) complained that
> they were testing very large machines with Fedora.  The testing done
> on RHEL showed that the performance impact was minimal.   For a very
> long time we had MAXSMP off and carried a patch which allowed us to
> turn on CPUMASK_OFFSTACK without debugging because there was supposed
> to be "something else" coming.  In 2019 we gave up, dropped that patch
> and just turned on MAXSMP.
> 
> I do not have any metrics for how often someone runs Fedora on a
> ridiculously large machine these days, but I would guess that number
> is not 0.

It is not 0.  I've seen data from large systems (1000+ logical threads) 
that are running Fedora albeit with a modified Fedora kernel.

Additionally the max limit for CPUS in RHEL is 1792, however, we have 
recently had a request to *double* that to 3584.  You should just assume 
that number will continue to increase.

P.


> 
> Justin
> 
>> [1] https://lore.kernel.org/lkml/20131106055634.GA24044@gmail.com/
>>
> _______________________________________________
> kernel mailing list -- kernel@lists.fedoraproject.org
> To unsubscribe send an email to kernel-leave@lists.fedoraproject.org
> Fedora Code of Conduct: https://docs.fedoraproject.org/en-US/project/code-of-conduct/
> List Guidelines: https://fedoraproject.org/wiki/Mailing_list_guidelines
> List Archives: https://lists.fedoraproject.org/archives/list/kernel@lists.fedoraproject.org
> Do not reply to spam on the list, report it: https://pagure.io/fedora-infrastructure

