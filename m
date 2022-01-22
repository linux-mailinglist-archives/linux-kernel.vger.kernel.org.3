Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45749693F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiAVBlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:41:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59414 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiAVBlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:41:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F7261AC4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA73AC340E8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642815659;
        bh=2N5YrILHS5ceu4+jWfQFwtxpuu3lUpp8FDDcghKzmLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nD5qBM/bt55NQW51x+CQTE1FGnclwBjf1R4Nw7PWZ7GRR9/ltDjcRZmST1cFi3rwM
         xzFNEL0IoOocvdcEOqthv9j3a3OYKhxGWvw0Fh2AzeQX0B2JRDVz9cYlPhbdEtrm3c
         Do+LaatyoFjSrlKy5E4cR/AcA0r9fhfRGHqj2szJhmrp9Df8ZaK7A7Yl+GX1T4Zpf/
         XZsQWhL+YYjkY8Zf/6ogsu040JSZEZA9c+S8oUqdlKueqiyzQQw8nNuuvfY8tBNzDz
         PaRoR7PkHzwCQAvpEvYybuECu4Scf6uLWQ7H8RSjEgy/Akictsm3kxy+jx575Wqp8k
         X78trr1zAAmuA==
Received: by mail-ed1-f52.google.com with SMTP id f21so45602021eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:59 -0800 (PST)
X-Gm-Message-State: AOAM531CozYXPhswcBx9UGQxHUtv2sbH7iW2544BgkEfX1SIRxA6kIeD
        Z+gyhCAXSf+ZHM5wUNmFrHOm0mRloXY1uNgf/A==
X-Google-Smtp-Source: ABdhPJwBhdgXoY3T9SQ1PCB8hLQfTa/L/ej2L/TDO5lS+k0Ku8sS2rzv+UehEghwTlMbxpYR0tTpJJ1LZ7FTukYTfaw=
X-Received: by 2002:aa7:dc44:: with SMTP id g4mr6490540edu.109.1642815658154;
 Fri, 21 Jan 2022 17:40:58 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com>
 <YesxfEDbK/qFizFG@robh.at.kernel.org> <CAMdYzYrnahMuZTBjwNRrHnnNhn4wB7Ze=UA_HhzurqHC9U6oJg@mail.gmail.com>
In-Reply-To: <CAMdYzYrnahMuZTBjwNRrHnnNhn4wB7Ze=UA_HhzurqHC9U6oJg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Jan 2022 19:40:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJfK5A7aH7oeGS+3MBoPBHKP=ZBADVpx4mcU53roYe+MA@mail.gmail.com>
Message-ID: <CAL_JsqJfK5A7aH7oeGS+3MBoPBHKP=ZBADVpx4mcU53roYe+MA@mail.gmail.com>
Subject: Re: [BUG] device_property_read_u16 reads out only zero
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 7:27 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Fri, Jan 21, 2022 at 5:19 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 14, 2022 at 05:48:52PM -0500, Peter Geis wrote:
> > > Good Evening,
> > >
> > > I seem to have come across a strange bug with drivers/base/property.c
> > > while expanding the new cyttsp5 driver to handle device-tree
> > > overrides.
> > >
> > > With the property:
> > > touchscreen-size-x = <1863>;
> > > The following code:
> > > u32 test_u32 = 32; /* canary to catch writing a zero */
> > > u16 test_u16 = 16; /* canary to catch writing a zero */
> > > int ret;
> > >
> > > ret = device_property_read_u32(ts->dev, "touchscreen-size-x", &test_u32);
> > > if(ret)
> > > dev_err(ts->dev, "read_u32 failed ret: %d\n", ret);
> > >
> > > ret = device_property_read_u16(ts->dev, "touchscreen-size-x", &test_u16);
> > > if(ret)
> > > dev_err(ts->dev, "read_u16 failed ret: %d\n", ret);
> > >
> > > dev_err(ts->dev, "read_u32: %d, read_u16: %d\n", test_u32, test_u16);
> > >
> > > returns the following:
> > > [    1.010876] cyttsp5 5-0024: read_u32: 1863, read_u16: 0
> > >
> > > This was as of 5.16-rc8, using the
> > > gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu compiler.
> > > I honestly am at a loss here, any insight you can provide here would
> > > be appreciated.
> >
> > The property "touchscreen-size-x" is a u32. Calling
> > device_property_read_u16 is an error though one is not returned here.
> > You get 0 because that is what the first 2 bytes of the property
> > contain. DT data is big-endian.
>
> I figured this was the case, but I was hopeful the operators would be
> smart enough to handle endian translations.
> Wouldn't all DT numeric properties be u32, meaning
> device_property_read_u16 and device_property_read_u8 are meaningless
> on little endian devices?

No.

> Or is there a way to force smaller values in the DT?

Yes. [ 0 1 2 ] notation is 8-bit. Or you can use the /bits/ 8|16|64 directive.

> > I suspect making this a hard error would break some users, but we could
> > try a WARN.
>
> I don't suspect it would be trivial to implement endian translation
> for these functions?

They do endian translation already. In your case byte 0 and byte 1 are swapped.

The DT data is purely a byte array once it's in the dtb. It's up to
the caller with specific knowledge about a property to know how to
interpret it. It would be nice if all the size and type information
was maintained in the dtb format, but it's not and no one has stepped
up to do a new format (changing would be painful too).

Rob
