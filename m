Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553ED4C7DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiB1Wrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiB1Wrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:47:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A514145D;
        Mon, 28 Feb 2022 14:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1C56134F;
        Mon, 28 Feb 2022 22:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFC3C36AE2;
        Mon, 28 Feb 2022 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646088418;
        bh=G6GLEJ6Wfn09TOzKxBlcJIFaXURnq/IsC7hPMLt8SC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BUts0ap93eFWhQJrO3DOo3KiralkFIxF9lRykNPSwvtarnylb2fBnPArIqVsIDMPa
         lL+JQQnMswA9onIB3ktOGKRQ7GeMl/Vx0zmo41v3ZX2CTqsm05YlIohf+7YFKg6J8h
         eTHKNCv3yl5ekWtRNql08HXRf/eYIS4MHFTquhs6ChGsohiagZH2zu8E07mvzCXDik
         JXoI0B1ZFZ2a0z7OwsAs5hh9CVtB75WkSSVVaF2qlHxpqWCL06/09rWRxZpqpqvouA
         xI+Exde4XbzmqV5VBdaNRSmtCDENNJhfESHW1fNUaFaVJHAUzUnEoL/+4wlpuE6VbC
         nma6M8fv1KXKg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2dbd8777564so10745667b3.0;
        Mon, 28 Feb 2022 14:46:58 -0800 (PST)
X-Gm-Message-State: AOAM5329DGobQAi9kg4ZBqZFi9FiInEcJKNjePOLzM8tysqTVe0FeHOi
        2GjVyZ4Zhtx2rjsi+CJoByvM86xMLgBTlz3pKU0=
X-Google-Smtp-Source: ABdhPJyB6L05mmX+2jIVYVXXY9bxGJucHrm6KGQeG1ruBMHmAj7ly1Q+IfWWXmiXsE40Q16hJcu0TO2OpaCuya+QS1I=
X-Received: by 2002:a0d:d482:0:b0:2d8:1555:e21d with SMTP id
 w124-20020a0dd482000000b002d81555e21dmr20621347ywd.272.1646088417394; Mon, 28
 Feb 2022 14:46:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com> <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
In-Reply-To: <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 23:46:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
Message-ID: <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
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

On Mon, 28 Feb 2022 at 23:38, Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org> Sent: Monday, February 28, 2022 2:22 PM
> >
> > On Mon, 28 Feb 2022 at 23:14, Michael Kelley (LINUX)
> > <mikelley@microsoft.com> wrote:
> > >
> > > From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Monday, February 28, 2022
> > 1:55 PM
> > > >
> > > > Hi Andy,
> > > >
> > > > On Mon, Feb 28, 2022 at 10:28 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > My point is that this is clear abuse of the spec and:
> > > > > 1) we have to enable the broken, because it is already in the wild with
> > > > >    the comment that this is an issue
> > > > >
> > > > > AND
> > > > >
> > > > > 2) issue an ECR / work with MS to make sure they understand the problem.
> > > > >
> > > > > This can be done in parallel. What I meant as a prerequisite is to start doing
> > > > > 2) while we have 1) on table.
> > > >
> > > > Oh, okay, that makes sense. If you want to get (2) going, by all means
> > > > go for it. I have no idea how to do this myself; Ard said something
> > > > about joining the UEFI forum as an individual something or another but
> > > > I don't think I'm the man for the job there. Is this something that
> > > > Intel can do with their existing membership (is that the right term?)
> > > > at the UEFI forum? Or maybe a Microsoft engineer on the list?
> > >
> > > My team at Microsoft, which works on Linux, filed a bug on this
> > > issue against the Hyper-V team about a year ago, probably when the issue
> > > was raised during the previous attempt to implement the functionality
> > > in Linux.  I've talked with the Hyper-V dev manager, and they acknowledge
> > > that the ACPI entry Hyper-V provides to guest VMs violates the spec.  But
> > > changing to an identifier that meets the spec is problematic because
> > > of backwards compatibility with Windows guests on Hyper-V that
> > > consume the current identifier.  There's no practical way to have Hyper-V
> > > provide a conformant identifier AND fix all the Windows guests out in
> > > the wild to consume the new identifier.   As a result, at this point Hyper-V
> > > is not planning to change anything.
> > >
> > > It's a lousy state-of-affairs, but as mentioned previously in this thread,
> > > it seems to be one that we will have to live with.
> > >
> >
> > Thanks for chiming in.
> >
> > Why not do something like
> >
> > Name (_CID, Package (2) { "VM_GEN_COUNTER", "VMGENCTR" } )
> >
> > ?
> >
> > That way, older clients can match on the existing _CID and new clients
> > can match on the spec compliant one.
>
> I'll run this by the Hyper-V guys.  I don't have the ACPI expertise to disagree
> with them when they say they can't change it. :-(
>

Yes, please, even if it makes no difference for this particular patch.
