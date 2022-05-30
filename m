Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB60537611
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiE3HyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiE3HyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 243B99FC5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653897214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lW8fZRkPKfhJnNOw18gq2IWP/lJEsxr/x1aT3dj708I=;
        b=SCujWkYkawSu5Ur9OUPTVS+UIXCRpPPQBM4ZPnGCeGu3Swpx9lYuJx7d5KmECJL1MOc7nw
        iLdhVaePuXBn56v7KRnIeZzhlCJhWxKf6E/e2iB439uag+R4Sy0u4YB2g3Jac4UOge88qA
        2uUw9EdOYwCF/BWEhZ3Y/c8dFpjMhl4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-OO-sqtlgPfKHeFNi7UdIKA-1; Mon, 30 May 2022 03:53:33 -0400
X-MC-Unique: OO-sqtlgPfKHeFNi7UdIKA-1
Received: by mail-wr1-f69.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1431201wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lW8fZRkPKfhJnNOw18gq2IWP/lJEsxr/x1aT3dj708I=;
        b=6ehuOeasHe5cZu276li8I9zDmN4pOxawGFDkRSvo4IS0frvoQt1nwiduKcBmJ8+2Wm
         1zvh62CvfcZmWqaFz+sLw5dPso8tQSFuJXsODjsxxwyvHgrfCJ6P8X/PnjtmhWBvQHba
         J08f3CxShpxoLTHw8a/mQgECvQQwRXf8XDjwizqnttXf/GB+bXRBklJgI10bhSW+9h/L
         xe3MMfeDD5MVBWq79887Pp0L20i7FHVNLMvC6uJBhmALsyuuDMz3tFQyKlOfQdzHiBi0
         gDkd+hFE23TaYxJ/rgjcVH/KADKV8JMlvg2pNEK/BsXz8PnB1iB0VIo0Ffqvh/B2vlLz
         PU5A==
X-Gm-Message-State: AOAM532NVglr86nevDVEkVINNcY4vibWup2GAdhT+aZkUxVu8ZZMeAIo
        +nJZIZWJDGBy4x+ncA78pr09RJV6velw0IiLwk8RafA32ZXF5KI00MiTkhsXp5Pa4H6u0iomQ8D
        CVrPLPyVcjJ76EweSvEA9Cn36
X-Received: by 2002:a05:600c:3543:b0:397:7565:ea4 with SMTP id i3-20020a05600c354300b0039775650ea4mr17556015wmq.86.1653897211918;
        Mon, 30 May 2022 00:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXMX0mVia1YfTVILgUPjxKu9Fq37hgGHboYr/arqWNq5GxPQTIQAE8Q8/KSnUDs6PSNUeh1A==
X-Received: by 2002:a05:600c:3543:b0:397:7565:ea4 with SMTP id i3-20020a05600c354300b0039775650ea4mr17555999wmq.86.1653897211629;
        Mon, 30 May 2022 00:53:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0020c5253d907sm8266521wro.83.2022.05.30.00.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:53:31 -0700 (PDT)
Message-ID: <fdbdb249-8f8f-5ca9-509c-6b4a4b94236a@redhat.com>
Date:   Mon, 30 May 2022 09:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <Yo0zmP28FqpivlxF@google.com>
 <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.22 01:32, zhenwei pi wrote:
> 
> 
> On 5/25/22 03:35, Sean Christopherson wrote:
>> On Fri, May 20, 2022, zhenwei pi wrote:
>>> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>>>   	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>>>   };
>>>   
>>> +/* the request body to commucate with host side */
>>> +struct __virtio_balloon_recover {
>>> +	struct virtio_balloon_recover vbr;
>>> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
>>
>> I assume this is copied from virtio_balloon.pfns, which also uses __virtio32, but
>> isn't that horribly broken?  PFNs are 'unsigned long', i.e. 64 bits on 64-bit kernels.
>> x86-64 at least most definitely generates 64-bit PFNs.  Unless there's magic I'm
>> missing, page_to_balloon_pfn() will truncate PFNs and feed the host bad info.
>>
> 
> Yes, I also noticed this point, I suppose the balloon device can not 
> work on a virtual machine which has physical address larger than 16T.

Yes, that's a historical artifact and we never ran into it in practice
-- because 16TB VMs are still rare, especially when paired with
virtio-balloon inflation/deflation. Most probably the guest should just
stop inflating when hitting such a big PFN. In the future, we might want
a proper sg interface instead.

-- 
Thanks,

David / dhildenb

