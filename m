Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A214B54AD72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349852AbiFNJfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiFNJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56BDC3DA7B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655199332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MtzWc5ofab5C3Xtt/UU+xbF7j8EBZN/y+HPGXLzh6o=;
        b=Gfo9614SsvMTDcQWdGdfcDGHMi/7CpxRty3hrWO8qv6w/qiwOteFmMj57ETmuTSbEufrQA
        4DiRImS5T+2INtiIH1u89s4Xar8uYWv1OIPGsy6hZrQgNC+5KNLQmMno9p6iPzVAB6mrms
        e3F4p7AB8+nfpsB/iSPRheCShGS9gxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-nrIU1TUaOq6hPc4oE2oobQ-1; Tue, 14 Jun 2022 05:35:30 -0400
X-MC-Unique: nrIU1TUaOq6hPc4oE2oobQ-1
Received: by mail-wm1-f71.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so4543267wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6MtzWc5ofab5C3Xtt/UU+xbF7j8EBZN/y+HPGXLzh6o=;
        b=DwPpVPU9It4caJjYKVJz3mdfvewreaB1VQyfxbQstD1pPb8OmsLmV9kUeU9l7uH5dg
         JQ+mTioA54ZoBxhNru9pfCOdQVYwLBk5I93zhwA44IXLLnaSaLQ+p5opZA6ZyHJ+bbki
         VZsP4e+muSTs4RTC0pwRCXtlM4gPfFtJ2OzFumKcIDoRBEH0xKQKJiM1GElDOXnCigSZ
         d428icuOSor8QkTwMkUBoDJ+MJ7zp3Me4zS4H+BY+JVPup4ijRG6+Uz3deUtUJSanfzG
         YIx3i7nSdRuTse1/yX1HlX4hcWd5onCr6fBCL54PiMsR/VDsQIIyReSfl77WleNgVlWf
         nbZw==
X-Gm-Message-State: AOAM533qzLFh95k9L8Dk9jndnp1eU9o+0qAHcNBlwgZ7ocpbU4A2g/PZ
        Zu3p4McFCpOdajKa/zMD4IBFyk0UhftEaZNHB23AlW4HDvCJlowWjA73uLSy8lnOvQ1Jk0/MBQT
        4/AjaPOr4z2LTe06s1UUV3D9+
X-Received: by 2002:a05:600c:4f84:b0:39c:9897:5295 with SMTP id n4-20020a05600c4f8400b0039c98975295mr3163976wmq.158.1655199329713;
        Tue, 14 Jun 2022 02:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydT242xpHrC7qCjNL4VuiBuNAOuitTkJEsXEJRCe7Z8yDT7urJGUrIk5+392xLlCaSjSrSTw==
X-Received: by 2002:a05:600c:4f84:b0:39c:9897:5295 with SMTP id n4-20020a05600c4f8400b0039c98975295mr3163959wmq.158.1655199329486;
        Tue, 14 Jun 2022 02:35:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:cf00:aace:de16:d459:d411? (p200300cbc70bcf00aacede16d459d411.dip0.t-ipconnect.de. [2003:cb:c70b:cf00:aace:de16:d459:d411])
        by smtp.gmail.com with ESMTPSA id r132-20020a1c448a000000b0039c798b2dc5sm14905286wma.8.2022.06.14.02.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:35:29 -0700 (PDT)
Message-ID: <2eb3f679-9779-2d7e-0863-5c808cf99ed6@redhat.com>
Date:   Tue, 14 Jun 2022 11:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220610101258.75738-1-david@redhat.com>
 <YqhV7W68zR4yorQL@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqhV7W68zR4yorQL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.22 11:33, Greg Kroah-Hartman wrote:
> On Fri, Jun 10, 2022 at 12:12:58PM +0200, David Hildenbrand wrote:
>> There are certainly a lot more files that partially fall into the memory
>> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
>> and mm/page_alloc.c. Let's only add what's almost completely memory
>> hot(un)plug related.
>>
>> Add myself as reviewer so it's easier for contributors to figure out
>> whom to CC.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  MAINTAINERS | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a6d3bd9d2a8d..77aebce76288 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
>>  F:	mm/
>>  F:	tools/testing/selftests/vm/
>>  
>> +MEMORY HOT(UN)PLUG
>> +M:	Andrew Morton <akpm@linux-foundation.org>
>> +R:	David Hildenbrand <david@redhat.com>
>> +L:	linux-mm@kvack.org
>> +S:	Maintained
>> +F:	Documentation/admin-guide/mm/memory-hotplug.rst
>> +F:	Documentation/core-api/memory-hotplug.rst
>> +F:	drivers/base/memory.c
>> +F:	include/linux/memory_hotplug.h
>> +F:	mm/memory_hotplug.c
>> +F:	tools/testing/selftests/memory-hotplug/
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> One question, will patches from you go through my driver core tree, or
> the -mm tree?  Either is fine for me, just curious.

In the past, most stuff regarding drivers/base/memory.c went through
-mm, so I'd say we keep it like that, unless it's really generic changes
to the driver model etc.

-- 
Thanks,

David / dhildenb

