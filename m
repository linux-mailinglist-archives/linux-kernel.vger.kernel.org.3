Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EE4A9B62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356071AbiBDOsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiBDOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:48:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F4C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:48:50 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEE1E1EC064D;
        Fri,  4 Feb 2022 15:48:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643986125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zPjQk2oTUAdLC1hsrbWamxWCeuB49O+XDJ3i6CqTVNA=;
        b=BCIXAi0HLfDdLqvmDTDTLBY7iCHVhNJ2JtrFZJN8wmB2kceAtqYSt0QCfMZvJgZrRIA8Lp
        vuh1BDmh9CwhxEcujFTgMqmxdcdNHxPrxnzwsahnyEQc7nGpY+WbDa68nZMmqWW3ri6PKS
        qBXYMNIGAybppJk5/hqREIF84PqRmx0=
Date:   Fri, 4 Feb 2022 15:48:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] x86/mce: Fix more noinstr fun
Message-ID: <Yf08yMZZDCtYMBVX@zn.tnic>
References: <20220204083015.17317-1-bp@alien8.de>
 <CANpmjNOvf7z4BdPqrJH2iF0KnZmP58uUzSH0fFoc4VNg+2S=hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNOvf7z4BdPqrJH2iF0KnZmP58uUzSH0fFoc4VNg+2S=hw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 12:24:00PM +0100, Marco Elver wrote:
> I guess to solve noinstr "calling" something else the only solution is
> to make the other function noinstr as well, or __always_inline.
> 
> Have you considered making some of these other functions 'noinstr' as
> well? I guess __always_inline works, esp. if there's just 1 caller.
> And by the looks of it you're getting a net .text reduction, so

Yeah, I started doing that and the savings were the persuasive
argument.

Even more so if the function has one caller only and gets inlined,
normally. I guess it doesn't get inlined when there's KASAN
instrumentation or so but I haven't verified it fully why.

Because even for oneliners like v8086_mode() which should get inlined
trivially, the compiler ends up doing this constprop thing - I guess
some constants folding optimization thing... it probably doesn't even
matter so much whether oneliners get inlined in KASAN-enabled builds so
I guess we might just as well force-inline them for the other configs.

> Acked-by: Marco Elver <elver@google.com>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
