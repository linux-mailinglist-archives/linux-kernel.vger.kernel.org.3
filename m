Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A474F6E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiDFWzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiDFWzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:55:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE02013D7;
        Wed,  6 Apr 2022 15:53:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649285588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79Kby/uV7p639MkQznCJ+d3X3HTdBEuKNEy4LIaFWuY=;
        b=KCGKNxMXL5YGBFRY3GAzQuJZWvxYZdjkPrqoOfmfz9l4aKFEyAB7eAEOOKll5ARB+fvakS
        j+6ehxJsOgvSHYvQWZwJn7YBf35YFEAcq8lcxLFccbosqKseknmAJ0bddn4orhEX1PQ6+0
        4cbDsBZdR+42+ApH9xVz5pW8tLpefbHl+yKx8OndEtUB4q25vyVl0LZE6IQp1ihoVEfxfj
        fT+cTY2+l/PRtVOollo59eHw4ICqHhuUmaqpyTXW8W8/vvft0p3M6sVaHtgx7szYlPy1ya
        RMxCxt5BlHewV8nfwyqkP+HVHVQ9CFexYCqXul3XSdVnIYApuUPK9dKAG/Bxmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649285588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79Kby/uV7p639MkQznCJ+d3X3HTdBEuKNEy4LIaFWuY=;
        b=FIajGwgRzIIi22lbQb0I4E8RqVrxibywlahZi/8ICtUxZ0zwDf+K+TeNqxDiFYtzU3per1
        0orTo1XRSIEqWOCA==
To:     Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 0/3] x86/platform/uv: UV Kernel support for UV5
In-Reply-To: <20220406195149.228164-1-steve.wahl@hpe.com>
References: <20220406195149.228164-1-steve.wahl@hpe.com>
Date:   Thu, 07 Apr 2022 00:53:08 +0200
Message-ID: <87k0c1zuwb.ffs@tglx>
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

On Wed, Apr 06 2022 at 14:51, Steve Wahl wrote:
> v2: Delete patch to remove SCRATCH 5 NMI support check for
>     UV2 and UV3k systems with old NMI support function.
>
> v3: Fix check BIOS NMI support mistake in Patch 1.
>
> v4: Clarify commit messages and comments in all 3 patches.
>     We hope this addresses the issues raised by Thomas Gleixner in
> 	https://lore.kernel.org/r/87zgl02w6v.ffs@tglx
>
>     Update NMI Handler for UV5
> 	Update NMI handler for UV5 hardware. A platform register
> 	changed, and UV5 only uses one of the two NMI methods used on
> 	previous hardware.
>
>     Update TSC sync state for UV5
>
> 	The UV5 platform synchronizes the TSCs among all chassis, and
> 	will not proceed to OS boot without achieving synchronization.
> 	Previous UV platforms provided a register indicating
> 	successful synchronization.  This is no longer available on
> 	UV5.  On this platform TSC_ADJUST should not be reset by the
> 	kernel.
>
>     Log gap hole end size
> 	Show value of gap end in the kernel log which equates to
> 	number of physical address bits used by system.
>
> Mike Travis (3):
>   x86/platform/uv: Update NMI Handler for UV5
>   x86/platform/uv: Update TSC sync state for UV5
>   x86/platform/uv: Log gap hole end size

Acked-by: Thomas Gleixner <tglx@linutronix.de>
