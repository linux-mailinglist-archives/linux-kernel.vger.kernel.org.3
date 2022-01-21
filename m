Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53444960B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381031AbiAUO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:26:03 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46290
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350535AbiAUOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:25:52 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71FE93FFD9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642775151;
        bh=AUxDslPF8lqTNSTtvzkdjxriihCQUQMZYiC1s+nxn1U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YCBQfkXCdosQVNsGtqj3RxWo8eUx/XiMfK6XsvMoulN5yazU/SUlgNi8u6s6ATq+P
         MnE1668D6H/67j03RDobCKOsVB4GbNEO5pzQKilA18V8o8U+F73bYaMnUevUyul32h
         LS+cZDwZH/v9zzSwNOonfP8T543uWd4JBV2sEK/mZ+LTy6K+zHlvATifJK25zfIeXy
         FCO2zh8Iw5FIWT7udx/Mlf+llgc3rvXvLUT5h6rlNC4XznOoSoHyNCPsA5LgZ8cngG
         YrQUTADJZIFGQrVPHKfK+uA7JbUKAB7Q5bQBjG4yPWWMAi7HQbICx7OQekSPbyvi/S
         1jsa/xjtSST1w==
Received: by mail-oo1-f72.google.com with SMTP id t12-20020a4ab58c000000b002dcbee240efso2515501ooo.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUxDslPF8lqTNSTtvzkdjxriihCQUQMZYiC1s+nxn1U=;
        b=SnA9Dw2EBn6fYnlUYtZO85eMTUYK7buLFRr+N+eM5ffwwbnpRIXtxn+iDDZe4WHFIY
         bluF1w85RdyKJDUN/6LpqOalLJL5on44X8AYBR5uBORDUHAnAm2Lbw9n0lDNL6SV5cv0
         Gum+3DfbtbhmIk8UAaay4HrunhDpwM7wS6wGVEhi2Go2lvm0kM40DiyHUJX6i0kLIvTs
         q8v1z7bvsu0iDhCFOFxM48lJycBNF5OHAYLNYwcYzZFQQLKByT8FOnwhCoQTPF/+TAIq
         x+AbpWoaedEOtdgZuzL42JkNHoXNo1/hF9aPG/MyHWd9vIlu5cf2tQ4N68Q1fOPflaIf
         c3Fg==
X-Gm-Message-State: AOAM53139TnwB+FI+sG8mmaIvWBQKiWTR0FnBC4GjflqAO/sljVlHcJL
        PzmzKQQ7sS/lXWnUX60X1Nigmv6evcQAN+h+3FkJ9lEw4GJ0l11T8ulvX9WzsWdG7YgtH7IvMSv
        P2Eexq0cmS6OZUpELiqOVCOvqk/6cbi04QoDt3Py/6cGOuO5MLbz4N7XRzw==
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr746163oib.41.1642775150177;
        Fri, 21 Jan 2022 06:25:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzl5cn5VM6kAoUVjAjl8gu6cXM4ni2jdIiRiuAaU8wfBVkVIF+aw34//cPznm1zFHtC62/hV6toXllHHWB1Dw=
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr746123oib.41.1642775149667;
 Fri, 21 Jan 2022 06:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20220105060643.822111-1-kai.heng.feng@canonical.com>
 <20220105201226.GA218998@bhelgaas> <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
 <YeqRGQoPKy389ct5@lahna> <CAAd53p4ej6FA0dM4ahngnGAccSLe=-bsUVkt-eGb2jZkms1UYA@mail.gmail.com>
 <Yeqqr1YXTNBkpz5C@lahna>
In-Reply-To: <Yeqqr1YXTNBkpz5C@lahna>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 22:25:38 +0800
Message-ID: <CAAd53p6p8YswUe0euxvrYTsT4ZFNiGgaB7MZesfGoWX=GmAjZA@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 8:44 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Jan 21, 2022 at 08:31:27PM +0800, Kai-Heng Feng wrote:
> > Hi Mika,
> >
> > On Fri, Jan 21, 2022 at 6:55 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi Kai-Heng,
> > >
> > > On Fri, Jan 07, 2022 at 12:09:57PM +0800, Kai-Heng Feng wrote:
> > > > Only from root ports of thunderbolt devices.
> > > >
> > > > The error occurs as soon as the root port is runtime suspended to D3cold.
> > > >
> > > > Runtime suspend the AER service can resolve the issue. I wonder if
> > > > it's the right thing to do here?
> > >
> > > I think you are right here. It seems that AER "service driver" is
> > > completely missing PM hooks. Probably because it is more used in server
> > > type of systems where power management is not priority.
> >
> > Here is my previous attempt to suspend AER:
> > https://lore.kernel.org/linux-pci/20210127173101.446940-1-kai.heng.feng@canonical.com/
>
> That's great!
>
> I think we should do the same for runtime PM paths too, though. Will you
> take care of that as well? :)

Yes that's the plan. I hope I can persuade Bjorn this time...

Kai-Heng
