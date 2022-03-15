Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444D4D92E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiCODXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCODXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A9643EC1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647314540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ypJCil04CfaW3VomauJXpYfaEKwnBls7PLMuFbkqEc=;
        b=czWNV5qV2NCjqeV4aXs9HFKdWGIWbOHVy2v9XRc8Z/6cIENFmtL0i1CxYPAyMrQX/1aT0P
        HClwcfOlUXV0ExLJT8/GuPrhg0nKyMZONBA5aoEQ8vswQbOzJq0xoxmGruUMnnZZmnDKSO
        8QEWLe8Iyf8AFKYKfXkSyd530G8Zat4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-uuJqeJJ1Pw6SMR8pp3PCjQ-1; Mon, 14 Mar 2022 23:22:18 -0400
X-MC-Unique: uuJqeJJ1Pw6SMR8pp3PCjQ-1
Received: by mail-lj1-f199.google.com with SMTP id x3-20020a05651c104300b00247ebe980b7so7197351ljm.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ypJCil04CfaW3VomauJXpYfaEKwnBls7PLMuFbkqEc=;
        b=Ng+k3HmYY7411EmJ8iruI8sDtqLPDM2zRa0N5vyxbAny6YUslf9hbaQENAy8YK2sRx
         EkR+ZUb4a7sCrQ4EjI5t4YXp0z+tAye4t3zgHHDf+SxCcYnvQiaWAESHLNsslKAw9lU3
         hLZAAf+w5fb76OJeXEPoZKv0gcd2iZ8aAp8VJNmznhcaW/Nw46IypwOsYBN2asrzOS1v
         Uxio4i/cbReuvdKu3jqwrAMUSiayi5pw93/eCymedVnaObHy8Pf+6GM7KW6OLAuMfen5
         N3dERbKJOm9CwTfbFEa+hOAT7I15GReWIGQxdE4IcGakcDJK/TEmUOMDk0+9JqOMAKfh
         BG4Q==
X-Gm-Message-State: AOAM532vc0gf4dsnaBTM0jHa2DDGVmJiE2OPkVMBx5glrm9+bVm7Z2Hl
        izYQYjCX+wMRRZUyw8XtYwbLE0XD6lIDU+z6I9ezwBru+rLxnn+4hv6vxboBZJpV/wU58Klhluh
        G746lIXP82xt391lZ9Y5bEpU=
X-Received: by 2002:a05:6512:1115:b0:448:6c0b:d1f with SMTP id l21-20020a056512111500b004486c0b0d1fmr11687875lfg.94.1647314537395;
        Mon, 14 Mar 2022 20:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY3CCDk9ukH2U+Kr/8vGYwVnK5BsS8X6MQn5V8KteHKP7+4yht4SnmJrDlzhjnpAN/lgS5cg==
X-Received: by 2002:a05:6512:1115:b0:448:6c0b:d1f with SMTP id l21-20020a056512111500b004486c0b0d1fmr11687861lfg.94.1647314537143;
        Mon, 14 Mar 2022 20:22:17 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id j15-20020a2e3c0f000000b00247e9bafa20sm4272092lja.99.2022.03.14.20.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 20:22:16 -0700 (PDT)
Message-ID: <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
Date:   Tue, 15 Mar 2022 05:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220314182439.GB64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason and thanks for your comments..

On 14.3.2022 20.24, Jason Gunthorpe wrote:
> On Fri, Mar 11, 2022 at 05:30:50AM +0200, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> HMM selftests use an in-kernel pseudo device to emulate device private
>> memory. The pseudo device registers a major device range for two pseudo
>> device instances. User space has a script that reads /proc/devices in
>> order to find the assigned major number, and sends that to mknod(1),
>> once for each node.
>>
>> This duplicates a fair amount of boilerplate that misc device can do
>> instead.
>>
>> Change this to use misc device, which makes the device node names appear
>> for us. This also enables udev-like processing if desired.
> 
> This is borderline the wrong way to use misc devices, they should
> never be embedded into other structs like this. It works out here
> because they are eventually only placed in a static array, but still
> it is a generally bad pattern to see.

Could you elaborate on this one? We have many in-tree usages of the same 
pattern, like:

drivers/video/fbdev/pxa3xx-gcu.c
drivers/platform/goldfish/goldfish_pipe.c
drivers/virt/vboxguest/vboxguest_linux.c
drivers/virt/nitro_enclaves/ne_pci_dev.c
drivers/watchdog/cpwd.c
drivers/platform/x86/toshiba_acpi.c
drivers/platform/x86/wmi.c
drivers/platform/surface/surface_dtx.c
drivers/bus/fsl-mc/fsl-mc-uapi.c
drivers/misc/dw-xdata-pcie.c
drivers/input/serio/serio_raw.c
fs/dlm/user.c
lib/test_kmod.c

You mention "placed in a static array", are you seeing a potential 
lifetime issue or what? Many of the examples above embed miscdevice in a 
dynamically allocated object also.

The file object's private_data holds a pointer to the miscdevice, and 
fops_get() pins the module. So freeing the objects miscdevice is 
embedded in at module_exit time should be fine. But, as you said, in 
this case the miscdevices are statically allocated, so that shouldn't be 
an issue either. But maybe I'm missing something?

> 
>> Delete the /proc/devices parsing from the user-space test script, now
>> that it is unnecessary.
> 
> This is all because the cdev is being used wrong - it get all this
> stuff it should be done via cdev_device_add() and a dmirror_device
> needs a struct device to hold the sysfs.
> 

I think using cdev_add ends up in the same results in device_* api 
sense. miscdevice acting like a mux at a higher abstraction level 
simplifies the code.


> Jason
> 


Thanks,

Mika

