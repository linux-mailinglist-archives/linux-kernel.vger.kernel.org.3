Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAC4F13A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359344AbiDDLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359282AbiDDLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF30E3B54B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649070624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6A01dDxN4AhfWeci3IfqR+D+i/Vo38DEq8zB5JTGSTo=;
        b=OrPhq9mUSt8KwgCC3T28dGa2XVogMFXr1Pn6rSeaog+ByumI4Grl7y4puef2PQUfuNXnoG
        hNj/AjS7S2q1qBL5wAyG8JjkhA/IWlFjSSb64IxZpqsCpKLacpVVP+KywPivmS3yGuuS58
        urrVk7x4MUASVNwWSFF0vfM050Ssb5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-iRvnxaDXMs6za-OuRFLPXA-1; Mon, 04 Apr 2022 07:10:22 -0400
X-MC-Unique: iRvnxaDXMs6za-OuRFLPXA-1
Received: by mail-ed1-f72.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso5260453edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 04:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6A01dDxN4AhfWeci3IfqR+D+i/Vo38DEq8zB5JTGSTo=;
        b=izCSL0V5GIU5B+5ygVCqSdkKJ9/3fEkS9RtYCUQn8FyWjwGA8J5TLY4aj8W3AoZKAY
         vEew8DRrPhuUvd/lgBSUSOTB/dUnUu4ILIpS+PWq6QgFxhBRrK/axNGWjAwSyzzdeqMR
         Pboi+U+sG8gIGg9+LyeCjfoJUaHYlCnMn8iT7DHCsopEbVZqm+5JZu0Lc9QiqnrHOwIk
         /8WZz1zOCHlsUQFSEvFE0KCG1eQkvRyGMjXDOpatIO/VAdv4NTNtkvEatm0y+/eFkj7r
         pQOInj1D9G2kvkCY35AHyYL0YcPMpb9Cf7cfN2Y0Gat4W4uWJIXpxUL2fpVj5X3HxbeK
         y1AA==
X-Gm-Message-State: AOAM5312DEQwXJ8aeTGw/O2tDSg1UYLaxPQNZHr2vRP5Aye+uIp62piz
        E3WAk1bz0bGfZcbXwp9BAvFiBh5NHxWakYs/QjTxzi26v9RDgd3P825gcJel5M0d2DdCWQJp6Zi
        Ma00hJpXcITIkPwjXozhD7jjY
X-Received: by 2002:a17:907:7252:b0:6df:75cc:615e with SMTP id ds18-20020a170907725200b006df75cc615emr10348704ejc.683.1649070621329;
        Mon, 04 Apr 2022 04:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfPjSGUTP7GT/ripRbE1qttsE5IB0zwM5i7Vj4d6y9queZLJfj6nGefOPOpRNW0SE0YoMpWg==
X-Received: by 2002:a17:907:7252:b0:6df:75cc:615e with SMTP id ds18-20020a170907725200b006df75cc615emr10348669ejc.683.1649070620966;
        Mon, 04 Apr 2022 04:10:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906725500b006e10a7d6d03sm4160148ejk.219.2022.04.04.04.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 04:10:20 -0700 (PDT)
Message-ID: <7f2d88de-60c5-e2ff-9b22-acba35cfdfb6@redhat.com>
Date:   Mon, 4 Apr 2022 13:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v10 0/3] drivers: ddcci: add drivers for DDCCI
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org,
        Sebastian Wick <sebastian.wick@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Martin Peres <martin.peres@linux.intel.com>
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
References: <20220403230850.2986-1-yusisamerican@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220403230850.2986-1-yusisamerican@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

On 4/4/22 01:08, Yusuf Khan wrote:
> This patch adds the DDCCI driver by Christoph Grenz into the kernel.
> The original gitlab page is loacted at https://gitlab.com/ddcci-driv
> er-linux/ddcci-driver-linux/-/tree/master.
> 
> DDC/CI is a control protocol for monitor settings supported by most
> monitors since about 2005. A chardev and sysfs interface is provided.
> A backlight driver using DDCCI is also provided in the seccond patch.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>

Thank you for your submission of this patch series.

I must say that I'm a bit surprised that this series was NOT
also send to the drm/kms subsystem maintainers and mailinglists
since this deals with monitors and thus is highly relevant for
those folks. Luckily I saw an article about this at Phoronix
(you write in the changelog that you believe that there is
no interaction with the DRM/KMS subsystems but that is wrong).

One very important thing which I'm missing in this cover-letter
is why you want to have this in the kernel at all? There are
already various tools which do DDCCI from userspace just fine.

I guess you may be interested in offering /sys/class/backlight
functionality for external monitors. That is actually something
which I'm interested in too, but it is not that simple.

The current /sys/class/backlight interface does not offer a
way for userspace to map a /sys/class/backlight device to
a specific display-output / monitor. So userspace currently
assumes that there is only 1 (1 valid) /sys/class/backlight
device and that that *always* belongs to the internal LCD
panel of a laptop.

So just adding /sys/class/backlight device(s) for internal
monitors without addressing the short-comings of the existing
userspace interface is simply not possible because it would
break existing userspace which is something which is not
allowed.

So NACK from me for the backlight part at least and without
that, I really see no reason to do this in the kernel rather
then userspace.

I've recently been discussing this with a colleague of mine,
Sebastian Wick and as a result of that I'm giving a talk
with a proposal for a better userspace API for this at
kernel-recipes:
https://kernel-recipes.org/en/2022/talks/new-userspace-api-for-display-panel-brightness-control/

I hope to start working on a RFC patch series for this soon.

IMHO merging this series should be put on hold until we
have a better idea of how we want to solve the userspace
API challenges, esp. the monitor <-> /sys/class/backlight
mapping problem.

Regards,

Hans



p.s.

This is not the first time this has come up:

https://lore.kernel.org/all/4b17ba08-39f3-57dd-5aad-d37d844b02c6@linux.intel.com/
https://www.x.org/wiki/Events/XDC2014/XDC2014GoedeBacklight/



> ---
> v2: Fix typos.
> 
> v3: Add documentation, move files around, replace semaphores with
> mutexes, and replaced <asm-generic/fcntl.h> with <linux/fcntl.h>.
> "imirkin"(which due to his involvement in the dri-devel irc channel
> I cant help but assume to be a DRM developer) said that the DDC/CI
> bus does not intefere with the buses that DRM is involved with.
> 
> v4: Move some documentation, fix grammer mistakes, remove usages of
> likely(), and clarify some documentation.
> 
> v5: Fix grammer mistakes, remove usages of likely(), and clarify
> some documentation.
> 
> v6: Change contact information to reference Christoph Grenz.
> 
> v7: Remove all instances of the unlikely() macro.
> 
> v8: Modify documentation to provide updated date and kernel
> documentation, fix SPDX lines, use isalpha instead of redefining
> logic, change maximum amount of bytes that can be written to be
> conformant with DDC/CI specification, prevent userspace from holding
> locks with the open file descriptor, remove ddcci_cdev_seek, dont
> refine sysfs_emit() logic, use EXPORT_SYMBOL_GPL instead of
> EXPORT_SYMBOL, remove ddcci_device_remove_void, remove module
> paramaters and version, and split into 2 patches.
> 
> v9: Fix IS_ANY_ID matching for compilers and archs where char is
> unsigned char and use the cannonical patch format.
> Reported-by: kernel test robot <lkp@intel.com>
> 
> v10: Change patch title to "drivers: ddcci: add drivers for DDCCI
> and change" and change patch descriptions to add more detailed
> explanations of function.
> 
> Patch 1: Add the main DDCCI component.
> 
> Patch 2: Add the backlight driver that utilizes the DDCCI driver.
> 
> Patch 3: Add documentation for the DDCCI drivers.
> 
> Yusuf Khan (3):
>   drivers: ddcci: add drivers for DDCCI
>   drivers: ddcci: add drivers for DDCCI
>   drivers: ddcci: add drivers for DDCCI
> 
>  Documentation/ABI/testing/sysfs-driver-ddcci |   57 +
>  Documentation/driver-api/ddcci.rst           |  122 ++
>  drivers/char/Kconfig                         |   11 +
>  drivers/char/Makefile                        |    1 +
>  drivers/char/ddcci.c                         | 1805 ++++++++++++++++++
>  drivers/video/backlight/Kconfig              |   11 +
>  drivers/video/backlight/Makefile             |    1 +
>  drivers/video/backlight/ddcci-backlight.c    |  411 ++++
>  include/linux/ddcci.h                        |  163 ++
>  9 files changed, 2582 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
>  create mode 100644 Documentation/driver-api/ddcci.rst
>  create mode 100644 drivers/char/ddcci.c
>  create mode 100644 drivers/video/backlight/ddcci-backlight.c
>  create mode 100644 include/linux/ddcci.h
> 

