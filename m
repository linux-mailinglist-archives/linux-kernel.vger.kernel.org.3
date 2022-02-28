Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15E4C77E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiB1SeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiB1Sdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:33:41 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FB7C7AE;
        Mon, 28 Feb 2022 10:19:13 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id b35so22228626ybi.13;
        Mon, 28 Feb 2022 10:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+StE5EDrX4KonZXXrEcAwaI/5yqzkjCqX+Vj4i9MMQ=;
        b=WEIuor3xIzRiN8woA7Rcg50X0GuVsL5DpyLnJdCvy8E3ZpdmjLqEk2sIeB0rThYByW
         8UzokdCy1u7RksAqWY8b0/SpNCXRjoQdeR7fDjG32F4jdm4ndBJol/8muEMBsrxmsmdo
         T+pXbA+CGOOY9WwsG3e9YJAXotRRTHyq/uaW6fbMUyevFvyuA+9qmNd/UM19fwWtemFG
         /ModbKAHBvNdebwPK0qq16UhZi5IvcjRqi9ZZkcUJDyyvzAnByXpQjajattQxgPHXOIc
         eE+qNkj9dIdDwxZEtcSXk6WdYBpGtYxw5C9jwOxTP8PNHzKQU4lg4ChqOmC0HJauEf0O
         vGkg==
X-Gm-Message-State: AOAM532h7WxVBFUm0YlTb0+wzmRMNnedJdJQA4X7pYzQ0Z1mwDPWRR1N
        HRsHevlgdbLhjJRpsYNRLW4+rokj7Asv3gsclbI=
X-Google-Smtp-Source: ABdhPJzWsCzDi+CFokdvxLYx8iy1cRJSPWBfOjOBbMf8ycRw2gUE3AI/ZxXAtE+1gGwxMpftuEdKMtEjV390ThV5muM=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr18395899ybe.365.1646072352451; Mon, 28
 Feb 2022 10:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com> <YhtyBHUyFysmZ9bC@zx2c4.com>
 <CAHmME9pocD1CoZbnF7p4k0ws7-R0Vc9H4i5TRJ_MCX-d3AZhFw@mail.gmail.com>
In-Reply-To: <CAHmME9pocD1CoZbnF7p4k0ws7-R0Vc9H4i5TRJ_MCX-d3AZhFw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Feb 2022 19:19:01 +0100
Message-ID: <CAJZ5v0h_Z9XS9ZgSF4CWrZ4RU7=Oa02MY3_g0Y_rcgRNzsizfQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexander Graf <graf@amazon.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mika, Andy and Hans in case they have something to add

On Mon, Feb 28, 2022 at 12:27 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey again,
>
> On Sun, Feb 27, 2022 at 1:43 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Alex,
> >
> > On Sun, Feb 27, 2022 at 12:42:03PM +0100, Alexander Graf wrote:
> > > > To allow device drivers to match identifiers that exceed the 9 byte
> > > > limit, this simply ups the length to 16, just like it was before the
> > > > aforementioned commit. Empirical testing indicates that this
> > >
> > >
> > > This is only true for 64bit systems where padding automatically bloated
> > > to 9 byte array to 16. I still believe the patch is fine as it is, but
> > > there will be minor .rodata overhead on 32bit targets which you may want
> > > to quantify in the patch description.
> >
> > Good point. So I just tried this out with a 32-bit i686 kernel and the
> > results are the same again for the size of vmlinux. I then ran `objdump
> > --headers` and looked at the size of the .rodata section, where it's
> > also the same. I'm not quite sure what to make of this, as it's not what
> > I was expecting, but I think I tested it right. So maybe we're lucky
> > here?
>
> I tried a little harder to get _some_ difference on 32-bit, and
> managed to get one by doing i386_defconfig and then switching off
> modules to make all M into Y, and then compared sizes:
>
> vmlinux: 25590780 -> 25598972, so a 0.032% increase.
> bzImage: 8698944 -> 8699424, so a 0.0055% increase.
>
> So it does increase, ever so slightly, but a) on 32-bit, and b) a
> super, super tiny amount.
>
> In other words, I still think this patch is very much a-okay. But very
> eager to hear from Rafael on the approach.

Increasing the ACPI_ID_LEN value is fine with me, but the patch
changelog is not entirely accurate.

The ACPI subsystem uses struct acpi_device_id mostly (if not only) for
device ID matching and it is generally used for creating lists of ACPI
device IDs in drivers (and allow/deny lists etc).  The device IDs
extracted from the ACPI tables can be longer than ACPI_ID_LEN.

This means that drivers cannot match device IDs longer than 8
characters (excluding the terminating 0), because the IDs in the lists
used by them for ID matching cannot be longer than this and not
because the ACPI subsystem is limited by that value.
