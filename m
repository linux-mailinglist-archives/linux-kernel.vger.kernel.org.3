Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1056A47B5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhLTWsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhLTWsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:48:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB7C061574;
        Mon, 20 Dec 2021 14:48:23 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCF6F1EC04E4;
        Mon, 20 Dec 2021 23:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640040497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FTdRJbvgD63oUHMOrYjWy5nRUmOd9XvXNqQ7stf7PJ0=;
        b=Lvq/LueX72/2Jeg6cTGhbJ/WttPypQkeaKdGZA84/DWA5Przw464qXs7ttqDoCH5BgCpHI
        QfVKhQzQwbGvb0hKkeyZvUkf8SeDnPSPJA4MaI9mSsYQ0Qq33GWGAazn2moLOefa9Kn/oH
        6D2saOIXBhG0TWaXctCWzg68pIIXUTU=
Date:   Mon, 20 Dec 2021 23:48:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/sgx: Add accounting for tracking overcommit
Message-ID: <YcEINHL3LViw11Yv@zn.tnic>
References: <20211220174640.7542-1-kristen@linux.intel.com>
 <20211220174640.7542-2-kristen@linux.intel.com>
 <YcDZ4++GQN+ODm50@zn.tnic>
 <9e08e13208950e9fd955a46994b7fef705751dd6.camel@linux.intel.com>
 <YcDxhWZ7lzB2BB8N@zn.tnic>
 <f9faa3ee2614af088c510bc3c68080712665cd8f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9faa3ee2614af088c510bc3c68080712665cd8f.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:35:03PM -0800, Kristen Carlson Accardi wrote:
> So, in your proposal you would first change the calculated number of
> maximum available backing pages to be based on total system RAM rather
> than EPC memory, got it.

This was just an example. My point is to try to make it automatic and
not introduce another knob. And to decide on the limits and behavior
by using common sense and addressing the common use cases first.

> This would require recalculating the max number of allowed backing
> pages per enclave at run time whenever a new enclave is loaded - but
> all the existing enclaves may have already used more than the new max
> number of per-enclave allowable pages. How would you handle that
> scenario? This would add a lot of complexity for sure - and it does
> make me wonder whether any additional benefit of limiting per enclave
> would be worth it.

See above - this was just an example. And as you've shown, an example of
what *not* to do.

> Thanks for your more detailed explanation - I will take a look at the
> VM overcommit limits. Since obviously the original implementation did
> have a default value set, I had still a remaining specific question
> about your comments. Are you suggesting that there should not be a way
> to override any overcommit limit at all? So drop the parameter all
> together?

So let me ask you a counter-question:

Imagine you're a sysadmin. Or a general, common system user if there
ever is one.

When your system starts thrashing and you're running a bunch of
enclaves, how do you find out there even is a knob which might
potentially help you?

And after you find it, how would you use that knob?

Or would you rather prefer that the system did the right thing for you
instead of having to figure out what the sensible values for that knob
would be?

My point is: put yourself in the user's shoes and try to think about
what would be the optimal thing the system should do.

Once that is cleanly and properly defined, then we can deal with knobs
and policies etc.

I sincerely hope that makes more sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
