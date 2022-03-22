Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D44E4745
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiCVUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCVUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98CB69CC4;
        Tue, 22 Mar 2022 13:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67781616C6;
        Tue, 22 Mar 2022 20:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6850EC340EC;
        Tue, 22 Mar 2022 20:11:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S+qu6etc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647979907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGxhNs6syTgAQkmDH5Xf0lVNC+PZFSBXYRSBv5AiVEA=;
        b=S+qu6etcxIO5ns2EJ3VPuXm6xJtT5RMXtMQPVHhSkszz0TsStLx7dE/lvkZa9F5cpCHfzq
        6QyTK7wjcTOjJf960cTwfIGU1NdcGKBEKG1ObIPIZNblGFs6w3KCoCjjXrcTzxSg9zrDnU
        CFkhjjCx04lsy+aJKRijTXXhGO+bOmk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7df72291 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 20:11:47 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e592e700acso204137497b3.5;
        Tue, 22 Mar 2022 13:11:47 -0700 (PDT)
X-Gm-Message-State: AOAM530yJ4VdXIfNdc5wxxbXUcIA3e8YkHXFU9ZtzPrUCxWi1QIk7bUU
        KXhsbeivwT93O4FFrtbwJ4dkQHhreBPKYpV6/hw=
X-Google-Smtp-Source: ABdhPJyV6N9zcsJlxnOI3YYRy1eTAlslombqvZiB+iMgzQOgy48+yY/h7duvef+r0nQ4lW6SO846hEmi0VowfwhzvIo=
X-Received: by 2002:a0d:d508:0:b0:2e5:d9ec:d668 with SMTP id
 x8-20020a0dd508000000b002e5d9ecd668mr24763243ywd.499.1647979905391; Tue, 22
 Mar 2022 13:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4707:b0:171:cd8f:b3d2 with HTTP; Tue, 22 Mar 2022
 13:11:44 -0700 (PDT)
In-Reply-To: <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
 <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com> <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 14:11:44 -0600
X-Gmail-Original-Message-ID: <CAHmME9pYObVqAPoGxTmvKhj31NFLO=_G7WECYDC0vb9nDTBhuw@mail.gmail.com>
Message-ID: <CAHmME9pYObVqAPoGxTmvKhj31NFLO=_G7WECYDC0vb9nDTBhuw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 3/22/22, Michael Kelley (LINUX) <mikelley@microsoft.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org> Sent: Monday, February 28, 2022 2:47
> PM
>>
>> On Mon, 28 Feb 2022 at 23:38, Michael Kelley (LINUX)
>> <mikelley@microsoft.com> wrote:
>> >
>> > From: Ard Biesheuvel <ardb@kernel.org> Sent: Monday, February 28, 2022
>> > 2:22 PM
>> > >
>> > > On Mon, 28 Feb 2022 at 23:14, Michael Kelley (LINUX)
>> > > <mikelley@microsoft.com> wrote:
>> > > >
>> > > > From: Jason A. Donenfeld <Jason@zx2c4.com> Sent: Monday, February
>> > > > 28, 2022
>> > > 1:55 PM
>> > > > >
>> > > > > Hi Andy,
>> > > > >
>> > > > > On Mon, Feb 28, 2022 at 10:28 PM Andy Shevchenko
>> > > > > <andy.shevchenko@gmail.com> wrote:
>> > > > > > My point is that this is clear abuse of the spec and:
>> > > > > > 1) we have to enable the broken, because it is already in the
>> > > > > > wild with
>> > > > > >    the comment that this is an issue
>> > > > > >
>> > > > > > AND
>> > > > > >
>> > > > > > 2) issue an ECR / work with MS to make sure they understand the
>> > > > > > problem.
>> > > > > >
>> > > > > > This can be done in parallel. What I meant as a prerequisite is
>> > > > > > to start doing
>> > > > > > 2) while we have 1) on table.
>> > > > >
>> > > > > Oh, okay, that makes sense. If you want to get (2) going, by all
>> > > > > means
>> > > > > go for it. I have no idea how to do this myself; Ard said
>> > > > > something
>> > > > > about joining the UEFI forum as an individual something or another
>> > > > > but
>> > > > > I don't think I'm the man for the job there. Is this something
>> > > > > that
>> > > > > Intel can do with their existing membership (is that the right
>> > > > > term?)
>> > > > > at the UEFI forum? Or maybe a Microsoft engineer on the list?
>> > > >
>> > > > My team at Microsoft, which works on Linux, filed a bug on this
>> > > > issue against the Hyper-V team about a year ago, probably when the
>> > > > issue
>> > > > was raised during the previous attempt to implement the
>> > > > functionality
>> > > > in Linux.  I've talked with the Hyper-V dev manager, and they
>> > > > acknowledge
>> > > > that the ACPI entry Hyper-V provides to guest VMs violates the spec.
>> > > >  But
>> > > > changing to an identifier that meets the spec is problematic
>> > > > because
>> > > > of backwards compatibility with Windows guests on Hyper-V that
>> > > > consume the current identifier.  There's no practical way to have
>> > > > Hyper-V
>> > > > provide a conformant identifier AND fix all the Windows guests out
>> > > > in
>> > > > the wild to consume the new identifier.   As a result, at this point
>> > > > Hyper-V
>> > > > is not planning to change anything.
>> > > >
>> > > > It's a lousy state-of-affairs, but as mentioned previously in this
>> > > > thread,
>> > > > it seems to be one that we will have to live with.
>> > > >
>> > >
>> > > Thanks for chiming in.
>> > >
>> > > Why not do something like
>> > >
>> > > Name (_CID, Package (2) { "VM_GEN_COUNTER", "VMGENCTR" } )
>> > >
>> > > ?
>> > >
>> > > That way, older clients can match on the existing _CID and new
>> > > clients
>> > > can match on the spec compliant one.
>> >
>> > I'll run this by the Hyper-V guys.  I don't have the ACPI expertise to
>> > disagree
>> > with them when they say they can't change it. :-(
>> >
>>
>> Yes, please, even if it makes no difference for this particular patch.
>
> The Hyper-V guys pass along their thanks for your suggestion.  They have
> created an internal build with the change and verified that it preserves
> compatibility with Windows guests.  I've tested with Linux guests and
> Jason's new driver (modified to look for "VMGENCTR"), and it all looks
> good.
> It will take a little while to wend its way through the Windows/Hyper-V
> release system, but they are planning to take the change.
>
> Michael
>

Do you want to send a patch against the crng/random.git tree adding that new id?

Jason
