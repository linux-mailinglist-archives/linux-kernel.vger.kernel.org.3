Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36858722C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiHAUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiHAUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6E4A43E7A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659384765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kc1sFpw2lNuatI//mMoMRuF0sPT7FdNZQixKasxwawE=;
        b=PLHiQ0GJw8zC0fGTz8aZy+64KEOoCs27Gew/iQVPRzDay/Wv2ZuMFDPgXTcPeROszcl5oL
        Ez5VtQ+2CZ5TcB3dzwkiDtUh+pPJ6qQDk5HZ58Ca3z0DJ3YrYw+c+KcTPdnuiOKE0bGCeC
        CQXghWPq483iNJfOJlSui9Yga5/iGFI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-n-aiiPnYN9iuUQ2T1f1qAQ-1; Mon, 01 Aug 2022 16:12:41 -0400
X-MC-Unique: n-aiiPnYN9iuUQ2T1f1qAQ-1
Received: by mail-wr1-f71.google.com with SMTP id h18-20020adfaa92000000b0021ec200d50fso2890711wrc.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Kc1sFpw2lNuatI//mMoMRuF0sPT7FdNZQixKasxwawE=;
        b=Vs7mb4lKFI75AMXqDmh9XoHZTO+S/dMUnCJDQFj4jAeCdj5H2iAxZOBeFEfxfVPl/a
         ugeY+z/BV8V0lv4MmAowYz2It+fHdLtQF53WVAvhTySMSvatbHbY7Z/Op1eJBMlXkdtz
         KnoHkKyj9nVFfO4oup92jCmT0CXIUpaxgQwSorvcVAqFYjCXd/cc1e3KBUQBx7EnyCWa
         km2mt0nlebWuRMDZC06jlgx84FjA/ZeaVPL4yHp0AjQ7xsKv5GPVii/dCKJajoZd4ykn
         bS9RlNt0nFkksQ512Djr0pQ2kIAd176M4c08FqHGW1tuX++QDYhBHy8meqg3lSd/ssqS
         zXxw==
X-Gm-Message-State: ACgBeo0N2xn1/vRby+Lk8nFlFE8AbsxC29X+sZHdH+fSKpFou3YNA9H6
        K21QxIhq5Eqk/JznMXAYjs+rSiEjVoIdpmSyB1gFDAxh2vi7fIXtCwe2SGam64+czy/W8Ln00j3
        vIYBTQ0Wtlj7qlfOApyBN7yHb
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id a3-20020adffb83000000b0021d649a72d9mr10733716wrr.688.1659384760033;
        Mon, 01 Aug 2022 13:12:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Tz4ZejXUtQgcoG19U1btxFHT7BplC99FNY+fPvkO8DAysitSkTo1SmQQ/0z17+5x7LjALYA==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id a3-20020adffb83000000b0021d649a72d9mr10733705wrr.688.1659384759731;
        Mon, 01 Aug 2022 13:12:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b0021eb309c97dsm12711970wrr.25.2022.08.01.13.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 13:12:39 -0700 (PDT)
Message-ID: <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
Date:   Mon, 1 Aug 2022 22:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
 <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
In-Reply-To: <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +
>>> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>> +		num_pages = -num_pages;
>> With VIRTIO_BALLOON_F_DEFLATE_ON_OOM this will now always report "0".
>>
>> which would be the same as "num_pages = 0;" and would deserve a comment
>> explaining why we don't indicate that as "inflated: ".
>>
>> Thanks.
> 
> Except if "now"  refers to some commit that i am missing it does not report 0.

/me facepalm

I read "-= num_pages"

> 
> 
> with qemu-system-x86_64  -enable-kvm -device virtio-balloon,id=balloon0,deflate-on-oom=on,notify_on_empty=on,page-per-vq=on -m 3G ....
> 
> / # cat /sys/kernel/debug/virtio-balloon
> inflated: 0 kB
> / # QEMU 4.2.1 monitor - type 'help' for more information
> (qemu) balloon 1024
> (qemu)
> 
> / # cat /sys/kernel/debug/virtio-balloon
> inflated: 2097152 kB
> / #
> 
> with qemu-system-x86_64  -enable-kvm -device 
> virtio-balloon,id=balloon0,deflate-on-oom=off,notify_on_empty=on,page-per-vq=on 
> -m 3G ...
> 
> / # cat /sys/kernel/debug/virtio-balloon
> inflated: 0 kB
> / # QEMU 4.2.1 monitor - type 'help' for more information
> (qemu) balloon 1024
> (qemu)
> / # cat /sys/kernel/debug/virtio-balloon
> inflated: -2097152 kB

What's the rationale of making it negative?

> 
> To join the threads:
> 
>>> Always account inflated memory as used for both cases - with and
>>> without deflate on oom. Do not change total ram which can confuse
>>> userspace and users.
> 
>> Sorry, but NAK.
> 
> Ok.
> 
>> This would affect existing users / user space / balloon stats. For example
>> HV just recently switch to properly using adjust_managed_page_count()
> 
> 
> I am wondering what's the rationale behind this i have never seen such users
> that expect it to work like this. Do you have any pointers to such users, so
> i can understood why they do so ?

We adjust total pages and managed pages to simulate what memory is
actually available to the system (just like during memory hot(un)plug).
Even though the pages are "allocated" by the driver, they are actually
unusable for the system, just as if they would have been offlined.
Strictly speaking, the guest OS can kill as many processes as it wants,
it cannot reclaim that memory, as it's logically no longer available.

There is nothing (valid, well, except driver unloading) the guest can do
to reuse these pages. The hypervisor has to get involved first to grant
access to some of these pages again (deflate the balloon).

It's different with deflate-on-oom: the guest will *itself* decide to
reuse inflated pages to deflate them. So the allocated pages can become
back usable easily. There was a recent discussion for virtio-balloon to
change that behavior when it's known that the hypervisor essentially
implements "deflate-on-oom" by looking at guest memory stats and
adjusting the balloon size accordingly; however, as long as we don't
know what the hypervisor does or doesn't do, we have to keep the
existing behavior.

Note that most balloon drivers under Linux share that behavior.

In case of Hyper-V I remember a customer BUG report that requested that
exact behavior, however, I'm not able to locate the BZ quickly.


[1]
https://lists.linuxfoundation.org/pipermail/virtualization/2021-November/057767.html
(note that I can't easily find the original mail in the archives)

Note: I suggested under [1] to expose inflated pages via /proc/meminfo
directly. We could do that consistently over all balloon drivers ...
doesn't sound too crazy.

-- 
Thanks,

David / dhildenb

