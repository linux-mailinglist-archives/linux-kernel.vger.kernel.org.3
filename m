Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAA4F8FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiDHHdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiDHHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54A111D0F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649403088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJie/UdH9Mqf7tAIiWd8hXnktBcEVlo+NQRFJbbT0jQ=;
        b=JwIiK0CVfCp3wjMb+11ryweoEmeU2F/gEDNqymOcXgWbO+HQ6e/Ba9P/K5Pnu6OjBQsmBa
        bpNWaASmlUw5gVXyvG/ekBcjWV/IthUgSxLs43T1jltG0MDID7DxjbTxzgXjAKodLN6FHf
        cx8kTCOg6vRTz841qAQAV9ozIzrBGaE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-WpvjlPijNHa5anCtP-Xsjw-1; Fri, 08 Apr 2022 03:31:26 -0400
X-MC-Unique: WpvjlPijNHa5anCtP-Xsjw-1
Received: by mail-wr1-f72.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so1959505wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=AJie/UdH9Mqf7tAIiWd8hXnktBcEVlo+NQRFJbbT0jQ=;
        b=1r3m3gYCijvdeY6xAJ1ZEh/jzTXb+7ul5C0XIZQG0baw/zkNL3wgzg6XwiaZTxSMI1
         CdCYA+zQIo51sgwbra5eIgPuZGnj4EgvllqsBzTvHla3wbTc/p9or/8t8KJ4/iDu1Rag
         22DGhiolk5ONb3y/ZCihrkAQ6o/WiLSkAtwD2ZJV31zY230ByQeoCuLDSih0nOGxtl95
         OvJuzpXTemnThVgMUKwXToLAPRhveQKstObsl3uGdhFfDfcr8lJm5VJBTnnwXFCvyGt0
         lyPdxunrmO2w3N25BbrJtRLctjjRRWF8vnVskY88Cc62304e1+jhc5JGUb0O+zRDu3F9
         pkdw==
X-Gm-Message-State: AOAM532kB5+SaMSEt5E9cjGfJqVEzZGMg5cr7NqW1thFq0PKYLB1HAoq
        RpMB0erMS+XS5KeDW3N5ggn4VIn048kQ8tNLog+rlC33w1qWqWopfXrT1vObZIq5e99U/6pYGmP
        208sOgAJxKhBc3FlV5c5rvrZg
X-Received: by 2002:a1c:7517:0:b0:38c:8722:9bc6 with SMTP id o23-20020a1c7517000000b0038c87229bc6mr15680350wmc.2.1649403085212;
        Fri, 08 Apr 2022 00:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3TTJ46O1ZC2FKUoNgMnaa7amF/PK4+JqHt94o201sprDkj+NNKAsFzvfC8rddbjp5DCgwYA==
X-Received: by 2002:a1c:7517:0:b0:38c:8722:9bc6 with SMTP id o23-20020a1c7517000000b0038c87229bc6mr15680330wmc.2.1649403084913;
        Fri, 08 Apr 2022 00:31:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:fd00:612:f12b:a4a2:26b0? (p200300cbc704fd000612f12ba4a226b0.dip0.t-ipconnect.de. [2003:cb:c704:fd00:612:f12b:a4a2:26b0])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm28007860wry.72.2022.04.08.00.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:31:24 -0700 (PDT)
Message-ID: <a6ce4cd3-dfbc-134c-88a0-40fefa8094f6@redhat.com>
Date:   Fri, 8 Apr 2022 09:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] delayacct: track delays from COW
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, bsingharora@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
References: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
 <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
 <624d434a.1c69fb81.11e99.b2b8@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <624d434a.1c69fb81.11e99.b2b8@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.22 09:37, CGEL wrote:
> On Wed, Mar 23, 2022 at 09:49:46AM +0100, David Hildenbrand wrote:
>> On 22.03.22 12:04, cgel.zte@gmail.com wrote:
>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>
>>> Delay accounting does not track the delay of COW. When tasks trigger
>>> much COW, it may spend a amount of time waiting for it. To get the
>>> impact of tasks in COW, measure the delay when it happens. This
>>> could help users to do tunnings, such as decide whether to use
>>> ksm or not.
>>>
>>> Also update tools/accounting/getdelays.c:
>>>
>>>     / # ./getdelays -dl -p 231
>>>     print delayacct stats ON
>>>     listen forever
>>>     PID     231
>>>
>>>     CPU             count     real total  virtual total    delay total  delay average
>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>     IO              count    delay total  delay average
>>>                         0              0              0ms
>>>     SWAP            count    delay total  delay average
>>>                         0              0              0ms
>>>     RECLAIM         count    delay total  delay average
>>>                         0              0              0ms
>>>     THRASHING       count    delay total  delay average
>>>                         0              0              0ms
>>>     COMPACT         count    delay total  delay average
>>>                         3          72758              0ms
>>>     COW             count    delay total  delay average
>>>                      3635      271567604              0ms
>>
>> You should also update Documentation/accounting/delay-accounting.rst
>> most probably.
>>
>> Overall LGTM and this might be of value not only for KSM but for anybody
>> using fork(). There will be collisions with [1], especially [2], which I
>> want to get in -next early after we have v5.18-rc1 (after rebasing [1]
>> on top of this).
>>
>> We'll have to decide if we want to also account hugetlb wp code
>> (hugetlb_cow), and if we want to account "unsharing" here as well under
>> cow (I tend to say that we want to for simplicity). For THP, we only
>> split and don't copy, so there isn't anything to account.
>>
> As for simplicity, what about account "PAGECOPY" instead of "COW"?
> "PAGECOPY" include COW and unsharing. And we may also account hugetlb
> wp in follow-up patches, based on this patch is sufficient reviewed.

PAGECOPY might be too generic. You actually want to express "potentially
shared page was copied by the write-fault handler while it was write
protected".

do_wp_page()->wp_page_copy()

Maybe simply "WP_COPY" as a prefix ("Write-protect copy") ?

-- 
Thanks,

David / dhildenb

