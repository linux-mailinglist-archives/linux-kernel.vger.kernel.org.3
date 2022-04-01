Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3774EF3D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349165AbiDAO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiDAOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5E8EBC7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648823582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FkKGzcuRI3KoanzjeW8ZOHsDrDg07oCSregG+FQ4Kw=;
        b=Tep+GDuei6eVmf45zPq3kjOIg2BkYPdetRiIqNHb02l6lClFZimlHH1SKY/+sOr/twJxMu
        JU8tVt/rWhbXA8CVzTBi33mvBEe2mtKVX0jZ33ay24xjkzf9FHbbYgX0UNZZeRmt4+z9eF
        P1ClbickyAxT6Ej9WVXesX/rB1ne49Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-wKM647CTOPOufhEMG7txWw-1; Fri, 01 Apr 2022 10:33:01 -0400
X-MC-Unique: wKM647CTOPOufhEMG7txWw-1
Received: by mail-wr1-f72.google.com with SMTP id d17-20020adfc3d1000000b00203e2ff73a6so646436wrg.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=3FkKGzcuRI3KoanzjeW8ZOHsDrDg07oCSregG+FQ4Kw=;
        b=qJMKLKpH+9TrNPsvFn+GmLHhf3+Ea58+kFKy9xsTGQgJsU6LsrYTCXbTEATUe+ANb2
         BloBEA4w5dhMfmZqO4mytB8g+l+yPCbfE8AqaG8QfBMvUnBd1TAwyUf0F/N3X7X6b/gA
         hobFeWHQbztraL8NR99ZB54R0fsLSzMIScYeM3Yktdelmj908FSrk4VXMG5r4FGzCTEb
         XZiHYwOHGm43NmxH7rbhtKnTik9Hbm/YC1wfPd5WaGebylBqUYlGkyumBWy4YNniEIRa
         /0r0gC6LtJ0XRf47MnOnnZKEVrlXxavwMMZlTUoI3Zf+o9oZzg0I3nKWYLj8wicuF/AF
         81Dw==
X-Gm-Message-State: AOAM533GfVNZGsLWLIfdPvKyBmGLcY6Rl/1WHq8OT3D88XZSvZrMDkuI
        d3v257BDDfwTGnx2rsr79q36qM7SwcCXvAuW7s79QaeGFxoeCEBYHY1UHgHwOjpRSOxZrWaeNgA
        YMjMmz2p+W1HXDvMjx/lRPaMP
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr8159236wri.569.1648823580413;
        Fri, 01 Apr 2022 07:33:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyV9Q2jBUjWwSiTkc1PF8AjDbEpvkrStU0j3S3k+eK49Ta/wdPOnig6w7vETKZoWdfoezUzw==
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr8159222wri.569.1648823580173;
        Fri, 01 Apr 2022 07:33:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id e8-20020a05600c2dc800b0038d05f2b34dsm10629273wmh.2.2022.04.01.07.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:32:59 -0700 (PDT)
Message-ID: <6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com>
Date:   Fri, 1 Apr 2022 16:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check
 in __free_one_page().
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
 <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
 <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
Organization: Red Hat
In-Reply-To: <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 16:22, David Hildenbrand wrote:
> On 01.04.22 16:19, Zi Yan wrote:
>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>
>>> On 01.04.22 15:58, Zi Yan wrote:
>>>
>>> It's weird, your mails arrive on my end as empty body with attachment. I
>>> first suspected Thunderbird, but I get the same result on the google
>>> mail web client.
>>>
>>> Not sure why that happens.
>>
>> No idea. They look fine (except mangled links by outlook) on my outlook
>> desk client and web client on my side. lore looks OK too:
>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/
> 
> I can spot in the raw mail I receive
> 
> "Content-Type: application/octet-stream; x-default=true"
> 
> But that seems to differ to the lore mail:
> 
> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw
> 
> 
> Maybe something in my mail server chain decides to do some nasty
> conversion (grml, wouldn't be the first time)
> 

Weird thing is that this only happens with your mails. I opened an
internal ticket, sorry for the noise.

-- 
Thanks,

David / dhildenb

