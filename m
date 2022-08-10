Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0458F45D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiHJW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:26:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65A8D3E5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:26:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z16so19275967wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=J1S4AO51CUHE+MiRUkGQ/82rQ/8c9Jpi9FTf1saPf2w=;
        b=QeShLouUtmJpWBEkceLNBWarGOX1MYjbKzCn1nv4kKocJLEFoP031jL8s0SsSDrENB
         Wda5fKDvu+0K5YNCaq9SuXTz69ykH/ukcSSjdJuM+sS8nvvKrNPrvoDt4SKJhqBeu7zc
         YW7340fBZAbgY7HZArLppFuPztV1DCTsGz3hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=J1S4AO51CUHE+MiRUkGQ/82rQ/8c9Jpi9FTf1saPf2w=;
        b=pCrz3VfAfgm12Anr1FkE6bQTGiqkBomA97wTOXfSOoxscpiEvUoCZlTrUye7uT3kr5
         P7qQNFeE5bk5oI5nJedu304TMF9nBG2fLFdNE09mybc103eXuGtWil7iH4g6554Rxe6j
         DFC8CinfJV9J7WlQ40L5VRNNnKKRJo1zJcYvmiTIuXI68GdCSrmklgwbpvQrKvwkMKeY
         DndJ6FIryKGfCmlcUNgAcYxBqyUu5B2k4Do6NMwU+Awjz0aFbFzyWggYq8d0noLjrA42
         lQuKi6LkPH4no3SnIqEwSil/FR1sf8pJcwquY6tdrza77+KPZf5TyOrVh6KYhxxm3ssM
         7JqQ==
X-Gm-Message-State: ACgBeo0cPC4gQwBmrgRuLtILb/LdynCrocEsL5zzBKRtMqmVueiearny
        cyV1Z9SMSWEwJyQTdoKmfr9isABeDdrOKpePwhYLFQ==
X-Google-Smtp-Source: AA6agR6zBcqjxGXqvDdiQWCumTiYzSbfSHy3S98eu0PRhYY8Qf6Q2Idre8LoyOGa2CL15n071Y0e+w/dghz8KtXIYxE=
X-Received: by 2002:a5d:47a4:0:b0:220:600d:2b0f with SMTP id
 4-20020a5d47a4000000b00220600d2b0fmr18598230wrb.407.1660170401636; Wed, 10
 Aug 2022 15:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <YuuBrUmiRYoaSmPw@google.com> <20220804142856.306032-1-jrosenth@chromium.org>
 <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
 <CAODwPW_mYQ1gcd2Xw5s+7dL2kLcYn-VTxKHUH1iM1V4mn7pT_w@mail.gmail.com> <CAE-0n504q_NeB9e2BYF8P9Scp7TPqsp9KEWu2DO=ZzbYdJfyew@mail.gmail.com>
In-Reply-To: <CAE-0n504q_NeB9e2BYF8P9Scp7TPqsp9KEWu2DO=ZzbYdJfyew@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 10 Aug 2022 15:26:30 -0700
Message-ID: <CAODwPW-LaaD+ptch=R-S4GWoBDjTgWzfvwjyQeBRETZnnosR7g@mail.gmail.com>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Alright cool. The bug says 'vbnv' so I was guessing 'nv' meant
> non-volatile.

"vbnv" is non-volatile memory, but this driver doesn't actually access
vbnv (which is on SPI flash). This driver is meant to access an
in-memory cache of vbnv that was put there by firmware.

> > We really only care about one of these right now and many of them will
> > never be relevant to the kernel, but I still thought that while we're
> > doing this we might as well provide a generic interface to all of them
> > because others may become useful in the future (and then you don't
> > have to update the kernel every time you get a new use case for some
> > userspace tool wanting to interact with some resident data structure
> > from coreboot).
>
> Exposing more than is necessary in the kernel ABI could get into
> problems with backwards compatibility. It also means we have to review
> the ABI with the consideration that something may change in the future
> and cbmem would be exposing something we don't want exposed, or maybe it
> is writeable when it shouldn't be?

I think we have a bit of a different concept of what this is supposed
to be. Forget about the vbnv and vboot workbuffer parts for the
moment, those are where our overall motivation for doing this comes
from but those should not be concerns for the kernel itself. From the
kernel's point of view, all we have here is a firmware information
structure it already knows about (the coreboot tables) pointing to a
list of opaque, firmware-specific memory buffers labeled with an ID,
and we want it to expose read and write access to those buffers to
userspace to make it easier for firmware-specific userspace helper
tools to work with them. Note that we already have userspace tools
doing that today anyway, e.g. the `cbmem` utility uses /dev/mem to
search for and parse the whole coreboot table itself before then using
it to access individual CBMEM buffers. But implementing all the logic
to do that in each tool that wants to support anything
coreboot-specific separately is cumbersome, so we thought that since
the kernel already has this coreboot table parsing support anyway, we
might as well export the info to userspace to make this job easier. So
really all the kernel does here is expose the address, size and ID
values from the coreboot table itself, it doesn't (and isn't supposed
to) have any understanding about the pointed to buffer. (We could also
leave out the `mem` node from this driver and just let our userspace
utilities read the `address` and `size` nodes and then use that info
to go through /dev/mem. Giving them a direct `mem` node for the buffer
just makes that process a bit easier and cleaner.)

So backwards compatibility should not be a concern (unless we're
talking about changes in the coreboot table itself, which we strongly
try to avoid and which would be an issue for existing kernel drivers
already anyway). Understanding of these buffers' contents is
explicitly supposed to be the responsibility of the userspace tool
that has an easier time keeping up with frequent firmware data format
changes and maintaining long lists of back-translating routines for
older structure formats for the specific kind of buffer it looks for
if necessary (something I specifically wouldn't want to clutter the
kernel with).

In regards to write access, I don't really see a point restricting
this since all these buffers are already accessible through /dev/mem
anyway. But that should only be needed for very few of these buffers
anyway, so if people think it's a concern I think we could also keep a
small explicit allowlist for the IDs that can be writable (shouldn't
need to be updated frequently) and disallow it for everything else.
Also, of course there's still the normal file system access
permissions that makes these only writable for root and users
specifically granted access by root. (Actually, Jack, that reminds
me... having the `mem` nodes world-readable is maybe not a good idea,
there's usually not anything specifically secret in there, but since
/dev/mem also isn't world-readable I think this one probably shouldn't
either. I'd suggest changing the initial umask to 0660 or 0600.)

> Furthermore, if the ABI that the kernel can expose already exists then
> we're better off because there may already be userspace programs written
> for that ABI with lessons learned and bugs ironed out. In this case, I
> was hoping that it was an nvmem, in which case we could tie it into the
> nvmem framework and piggyback on the nvmem APIs. It also helps to expose
> a more generic ABI to userspace instead of developing a bespoke solution
> requiring boutique software. Of course sometimes things can't be so
> generic so code has to be written.

Yeah but this isn't anything that can be genericized, this is
specifically meant for boutique software to maintain its internal data
structures. vbnv and the vb2_shared_data structure in the workbuffer
are supposed to be completely internal to vboot and not interpreted by
any code other than vboot itself -- even coreboot never accesses them
directly (only by linking in vboot functions and calling those). We
explicitly don't want to deal with having to sync data structure
format changes to anywhere outside the vboot repository. The problem
is just that unlike most software, vboot is a framework that contains
both firmware and userspace components, so the latter necessarily need
some help from the kernel (as an oblivious forwarder of opaque data)
to be able to access the internal data structures passed on from the
former.
