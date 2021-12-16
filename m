Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE24775BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhLPPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:21:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51418 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhLPPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:21:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 065A4B82484;
        Thu, 16 Dec 2021 15:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB20C36AE4;
        Thu, 16 Dec 2021 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639668076;
        bh=YLJMEoEPmFbk5sG6PffTZ+cN1H+IWVtIDJtqiCsWvqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7C241q3mGLxuufNbyH6ItOWn3QxuYcF2UHX0xaKoAVAV7fH4IZnLzvVq41zQn2VD
         h8m/GUYf4dheTNp/J3Mk888qVUTWoeKZaHV1o/oBL8kAiftVQOicf6pbx6AK2g9XHR
         Ms7bnoK6EDSq4g84qCyA8jP6JV6nNgOMDI7N8zzWkHT4KKu9oe8g6/x1SvbYWrL+NZ
         ztEwSEKySM12HzlNQqleqLiJ05VIPS+01gFOmQ65kwqZ8dgGw85Va+W9owLhQDo+Oq
         NFlbM/Nydzvmw6iAdmIWKVmhXbvQQSwkEr0WyApvUCASCRjS7DR/PbcJXBIn2HMk+6
         /3eu8lmhv6fzw==
Received: by mail-ed1-f44.google.com with SMTP id z29so8111312edl.7;
        Thu, 16 Dec 2021 07:21:16 -0800 (PST)
X-Gm-Message-State: AOAM53390QHia4IZtCL7h8f1s5DNi+FwcVy9X3PyczFYOdQdwODcVRRZ
        zYueleD0Gbcp54P/OldD/1hKomAyOCJ41SbHGw==
X-Google-Smtp-Source: ABdhPJy2dq3V5p7RpyMzWd50K1Gf1zdipmZxv6Rq2BYsOPSruamBi8El0fX0tWu/FVmcw9e6J+ebt8mZq17bf68+ZAw=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr20627713edx.306.1639668072477;
 Thu, 16 Dec 2021 07:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20211213195833.772892-1-dbrazdil@google.com> <20211213195833.772892-2-dbrazdil@google.com>
 <YbpPYG4rzPmJmwA6@robh.at.kernel.org> <YbpZTSpmnieCNZ9a@google.com>
In-Reply-To: <YbpZTSpmnieCNZ9a@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Dec 2021 09:21:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJRpNr7McM9OJcPs095ZfAqGJfN7FhGhy7i6pN+tx1MGg@mail.gmail.com>
Message-ID: <CAL_JsqJRpNr7McM9OJcPs095ZfAqGJfN7FhGhy7i6pN+tx1MGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: Add Open Profile for DICE
To:     David Brazdil <dbrazdil@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 3:08 PM David Brazdil <dbrazdil@google.com> wrote:
>
> Hi Rob,
>
> > > +        dice_reserved: dice@12340000 {
> > > +            reg = <0x00 0x12340000 0x2000>;
> > > +            no-map;
> > > +        };
> > > +    };
> > > +
> > > +    dice {
> > > +        compatible = "google,open-dice";
> > > +        memory-region = <&dice_reserved>;
> >
> > There's no need for this indirection. Just add the compatible to the
> > dice@12340000 node. You can bind drivers to /reserved-memory nodes.
>
> I have not found a way to make that work for kernel modules. Built-in
> drivers can bind with RESERVEDMEM_OF_DECLARE, which puts an entry in
> __reservedmem_of_table and __reserved_mem_init_node() iterates find it
> there. A good case study might be CONFIG_TEGRA210_EMC, where the driver
> itself can be a module but the rmem parsing is always built-in under
> CONFIG_TEGRA210_EMC_TABLE. I don't think that's worth the trouble with
> this driver.

I forgot you have to add the compatible to reserved_mem_matches in
drivers/of/platform.c.

Rob
