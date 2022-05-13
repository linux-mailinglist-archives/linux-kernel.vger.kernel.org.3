Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE65526047
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379576AbiEMKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353808AbiEMKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:43:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873EB106A4A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:43:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h29so13815247lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6sXboJ1IWrFfaZL2CwvKWBto1jYzvNRlolwzbKkJnzI=;
        b=O7IrsLiI6m+XnVXL609wbEZd46wLeUQTt11dOyDyb0m3qmultIKmwLTgLEc8uZKPkz
         oRVFNrS9W09pQ4KsFgRpm6cOj+dvHzUx2y4L1n+jNSjeWv11Q73apCVW76PkYSzRKcks
         82OTQqbzDdxYA1kDqW6s6/pgZLzyPA2pMKtsiLflLcsS26esBBbgzAebIQRHoB8q/XDa
         J8u+Y+xqBuigPblfPvo3H2DENlKFeofiTc2i+0wgT+8ntV0CsQaAthZlBnlIxWaDD4FU
         DdMIoAF7qJz3f6jtwmNN53zpMjgR/H5//deFyfs0IJU1yqMnax3Il/kEYWyNCMiTPnq4
         0fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6sXboJ1IWrFfaZL2CwvKWBto1jYzvNRlolwzbKkJnzI=;
        b=wiuPM8xm4YZRaQfoEv43MewPl1hxHqjuGj9XXI/7sRsrMJxAUofebyA4+s3oshHNrN
         NgwrZNx8sH0rIGW1H6Wxme6zM/5rdGvhDPOxqncEbQ6lKGbNwvH/Ysor1Qjfbuf/1C1i
         DaHuYk5D0xJXn5+Jg0oukO0NlZeVchk/LxRzCVCJ1OQcadxbXfdF4omTNwgRCAeEVcum
         zFhyymy6KynyG6tsBGl03xUqY5POP5zYao0zo5r90XAl7aKGsmIzTNJYpqNzA80ZPqmM
         r5Iq2w6Fzd6aAAPC3mHLqNeUMv9roRulC0fvhbr6jpfZ6F+iLeEJHJGLq9whALVRvurQ
         M0RA==
X-Gm-Message-State: AOAM530RbYCp7WOg4MdyLv8ncKSUuzlmk52Bzl/LisCN+5iTxoYiyUKJ
        3ex5QCy1rKLH4s2lWk883so=
X-Google-Smtp-Source: ABdhPJxvCY8n6V16nGeI843LAEA5SzPc7sIbEPwvo4gLBMAfPQogJJiWevnffE3lSSwYRwuInpsqWQ==
X-Received: by 2002:a05:6512:3157:b0:474:2ac5:63d with SMTP id s23-20020a056512315700b004742ac5063dmr2934962lfi.367.1652438588735;
        Fri, 13 May 2022 03:43:08 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9c84000000b0024f3d1dae8esm388198lji.22.2022.05.13.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 03:43:07 -0700 (PDT)
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <263070e7-0043-1c5f-ba14-8ca7bb4ca6a0@gmail.com>
Date:   Fri, 13 May 2022 13:43:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.05.22 08:33, Juergen Gross wrote:
> On 12.05.22 22:01, Boris Ostrovsky wrote:


Hello Juergen, Boris


[Juergen, thank you for your explanation]


>
>>
>> On 5/7/22 2:19 PM, Oleksandr Tyshchenko wrote:
>>> +
>>> +/*
>>> + * Handling of free grants:
>>> + *
>>> + * Free grants are in a simple list anchored in gnttab_free_head. 
>>> They are
>>> + * linked by grant ref, the last element contains GNTTAB_LIST_END. 
>>> The number
>>> + * of free entries is stored in gnttab_free_count.
>>> + * Additionally there is a bitmap of free entries anchored in
>>> + * gnttab_free_bitmap. This is being used for simplifying 
>>> allocation of
>>> + * multiple consecutive grants, which is needed e.g. for support of 
>>> virtio.
>>> + * gnttab_last_free is used to add free entries of new frames at 
>>> the end of
>>> + * the free list.
>>> + * gnttab_free_tail_ptr specifies the variable which references the 
>>> start
>>
>>
>> If this references the start of the free interval, why is it called 
>> gnttab_free_*tail*_ptr?
>
> Because this is the tail of the whole area which is free.
>
> It could be renamed to gnttab_free_tail_start_ptr. :-)
>
>>
>>
>>> + * of consecutive free grants ending with gnttab_last_free. This 
>>> pointer is
>>> + * updated in a rather defensive way, in order to avoid performance 
>>> hits in
>>> + * hot paths.
>>> + * All those variables are protected by gnttab_list_lock.
>>> + */
>>>   static int gnttab_free_count;
>>> -static grant_ref_t gnttab_free_head;
>>> +static unsigned int gnttab_size;
>>> +static grant_ref_t gnttab_free_head = GNTTAB_LIST_END;
>>> +static grant_ref_t gnttab_last_free = GNTTAB_LIST_END;
>>> +static grant_ref_t *gnttab_free_tail_ptr;
>>> +static unsigned long *gnttab_free_bitmap;
>>>   static DEFINE_SPINLOCK(gnttab_list_lock);
>>> +
>>>   struct grant_frames xen_auto_xlat_grant_frames;
>>>   static unsigned int xen_gnttab_version;
>>>   module_param_named(version, xen_gnttab_version, uint, 0);
>>> @@ -170,16 +194,111 @@ static int get_free_entries(unsigned count)
>>>       ref = head = gnttab_free_head;
>>>       gnttab_free_count -= count;
>>> -    while (count-- > 1)
>>> -        head = gnttab_entry(head);
>>> +    while (count--) {
>>> +        bitmap_clear(gnttab_free_bitmap, head, 1);
>>> +        if (gnttab_free_tail_ptr == __gnttab_entry(head))
>>> +            gnttab_free_tail_ptr = &gnttab_free_head;
>>> +        if (count)
>>> +            head = gnttab_entry(head);
>>> +    }
>>>       gnttab_free_head = gnttab_entry(head);
>>>       gnttab_entry(head) = GNTTAB_LIST_END;
>>> +    if (!gnttab_free_count) {
>>> +        gnttab_last_free = GNTTAB_LIST_END;
>>> +        gnttab_free_tail_ptr = NULL;
>>> +    }
>>> +
>>>       spin_unlock_irqrestore(&gnttab_list_lock, flags);
>>>       return ref;
>>>   }
>>> +static int get_seq_entry_count(void)
>>> +{
>>> +    if (gnttab_last_free == GNTTAB_LIST_END || 
>>> !gnttab_free_tail_ptr ||
>>> +        *gnttab_free_tail_ptr == GNTTAB_LIST_END)
>>> +        return 0;
>>> +
>>> +    return gnttab_last_free - *gnttab_free_tail_ptr + 1;
>>> +}
>>> +
>>> +/* Rebuilds the free grant list and tries to find count consecutive 
>>> entries. */
>>> +static int get_free_seq(unsigned int count)
>>> +{
>>> +    int ret = -ENOSPC;
>>> +    unsigned int from, to;
>>> +    grant_ref_t *last;
>>> +
>>> +    gnttab_free_tail_ptr = &gnttab_free_head;
>>> +    last = &gnttab_free_head;
>>> +
>>> +    for (from = find_first_bit(gnttab_free_bitmap, gnttab_size);
>>> +         from < gnttab_size;
>>> +         from = find_next_bit(gnttab_free_bitmap, gnttab_size, to + 
>>> 1)) {
>>> +        to = find_next_zero_bit(gnttab_free_bitmap, gnttab_size,
>>> +                    from + 1);
>>> +        if (ret < 0 && to - from >= count) {
>>> +            ret = from;
>>> +            bitmap_clear(gnttab_free_bitmap, ret, count);
>>> +            from += count;
>>> +            gnttab_free_count -= count;
>>
>>
>> IIUIC we can have multiple passes over this, meaning that the 
>> gnttab_free_count may be decremented more than once. Is that 
>> intentional?
>
> After the first pass decrementing gnttab_free_cnt, ret will no
> longer be less than zero, so this can be hit only once.
>
>>
>>
>>> +            if (from == to)
>>> +                continue;
>>> +        }
>>> +
>>> +        while (from < to) {
>>> +            *last = from;
>>> +            last = __gnttab_entry(from);
>>> +            gnttab_last_free = from;
>>> +            from++;
>>> +        }
>>
>>
>> I have been looking at this loop and I can't understand what it is 
>> doing ;-( Can you enlighten me?
>
> It is recreating the free list in order to have it properly sorted.
> This is needed to make sure that the free tail has the maximum
> possible size (you can take the tail off the list without having
> to worry about breaking the linked list because of references into
> the tail).

I think the loop deserves a comment on top, I will add it.



>
>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

