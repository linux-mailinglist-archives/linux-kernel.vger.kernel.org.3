Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417684C4C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiBYRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiBYRa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:30:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72F652E4;
        Fri, 25 Feb 2022 09:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C59A61DB3;
        Fri, 25 Feb 2022 17:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B3C340F2;
        Fri, 25 Feb 2022 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810226;
        bh=gcH32dGW4EZg7RhvfI9PxuB4WZ5SQvodrDrzUdNnKWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7TWQ+pL8SilFZ/W8gL6GZJkmwvlI7P3wrp1A68wtRh0+yEYlL2LbBn6ojgUIenrz
         DWUJSiENv03fyffxS6/GLCmCBH1tVtxo3rrRMActUr+heDbYUwGIPRukx+lfR6r2BJ
         C6maz7CX0e/YMbJWKYA465x6I5ylBSh0YLjQaLnqYXpn2opiTmauvg4BVjp3lgtwSp
         wo09iI3ZknB/EhpPzj9X1b03A9l8EyyWLohPMgsfWTJW7s2UXIb7TKMKX4a49vL83R
         NdfhcHwy9XsnJCEHxAU+RJW2ZMIpoXZQqKkMsh9lI86UIB9U8PjLAdbj9oJX8H3uYH
         QVZLe1cPKUyxQ==
Received: by mail-yb1-f174.google.com with SMTP id d21so7210596yba.11;
        Fri, 25 Feb 2022 09:30:26 -0800 (PST)
X-Gm-Message-State: AOAM530ZplcOyNb/FBSIZS8/P3ZpWeT2qt4sNzckB/j1n1Et2YhTiHJ/
        OVjgrqFxndnm4jfBmmU/kc4k/zFgFYs3l3+220c=
X-Google-Smtp-Source: ABdhPJz38V+iNaKLP6PxVSjf2Dw++J9wO+pfVO8AqgNDrTjTJT6JAfe/zvEIoqQhdtoe5zUJGa5VxUpfMz/deLHuYMw=
X-Received: by 2002:a25:4214:0:b0:624:6215:4823 with SMTP id
 p20-20020a254214000000b0062462154823mr8228722yba.432.1645810225527; Fri, 25
 Feb 2022 09:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20220225155552.30636-1-graf@amazon.com> <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com>
In-Reply-To: <YhkQKfE8ErtFBmSB@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Feb 2022 18:30:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
Message-ID: <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexander Graf <graf@amazon.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, 25 Feb 2022 at 18:21, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Feb 25, 2022 at 6:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The device subsystem side of things already deals with this properly:
> > the modalias of the QEMU vmgenid device comes up as
> > 'acpi:QEMUVGID:VM_GEN_COUNTER', which means it already captures the
> > entire string, and exposes it in the correct way (modulo the all caps)
>
> Ahh, so the userspace side of this won't work right. Shucks. That's what
> I was concerned about.
>
> > I don't like this hack. If we are going to accept the fact that CIDs
> > could be arbitrary length strings, we should handle them properly.
> >
> > So what we need is a way for a module to describe its compatibility
> > with such a _CID, which shouldn't be that complicated.
>
> Can't we do something more boring and just...
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 4bb71979a8fd..5da5d990ff58 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -210,9 +210,9 @@ struct css_device_id {
>         __u8 type; /* subchannel type */
>         kernel_ulong_t driver_data;
>  };
>
> -#define ACPI_ID_LEN    9
> +#define ACPI_ID_LEN    16
>
>  struct acpi_device_id {
>         __u8 id[ACPI_ID_LEN];
>         kernel_ulong_t driver_data;
>
>
> As you can see from the context, those additional 7 bytes were being
> wasted on padding anyway inside the acpi_device_id struct, so it's
> basically free, it would seem. This seems like the least convoluted way
> of solving this issue? If we ever encounter _more_ ACPI devices with
> weird names, we could revisit a fancy dynamic solution, but for now, why
> don't we keep it simple?
>

Yeah, good point. I think this is fine, although there are a few other
uses of ACPI_ID_LEN in the tree. So perhaps this should be something
like

#define ACPI_ID_LEN    9
#define ACPI_CID_LEN    16

/* explanation goes here */

struct acpi_device_id {
    __u8 id[ACPI_CID_LEN];

instead? At a quick glance, none of those ACPI_ID_LEN users seem
related to the CID or the match metadata.
