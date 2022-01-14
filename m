Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877048E6AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiANIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiANIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:38:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB66C061574;
        Fri, 14 Jan 2022 00:38:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A7A61998;
        Fri, 14 Jan 2022 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD51C36AE9;
        Fri, 14 Jan 2022 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642149497;
        bh=YGkYm9ISTpruq1RiIS/D3UGxFTC4kUdeUfT0+pdRgoY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=U/GR1rOKg2okE6AmaOGIv4kYQ7nViMlcfg6Xk3AYYhHr/vLyS0kxV1LzNtC6pelJU
         R6rcrLFjUv4tgZWW/9rMpHbsBfwIoXnvQLxqOp3uh1n8jKOuGfs4ig/3Vt3q00vZ9y
         WEcFF8MZ16nVaB66OvdGWwNudHY65/j3dtRf/1kQ1CBCtqVwv1ldA1fAPHpKP2HzLy
         XMk+TjXhdAI/u/cOLq/KX5Wfu0Pzooh3dtLzDr5HNPfSLDsiLy3J6uqqngbr9zScwF
         wh5+E4bgqgUqncYzC7JwQP+s38svWPRMFUuIb7fV5Q37ViJQD4amZr76I886FfmeGR
         qx4SF/beAvfzQ==
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com>
 <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
 <87czku4z2i.fsf@kernel.org>
 <CAMuHMdWEh07zXZZesuY0sksXaa6ptDvv3Fv4UC1RDkf7_KUv8w@mail.gmail.com>
 <2d6ab8ab-79c8-681b-a898-a88b48fceb55@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH 2/5] platform: surface: Propagate ACPI Dependency
Date:   Fri, 14 Jan 2022 10:37:57 +0200
In-reply-to: <2d6ab8ab-79c8-681b-a898-a88b48fceb55@redhat.com>
Message-ID: <874k664sqz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Hans de Goede <hdegoede@redhat.com> writes:
> Hi,
>
> On 1/14/22 09:29, Geert Uytterhoeven wrote:
>> Hi Felipe,
>> 
>> On Fri, Jan 14, 2022 at 7:21 AM Felipe Balbi <balbi@kernel.org> wrote:
>>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>>> On Mon, Dec 6, 2021 at 4:03 PM Jarrett Schultz <jaschultzms@gmail.com> wrote:
>>>>> Since the Surface XBL Driver does not depend on ACPI, the
>>>>> platform/surface directory as a whole no longer depends on ACPI. With
>>>>> respect to this, the ACPI dependency is moved into each config that depends
>>>>> on ACPI individually.
>>>>>
>>>>> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
>>>>
>>>> Thanks for your patch, which is now commit 272479928172edf0 ("platform:
>>>> surface: Propagate ACPI Dependency").
>>>>
>>>>> --- a/drivers/platform/surface/Kconfig
>>>>> +++ b/drivers/platform/surface/Kconfig
>>>>> @@ -5,7 +5,6 @@
>>>>>
>>>>>  menuconfig SURFACE_PLATFORMS
>>>>>         bool "Microsoft Surface Platform-Specific Device Drivers"
>>>>> -       depends on ACPI
>>>>>         default y
>>>>>         help
>>>>>           Say Y here to get to see options for platform-specific device drivers
>>>>
>>>> Without any dependency, all users configuring a kernel are now asked
>>>> about this. Is there any other platform dependency that can be used
>>>> instead?
>>>
>>> there's probably no symbol that would be true for x86 and arm64 while
>>> being false for everything else. Any ideas?
>> 
>> depends on ARM64 || X86 || COMPILE_TEST?
>
> That sounds reasonable to me, I would be happy to take a patch for that.

fair enough, let's see what Jarrett replies

-- 
balbi
