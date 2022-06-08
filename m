Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED9542B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiFHJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiFHJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D319319FB4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654678292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTJNxPhm7RLPPszuwy8H6thl/19s3griMfO8/U8OJSI=;
        b=aUzpMtqoMu3IT1SEiPZ9A94HaDLNiEkqJ0Eyk+Sx3pDAhQtfsb96q/UWCCdFPhTQZ+hLQu
        +3EqldW/quws85GNTC2ErFm09naCBEKlODYQulhrqCAyh34Z1R9+c2onHkdJNB9EH3k5Nl
        y8q3sZ0ChU328pUepAm/4vCeqLvrYU4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-HL8UhSVrMnmIdlsHEQPbFQ-1; Wed, 08 Jun 2022 04:51:31 -0400
X-MC-Unique: HL8UhSVrMnmIdlsHEQPbFQ-1
Received: by mail-wr1-f70.google.com with SMTP id c11-20020adffb4b000000b0020ff998391dso4550561wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YTJNxPhm7RLPPszuwy8H6thl/19s3griMfO8/U8OJSI=;
        b=dMhaNSzb6rVkovgNfejt3q1GUQswnpuPHABAgfrM7Lczhpc4S3KVCfBHJ4WABymNYj
         f3gsTD+dWJTiAayxfhGh9WgeGIzETMzbJgP5JxmzgVVsebDrNDWFn2hg7oSeu60ZTam9
         sIHba6u2oBpuRdj8frZ1jtqIejzTN/ppalrEehhK96HMJmom+xOuH3tbI3KjfsDefWJT
         IDdKPVcIUt9yZ3G7g4AA1zyAQF+WC51XAwd5jPbVRHGLBD7i/OS1TcTxhnQV2Ccp/sot
         sf9OduisBF8fDChKz2bvdWEw3j0G/nykcEs1hzzDkXnUmnuVCzNqdyMQmewh/CwheOvg
         cDAw==
X-Gm-Message-State: AOAM533CLyv9suZbLQMBP6Sepfj0tZCtP/Z0IogD+65VMDWk2g6WlZQ6
        krBSGU5n34iAm3bRRfNwHwCxP/jjlpF7If7J55+uowuU3YJFMsbcF0Hc7x3Y5rcCtCTSkftS6Ah
        EhUswE7tf5cysrIe9l2uw7hyU
X-Received: by 2002:a5d:6c61:0:b0:210:7277:774c with SMTP id r1-20020a5d6c61000000b002107277774cmr32149889wrz.212.1654678290641;
        Wed, 08 Jun 2022 01:51:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9FLAVx/XGPFkjTafQfU+5134QjcX4BkF6fWgLxlLiGCIxPsAWXQSt59EybZDIXIW+BiEaHw==
X-Received: by 2002:a5d:6c61:0:b0:210:7277:774c with SMTP id r1-20020a5d6c61000000b002107277774cmr32149854wrz.212.1654678290282;
        Wed, 08 Jun 2022 01:51:30 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b0039c3b05540fsm20692462wmq.27.2022.06.08.01.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:51:29 -0700 (PDT)
Message-ID: <b8eee5a7-7428-fcfd-9266-fa63b9fde5e9@redhat.com>
Date:   Wed, 8 Jun 2022 10:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Improve vfio-pci primary GPU assignment behavior
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        kvm@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <165453797543.3592816.6381793341352595461.stgit@omen>
 <badc8e91-f843-2c96-9c02-4fbb59accdc4@redhat.com>
 <20220608074306.wyav3oerq5crdk6c@sirius.home.kraxel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220608074306.wyav3oerq5crdk6c@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerd and Alex,

On 6/8/22 09:43, Gerd Hoffmann wrote:
>   Hi,
> 
>> But also, this issue isn't something that only affects graphic devices,
>> right? AFAIU from [1] and [2], the same issue happens if a PCI device
>> has to be bound to vfio-pci but already was bound to a host driver.
> 
> Nope.  There is a standard procedure to bind and unbind pci drivers via
> sysfs, using /sys/bus/pci/drivers/$name/{bind,unbind}.
>

Yes, but the cover letter says:

"Users often employ kernel command line arguments to disable conflicting
drivers or perform unbinding in userspace to avoid this"

So I misunderstood that the goal was to avoid the need to do this via sysfs
in user-space. I understand now that the problem is that for real PCI devices
bound to a driver, you know the PCI device ID and bus so that you can use it,
but with platform devices bound to drivers that just use a firmware-provided
framebuffers you don't have that information to unbound.

Because you could use the standard sysfs bind/unbind interface for this too,
but don't have a way to know if the "simple-framebuffer" or "efi-framebuffer"
is associated with a PCI device that you want to pass through or another one.

The only information that could tell you that is the I/O memory resource that
is associated with the platform device registered and that's why you want to
use the drm_aperture_remove_conflicting_pci_framebuffers() helper.
 
>> The fact that DRM happens to have some infrastructure to remove devices
>> that conflict with an aperture is just a coincidence.
> 
> No.  It's a consequence of firmware framebuffers not being linked to the
> pci device actually backing them, so some other way is needed to find
> and solve conflicts.
>

Right, it's clear to me now. As mentioned I misunderstood your problem.

>> The series [0] mentioned above, adds a sysfb_disable() that disables the
>> Generic System Framebuffer logic that is what registers the framebuffer
>> devices that are bound to these generic video drivers. On disable, the
>> devices registered by sysfb are also unregistered.
> 
> As Alex already mentioned this might not have the desired effect on
> systems with multiple GPUs (I think even without considering vfio-pci).
>

That's correct, although the firmware framebuffer drivers are just a best
effort to allow having some display output even if there's no real video
driver (or if the user prevented them to load with "nomodeset").

We have talked about improving this, by unifying fbdev and DRM apertures
in a single list that could track all the devices registered and their
requested aperture so that all subsystems could use it. The reason why
I was pushing back on using the DRM aperture helper is that it would
make more complicated later to do this refactoring as more subsystems
use the current API.

But as Alex said, it wouldn't make the problem worse so I'm OK with this
if others agree that's the correct thing to do.
 
>> That is, do you want to remove the {vesa,efi,simple}fb and simpledrm
>> drivers or is there a need to also remove real fbdev and DRM drivers?
> 
> Boot framebuffers are the problem because they are neither visible nor
> manageable in /sys/bus/pci.  For real fbdev/drm drivers the standard pci
> unbind can be used.
>

Yes. Honestly I believe all this should be handled by the Linux device model.

That is, drivers could just do pci_request_region() / request_mem_region()
and drivers that want to unbind another bound device could do something like
pci_request_region_force() / request_mem_region_force() to kick them out.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

