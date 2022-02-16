Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40E4B8CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiBPPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:45:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiBPPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:45:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36D2A0D69
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A595FB81F39
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9EC340F0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026323;
        bh=XpMxzkB0stx81ZabSJ8/IiFdYsJ2zJ9N9l7L4UMFCYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXEScut2qGqZrT7XmA5vtEKZ439QC6HzWQD2GYGjHI1jTInTqoXll7M+2DOTe8/i7
         6TUUC7wT9o71IeqT868IQ9W+o8pi4K/S/nrdH9PYDm87W3v4/UL2oLX3Eg6pVzmMmk
         Bt4HtL9xBMvPUHcYxBnWPv0OjyWP6y2XxLrh4XWtpPHeRHzX/Oc4i+wYLoEhir/4oa
         x++EGD4HvHDf6xtXfNrNYOagNpG3t6UEUCLqGbfQ8vGehuJH7OXdk65fsVyPJXIJTj
         euVBAMJ3BIYhF+FCwh73I4eB8fldop4vxmjoPWOhqu7+lYwQrAHJHqHXkiSmMKgZog
         XXALwMEUX9O7g==
Received: by mail-ej1-f54.google.com with SMTP id p9so192286ejd.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:45:23 -0800 (PST)
X-Gm-Message-State: AOAM533iaDLKWnqW8/OpmB9XzkNguadM7Po94eczjC/BmX/eZkamOVMW
        nwdrIuMPHxJyaFaKmpbJFBnCh45TTUF9gteXzQ==
X-Google-Smtp-Source: ABdhPJy+XPhpKOPNgtxSOq6QJrDhVh6yHZfMZsKNmjTCxgGpf4onTSyh/XKQkdg7X7C+3816Adgz0hGtb7aQNSZhX4U=
X-Received: by 2002:a17:906:d935:b0:6cc:fcfc:c286 with SMTP id
 rn21-20020a170906d93500b006ccfcfcc286mr2721203ejb.423.1645026321747; Wed, 16
 Feb 2022 07:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20220216094128.4025861-1-marten.lindahl@axis.com>
In-Reply-To: <20220216094128.4025861-1-marten.lindahl@axis.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Feb 2022 09:45:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQ2sZ1YnxGzBvVfHBAq7b34pT4=qs147RsFMjFuFJc+Q@mail.gmail.com>
Message-ID: <CAL_JsqKQ2sZ1YnxGzBvVfHBAq7b34pT4=qs147RsFMjFuFJc+Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: Free DMA range map when device is released
To:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 3:42 AM M=C3=A5rten Lindahl <marten.lindahl@axis.co=
m> wrote:
>
> When unbinding/binding a driver with DMA mapped memory, the DMA map is
> not freed before the driver is reloaded. This leads to a memory leak
> when the DMA map is overwritten when reprobing the driver.
>
> This can be reproduced with a platform driver having a dma-range:
>
> dummy {
>         ...
>         #address-cells =3D <0x2>;
>         #size-cells =3D <0x2>;
>         ranges;
>         dma-ranges =3D <...>;
>         ...
> };
>
> and then unbinding/binding it:
>
> ~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/unbind
>
> DMA map object 0xffffff800b0ae540 still being held by &pdev->dev
>
> ~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/bind
> ~# echo scan > /sys/kernel/debug/kmemleak
> ~# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffff800b0ae540 (size 64):
>   comm "sh", pid 833, jiffies 4295174550 (age 2535.352s)
>   hex dump (first 32 bytes):
>     00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 80 00 00 00 00 00 00 00 80 00 00 00 00  ................
>   backtrace:
>     [<ffffffefd1694708>] create_object.isra.0+0x108/0x344
>     [<ffffffefd1d1a850>] kmemleak_alloc+0x8c/0xd0
>     [<ffffffefd167e2d0>] __kmalloc+0x440/0x6f0
>     [<ffffffefd1a960a4>] of_dma_get_range+0x124/0x220
>     [<ffffffefd1a8ce90>] of_dma_configure_id+0x40/0x2d0
>     [<ffffffefd198b68c>] platform_dma_configure+0x5c/0xa4
>     [<ffffffefd198846c>] really_probe+0x8c/0x514
>     [<ffffffefd1988990>] __driver_probe_device+0x9c/0x19c
>     [<ffffffefd1988cd8>] device_driver_attach+0x54/0xbc
>     [<ffffffefd1986634>] bind_store+0xc4/0x120
>     [<ffffffefd19856e0>] drv_attr_store+0x30/0x44
>     [<ffffffefd173c9b0>] sysfs_kf_write+0x50/0x60
>     [<ffffffefd173c1c4>] kernfs_fop_write_iter+0x124/0x1b4
>     [<ffffffefd16a013c>] new_sync_write+0xdc/0x160
>     [<ffffffefd16a256c>] vfs_write+0x23c/0x2a0
>     [<ffffffefd16a2758>] ksys_write+0x64/0xec
>
> To prevent this we should free the dma_range_map when the device is
> released.
>
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Suggested-by: Rob Herring <robh@kernel.org>
Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map,
supplanting dma_pfn_offset")
Reviewed-by: Rob Herring <robh@kernel.org>

I've got a follow-up patch to refactor the 3 occurrences of this same
deinit code.

Rob
