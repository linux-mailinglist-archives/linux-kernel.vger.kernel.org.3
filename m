Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F695475AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhLOOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243396AbhLOOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639579119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6pfROBDfzPHrRI6V70wzqnGyNtkI6mkFt3s2V28EO0=;
        b=fKdQlU+XIXDHO8TMzzqGwmH4YABIdiE/d2ZUFiJOMpXQMLFHcIvCAdgXx4ZurWcRgLMPYY
        mW2wIIgOzc6xzzuaJuT3zoGvVtrJql6euE8MHpSlfHor+NfNDSpzl9dXqDuQ/4im6ErHag
        /6nAyH9lstB8MnY6OiTEHESjhXxLdRA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-3WDuRJUaNb2Jnx2hLyvu_A-1; Wed, 15 Dec 2021 09:38:38 -0500
X-MC-Unique: 3WDuRJUaNb2Jnx2hLyvu_A-1
Received: by mail-wm1-f70.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so14750926wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6pfROBDfzPHrRI6V70wzqnGyNtkI6mkFt3s2V28EO0=;
        b=KMvoC+p8d4JKugiWX+Klydaqh1ss1HH4evq6nmnCyLS9JcpGX/X5fsbl2FCIh2cB3g
         bK08CEokksJwRZCw8VbXnzu6RE3ElGRVb4B1rPv1M/hzJYIx/K1+pNmc4XU3T63m764K
         Zbj/ZsyJVuKRzpK7WH9bkR4ZmoW5wic68z/NJWYHfS3S1nzYWlEDiVW37FTqrS2TOpIl
         LfacgMwPLgcXTnnS2iflnk6mV+MPYW7Ncm4oucpLhSwadkkrvbQqL2il7D/QGWEJe1/X
         TVHcXv9cvnAFehopaLrO+6vvrMBMKYjD+hVpLafsKpeftvhAX9+kvtu5meDorpwSpVfo
         go/w==
X-Gm-Message-State: AOAM531xMg8iL28rTiklwQ/HIb7inpNGX+W6nLq2URCDgVG6JacjPcR5
        sccFKmNkR5xBZJGpg3QlfcD+6mjwsEG/08nSv/N5j3bYuRvJyEYzdbMVzOu0ViNV2yJCsnw9v6E
        xN1dM5TIhuIWKr8kWROI4+/rK
X-Received: by 2002:a1c:2:: with SMTP id 2mr64292wma.41.1639579116907;
        Wed, 15 Dec 2021 06:38:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEr/EwQXQrqQjR6qrytGRdqfOvPeN52Dtw1JE/+pcZhnuNslRF0n07yrBSjm4zuYBuGpEggQ==
X-Received: by 2002:a1c:2:: with SMTP id 2mr64262wma.41.1639579116662;
        Wed, 15 Dec 2021 06:38:36 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id g124sm5190048wme.28.2021.12.15.06.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 06:38:36 -0800 (PST)
Message-ID: <2a889dcf-e20f-84cc-cc69-6cb381764047@redhat.com>
Date:   Wed, 15 Dec 2021 15:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
 <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
 <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com> <87tufaqbex.fsf@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <87tufaqbex.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 13.51, Cornelia Huck wrote:
> On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 14/12/2021 22.55, Tony Krowiak wrote:
>>>
>>>
>>> On 12/13/21 11:11, Cornelia Huck wrote:
>>>> One possibility is simply blocking autoload of the module in userspace by
>>>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
>>>> is installed on the system. This is obviously something that needs to be
>>>> decided by the distros.
>>>>
>>>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
>>>> not really make it worse.)
>>>
>>> Of the vfio_ccw module is automatically loaded, then the kvm
>>> module will also get loaded. I startup up a RHEL8.3 system and
>>> sure enough, the vfio_ccw module is loaded along with the
>>> kvm, vfio and mdev modules. If this is true for all distros, then
>>> it wouldn't make much difference if the vfio_ap module is
>>> autoloaded too.
>>
>> I think I don't mind too much if we auto-load vfio-ap or not - but I think
>> we should make it consistent with vfio-ccw. So either auto-load both modules
>> (if the corresponding devices are available), or remove the
>> MODULE_DEVICE_TABLE() entries from both modules?
> 
> I think we really need to take a step back and think about the purpose
> of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
> of devices on a certain bus a driver supports, in a way that can be
> consumed by userspace (after file2alias.c worked on it).
> 
> Userspace typically uses this to match devices it is notified about to
> drivers that could possibly drive those devices. In general, the
> assumption is that you will want to have the drivers for your devices
> loaded. In some cases (drivers only used in special cases, like here),
> it might be a better idea to autoload the drivers only under certain
> circumstances (e.g. if you know you're going to run KVM guests).
> 
> My main point, however, is that we're talking about policy here: whether
> a potentially useful driver should be loaded or not is a decision that
> should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
> not look like the right solution, as it deprives userspace of the
> information to autoload the driver, if it actually wants to do so.

Thanks, Cornelia, that's a very valid point, I didn't see it from this 
perspective yet, but it sounds like the right way to handle this. So I think 
my patch should be applied, and if we then agree that the module should not 
be auto-loaded by default, it should be handled with the appropriate changes 
in userspace instead.

  Thomas

