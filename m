Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE84C7C83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiB1Vzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiB1Vzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:55:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138426550;
        Mon, 28 Feb 2022 13:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BBD61216;
        Mon, 28 Feb 2022 21:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F0C340F2;
        Mon, 28 Feb 2022 21:54:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ih5F4FRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646085292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gYo+w+F9Yr9jXeKd4yhlIselJQUhTYBVZBr6ICmc44=;
        b=Ih5F4FREcrCYLk5lw1LYw/3HpDY//WblCvSVj3bAxTYy1u8mnNT+u+M65gLh33zQ3fjbIc
        q9YZW/dRNDs269fTyRUxqE+Qs9nx1eI100D28JGZLhSwxO8lGoTNswdnsYjHBDvvhplE5q
        GQ+0usGDCbQ/ovrAkyMhAlFlgukzzVc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 41a9ebdc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 21:54:52 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id b35so23321533ybi.13;
        Mon, 28 Feb 2022 13:54:51 -0800 (PST)
X-Gm-Message-State: AOAM531gJa5iOwiBkPn12oMb/hEclDlJ0FKFPMQNuzh4ERvGhRWU6WYG
        VoNp/lbD3iJ5vEh1uaRrFEWM42xZY9HCywAWnVo=
X-Google-Smtp-Source: ABdhPJwNe9vFPbC4DSpnChci/IikmDINZcY4NEsYLNZXyhxmNiIP/uNzExOmckdLCqpmu7NklpucicQIVD7qYlRH09g=
X-Received: by 2002:a25:b905:0:b0:61e:23e4:949f with SMTP id
 x5-20020a25b905000000b0061e23e4949fmr21728876ybj.373.1646085290051; Mon, 28
 Feb 2022 13:54:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com> <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
In-Reply-To: <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 22:54:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
Message-ID: <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Hi Andy,

On Mon, Feb 28, 2022 at 10:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> My point is that this is clear abuse of the spec and:
> 1) we have to enable the broken, because it is already in the wild with
>    the comment that this is an issue
>
> AND
>
> 2) issue an ECR / work with MS to make sure they understand the problem.
>
> This can be done in parallel. What I meant as a prerequisite is to start doing
> 2) while we have 1) on table.

Oh, okay, that makes sense. If you want to get (2) going, by all means
go for it. I have no idea how to do this myself; Ard said something
about joining the UEFI forum as an individual something or another but
I don't think I'm the man for the job there. Is this something that
Intel can do with their existing membership (is that the right term?)
at the UEFI forum? Or maybe a Microsoft engineer on the list?

From my side, regarding (1), I'm basically just waiting for Rafael's
"Acked-by" (or an explicit nack) so I can put this in my tree and move
on.

Jason
