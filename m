Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8A4C59E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiB0HiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiB0HiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:38:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B38140B4;
        Sat, 26 Feb 2022 23:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55DF1B80B3B;
        Sun, 27 Feb 2022 07:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AE9C340F4;
        Sun, 27 Feb 2022 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645947450;
        bh=0BWGGDk4yOAhJkVrMkm/YEx785K8+w2gik+gmhK7BYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bov5E/ezJUzhGNYLyNOyNliF6+eEhILqHY36dqb0+AVr+glf56fOtGUyuaegjTjl9
         Qsr3UnWXD21gOUqghFWSoQT614fyE1JsxXcDoK8lhtMNu+vsCczSJhkJvkvFv8aVHR
         +K3nLDsLxUtUzPjAtSHYsq2c4E25+36mY2KBh5IwyWhWH6+YddHfZT+Z2FSGeqAC2P
         0268jaNy4niBNCkKujy8tthJPzSE1NOKrPtFnAsa2iSoYe1PHfOHjal9aL3tfaei9J
         oBV5vneUPn9oqI6jwdMsPo7277fTqzGCoax63xx9cBhFng1tiPRxwgeulujJBqnvxL
         /eBIUDhjlzabA==
Received: by mail-yb1-f176.google.com with SMTP id e140so14323388ybh.9;
        Sat, 26 Feb 2022 23:37:30 -0800 (PST)
X-Gm-Message-State: AOAM5301d5ST+TqTprxKNJvrmuIqYWQ/eq9ejSXb/Sy+NCJRp6v/6NOg
        4e3X7Fb4E48uAodD9dD0c7yV136LTWxz7aY3bHE=
X-Google-Smtp-Source: ABdhPJzYlDbfRocjrgv+BzLnyi6LxQpvW1ZnwT6DHaY7e4xUkJYqoOyp5SO2BASnGX7RMPQj+gaw0X0KaF6yb8qiEoc=
X-Received: by 2002:a25:af8e:0:b0:622:c778:c0a2 with SMTP id
 g14-20020a25af8e000000b00622c778c0a2mr14291612ybh.50.1645947449941; Sat, 26
 Feb 2022 23:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
In-Reply-To: <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 08:37:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFVkEriwPhKhb1TC05sK9JmzE94Xmp=r1xty1BP2RcY2g@mail.gmail.com>
Message-ID: <CAMj1kXFVkEriwPhKhb1TC05sK9JmzE94Xmp=r1xty1BP2RcY2g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
>
> Please don't invent patch authors like that. Alex's patch that started
> this discussion was completely different.
>
> > We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> > entries of the respective devices. However, we squeeze them into struct
> > acpi_device_id, which only has 9 bytes space to store the identifier. It
> > originally had 16 bytes, but was changed to only have 9 in 6543becf26ff
> > ("mod/file2alias: make modalias generation safe for cross compiling"),
> > presumably on the theory that it would match the ACPI spec so it didn't
> > matter.
> >
>
> Please clarify that this applies to the module metadata side of
> things. The ACPI subsystem already captures and exposes _HIDs and
> _CIDs that are longer than 8 characters, which is why simply
> increasing the size of this field is sufficient to create modules that
> can match devices that expose a CID that is longer than 8 bytes.
>
> > Unfortunately, while most people adhere to the ACPI specs, Microsoft
> > decided that its VM Generation Counter device [1] should only be
> > identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> > than 9 characters.
> >
> > To allow device drivers to match identifiers that exceed the 9 byte
> > limit, this simply ups the length to 16, just like it was before the
> > aforementioned commit. Empirical testing indicates that this
> > doesn't actually increase vmlinux size, because the ulong in the same
> > struct caused there to be 7 bytes of padding anyway.
> >
>
> The padding situation only applies to struct acpi_device_id, whereas
> ACPI_ID_LEN is used in other places as well. Also, the size of vmlinux
> only covers statically allocated instances in the core kernel, and
> most of the ACPI_ID_LEN uses are probably in drivers. So whether
> vmlinux changes size or not is not that relevant.
>
>
> > This patch is a prerequisite to add support for VMGenID in Linux, the
> > subsequent patch in this series. It has been confirmed to also work on
> > the udev/modalias side in userspace.
> >
> > [1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Patch 6543becf26ff was wrong to change ACPI_ID_LEN, because it failed
> to take into account any other uses of ACPI_ID_LEN, and did not bother
> to explain why the change was necessary in the context of what it was
> trying to achieve.
>

Hmm, actually, ACPI_ID_LEN wasn't used outside of
linux/mod_device_table.h before 6543becf26ff, so changing it at that
point was fine.

I do wonder how much code is out there that blindly assumes the ACPI
core will never deliver more than 8 bytes' worth of _HID/_CID, and
subsequently runs off the end of a statically sized buffer.
