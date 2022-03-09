Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA4E4D2576
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiCIBHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCIBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1125DE2FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646786758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWxGHfzk1NFn72F5fALKy03cifHH/VxoHr37b3M8dWU=;
        b=cWnyZ4nVp1cEMI26b5g35OFVVv3ZH2wTIiN7DX5nOwTmAsHtJmV1kFXxoNOTM27QDY8oWq
        HxoaTEYtt64E3y9+RDlfAD81F2/3ygpoE95+X2D88hYalYJ48D3FUfrlUPiB96UgUXReFH
        yqkqEpgy4pFUNLz2QJ3bFz2EP7bJ9og=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-OvEFvMfWPB2mkzp7XskEeA-1; Tue, 08 Mar 2022 19:24:22 -0500
X-MC-Unique: OvEFvMfWPB2mkzp7XskEeA-1
Received: by mail-io1-f69.google.com with SMTP id 24-20020a5d9c18000000b0064075f4edbdso604315ioe.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MWxGHfzk1NFn72F5fALKy03cifHH/VxoHr37b3M8dWU=;
        b=gYRPmo8kjKwt8wyT3MjpeGMYT1z/C7FyRC1cULw3QgakqG7ItJ6KFIrBjeADeWD3VU
         +WOBIz38LPNBY04b0xcAET/6stgq3DddfrGgYvRWl3YzfO5iIHqpvWQt2dVLK69WEA45
         S10YLskaLO2dKD7tYyQtSlz8oYrnlLZPOnqDRv3hpm+23AUCPQUIcni51U9psnZHa5cy
         ASF+oxmfXWegb8ni53L+XFfNE+gR/GTuKlHe6Ay6I539Dtb0inebv386mr8FtLDra2no
         qyOXN6rMarDWc/WBePMd9b0SqpZ3dlwdvFr7AFGuf7lixOlRSckgkBz3PO9lxLnmL6f7
         8oJQ==
X-Gm-Message-State: AOAM530R3lby4g+GwtclU60t0VykMzdQkcm0zyzgxfvg6hCRFJAvyUVg
        aVri0ONP4pRNBDNGwCJgEY0QwV8GGiGx/n8XPVCXXwrfvdvrtcB8klijPZ8TxkRdP3dpR+g4GFs
        cpmmMsuVyCwrSYKG9ULZUyZds
X-Received: by 2002:a92:c086:0:b0:2c5:eae4:ced7 with SMTP id h6-20020a92c086000000b002c5eae4ced7mr14438115ile.94.1646785461348;
        Tue, 08 Mar 2022 16:24:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5qPapOLi12nNZ07z/TMMkyg3AmpQFXZWg2t4tBSDZxjSFCSg8iVqvI3a66ATXQQJIX0hEPA==
X-Received: by 2002:a92:c086:0:b0:2c5:eae4:ced7 with SMTP id h6-20020a92c086000000b002c5eae4ced7mr14438090ile.94.1646785461035;
        Tue, 08 Mar 2022 16:24:21 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::11d7? ([2601:280:4400:a2e0::11d7])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d9544000000b00640a6eb6e1esm201323ios.53.2022.03.08.16.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:24:20 -0800 (PST)
Message-ID: <f3f665a5-0e80-2953-7ab6-258f5b7d0225@redhat.com>
Date:   Tue, 8 Mar 2022 17:24:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved robust
 futex
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
 <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
 <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
 <Yh9+O/xqNLnV1jmA@dhcp22.suse.cz>
 <7f1ba14f-34e8-5f05-53b7-c12913693df8@redhat.com>
 <YiBy0MXkefqfFvKk@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YiBy0MXkefqfFvKk@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 00:48, Michal Hocko wrote:
> On Wed 02-03-22 12:26:45, Nico Pache wrote:
>>
>>
>> On 3/2/22 09:24, Michal Hocko wrote:
>>> Sorry, this has slipped through cracks.
>>>
>>> On Mon 14-02-22 15:39:31, Nico Pache wrote:
>>> [...]
>>>> We've recently been discussing the following if statement in __oom_reap_task_mm:
>>>> 	if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED))
>>>>
>>>> Given the comment above it, and some of the upstream discussion the original
>>>> RFC, we are struggling to see why this should be a `||` and not an `&&`. If we
>>>> only want to reap anon memory and reaping shared memory can be dangerous is this
>>>> statement incorrect?
>>>>
>>>> We have a patch queued up to make this change, but wanted to get your opinion on
>>>> why this was originally designed this way in case we are missing something.
>>>
>>> I do not really see why this would be wrong. Private file backed
>>> mappings can contain a reapable memory as well. I do not see how this
>>> would solve the futex issue
>> We were basing our discussion around the following comment:
>> /*
>>  * Only anonymous pages have a good chance to be dropped
>>  * without additional steps which we cannot afford as we
>>  * are OOM already.
>>  *
>>  * We do not even care about fs backed pages because all
>>  * which are reclaimable have already been reclaimed and
>>  * we do not want to block exit_mmap by keeping mm ref
>>  * count elevated without a good reason.
>>  */
>>
>> So changing to an && would align the functionality with this comment by ignoring
>> fs backed pages, and additionally it prevents shared mappings from being reaped.
>> We have tested this change and found we can no longer reproduce the issue. In
>> our case we allocate the mutex on a MAP_SHARED|MAP_ANONYMOUS mmap so the if-
>> statement in question would no longer return true after the && change.
>>
>> If it is the case that private fs backed pages matter perhaps we want something
>> like this:
>> 	if ((vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED))
>> 	||(!vma_is_anonymous(vma) && !(vma->vm_flags & VM_SHARED)))
>>
>> or more simply:
>> 	if(!(vma->vm_flags & VM_SHARED))
>>
>> to exclude all VM_SHARED mappings.
> 
> I would have to think about that some more but I do not really see how
> this is related to the futex issue. In other words what kind of problem
> does this solve?
> 

We had a misunderstanding of what vma_is_anonymous actually checks for... It
returns true if the VMA is PRIVATE|ANONYMOUS. We may follow up with a patch to
change the name of this function or at least add a comment at the top of the
function to be more descriptive. Furthermore, we ended up being able to
reproduce this issue on the && kernel.

We have also found the actual cause of the issue, and we'll post that fix. Its
related to the glibc allocation done for pthreads as we discussed earlier in
this thread. The mapping that stores the futex robust list is in userspace and a
race occurs between the oom_reap_task_mm and the exit path that handles the
futex cleanup.

Cheers,
-- Nico

