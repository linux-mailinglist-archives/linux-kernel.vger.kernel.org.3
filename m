Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746874FF78F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiDMN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiDMN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:26:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD685A17F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:24:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649856248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPXICJta5haLPFS6jvdk3LgrFwQUzBpKD9OoNyZ5Z/A=;
        b=shGqH5iew2vdg6NcRgItaWgWqjMdAkG4xs72W0hSjGyglQpaD4J1vbqbAIrGllmOJRIIYD
        4l9i1fqWyUSZd7nz+ZM5TDn7ND5pcbNRNzkX07GawdrbEtN2wq0Gw0JbzX0SOI0Gg/3D/K
        /oKwAt5/irlrrrQACdtZyIdT7AFXuUVKD2qj0iDnjWMbblp7wmbgXVrV3Sus/Ce9S/xEpY
        yp2YanLA7OigPtzPT7aYrL/h6ihX+SJX4eu7g4efPl2NyjmADn9ktpCziOqI5slAMDVkg+
        TDLSMflwd619msbB1BJxl+YMd6CWtFyOgi0mIi3vZXnSMnPu8emPs/zCEA6lgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649856248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPXICJta5haLPFS6jvdk3LgrFwQUzBpKD9OoNyZ5Z/A=;
        b=z3Us5IOV/nW26DsKuBlEsBgL9EzSW77cVW6yYp9NoyH4XTs1tgaSVuB5LmiTRX/CkTOtpG
        AhS8A3N/wKcXmZCA==
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Daniel Vacek <neelx@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Clarify i82489DX bit overlap in APIC_LVT0
In-Reply-To: <alpine.DEB.2.21.2204122235140.9383@angie.orcam.me.uk>
References: <20220202140244.1681140-1-neelx@redhat.com>
 <874k361liu.ffs@tglx>
 <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com>
 <87ee22f3ci.ffs@tglx>
 <alpine.DEB.2.21.2204122235140.9383@angie.orcam.me.uk>
Date:   Wed, 13 Apr 2022 15:24:07 +0200
Message-ID: <875yndf760.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej,

On Tue, Apr 12 2022 at 23:17, Maciej W. Rozycki wrote:
> On Tue, 12 Apr 2022, Thomas Gleixner wrote:
>
>> Daniel stumbled over the undocumented bit overlap of the i82498DX external
>> APIC and the TSC deadline timer configuration bit in modern APICs.
>
>  For the record, it's documented in the i82498DX datasheet[1] and user 
> manual[2]:
>
> 'Bits [19:18] Timer Base: This field selects the time base input to be 
> used by the timer.

That's true, but how many people aside of you and me still have access
to the i82498DX related documentation? The interwebs has no trace of
them.

With the above I explicitely meant the undocumented bit overlap both in
the current SDMs and the kernel source.

Thanks,

        tglx
