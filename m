Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315414A7E31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbiBCDCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349126AbiBCDCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:02:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0FC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 19:02:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so964485plh.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fi4i69yyHlW9dNLZasSOsCzYr8hNca983K/7O4yLzcY=;
        b=gldBUpRszuUXxkfZKfanjJFZnzVNJdYwINvQKMPFH0e/fo+gWPnTSWpOq7RuW2N2VU
         vGTFobykSKv2bO9aM/jttCa/gxjfr2iHhNxBe/o+zWpeth73uKzz4Um0U/Vp88+RQGJs
         g0HIMIEMLHg/XZbUOYfjrG4tbIxsM2YZDBBtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fi4i69yyHlW9dNLZasSOsCzYr8hNca983K/7O4yLzcY=;
        b=Y9dr2nRMoeN+OLYZp0kWmFFXxVmjVKsn/zBKjiE2uqLFoAcLpnCsXcMyjknUI5T2/X
         jDLe4LL8VEyTN6GdidEpIwLcD+NwmYqVoFzSK+wziaK3XyxG8hORUJQrPIesaS7eWZ7U
         MxHHyLO6mfKp76Lg8ixXLanBq/lv7/CPFRY73QRVhMmf+jB618YmMDHT5LMz/hXA1+GM
         s1uAGIgxPAZ9hzbjvFnoJkbwDxvyEjyei8/y2o5ZRfl68R86+3s14WwD0VHfJ5BS1mxZ
         rr2iLyjsQ2/chDA8F6P0ZREy3WX8TKjSUj21FtF1jcR4IxfVJMU4d9zoPIy/3Cas0t2p
         UPEw==
X-Gm-Message-State: AOAM532Eo41dNyWDW+xAYiGOQ+IiTpKBmtI6oSfQ3d/sJR5ujGNsFg4j
        9PifClhUT+0T15AP2to9TnmLnA==
X-Google-Smtp-Source: ABdhPJz1PHmuumehqVMBhGYb0YO27H24hrHGlvXarpEvxEgjLLdf68YQR3qgsnZX28P1KOAcokVCVg==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id fr10mr11469589pjb.51.1643857332940;
        Wed, 02 Feb 2022 19:02:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n22sm27145613pfu.77.2022.02.02.19.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:02:12 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:02:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202202021901.ED81570F@keescook>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net>
 <202202021409.2AA6A4246@keescook>
 <5ce016f8-fb4b-ef50-c543-886b4cfda225@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce016f8-fb4b-ef50-c543-886b4cfda225@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:21:49PM -0800, Guenter Roeck wrote:
> On 2/2/22 14:11, Kees Cook wrote:
> > On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
> > > On Wed, Aug 18, 2021 at 01:11:17AM -0700, Kees Cook wrote:
> > > > With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
> > > > coverage, it is now possible to enable -Warray-bounds. Since both
> > > > GCC and Clang include -Warray-bounds in -Wall, we just need to stop
> > > > disabling it.
> > > > 
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Cc: linux-kbuild@vger.kernel.org
> > > > Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >   Makefile | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index a4aca01a4835..af22b83cede7 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1072,7 +1072,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
> > > >   # We'll want to enable this eventually, but it's not going away for 5.7 at least
> > > >   KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
> > > > -KBUILD_CFLAGS += -Wno-array-bounds
> > > >   KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
> > > >   # Another good warning that we'll want to enable eventually
> > > 
> > > alpha:defconfig:
> > > 
> > > In function '__memset',
> > >      inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
> > > ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
> > >     37 |                         return __builtin_memset(s, c, n);
> > >        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > In function '__memset',
> > >      inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
> > > ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
> > >     37 |                         return __builtin_memset(s, c, n);
> > >        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > In function '__memset',
> > >      inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
> > > ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
> > >     37 |                         return __builtin_memset(s, c, n);
> > 
> > Ah! With Arnd and Nathan's help, I saw:
> > https://lore.kernel.org/all/20210912160149.2227137-3-linux@roeck-us.net/
> 
> Guilty as charged. Sorry, I didn't try to analyze the problem,
> or I might have noticed (and saved you some work).

No worries! It manifests as a completely different warning. It just
happens to come from the same internal diagnostics info, I think. :)

I was just delighted to see it already had a solution!

-Kees

-- 
Kees Cook
