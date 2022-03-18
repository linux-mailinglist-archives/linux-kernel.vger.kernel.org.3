Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39D4DD602
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiCRIXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCRIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8F222298
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647591710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MDxVA2EwZ5Sv6QfEAtDaBAheOB5XbiWwchPRUQfQRw=;
        b=SJT++Ja9CSkIYt4ALBY82sKXkeG4wUeQ7VeCNpwsRZYhB4VyqdgK3Bql+Yxy3e3fgOdx/T
        13xfZRW0iwAztKjqsgAUXnlfy/a1J3Mn1qcYsgr5Va1m4E9ymU9f2x8cU4UksJ2hiOyiAR
        lw/13orQOSmip3uD2QO2Mq4FRmK60bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-AL6GdjTsMNedPLlHbfb2HA-1; Fri, 18 Mar 2022 04:21:49 -0400
X-MC-Unique: AL6GdjTsMNedPLlHbfb2HA-1
Received: by mail-wm1-f70.google.com with SMTP id o19-20020a05600c379300b0038c7117460dso2401806wmr.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0MDxVA2EwZ5Sv6QfEAtDaBAheOB5XbiWwchPRUQfQRw=;
        b=aDjMhFQB1QMppFs6755+2KR96i80KRQkzo19FXRKPG/rgX/tEovGSXsNrBlZWxpZPf
         OSgmFpMyE0hl/nWs55+vrD3D69fwcY8jTbjncmhk35Fs/fN856iJ5h8M0FXeozwQ16wS
         NO2pwjj7t2YNXVhk+jbrnDJuqBPnPsM/D39m+RmQbYCGO93T9rNpmn5/X/UBNMqFcKwx
         H5jHwouUBsiJBtTttG3Dh9poK6QeksosBkYUFqpVq9pq5RuUyJCSxhtVGWQ+faJWEiy2
         fnawEMbx7wEmljx/OWiUPAiRx09MwdQ4gg+N2jsmZxQxsMXUY14Uqdty27C2DS8I7/zS
         NkdA==
X-Gm-Message-State: AOAM5329E8GEbi5z7FngyCMKgevISyot3aqn3Hgpo4ZLfTCQTUCnsfgy
        Ata3PfaJLH2mvXGsUv6W1TT71vtUBtLt+GWTwq3gCePiDGuWCqE8XZVdptJV2Wd+CAWngumKESy
        NN0Qv//+/sCdcfQ9vY9pMJ07s
X-Received: by 2002:adf:fe4a:0:b0:203:fb08:11d8 with SMTP id m10-20020adffe4a000000b00203fb0811d8mr197395wrs.356.1647591708225;
        Fri, 18 Mar 2022 01:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTyuk2uv2CLh4Pacq9Jr7nZxo1WSE7M1vWg5mZnRPhyRCC1hJehrGKvC3TTnTVTHeBhNNx8A==
X-Received: by 2002:adf:fe4a:0:b0:203:fb08:11d8 with SMTP id m10-20020adffe4a000000b00203fb0811d8mr197374wrs.356.1647591707858;
        Fri, 18 Mar 2022 01:21:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b00384d42a9638sm6067460wma.2.2022.03.18.01.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:21:47 -0700 (PDT)
Message-ID: <8483f080-a23e-fe5d-88c2-4b32d8fda521@redhat.com>
Date:   Fri, 18 Mar 2022 09:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
 <fbe8f659-44dd-dd10-a3c3-acaf387abd4d@redhat.com>
 <1c54d958-9da2-97d0-e9a8-7629d4a3f7bd@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1c54d958-9da2-97d0-e9a8-7629d4a3f7bd@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.22 02:17, maobibo wrote:
> 
> 
> On 03/17/2022 08:32 PM, David Hildenbrand wrote:
>> On 17.03.22 07:50, Bibo Mao wrote:
>>> On platforms like x86/arm which supports hw page walking, access
>>> and dirty bit is set by hw, however on some platforms without
>>> such hw functions, access and dirty bit is set by software in
>>> next trap.
>>>
>>> During numa page fault, dirty bit can be added for old pte if
>>> fail to migrate on write fault. And if it succeeds to migrate,
>>> access bit can be added for migrated new pte, also dirty bit
>>> can be added for write fault.
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>  mm/memory.c | 21 ++++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index c125c4969913..65813bec9c06 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>>>  		page_nid = target_nid;
>>>  		flags |= TNF_MIGRATED;
>>> +
>>> +		/*
>>> +		 * update pte entry with access bit, and dirty bit for
>>> +		 * write fault
>>> +		 */
>>> +		spin_lock(vmf->ptl);
>>
>> Ehm, are you sure? We did a pte_unmap_unlock(), so you most certainly need a
>>
>> vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> yes, we need probe pte entry again after function pte_unmap_unlock().
>>
>>
>> Also, don't we need pte_same() checks before we do anything after
>> dropping the PT lock?
> I do not think so. If page succeeds in migration, pte entry should be changed
> also, it should be different.
> 

We have to be very careful here. Page migration succeeded, so I do
wonder if you have to do anything on this branch *at all*. I'd assume
that page migration too care of that already.

See, when only holding the mmap lock in read mode, there are absolutely
no guarantees what will happen after dropping the PT lock. The page
could get unmapped and another page could get mapped. The page could
have been mapped R/O in the meantime.

So I'm pretty sure that unconditionally modifying the PTE here is wrong.

-- 
Thanks,

David / dhildenb

