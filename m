Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06AB4E7D71
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCYUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiCYUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 294665A092
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648239595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaVEjwXsaEy7cL7JZ+Za+DImYZdSvwVcJnKXWnRGcmo=;
        b=N8d6zWPJdkAQANoZdwxtt/kVMxE0vJN4W8B4SlenS0KAE/jEHCruQVgC8T1oZJF7vgObRx
        bJD+cKAxNd0DDDOsjsqx+/tJtzgDs2uGDMKi55tG68mcPuLFQCCT5dsu6zgS95x2uF4+Nm
        CaiuBJ5favMqGVzFEBtELYEc8gUM5zg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-VqUDbZcCN5WaV9ZW7ex9LA-1; Fri, 25 Mar 2022 16:19:54 -0400
X-MC-Unique: VqUDbZcCN5WaV9ZW7ex9LA-1
Received: by mail-wr1-f72.google.com with SMTP id l19-20020adf9f13000000b00203f7f64c7bso2995918wrf.18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BaVEjwXsaEy7cL7JZ+Za+DImYZdSvwVcJnKXWnRGcmo=;
        b=oOrbUFMAiMrDNDSxTu6BVWDZj14QKxFRtIjqge7ImOxzhbyiPVxpLQsNLENwp1vQUX
         IXcXtmpa/JHtipHxvhnLrDr693gwnqLHIG0LoXC9qfPeM5XUqqnCGdECxHh71hNPhQHj
         sib6Dkep7OqlC0Bj4dKBVoOAN7BkfSQEiFSDnusxufZG+kdDKgJRkllLROBbHshZidgZ
         hI0qxvCXWvRkf09cIH96yfMmrbH5kY+Cg+jLqPL8TmaiNz2pfTiLOThiofqcCGEN8aIg
         5FWo7czzYAPg2xV7itMokC5C8dLfVrxs0//xh7nJJOVQik0ZIhKF03zGLFOwBTfuoR2/
         BvAA==
X-Gm-Message-State: AOAM532QtSjXID1Jca5wVKCh6oHwPU/1FH/WgjJEbcVQO/iGzTNSBg3f
        3JUks5QAORkujl6X/CRu+kg/hqdojodf09qSz2R04NPX/qmjGptzjdUpJKzWkI3/QRkNuaX0EzB
        0Kj21foL9shy1Gz60knIWfDZ8
X-Received: by 2002:a5d:588b:0:b0:204:1c1a:965d with SMTP id n11-20020a5d588b000000b002041c1a965dmr10653936wrf.669.1648239593314;
        Fri, 25 Mar 2022 13:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyklR57T5x3dRn1ErKGUmoiztN0RoMK7oC4+/r9nKYD6tFd8xCH69JAOhXQJEPU1GHkeTEKQ==
X-Received: by 2002:a5d:588b:0:b0:204:1c1a:965d with SMTP id n11-20020a5d588b000000b002041c1a965dmr10653911wrf.669.1648239593051;
        Fri, 25 Mar 2022 13:19:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4200:6374:a71a:a88:a4b? (p200300cbc70542006374a71a0a880a4b.dip0.t-ipconnect.de. [2003:cb:c705:4200:6374:a71a:a88:a4b])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm9619012wms.25.2022.03.25.13.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:19:52 -0700 (PDT)
Message-ID: <7f3a973f-1f0c-4e50-2528-b0e9dc3e4cac@redhat.com>
Date:   Fri, 25 Mar 2022 21:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] mm/vmstat: add events for ksm cow
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, cgel.zte@gmail.com
Cc:     yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, dave.hansen@linux.intel.com,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
 <20220325130957.171a68dee88118082ab841c5@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220325130957.171a68dee88118082ab841c5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.22 21:09, Andrew Morton wrote:
> On Thu, 24 Mar 2022 10:43:33 +0000 cgel.zte@gmail.com wrote:
> 
>> From: Yang Yang <yang.yang29@zte.com.cn>
>>
>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>> to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>> get to know how much memory ksm saved by reading
>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
>> of ksm cow, and this is important of some delay sensitive tasks.
>>
>> So add ksm cow events to help users evaluate whether or how to use ksm.
> 
> It's unclear (to me) how anyone will actually use this, how they will
> interpret the output.
> 
> Some tutorial words added to Documentation/vm/ksm.rst would be helpful.
> While in there, please check for any other /proc/vmstat fields which
> we forgot to document.
> 
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -131,6 +131,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>  		SWAP_RA_HIT,
>>  #ifdef CONFIG_KSM
>>  		KSM_SWPIN_COPY,
>> +		COW_KSM,
> 
> I agree that this name looks unpleasingly backwards.  Do we have an
> expectation that we actually will be adding more COW_* fields?

As raised previously (also when proposing this), I'd like to have
COW_ANON, COW_ZERO, COW_OTHER. Ideally, we'd have added all via a single
patch for them. They would at least be of value to me.

-- 
Thanks,

David / dhildenb

