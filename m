Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA04C5A67
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiB0KEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0KEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477C5C372;
        Sun, 27 Feb 2022 02:03:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 088BF60A28;
        Sun, 27 Feb 2022 10:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C83C340E9;
        Sun, 27 Feb 2022 10:03:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SWbE859G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645956233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0y6/b4jJfIe6Yc+9ImHaOFk+3EWN1XclfmHMTP1s7ZQ=;
        b=SWbE859GIbNh8OyLOAmI2smrNAXi/flka98GtIxl51yXAH/dFse9jhZaq095fXTUft8Zd/
        9KBvfJ1fCbX8Lzebi70QyZDTPfgDSdfuegIZXLsWYbXypz81UnIrvF89rctgS7ehf+Ywr1
        7EafA1UDBFEqli6XQn8JNOKk0fgQKyY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1b97871 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 27 Feb 2022 10:03:52 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d310db3812so77870457b3.3;
        Sun, 27 Feb 2022 02:03:52 -0800 (PST)
X-Gm-Message-State: AOAM532MNMwsdEKzxtXaBLfXWsvqamwWF+GjTU/JC+wTFgnrScFdQnkO
        IcbkBn4+M3lNKresXYrGPRA7lggt8Ju+yzFVSqw=
X-Google-Smtp-Source: ABdhPJx41XAu9RouMczPScnz+HcpQjZNqDXsMjF3Oc86TV0YopIgOJfZjbzZY9ZwssTUAKVtbtUed0VoGotlPMFhWxs=
X-Received: by 2002:a81:8984:0:b0:2db:6b04:be0c with SMTP id
 z126-20020a818984000000b002db6b04be0cmr2276143ywf.2.1645956231622; Sun, 27
 Feb 2022 02:03:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:71a8:b0:167:24f9:2d40 with HTTP; Sun, 27 Feb 2022
 02:03:50 -0800 (PST)
In-Reply-To: <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 27 Feb 2022 11:03:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
Message-ID: <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> From: Alexander Graf <graf@amazon.com>
>>
>
> Please don't invent patch authors like that. Alex's patch that started
> this discussion was completely different.

Considering the investigative side ("why won't the _CID match?") and
most the commit message were Alex's, and that those things comprise
95% of what this patch is, and that the code change itself isn't even
part of anything Turing complete, I most certainly did not feel
comfortable stripping Alex's authorship. Instead I added myself as a
co-author at the bottom. When in doubt, err on the side of crediting
others. Alex also took a look at this patch, I am under the impression
of at least, before it went out. Let's minimize the paperwork
policing, okay? I think it'd make for a much more pleasant space here.
If Alex objects he can just simply say, "hey feel free to remove me as
author," and it'll be simple as that, and again doesn't involve your
policing.

>
>> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
>> entries of the respective devices. However, we squeeze them into struct
>> acpi_device_id, which only has 9 bytes space to store the identifier. It
>> originally had 16 bytes, but was changed to only have 9 in 6543becf26ff
>> ("mod/file2alias: make modalias generation safe for cross compiling"),
>> presumably on the theory that it would match the ACPI spec so it didn't
>> matter.
>>
>
> Please clarify that this applies to the module metadata side of
> things. The ACPI subsystem already captures and exposes _HIDs and
> _CIDs that are longer than 8 characters, which is why simply
> increasing the size of this field is sufficient to create modules that
> can match devices that expose a CID that is longer than 8 bytes.

Good point for strengthening the argument here. Will do.

>
>> Unfortunately, while most people adhere to the ACPI specs, Microsoft
>> decided that its VM Generation Counter device [1] should only be
>> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
>> than 9 characters.
>>
>> To allow device drivers to match identifiers that exceed the 9 byte
>> limit, this simply ups the length to 16, just like it was before the
>> aforementioned commit. Empirical testing indicates that this
>> doesn't actually increase vmlinux size, because the ulong in the same
>> struct caused there to be 7 bytes of padding anyway.
>>
>
> The padding situation only applies to struct acpi_device_id, whereas
> ACPI_ID_LEN is used in other places as well. Also, the size of vmlinux
> only covers statically allocated instances in the core kernel, and
> most of the ACPI_ID_LEN uses are probably in drivers. So whether
> vmlinux changes size or not is not that relevant.

I actually looked at every usage in the tree (there aren't that many)
and couldn't find a single one where behavior changed, performance
changed, or memory usage changed. I thought we looked together on IRC
so I'm surprised to see you mention this, but maybe I misunderstood
you. Anyway, I can't see the size increase impacting anything at all.
If you see a case, this would be the time to mention that you see
something. I didn't find anything though.

> Patch 6543becf26ff was wrong to change ACPI_ID_LEN, because it failed
> to take into account any other uses of ACPI_ID_LEN, and did not bother
> to explain why the change was necessary in the context of what it was
> trying to achieve.

I'm not sure there really were other usages back then. The commit
message seems descriptive enough to me too. This was about cross
compiling, so padding. But it certainly did seem to limit future
drivers in an unintended way, as you wrote:

> So, given that we need more than 8 characters to match drivers to
> devices exposed by Hyper-V (or other VMMs adhering to the VMGENID
> spec), I think this change is necessary and correct.

Right, that's the idea.


>
> So, with the authorship/signoff corrected, and the commit log clarified,
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks.

Hopefully we'll hear from Rafael this week.

Jason
