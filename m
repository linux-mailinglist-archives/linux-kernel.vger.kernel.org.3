Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14D4F7AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiDGJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiDGJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D886215DAB2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649322037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0inCEjJJWw//2DoC93l0BxRCxkrP6GV4SWwsKG2zpLQ=;
        b=aJxOc89Id1Wis/A/CoCs0zLw7VELjzmN2teAJK6WWAhLr6n7bnho+Y0w9T2rKrUXufBbP9
        GNU81ZsqKgErQZHC+xC+DN5PJcussH5ZmHjY1rd8JHXIPUjUBAAgU1p76xGc015DhRfX45
        0LrTsmj5F8cxn7sGsqm4lv/aU1MsYCY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-oaIHuCeKPAaVUJYwE42asQ-1; Thu, 07 Apr 2022 05:00:36 -0400
X-MC-Unique: oaIHuCeKPAaVUJYwE42asQ-1
Received: by mail-wm1-f69.google.com with SMTP id c62-20020a1c3541000000b003815245c642so4286221wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0inCEjJJWw//2DoC93l0BxRCxkrP6GV4SWwsKG2zpLQ=;
        b=kzn6ssAo5JRF63I4o2dZmGmu5gqbe8hjWJ40j8dUtePo5ERQWu4yASHjbeCKoniDZg
         F8gOpvW+2p1kRlWksb4yKzB65sr1I00TS+0/5/HZUidpAGpj4vT9XBgNUaSPkXimW3//
         teiOlRmRO03kZFa4hr53qeWwEiMyRwIpLby9U6/KN5JO56DRlo7Q7BaleBWx60MuEsrc
         0OlaIZwHOOQEaooODDXiaavOtEF2+410V1Zjr9Vap5pYGbsuvXxvGTVcBdjhff0MeSL2
         2JIi/+dkuxcqxGIx39YHLcUW4aFNTDOk4JQ5P7gv08H2czc+dh8NSRyxRUOQS2zbOWVt
         a/iA==
X-Gm-Message-State: AOAM531ZsJu0egyYQmFnD/kcmh40pOELDC+DwayNZ6tCZiYnv2zBu1Px
        jt4MXrR5Go9zPTvvQLZpALuuFztRONgpg97gT2r+6xeTZ32B/3+bHKTjnHz8yeVWgLq1gwIWFEm
        KvzsCv0ikZoZQ4WhHwFGAM2UE
X-Received: by 2002:a05:600c:17c5:b0:38e:7853:e915 with SMTP id y5-20020a05600c17c500b0038e7853e915mr11065439wmo.123.1649322035314;
        Thu, 07 Apr 2022 02:00:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDXbmi0MYBbhyvRv3XQym+Vvb0hr0yJXFvC8twCFVw7fXFScumPU3//4ro5ZrKBn7rVoiing==
X-Received: by 2002:a05:600c:17c5:b0:38e:7853:e915 with SMTP id y5-20020a05600c17c500b0038e7853e915mr11065408wmo.123.1649322035047;
        Thu, 07 Apr 2022 02:00:35 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm7933452wmq.23.2022.04.07.02.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:00:34 -0700 (PDT)
Message-ID: <f423e210-3e28-73f8-1082-869ef680b9b0@redhat.com>
Date:   Thu, 7 Apr 2022 11:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] xen/balloon: fix page onlining when populating new zone
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        stable@vger.kernel.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20220406133229.15979-1-jgross@suse.com>
 <89ad978d-e95e-d3ea-5c8f-acf4b28f992c@redhat.com>
 <4f1908b5-5674-a772-3cd9-78e4dc40f776@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4f1908b5-5674-a772-3cd9-78e4dc40f776@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.22 10:50, Juergen Gross wrote:
> On 07.04.22 10:23, David Hildenbrand wrote:
>> On 06.04.22 15:32, Juergen Gross wrote:
>>> When onlining a new memory page in a guest the Xen balloon driver is
>>> adding it to the ballooned pages instead making it available to be
>>> used immediately. This is meant to enable to add a new upper memory
>>> limit to a guest via hotplugging memory, without having to assign the
>>> new memory in one go.
>>>
>>> In case the upper memory limit will be raised above 4G, the new memory
>>> will populate the ZONE_NORMAL memory zone, which wasn't populated
>>> before. The newly populated zone won't be added to the list of zones
>>> looked at by the page allocator though, as only zones with available
>>> memory are being added, and the memory isn't yet available as it is
>>> ballooned out.
>>
>> I think we just recently discussed these corner cases on the -mm list.
> 
> Indeed.
> 
>> The issue is having effectively populated zones without manages pages
>> because everything is inflated in a balloon.
> 
> Correct.
> 
>> That can theoretically also happen when managing to fully inflate the
>> balloon in one zone and then, somehow, the zones get rebuilt.
> 
> I think you are right. I didn't think of that scenario.
> 
>> build_zonerefs_node() documents "Add all populated zones of a node to
>> the zonelist" but checks for managed zones, which is wrong.
>>
>> See https://lkml.kernel.org/r/20220201070044.zbm3obsoimhz3xd3@master
> 
> I found commit 6aa303defb7454 which introduced this test. I thought
> it was needed due to the problem this commit tried to solve. Maybe I
> was wrong and that commit shouldn't have changed the condition when
> building the zonelist, but just the ones in the allocation paths.

In regard to kswapd, that is currently being worked on via

https://lkml.kernel.org/r/20220329010901.1654-2-richard.weiyang@gmail.com

-- 
Thanks,

David / dhildenb

