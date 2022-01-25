Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213FB49BA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352414AbiAYRob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiAYRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:43:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4FC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:43:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d1so20018727plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NeOAxpdxjWDKGKhW1TpnxdPLPPyAy5jeeY/WTUKNSA=;
        b=Q0mbDGc/h6Szxq44bScruvzUADOZfGbqZDL0+yNb1fO0Iu4jldp8rqQMNRTLPw1aEr
         qz19/xV2akGlEkJJ3W1R/rJccgogqwf8k+pfa6f/k+u6RTjYBiy6Ai1HvNgoCT4+x0HY
         mHOlnQ7DaV201efnCrIGf+jYQpkfcVJcp8ywI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NeOAxpdxjWDKGKhW1TpnxdPLPPyAy5jeeY/WTUKNSA=;
        b=bXmYSOM2ovV/uLG1Kx1qnBZFhRV2bfkzHyEIKtRQE9Sw9erA5/ifjf2jx11yZvp13d
         XBiRXk2lxACN/dAgwTo9vPvUzq7zQllPM5BDP1xMGPNSu32KeRtePcdGknV7xlqlFQ9p
         UJU/3b14lv4qgsnoMsR3y5Hmvs/wEKm3GaRdfkvCkjQj24RXrkrNr0k7uMFSFqmVXVsz
         o12EUPIkjWNcGotIQYkJ4eXblBS2Ck6IkkAbDEh8tmdjfYIu2JXJK9gDWGCPEkzaHMyy
         T9/LqhFNEBH3QucbIFnkTRE1CZrJzIZS5q1z9/7rDtvYTgpfetKaWOxdvRqsPMcnbgAW
         wv0g==
X-Gm-Message-State: AOAM532jQqeNMIiU+xWtEB5qPuDMsMC2BLHc+CEwuuTf7Y5krqYnkBri
        +ILhBtpJHctGw6LY+sbQCoLeXw==
X-Google-Smtp-Source: ABdhPJz2DPHOV8XawNQSvqeOIS3FYt4Lo8r9uiSHC8+5GgrNXZgmVXpP2qgfv29+dHKvJgCuqJ38+w==
X-Received: by 2002:a17:90a:e601:: with SMTP id j1mr4602058pjy.69.1643132610805;
        Tue, 25 Jan 2022 09:43:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm20637342pfl.106.2022.01.25.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:43:30 -0800 (PST)
Date:   Tue, 25 Jan 2022 09:43:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5.17-rc1 v2] eeprom: at25: Restore missing allocation
Message-ID: <202201250943.A28F4346@keescook>
References: <20220118182003.3385019-1-keescook@chromium.org>
 <CAMuHMdWu-unMfV1U_HAKwJwPkB_LY3kU88_D69M=bX8y1B=QTg@mail.gmail.com>
 <CAMuHMdXzEWN7B122ca279t4RPSSWGL29jzTgMdSoJ+Y56jEQYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXzEWN7B122ca279t4RPSSWGL29jzTgMdSoJ+Y56jEQYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:25:39PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 25, 2022 at 3:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jan 21, 2022 at 12:33 AM Kees Cook <keescook@chromium.org> wrote:
> > > The at25 driver regressed in v5.17-rc1 due to a broken conflict
> > > resolution: the allocation of the object was accidentally removed. Restore
> > > it.
> > >
> > > This was found when building under CONFIG_FORTIFY_SOURCE=y and
> > > -Warray-bounds, which complained about strncpy() being used against an
> > > empty object:
> > >
> > > In function 'strncpy',
> > >     inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
> > > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> > >    48 | #define __underlying_strncpy    __builtin_strncpy
> > >       |                                 ^
> > > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> > >    59 |         return __underlying_strncpy(p, q, size);
> > >       |                ^~~~~~~~~~~~~~~~~~~~
> > > In function 'strncpy',
> > >     inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
> > >     inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
> > > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> > >    48 | #define __underlying_strncpy    __builtin_strncpy
> > >       |                                 ^
> > > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> > >    59 |         return __underlying_strncpy(p, q, size);
> > >       |                ^~~~~~~~~~~~~~~~~~~~
> >
> > On real hardware:
> >
> >     Unable to handle kernel access to user memory outside uaccess
> > routines at virtual address 0000000000000028
> >     ...
> >     pc : __mutex_init+0x20/0x68
> >     lr : at25_probe+0x8c/0x4d8
> 
> To avoid confusion: of course the crash happens only without Kees'
> patch.  I just wanted to point out what happens when you boot on
> real hardware, as it might be worthwhile to add that to the commit
> description.

Okay, whew. :)


-- 
Kees Cook
