Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC474C7B35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiB1U7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiB1U7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:59:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547334B95;
        Mon, 28 Feb 2022 12:58:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED08F60F7F;
        Mon, 28 Feb 2022 20:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9ADC340F4;
        Mon, 28 Feb 2022 20:58:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oqKkKpHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646081918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqohqG3LXXo3Vz4caltCVBd/GVMaQSHhe0U1yNB9f7s=;
        b=oqKkKpHIwznsnW+OplNfnLGWmSexVKvOIAK/8Ne9Vhd6LxTk4/m0PbqifyRWUawW3Yz2Jf
        HQYQt3T8EvKRsUl8XloPmk3lnjspGERuADKjYmyUQW4+53zxjEWTUmwnMNM2Q1d2IVUxNi
        8+HpnCCDLEEZ5fD88a4+Vm2YRI4S9R4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c466720a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 20:58:37 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dbd97f9bfcso5117277b3.9;
        Mon, 28 Feb 2022 12:58:36 -0800 (PST)
X-Gm-Message-State: AOAM532aPIhPoEiTqJGrIQ3L7oaR4h8SdO7lRSopceijUeJ/FXxCd9JR
        sZauA48SFDCnM4YVp+kqcVvaR7qagmA0HT5cP2s=
X-Google-Smtp-Source: ABdhPJxAgPwGmS0Vl76KY6GXZiI1ElLpNGeheuKi7TiNeDjCSedlJ5mUrV9FsJB1jf5+X9Q0L9hBjFWLu5s35fYcq1E=
X-Received: by 2002:a81:1143:0:b0:2db:ccb4:b0a1 with SMTP id
 64-20020a811143000000b002dbccb4b0a1mr2307269ywr.499.1646081915734; Mon, 28
 Feb 2022 12:58:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
In-Reply-To: <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 21:58:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9pPU7kWXeodY+GZwLvFNTwDZXnRNMFk3EEucdFxc2ZEig@mail.gmail.com>
Message-ID: <CAHmME9pPU7kWXeodY+GZwLvFNTwDZXnRNMFk3EEucdFxc2ZEig@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Feb 28, 2022 at 9:47 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Then why do we not see the ECR from somebody to update the spec or to
> fix MS' abuse of it?
> I believe _this_ should be the prerequisite to the proposed change.

Sorry, but no; that seems like a ridiculous requirement. There's
virtual "hardware" out there that is behaving like this. It serves an
important security function. There are no technical downsides to
making the change. It works well.

Yet you're upset that they didn't follow the rules. Indeed, tsk tsk on
Microsoft. But that doesn't mean Linux users should suffer and have
poorer security than Windows.

This kind of thing happens all the time. We do our best to find the
cleanest solution to the problem, and live with it. Linux isn't a
one-hundred-per-cent-by-the-spec operating system, because the things
it works with are often not one-hundred-per-cent-by-the-spec. We even
have quirks tables. It's part of life.

And in this case, the solution is so straightforward that it doesn't
even require anything closely resembling a "hack" or a layering
violation. And that space is already being used (zero filled) anyway
because of struct padding.

This fix is the "clean" way of doing it. Why make this harder than it
needs to be?

Jason
