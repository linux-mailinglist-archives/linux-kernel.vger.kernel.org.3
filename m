Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C94AACA6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381439AbiBEVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:13:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59758
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbiBEVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:13:12 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E54C23FE4B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644095590;
        bh=nz2Z4bFotqetThuLUskNVZCWGhwv1YrdlfnjDQe5gQs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=K0puRBppIpE4rnEKVNnKGfOPwH0dhCZq5XLEdIgCOBGZByOikF33flBu2vbchkgEJ
         74GKJBsu7xZoKu7/wzGJ7dxbzIsjbturV6JFTk8SlCLw3jZbSNmHwGEJp/SiMxTxH1
         E/tl2PinE41s5nJH+FFUhmoL8/K0fTenK8d8irWz7Kc9pa26KlN3EciJwQlxWzm818
         yoUFnz/zOyBUFv33vWOtK/vTMKaClWwyHRUFL+blv47CDPU1YgEsUOoloQcJ0xQVQ2
         TbmmnU7W5BAPyiSysO4LM3DW38fqbe8E62+hzmuejUMp3IJyMBsLLQ/IiOpvVU644O
         K9pfcTyAi2YxA==
Received: by mail-wm1-f69.google.com with SMTP id s187-20020a1ca9c4000000b0037bb8547d64so584896wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 13:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nz2Z4bFotqetThuLUskNVZCWGhwv1YrdlfnjDQe5gQs=;
        b=prwdYqjsSYv43bADxLLLBbOVtHvI2i9FAR2y251V5Q/jxkYWq88EELOP8QPAhqzngd
         uEBwqute1FKXHbj3D9KrP5UknBUARVVyquy4T1JE8F0y/o6UKSp7YI0xnaCkQksfldBS
         SCvqQJyZHulwJ4x3zDv1to8Sl8/op1q4iIo6zUZ1mPW/o8A+OjlRF8VYjVNXVDVuJ2/V
         zBQOmm8/Ii1gt02K/tLE+8zM4n8oBAKUsDhIvmVOqCHdzgVhvKVo+qgtZIpFmjpWTGvA
         2Ot03i++zsLp7bNB8UvnGMhtFhV6TjXVcMr00kQq8vfajlydYvAyAFqVDOAHLTg+8em8
         h6Yg==
X-Gm-Message-State: AOAM533Ba4+yMNHKwBmD81UF6DwZ+H6MWPg9kMoYD31+ncY9LnHnZ7xt
        TG+6nw6HFxsjuFf2Xdp1OCQoYhC6JdCOLFZ3DA1DW9ScqevAHxxXJhZB5dEq991bIIQQ6IQopV5
        FnxeS/eduYXlC90zRMiw9l6vh8kXOr3P76C9TloE6GXKghCq1897C3ydIEw==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr4286322wrc.234.1644095590469;
        Sat, 05 Feb 2022 13:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0O5lMWQqmnSzmHWQqbnIIH10oDMuf24v+GRzu1vHjjMNiBTdjAaypokB3rE4ZxL9Iq0Fr05Wxc5BZQWT7mig=
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr4286310wrc.234.1644095590242;
 Sat, 05 Feb 2022 13:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20211129173637.303201-1-robh@kernel.org> <Yf2wTLjmcRj+AbDv@xps13.dannf>
 <CAL_Jsq+4b4Yy8rJGJv9j9j_TCm6mTAkW5fzcDuuW-jOoiZ2GLg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+4b4Yy8rJGJv9j9j_TCm6mTAkW5fzcDuuW-jOoiZ2GLg@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Sat, 5 Feb 2022 14:12:57 -0700
Message-ID: <CALdTtnuK+D7gNbEDgHbrc29pFFCR3XYAHqrK3=X_hQxUx-Seow@mail.gmail.com>
Subject: Re: [PATCH] PCI: xgene: Fix IB window setup
To:     Rob Herring <robh@kernel.org>
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        stable <stable@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 5, 2022 at 9:05 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 4, 2022 at 5:01 PM dann frazier <dann.frazier@canonical.com> =
wrote:
> >
> > On Mon, Nov 29, 2021 at 11:36:37AM -0600, Rob Herring wrote:
> > > Commit 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup")
> > > broke PCI support on XGene. The cause is the IB resources are now sor=
ted
> > > in address order instead of being in DT dma-ranges order. The result =
is
> > > which inbound registers are used for each region are swapped. I don't
> > > know the details about this h/w, but it appears that IB region 0
> > > registers can't handle a size greater than 4GB. In any case, limiting
> > > the size for region 0 is enough to get back to the original assignmen=
t
> > > of dma-ranges to regions.
> >
> > hey Rob!
> >
> > I've been seeing a panic on HP Moonshoot m400 cartridges (X-Gene1) -
> > only during network installs - that I also bisected down to commit
> > 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup"). I was
> > hoping that this patch that fixed the issue on St=C3=A9phane's X-Gene2
> > system would also fix my issue, but no luck. In fact, it seems to just
> > makes it fail differently. Reverting both patches is required to get a
> > v5.17-rc kernel to boot.
> >
> > I've collected the following logs - let me know if anything else would
> > be useful.
> >
> > 1) v5.17-rc2+ (unmodified):
> >    http://dannf.org/bugs/m400-no-reverts.log
> >    Note that the mlx4 driver fails initialization.
> >
> > 2) v5.17-rc2+, w/o the commit that fixed St=C3=A9phane's system:
> >    http://dannf.org/bugs/m400-xgene2-fix-reverted.log
> >    Note the mlx4 MSI-X timeout, and later panic.
> >
> > 3) v5.17-rc2+, w/ both commits reverted (works)
> >    http://dannf.org/bugs/m400-both-reverted.log
>
> The ranges and dma-ranges addresses don't appear to match up with any
> upstream dts files. Can you send me the DT?

Sure: http://dannf.org/bugs/fdt

 -dann

> Otherwise, we're going to need some debugging added to
> xgene_pcie_setup_ib_reg() to see if the register setup changed. I can
> come up with something next week.
>
> Rob
