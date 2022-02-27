Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98B64C59E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiB0Hcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiB0Hcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:32:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E9C4D;
        Sat, 26 Feb 2022 23:32:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D90160A2B;
        Sun, 27 Feb 2022 07:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E43EC340EF;
        Sun, 27 Feb 2022 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645947126;
        bh=qcOpXG4QpqEcxElyWgrGsWaPoAG+dPvvg3UDRWAQbg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nO27vOjA4mH8v/aGgRuXLfvnYB+W/cdffbBH6UMlI2RmZbL5+X2bpRxfdrGqSyVSC
         5Wumrth11rZJnIMUDoEvcdoI+hS9IZxJFKX8syJGbC2KOVdSOwC6Nn87ceE7tHIMbK
         xAmOrHdahZoID9jWrX+bhXD0S+f/aOA5uqym3CG5UIwmB31/+FtYxHtlhYihAmysfV
         BNv9acScZwnPquvSB2A6rIcAjEuN7zHty6QuKYI87WWu03aUD58ZBmF4mPJgtpwa20
         GtHhTstWFvc6CKeweZhpjFFdt3wcQ5daYA9lp/0DoyP2K2hUMo2fdkTKhiVPB/Mifs
         RIxdHQTQ+q09A==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2d79394434dso76074497b3.5;
        Sat, 26 Feb 2022 23:32:06 -0800 (PST)
X-Gm-Message-State: AOAM531xt7PylxC0N59mml1Ct9wdCJGT11egr1xaEhJ0dmKlxPsFUrLC
        DJXyPi+/UYXS8F3ty799hclONaQdTclcREUTjxU=
X-Google-Smtp-Source: ABdhPJyW0CxhFKZ2MdIXt1JkTAl92QE+R6DwnJTmXDacGyEM/DlkorPdFmxvmMz87/9cIa7bKcUS3+zQKghn6WlYOJc=
X-Received: by 2002:a0d:dfd5:0:b0:2cf:924b:105d with SMTP id
 i204-20020a0ddfd5000000b002cf924b105dmr15706423ywe.342.1645947125491; Sat, 26
 Feb 2022 23:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
In-Reply-To: <20220226220639.1173594-3-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 08:31:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
Message-ID: <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
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

On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>

Please don't invent patch authors like that. Alex's patch that started
this discussion was completely different.

> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> entries of the respective devices. However, we squeeze them into struct
> acpi_device_id, which only has 9 bytes space to store the identifier. It
> originally had 16 bytes, but was changed to only have 9 in 6543becf26ff
> ("mod/file2alias: make modalias generation safe for cross compiling"),
> presumably on the theory that it would match the ACPI spec so it didn't
> matter.
>

Please clarify that this applies to the module metadata side of
things. The ACPI subsystem already captures and exposes _HIDs and
_CIDs that are longer than 8 characters, which is why simply
increasing the size of this field is sufficient to create modules that
can match devices that expose a CID that is longer than 8 bytes.

> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> decided that its VM Generation Counter device [1] should only be
> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> than 9 characters.
>
> To allow device drivers to match identifiers that exceed the 9 byte
> limit, this simply ups the length to 16, just like it was before the
> aforementioned commit. Empirical testing indicates that this
> doesn't actually increase vmlinux size, because the ulong in the same
> struct caused there to be 7 bytes of padding anyway.
>

The padding situation only applies to struct acpi_device_id, whereas
ACPI_ID_LEN is used in other places as well. Also, the size of vmlinux
only covers statically allocated instances in the core kernel, and
most of the ACPI_ID_LEN uses are probably in drivers. So whether
vmlinux changes size or not is not that relevant.


> This patch is a prerequisite to add support for VMGenID in Linux, the
> subsequent patch in this series. It has been confirmed to also work on
> the udev/modalias side in userspace.
>
> [1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Patch 6543becf26ff was wrong to change ACPI_ID_LEN, because it failed
to take into account any other uses of ACPI_ID_LEN, and did not bother
to explain why the change was necessary in the context of what it was
trying to achieve.

So, given that we need more than 8 characters to match drivers to
devices exposed by Hyper-V (or other VMMs adhering to the VMGENID
spec), I think this change is necessary and correct.

So, with the authorship/signoff corrected, and the commit log clarified,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
> Hi Rafael & Len,
>
> This patchset is directed toward you two specifically. Patches 1/3 and
> 3/3 have been through the ringer of review a bit already and do not
> specifically require your attention, but in v4 we wound up getting hung
> up on an ACPI API limitation. This v5 fixes that limitation with this
> 2/3 patch that you see here, with a trivial one line fix, which does
> require your attention.
>
> Patches 1/3 and 3/3 will go through my random.git tree. However, 3/3
> actually depends on this one here, 2/3, in order to compile without
> warnings (and be functional at all). Therefore, it would be nice if you
> would provide an "Acked-by" on it and permit me to /also/ take it
> through my random.git tree (if it looks like a correct patch to you, of
> course). This would make the merge logistics a lot easier. Plus it's a
> small +1/-1 line change.
>
> Please have a look and let me know what you think.
>
> Thanks,
> Jason
>
>  include/linux/mod_devicetable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 4bb71979a8fd..5da5d990ff58 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -211,7 +211,7 @@ struct css_device_id {
>         kernel_ulong_t driver_data;
>  };
>
> -#define ACPI_ID_LEN    9
> +#define ACPI_ID_LEN    16
>
>  struct acpi_device_id {
>         __u8 id[ACPI_ID_LEN];
> --
> 2.35.1
>
