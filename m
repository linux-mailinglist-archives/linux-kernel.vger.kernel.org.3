Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F04C8B98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiCAMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiCAMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:30:05 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6357C7BD;
        Tue,  1 Mar 2022 04:29:23 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id e186so2749680ybc.7;
        Tue, 01 Mar 2022 04:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Qb+h6pvmrYcsYdF4fmRmPW5GvZZaWDE9Xx5LWTWH34=;
        b=PlOHSc6xG0KtIUuc39L0z+7afFzJoKqA99WLj4+afh1W1YEujhBofgcdTWsy+oBkiU
         ISJ4VVRNfqlpyUMg8MyjN76lLHzgtATNK95tGlfeQkb9IBDX6Cw6bnauPSOXU+9DFNBX
         XR9wtWRh5fy1kLsA+b9ejl8I3RucVM8nN2BGmfjNCfye1fLiaZo4OahE3bepaLzA4yj7
         AsGUN0lIvNBqFXxP6LRXnIqBxPEDHnKLOgbDFUSxDhmBrX0lmPlfwzfianfo6rf56Ao9
         FMAziQt+psIkhiwmEzwQ8J6hRHdl9mnG2oF7uCFaljDpMqgxciPGsaHlp36WftJbJRvC
         uwnA==
X-Gm-Message-State: AOAM5308V5UEcODpw0YX0nAtxiUFyNB3dCcmlk1lv3y/zBAKeOh9MWRI
        A/hfL2qRZJHWwWC+4WHC1Yvhwmj1TWuPXonK3cA=
X-Google-Smtp-Source: ABdhPJx83Dm3C89wEnZvq5L0H/uXdIUCUF+VaaSrxtZgFnG2zvKEmtY6mGRdRaGSYA7F8csBBVvhQVCoy7FuKYkg+vc=
X-Received: by 2002:a25:d90d:0:b0:615:e400:94c1 with SMTP id
 q13-20020a25d90d000000b00615e40094c1mr23374790ybg.81.1646137762438; Tue, 01
 Mar 2022 04:29:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
In-Reply-To: <20220228183355.9090-1-Jason@zx2c4.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 13:29:11 +0100
Message-ID: <CAJZ5v0jPP5UJevOFQprxvv+9-HRZHH22Ms7AmG04=BpoeXF-uA@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 7:34 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> entries of the respective devices. However, when making structs for
> matching, we squeeze those IDs into acpi_device_id, which only has 9
> bytes space to store the identifier. The subsystem actually captures the
> full length of the IDs, and the modalias has the full length, but this
> struct we use for matching is limited. It originally had 16 bytes, but
> was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> modalias generation safe for cross compiling"), presumably on the theory
> that it would match the ACPI spec so it didn't matter.
>
> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> decided that its VM Generation Counter device [1] should only be
> identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> than 9 characters.
>
> To allow device drivers to match identifiers that exceed the 9 byte
> limit, this simply ups the length to 16, just like it was before the
> aforementioned commit. Empirical testing indicates that this
> doesn't actually increase vmlinux size on 64-bit, because the ulong in
> the same struct caused there to be 7 bytes of padding anyway, and when
> doing a s/M/Y/g i386_defconfig build, the bzImage only increased by
> 0.0055%, so negligible.
>
> This patch is a prerequisite to add support for VMGenID in Linux, the
> subsequent patch in this series. It has been confirmed to also work on
> the udev/modalias side in userspace.
>
> [1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>
> [Jason: reworked commit message a bit, went with len=16 approach.]
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Hi Rafael,
>
> This patch is directed toward you specifically. The first and last patch
> of the series this is part of have been through the ringer of review a
> bit already and do not specifically require your attention, but we wound
> up getting hung up on an ACPI ID matching API limitation. This patch
> fixes that limitation with this patch that you see here, with a trivial
> one line fix, which does require your attention.
>
> The other patches will go through my random.git tree naturally, but
> because those patches depend on this one here, in order to compile
> without warnings (and be functional at all), it would be nice if you
> would provide an "Acked-by" on it and permit me to /also/ take it
> through my random.git tree (if it looks like a correct patch to you, of
> course). This would make the merge logistics a lot easier. Plus it's a
> small +1/-1 line change.
>
> This v6 updates the commit message.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
