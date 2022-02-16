Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D14B8A99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiBPNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:47:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiBPNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41B1413F67
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645019220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/viJHST1z9zD64KMBaMBA5BOjVQloi17QEdRKdLQtOY=;
        b=GRM7/m+bjzZJdiYNVR9iJAcdVTPUGZjbhCFtrlyP/7RYzQsOWuEYmFD/31V899oGMUVVtO
        GOsPXYp7R4Nr7khvWy0amQ1FWS27lINprMaaaVDO6lh8LlcGPeJy9fZlh7WOGaseWUFi3V
        cJ06FS8etm3qrVsV1bcUlqxJ9viileM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-FYwnBy1xMuGcMybxId4W3Q-1; Wed, 16 Feb 2022 08:46:59 -0500
X-MC-Unique: FYwnBy1xMuGcMybxId4W3Q-1
Received: by mail-wm1-f70.google.com with SMTP id k30-20020a05600c1c9e00b0037d1bee4847so2909393wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/viJHST1z9zD64KMBaMBA5BOjVQloi17QEdRKdLQtOY=;
        b=cv0TYjaYxeTw11TtyzV1o16pBjn5T71E8uaAd8VjqcQ6NqAUmRDKFeRDqmP0BbUfIR
         23ZQGlNLgwOIBe3FfA6XvU6T1e9DTJVt4UjS0HVPvdLAyZyctPdvxBk5lBu7LmrIPaNj
         Sn7PFMCIxX3kclAc7thX1s2bKwGNIA7IX6jzkIUSVUjZf+k65z6FXqDB8jFaj3vHAN4N
         VdDkdlTKdwORNl47dUECqBNnJYQwsARBXehcPFQEGgHqcJ1vWcGiGhD2v4c3eNe8Gu5X
         Ok5X+3oxyCtbaDdqXJExXdKuHeOJCDUZOnHPBDgl+U4yL7X9PDwz65zN5tE7ppnavBCs
         Bv+A==
X-Gm-Message-State: AOAM530cuaXoC4QnlVX3CEczlbb2IzMcjys/fuHypvwCCkfNgxquozdp
        MeJ2UIiDDwhpiVhvTaV5NG9c2rdWZKj7aPH7aTu40BrlXJGQoTb0GFgUTyTFiW+JY0p/vQcSqTL
        vTl1dd1gMYEaicHRmtrCSC5kZ
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id i5-20020adfb645000000b001e30bab7594mr2431180wre.346.1645019218055;
        Wed, 16 Feb 2022 05:46:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXN+PGgiUh4jnY/IHW6kWYB+oyHZfFkJJcHP/ie9LhxwJ94HR5UHGasOFkSazLdIrHd1wXpw==
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id i5-20020adfb645000000b001e30bab7594mr2431161wre.346.1645019217772;
        Wed, 16 Feb 2022 05:46:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:600:4ff7:25c:5aad:2711? (p200300cbc70b06004ff7025c5aad2711.dip0.t-ipconnect.de. [2003:cb:c70b:600:4ff7:25c:5aad:2711])
        by smtp.gmail.com with ESMTPSA id l26sm18554970wms.24.2022.02.16.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:46:57 -0800 (PST)
Message-ID: <9738c049-a6a2-19f7-f9be-e7ae98c2c66b@redhat.com>
Date:   Wed, 16 Feb 2022 14:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     osalvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
References: <20220210184359.235565-1-david@redhat.com>
 <20220210184359.235565-3-david@redhat.com>
 <YguFFRiNIktJhGnT@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
In-Reply-To: <YguFFRiNIktJhGnT@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi David
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> One minor thing below: 
> 
>> @@ -663,6 +743,17 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
>>  	mem->nr_vmemmap_pages = nr_vmemmap_pages;
>>  	INIT_LIST_HEAD(&mem->group_next);
>>  
>> +#ifndef CONFIG_NUMA
>> +	if (state == MEM_ONLINE)
>> +		/*
>> +		 * MEM_ONLINE at this point implies early memory. With NUMA,
>> +		 * we'll determine the zone when setting the node id via
>> +		 * memory_block_add_nid(). Memory hotplug updated the zone
>> +		 * manually when memory onlining/offlining succeeds.
>> +		 */
>> +		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);
> 
> I took me a couple of minutes to figure out that MEM_ONLINE implies
> early memory at this point because 1) of course early memory must be
> online and 2) the only caller that passes MEM_ONLINE to
> init_memory_block() is add_memory_block(), which only gets called at
> boot time. (btw, add_memory_block() really should use __init, right?)
> 
> I guess what I am saying here is: I really like the comment, but I am not sure
> whether other people with a drifting brain like mine will also wonder about
> that.

Thanks for the review!

I originally planned on passing "enum meminit_context context" here, but
it just uglifies the function without any real added value. MEM_ONLINE
is fully expressive.

In general:
a) Boot memory always starts out online.
b) Hotplugged memory always starts out offline.


And yes, add_memory_block() chould __init, that would also make it
clearer out of which context init_memory_block() is called with
MEM_ONLINE. I can send an addon patch for that!

-- 
Thanks,

David / dhildenb

