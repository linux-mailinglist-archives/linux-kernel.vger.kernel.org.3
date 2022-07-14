Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551C574F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiGNNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbiGNNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C0DD12D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657805084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFb6Y2djfjlq4aYtQeDVixTBGc4GMhc4NBOsa8B4jJM=;
        b=DUX4l/Y5NzkoIpo8VCXh22LGDPOnwpVAsT2UbeHmiFzIJJCzn5Z0J5O35k14llKziCydHs
        pJxyRN1P2Je55JLtmS0WD8ZnC0r0vi8WRMV1mhLKbGl9S0AHBXf9dNFuEPd6Auy5U3SuyT
        /am7Tsg/jyqkQGYLji5r1pA2AATTsUA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-DB1z4NIPN9OC8NJL66wxNA-1; Thu, 14 Jul 2022 09:24:43 -0400
X-MC-Unique: DB1z4NIPN9OC8NJL66wxNA-1
Received: by mail-wm1-f70.google.com with SMTP id r5-20020a1c4405000000b003a2fdeea756so1902290wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JFb6Y2djfjlq4aYtQeDVixTBGc4GMhc4NBOsa8B4jJM=;
        b=L/zicAOvAslWwzDT+BSk7zrsHzexdYabEHLerVk7MnGyX6CAxXb9UmHdKLQhapLj/i
         9OWLOXief3xwsCpYmc0HSUTfIPZOmu/zbIGErHRXarEeV8jYOV5cJfEChmx5adlfAJb7
         Q01Jp3NfMs5RT6FJtbAiJ3zkgRgJLfR/oxHeKw1hZXikqtiEEKTxhnuba8jpLwlQq10B
         fW2YnpFnmsNH8RavbeXZNFWpktXyMamIWNy614xw9pT+Iif0puA8uMu9sCXqqfLnxzyq
         dKyBZ8J9wPDKT3SP0w9ABxDnBPD9pX8rVjqETKyUiSZWIdGMnZmB6OMZubePjeErayA7
         j+WA==
X-Gm-Message-State: AJIora9gZSz/y2bmowSZsObn2p+tylwrOKko62l5Dlym9N8i9r6NcwSE
        HDJk/oVIjXrlda0GQk8pAFEdu/5g3oo9DhToc9xyLbzWgYoTRaawFFJev8Hmg+Kix3FBBycIwJx
        yRTagpCwZGT4PAfc+rvJ9I0m6
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id o12-20020a05600002cc00b0021d76d81f2cmr8158612wry.471.1657805082135;
        Thu, 14 Jul 2022 06:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXOdCJbsP6vWBuuwTfoqFW5KzG83L6mkk6KFoxTtE5rJXJnDpfvfDi52mje6Dx7tO8Ehze5A==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id o12-20020a05600002cc00b0021d76d81f2cmr8158591wry.471.1657805081871;
        Thu, 14 Jul 2022 06:24:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3d00:dae4:4dc0:aa8c:bc1? (p200300cbc7093d00dae44dc0aa8c0bc1.dip0.t-ipconnect.de. [2003:cb:c709:3d00:dae4:4dc0:aa8c:bc1])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003a2cfb9f5basm6564857wmq.16.2022.07.14.06.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:24:41 -0700 (PDT)
Message-ID: <bfb7ab7f-6c17-e1fe-d87e-b19312f06e0c@redhat.com>
Date:   Thu, 14 Jul 2022 15:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.22 15:20, Alexander Atanasov wrote:
> Hello,
> 
> On 14/07/2022 14:35, David Hildenbrand wrote:
>> On 05.07.22 10:36, Alexander Atanasov wrote:
>>> Allow the guest to know how much it is ballooned by the host.
>>> It is useful when debugging out of memory conditions.
>>>
>>> When host gets back memory from the guest it is accounted
>>> as used memory in the guest but the guest have no way to know
>>> how much it is actually ballooned.
>>>
>>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>>> ---
>>>   drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>>>   include/uapi/linux/virtio_balloon.h |  1 +
>>>   2 files changed, 78 insertions(+)
>>>
>>> V2:
>>>   - fixed coding style
>>>   - removed pretty print
>>> V3:
>>>   - removed dublicate of features
>>>   - comment about balooned_pages more clear
>>>   - convert host pages to balloon pages
>>> V4:
>>>   - added a define for BALLOON_PAGE_SIZE to make things clear
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>>> index b9737da6c4dd..dc4ad584b947 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/virtio_balloon.h>
>>>   #include <linux/swap.h>
>>>   #include <linux/workqueue.h>
>>> +#include <linux/debugfs.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
>>>   	}
>>>   }
>>>   
>>> +/*
>>> + * DEBUGFS Interface
>>> + */
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
>>> +/**
>>> + * virtio_balloon_debug_show - shows statistics of balloon operations.
>>> + * @f: pointer to the &struct seq_file.
>>> + * @offset: ignored.
>>> + *
>>> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
>>> + *
>>> + * Return: zero on success or an error code.
>>> + */
>>> +
>>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>>> +{
>>> +	struct virtio_balloon *b = f->private;
>>> +	u32 num_pages;
>>> +	struct sysinfo i;
>>> +
>>> +	si_meminfo(&i);
>>> +
>>> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
>>> +
>>> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
>>> +			&num_pages);
>>> +	/*
>>> +	 * Pages allocated by host from the guest memory.
>>> +	 * Host inflates the balloon to get more memory.
>>> +	 * Guest needs to deflate the balloon to get more memory.
>>> +	 */
>> Please drop that comment. This is basic virtio-balloon operation that
>> must not be explained at this point.
> 
> Ok
> 
>>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>>> +
>>> +	/* Total Memory for the guest from host */
>>> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
>>> +			guest_to_balloon_pages(i.totalram));
>> totalram is calculated from totalram_pages().
>>
>> When we inflate/deflate, we adjust totalram as well via
>> adjust_managed_page_count().
> 
> That is true only when not using DEFLATE_ON_OOM.
> 
> Otherwise inflated memory is accounted as used and total ram stays the same.
>> Consequently, this doesn't calculate what you actually want?
>> Total memory would be totalram+inflated, current would be totalram.
> 
> My calculations are correct for the case deflate_on_oom is enabled.
> 

Which is the corner cases. You'd have to special case on DEFLATE_ON_OOM
availability.

>> But, TBH, only export num_pages. User space can just lookup the other
>> information (totalram) via /proc/meminfo.
> 
> I have missed that the memory accounting is made differently depending 
> on a flag.
> 
> Since the calculations are different i'd prefer to have the values 
> calculate and printed there.

What about an indication instead, whether or not inflated pages are
accounted into total or not? That would be slightly cleaner IMHO.

-- 
Thanks,

David / dhildenb

