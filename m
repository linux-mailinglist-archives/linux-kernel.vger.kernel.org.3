Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A45246F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350959AbiELH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiELH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD42B13B8C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652340524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfstWGJUBLYX/+vki/Cy7YQudH1HsO0LES4kozBG1lU=;
        b=F0VQSI0cyUE6Nufk4mVJzGJKvikmTO6uye+PjEV1YfCQ0X2bqbsvY/DqlnJvZ2LoeuSNZD
        CzaGqxzTGHFzUwheRIqYhyEsUJ/yc8VxF3pGvgiMy3G0Aku1ncnQRRib9OQR2pStlw2/t8
        5EeQwZi7WdiEzG9vgDOkEg3urZjiLfo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-LT9iwnfFPDGgzSk8MxuNcg-1; Thu, 12 May 2022 03:28:43 -0400
X-MC-Unique: LT9iwnfFPDGgzSk8MxuNcg-1
Received: by mail-wr1-f71.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1724996wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QfstWGJUBLYX/+vki/Cy7YQudH1HsO0LES4kozBG1lU=;
        b=E7Zx19z0ZHT/C5nW29KNhhKcBriII91ImJfZ7g7noeI/+gnAKDntB9hInOspK+Q64p
         VAnKSLOc2hBgH6Mh0h017OKsG0hoolBUsTqSJcmmT75Eltk7zTdP9uAVQUKY1p/c1+/8
         WYWnU9XtfJu9Uam6XGxX906XdKnkCrgrWKqrV+33fAUV0ucAvQNzANO6GbjNJ2e/7sQi
         363wzIsegiYIEnff94f3BucJRgkQCTG30jCf7kgc1xnxb3kfOPXq6bULHmg88PcA0qVY
         WXXqn+kP0sww5NYL1AE8ahc+hHGIZzwqA22lYZYmb0RWF3uNMVC95Bdtjk7tDPDl16n8
         B54g==
X-Gm-Message-State: AOAM530Bmks61pDDX3dLJ+xZe+HBcq33tJmhBEvKS5iS/u7awUL0wASS
        uLAqm+47quPj/HX8yUT/tJlP/3Nq8V+/dy/LylvIDRB8XF6OkEPfqgfYZpzx5oyLZlXZ5LMHB2V
        QDtJU33qWZ1B0cBmkfd5AyEyy
X-Received: by 2002:a05:600c:3583:b0:394:804f:ecb2 with SMTP id p3-20020a05600c358300b00394804fecb2mr8858177wmq.10.1652340522087;
        Thu, 12 May 2022 00:28:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQpDPTggJKfya+MUlFlEpIuFmh0Zg+1wFOukWRLIMOVAz7TNkC4C6ofLd3Z14O0Stff2rccA==
X-Received: by 2002:a05:600c:3583:b0:394:804f:ecb2 with SMTP id p3-20020a05600c358300b00394804fecb2mr8858161wmq.10.1652340521830;
        Thu, 12 May 2022 00:28:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d618c000000b0020c5253d8f2sm3383048wru.62.2022.05.12.00.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:28:41 -0700 (PDT)
Message-ID: <c424e8a2-a771-e738-396c-24ac907b557f@redhat.com>
Date:   Thu, 12 May 2022 09:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
 <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>
>>>> Once the problematic DIMM would actually get unplugged, the memory block devices
>>>> would get removed as well. So when hotplugging a new DIMM in the same
>>>> location, we could online that memory again.
>>>
>>> What about PG_hwpoison flags?  struct pages are also freed and reallocated
>>> in the actual DIMM replacement?
>>
>> Once memory is offline, the memmap is stale and is no longer
>> trustworthy. It gets reinitialize during memory onlining -- so any
>> previous PG_hwpoison is overridden at least there. In some setups, we
>> even poison the whole memmap via page_init_poison() during memory offlining.
>>
>> Apart from that, we should be freeing the memmap in all relevant cases
>> when removing memory. I remember there are a couple of corner cases, but
>> we don't really have to care about that.
> 
> OK, so there seems no need to manipulate struct pages for hwpoison in
> all relevant cases.

Right. When offlining a memory block, all we have to do is remember if
we stumbled over a hwpoisoned page and rememebr that inside the memory
block. Rejecting to online is then easy.

-- 
Thanks,

David / dhildenb

