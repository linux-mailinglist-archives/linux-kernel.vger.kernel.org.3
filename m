Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B15252CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356618AbiELQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356597AbiELQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E0842685DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652373618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NsJep5oCvE52cG8IYLZ5lNH1MW8yFZhmyzXX66loBtY=;
        b=XoLxstCC8bh8lkxKIfPpYg/4m6wrS7Q+HFvk1vz5XUwdyFCDeg9KX26j3PMwy0oipBl4Mn
        PyVZ1tYmGcDvW2qKbmSnB3vdFosutCODGwJ+n53k95cEbKoW/g9r8cHO5nx2ebQ43ijOiI
        7yyphX6dIN8GXHf/GnXBb7eVTHh30mw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-Kr9BY_KXP7W46BRkyXm1aA-1; Thu, 12 May 2022 12:40:16 -0400
X-MC-Unique: Kr9BY_KXP7W46BRkyXm1aA-1
Received: by mail-wm1-f69.google.com with SMTP id 26-20020a05600c021a00b003940660c053so1845973wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NsJep5oCvE52cG8IYLZ5lNH1MW8yFZhmyzXX66loBtY=;
        b=L5Ct1ve1Orm9HQI0j+EnQ/MYZ2ZU4K1TkvCQotGDPnBAzQAOLlvP3JXx3lPjEgt6jT
         fKlNOHVOs+APzOoo1OboNX5QSpeSvS1DpEf5nLYg9BXv4ltAFjjpjSMK96+NDwyyW3jb
         iUDUgPQImf6+HHsTAt8qSS70h+ABPWHRCdEITMSEZYoHTtee3zXewbQbmabuaykgJfZI
         etGgVSXqUg2tgXy3TIgCk8dY6ebfAbJcX0vFsjcRKSXqhTYQVA+71p6OCDKLlft4rexa
         Z87BwdiRPSclcQPTBX3YLM1NUtsUeiY73CsJeSVi9u3i+o5f7F0LmaG/H9c4htnTiini
         D4aw==
X-Gm-Message-State: AOAM533Bxy4ZnysVDpHNQRAnzarnpvZ2ZzvoVfWjXfSMJyDaPitA/pp3
        ua1+ZFWA0wD3yfH0+MGu+s+xoaXaHzGcMqAj7Ug0rU4tVHUTHTMRs7+XJJsevwdhecEn3a3kgBb
        bumN927+1ZLxhXQLxNI///Xft
X-Received: by 2002:adf:e812:0:b0:20c:dd44:b06c with SMTP id o18-20020adfe812000000b0020cdd44b06cmr468985wrm.714.1652373615740;
        Thu, 12 May 2022 09:40:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWKc+W5dfrOdOxweNVXdTz6oJYOENyjVQGLe4xiMAybfEgwkqqsd4IYjrdjYIX8sxGYcz+PA==
X-Received: by 2002:adf:e812:0:b0:20c:dd44:b06c with SMTP id o18-20020adfe812000000b0020cdd44b06cmr468956wrm.714.1652373615462;
        Thu, 12 May 2022 09:40:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa34b000000b0020c86a9f33bsm65751wrb.18.2022.05.12.09.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 09:40:14 -0700 (PDT)
Message-ID: <089a4ded-636f-b0c6-0645-8220c5a785d9@redhat.com>
Date:   Thu, 12 May 2022 18:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220512131019.2594948-1-scgl@linux.ibm.com>
 <20220512131019.2594948-2-scgl@linux.ibm.com>
 <77f6f5e7-5945-c478-0e41-affed62252eb@redhat.com>
 <4a06e3e8-4453-9204-eb66-d435860c5714@linux.ibm.com>
 <701033df-49c5-987e-b316-40835ad83d16@redhat.com>
 <9ad7acb4-2729-15bb-7b25-eb95c4a12f09@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9ad7acb4-2729-15bb-7b25-eb95c4a12f09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 18:26, Christian Borntraeger wrote:
> 
> 
> Am 12.05.22 um 17:50 schrieb David Hildenbrand:
>> On 12.05.22 15:51, Christian Borntraeger wrote:
>>>
>>>
>>> Am 12.05.22 um 15:22 schrieb David Hildenbrand:
>>>> On 12.05.22 15:10, Janis Schoetterl-Glausch wrote:
>>>>> If user space uses a memop to emulate an instruction and that
>>>>> memop fails, the execution of the instruction ends.
>>>>> Instruction execution can end in different ways, one of which is
>>>>> suppression, which requires that the instruction execute like a no-op.
>>>>> A writing memop that spans multiple pages and fails due to key
>>>>> protection may have modified guest memory, as a result, the likely
>>>>> correct ending is termination. Therefore, do not indicate a
>>>>> suppressing instruction ending in this case.
>>>>
>>>> I think that is possibly problematic handling.
>>>>
>>>> In TCG we stumbled in similar issues in the past for MVC when crossing
>>>> page boundaries. Failing after modifying the first page already
>>>> seriously broke some user space, because the guest would retry the
>>>> instruction after fixing up the fault reason on the second page: if
>>>> source and destination operands overlap, you'll be in trouble because
>>>> the input parameters already changed.
>>>>
>>>> For this reason, in TCG we make sure that all accesses are valid before
>>>> starting modifications.
>>>>
>>>> See target/s390x/tcg/mem_helper.c:do_helper_mvc with access_prepare()
>>>> and friends as an example.
>>>>
>>>> Now, I don't know how to tackle that for KVM, I just wanted to raise
>>>> awareness that injecting an interrupt after modifying page content is
>>>> possible dodgy and dangerous.
>>>
>>> this is really special and only for key protection crossing pages.
>>> Its been done since the 70ies in that way on z/VM. The architecture
>>> is and was always written in a way to allow termination for this
>>> case for hypervisors.
>>
>> Just so I understand correctly: all instructions that a hypervisor with
>> hardware virtualization is supposed to emulate are "written in a way to
>> allow termination", correct? That makes things a lot easier.
> 
> Only for key protection. Key protection can always be terminating no matter
> what the instruction says. This is historical baggage - key protection was
> resulting in abends - killing the process. So it does not matter if we
> provide the extra info as in enhanced suppression on protection as nobody
> is making use of that (apart from debuggers maybe).

Got it, makes sense then. Thanks for clarifying!

-- 
Thanks,

David / dhildenb

