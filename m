Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECD4C504F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiBYVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiBYVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:06:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275A18F22D;
        Fri, 25 Feb 2022 13:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E629CE27E9;
        Fri, 25 Feb 2022 21:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C8FC340E7;
        Fri, 25 Feb 2022 21:05:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T72zAitS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645823116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTYLcwUbreSo2d+DQqXz8u/h/iA9YEA+75XmkkTkj68=;
        b=T72zAitSXL2dBjYh8loaFFPEbxx65VgYYgcG/gTiVj8HTJ3iELrBYR3EjoB3aaOySWQiWP
        HavtRjTD0jP3FGuANO8eXwxQ9O5bkAxrsLluPhV4ShprQrAmvc4rb39QazbohqV3iAbbo4
        z69rUB41iyQvgjhezrgAU1YxCvjwTQA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c415d855 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 21:05:16 +0000 (UTC)
Date:   Fri, 25 Feb 2022 22:03:01 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Message-ID: <YhlEBUOeiP4jOIsf@zx2c4.com>
References: <20220225155552.30636-1-graf@amazon.com>
 <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com>
 <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
 <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
 <YhkaAUQ/5ChlKlXt@zx2c4.com>
 <CAHmME9rzS5rAKoAfv7+N_R71pWduV=a=gJJoKPoLtYx7m7CFEg@mail.gmail.com>
 <a71a855f-9f3b-c99d-d4f9-c1ceb13c690d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71a855f-9f3b-c99d-d4f9-c1ceb13c690d@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Feb 25, 2022 at 08:06:39PM +0100, Alexander Graf wrote:
> On 25.02.22 19:39, Jason A. Donenfeld wrote:
> > Okay, the final piece, userspace:
> >
> > /sys/bus/acpi/devices/QEMUVGID:00/modalias gives:
> >      acpi:QEMUVGID:VM_GEN_COUNTER:
> >
> > modinfo -F alias vmgenid.ko gives:
> >      acpi*:VM_GEN_COUNTER:*
> >
> > udev src uses fnmatch.
> >
> > Bash confirms a match:
> >
> > $ [[ "acpi:QEMUVGID:VM_GEN_COUNTER:" == acpi*:VM_GEN_COUNTER:* ]] &&
> > echo matches
> > matches
> >
> > So I think with ACPI_ID_LEN --> 16 we are good to go.
> 
> 
> Is the size increase (mostly rodata I suppose? Anywhere else?) measurable?

On my test kernel, the size of vmlinux increases from 26918200 bytes to
26918200 bytes.

Wait, did I do that test right? I'll try again.

Yep, 26918200 -> 26918200, so it doesn't grow at all. I believe the
reason is mostly because of:

    #define ACPI_ID_LEN     16
    
    struct acpi_device_id {
      __u8 id[ACPI_ID_LEN];
      kernel_ulong_t driver_data;
      __u32 cls;
      __u32 cls_msk;
    };

Because of the padding, 9->16 doesn't actually change the way this
structure is allocated. Then, additional uses of ACPI_ID_LEN throughout
the tree are rather sparse or enclosed within other structures or
similar things.

In other words, code size seems like very much a non-issue. Also, it's
not as though MIPS has ACPI. We're talking about x86, Itanium, and
(sometimes, I guess) arm64.

Regards,
Jason
