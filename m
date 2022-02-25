Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8534C4BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiBYRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiBYRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:14:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A51AA48A;
        Fri, 25 Feb 2022 09:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DF93B832D2;
        Fri, 25 Feb 2022 17:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8885C340F5;
        Fri, 25 Feb 2022 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645809230;
        bh=PAzgk9fc8UNeS61XwY8qL+LCQ/UWWXGsmNJHOaD8Wqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BF55rSVh3MUsVAQ0EqnmhHfNI2U7oWOru1e8h8lpAeL5NJ6tNtpiGD72MF+sCSmd2
         1ey99dvbhkignhEj/6Uxio6AG+j9bncI+eNP/KUOex4n+TKOJklcXaSrbNMmRhEa2w
         tpqt9AcYflWIhXJK8KhyYt0n32cW9m0K5q/P66YWnAhLRId8RCk6chcW7I55+bRn7x
         KyY+UILiydfOsY0T64fU78XytNuDVGvF8OOZ6bHml6V6nTeieg8SWKjNLapaqU4rlT
         Lz4MzY1eVgp1XOL/GFihSu5UvLcfbkIlh6WI1Xw8vqbwqlVG0rQQYFM9/QOf0LjXli
         cqCk99aoJHC7w==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d641c31776so40429027b3.12;
        Fri, 25 Feb 2022 09:13:50 -0800 (PST)
X-Gm-Message-State: AOAM533YdlGrpykHomY/nZMwrKk7d4MkhSohVPRYnSfq4uHakjiepwwk
        BCfZdEhHu1Xp+YYo8BIAATObk8SkK0h4amIfgKk=
X-Google-Smtp-Source: ABdhPJzbDDNFMjY/4QToEsZKcKs4D81AkaPkx0SNKdQc5rVFGCht3B168yIkyvgYZHUd2tphyeeTM+xp5HP7aDeyf2g=
X-Received: by 2002:a0d:d482:0:b0:2d8:1555:e21d with SMTP id
 w124-20020a0dd482000000b002d81555e21dmr6750504ywd.272.1645809229658; Fri, 25
 Feb 2022 09:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220225155552.30636-1-graf@amazon.com>
In-Reply-To: <20220225155552.30636-1-graf@amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Feb 2022 18:13:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
Message-ID: <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     Alexander Graf <graf@amazon.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
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

On Fri, 25 Feb 2022 at 16:56, Alexander Graf <graf@amazon.com> wrote:
>
> We create a list of ACPI "PNP" IDs which contains _HID, _CID and CLS
> entries of the respective devices. However, we squeeze them into
> struct acpi_device_id which only has 9 bytes space to store the identifier
> based on the ACPI spec:
>
> """
> A _HID object evaluates to either a numeric 32-bit compressed EISA
> type ID or a string. If a string, the format must be an alphanumeric
> PNP or ACPI ID with no asterisk or other leading characters.
> A valid PNP ID must be of the form "AAA####" where A is an uppercase
> letter and # is a hex digit.
> A valid ACPI ID must be of the form "NNNN####" where N is an uppercase
> letter or a digit ('0'-'9') and # is a hex digit. This specification
> reserves the string "ACPI" for use only with devices defined herein.
> It further reserves all strings representing 4 HEX digits for
> exclusive use with PCI-assigned Vendor IDs.
> """
>
> While most people adhere to the ACPI specs, Microsoft decided that its
> VM Generation Counter device [1] should only be identifiable by _CID with
> an value of "VM_Gen_Counter" - longer than 9 characters.
>
> To still allow device drivers to match identifiers that exceed the 9 byte
> limit, without wasting memory for the unlikely case that you have long
> identifiers, let's match only the first 9 characters of the identifier.
>
> This patch is a prerequisite to add support for VMGenID in Linux [2].
>
> [1] https://download.microsoft.com/download/3/1/C/31CFC307-98CA-4CA5-914C-D9772691E214/VirtualMachineGenerationID.docx
> [2] https://lore.kernel.org/lkml/20220225124848.909093-1-Jason@zx2c4.com/
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
> Alternatives to the approach above would be:
>
>   1) Always set id[8] = '\0' in acpi_add_id()
>   2) Allocate the id in struct acpi_device_id dynamically
>
> I'm happy to explore option 1 instead if people believe it's cleaner.
> Option 2 on the other hand seems overkill for the issue at hand. We don't
> have a lot of devices that exceed the 8 character threshold, so chance of
> collision is quite small. On the other hand, the extra overhead of
> maintaining the string allocation dynamically will quickly become a
> headache.
>

I don't like this hack. If we are going to accept the fact that CIDs
could be arbitrary length strings, we should handle them properly.

The device subsystem side of things already deals with this properly:
the modalias of the QEMU vmgenid device comes up as
'acpi:QEMUVGID:VM_GEN_COUNTER', which means it already captures the
entire string, and exposes it in the correct way (modulo the all caps)

So what we need is a way for a module to describe its compatibility
with such a _CID, which shouldn't be that complicated.

I'll try to cook something up.


> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..aba93171739f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -829,7 +829,7 @@ static bool __acpi_match_device(struct acpi_device *device,
>                 /* First, check the ACPI/PNP IDs provided by the caller. */
>                 if (acpi_ids) {
>                         for (id = acpi_ids; id->id[0] || id->cls; id++) {
> -                               if (id->id[0] && !strcmp((char *)id->id, hwid->id))
> +                               if (id->id[0] && !strncmp((char *)id->id, hwid->id, ACPI_ID_LEN))
>                                         goto out_acpi_match;
>                                 if (id->cls && __acpi_match_device_cls(id, hwid))
>                                         goto out_acpi_match;
> --
> 2.16.4
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
