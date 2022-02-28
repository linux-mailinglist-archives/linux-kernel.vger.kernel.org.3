Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CF4C7D38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiB1WWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiB1WWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:22:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F3506EC;
        Mon, 28 Feb 2022 14:22:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD09B8169B;
        Mon, 28 Feb 2022 22:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36988C340F1;
        Mon, 28 Feb 2022 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646086926;
        bh=P3RJPyvew0u9GaWw0+kawCA+Aa0S0Cg+fhDhJTtI7WY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kKgSKNxp3dy1v+6fq7H/LaJA67HACjUO8DeHJ7O68Pdj4zyGywNWWgC5VXkw0y5bd
         w4ynr4JZ64dYDSMBlpniIitw5ZCsocK1WNcwAJoG/x1OhAep29Qh5W9AYc6+KrBV/F
         SXdsoCRHA7SPtbswz7UbM3c5fnsjDQJuTAUCMXKLuQ4Wl7wSWZ5RLMTeQcXBLgQlbe
         ES0IU7rzZddlU2GUDOgYT5Ovx0ByJuBv3wnc1l/gamx6V1aLArp+c+4goNkLfjMjcq
         +HFLaDP9XVOB0q8QVuPyiLM3DM/5UVaZt0CLvFJmOdGkggyPzVBLzapz+I/tNFNn3Z
         SfIPS6x3wrrWA==
Received: by mail-yb1-f177.google.com with SMTP id g6so23461228ybe.12;
        Mon, 28 Feb 2022 14:22:06 -0800 (PST)
X-Gm-Message-State: AOAM5309mraBstu5+Zydqjdhnm2g9VsWPCJpx5VVfckmFeQHLz91BBN4
        Y0vQpm53MRmoKDH9W5Ln2yOYiIwOnP3lp8AulSU=
X-Google-Smtp-Source: ABdhPJypMTo8MRt76kkvfuMrl1ogcW1q2vbMVNiJZF/J6htWVaDJY+qiqmeCSg2/8ymFNE57DSGqOk5DBFs2FxxX7Jw=
X-Received: by 2002:a25:24ce:0:b0:61e:1276:bfcf with SMTP id
 k197-20020a2524ce000000b0061e1276bfcfmr20824571ybk.299.1646086925296; Mon, 28
 Feb 2022 14:22:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
In-Reply-To: <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 23:21:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
Message-ID: <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     jason <jason@zx2c4.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 23:14, Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Monday, February 28, 2022 1:55 PM
> >
> > Hi Andy,
> >
> > On Mon, Feb 28, 2022 at 10:28 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > My point is that this is clear abuse of the spec and:
> > > 1) we have to enable the broken, because it is already in the wild with
> > >    the comment that this is an issue
> > >
> > > AND
> > >
> > > 2) issue an ECR / work with MS to make sure they understand the problem.
> > >
> > > This can be done in parallel. What I meant as a prerequisite is to start doing
> > > 2) while we have 1) on table.
> >
> > Oh, okay, that makes sense. If you want to get (2) going, by all means
> > go for it. I have no idea how to do this myself; Ard said something
> > about joining the UEFI forum as an individual something or another but
> > I don't think I'm the man for the job there. Is this something that
> > Intel can do with their existing membership (is that the right term?)
> > at the UEFI forum? Or maybe a Microsoft engineer on the list?
>
> My team at Microsoft, which works on Linux, filed a bug on this
> issue against the Hyper-V team about a year ago, probably when the issue
> was raised during the previous attempt to implement the functionality
> in Linux.  I've talked with the Hyper-V dev manager, and they acknowledge
> that the ACPI entry Hyper-V provides to guest VMs violates the spec.  But
> changing to an identifier that meets the spec is problematic because
> of backwards compatibility with Windows guests on Hyper-V that
> consume the current identifier.  There's no practical way to have Hyper-V
> provide a conformant identifier AND fix all the Windows guests out in
> the wild to consume the new identifier.   As a result, at this point Hyper-V
> is not planning to change anything.
>
> It's a lousy state-of-affairs, but as mentioned previously in this thread,
> it seems to be one that we will have to live with.
>

Thanks for chiming in.

Why not do something like

Name (_CID, Package (2) { "VM_GEN_COUNTER", "VMGENCTR" } )

?

That way, older clients can match on the existing _CID and new clients
can match on the spec compliant one.
