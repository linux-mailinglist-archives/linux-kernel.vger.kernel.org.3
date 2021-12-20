Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488D47B4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhLTVLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhLTVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:11:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E457C06173E;
        Mon, 20 Dec 2021 13:11:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DE041EC0567;
        Mon, 20 Dec 2021 22:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640034690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BLQ6baFLS3cDoDnsNTJdWjnGrBJb9oTVTXbjosAlDnw=;
        b=plAxDQNSX5sRdFG9u5FikZLiIimJu9YLkBRqAl+qni7dNLO+ATMTvdeuVyJA/YynYgx1EF
        mcLFWpNeH0Gz4xkVk3ePqF1BQUOHqY44GInO06C606//yNUk9lHFWgTqHCaoY0Hi0YVa6S
        NQXCo0JX48FMK48mK1kVSQfhIPx8csY=
Date:   Mon, 20 Dec 2021 22:11:33 +0100
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
Message-ID: <YcDxhWZ7lzB2BB8N@zn.tnic>
References: <20211220174640.7542-1-kristen@linux.intel.com>
 <20211220174640.7542-2-kristen@linux.intel.com>
 <YcDZ4++GQN+ODm50@zn.tnic>
 <9e08e13208950e9fd955a46994b7fef705751dd6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e08e13208950e9fd955a46994b7fef705751dd6.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bah, that thread is not on lkml. Please always Cc lkml in the future.

On Mon, Dec 20, 2021 at 12:39:19PM -0800, Kristen Carlson Accardi wrote:
> If a malicious or just extra large enclave is loaded, or even just a
> lot of enclaves, it can eat up all the normal RAM on the system. Normal
> methods of finding out where all the memory on the system is being
> used, wouldn't be able to find this usage since it is shared memory. In
> addition, the OOM killer wouldn't be able to kill any enclaves.

So you need some sort of limiting against malicious enclaves anyways,
regardless of this knob. IOW, you can set a percentage limit of
per-enclave memory which cannot exceed a certain amount which won't
prevent the system from its normal operation. For example.

> I completely agree - so I'm trying to make sure I understand this
> comment, as the value is currently set to default that would
> automatically apply that is based on EPC memory present and not a fixed
> value. So I'd like to understand what you'd like to see done
> differently. are you saying you'd like to eliminated the ability to
> override the automatic default? Or just that you'd rather calculate the
> percentage based on total normal system RAM rather than EPC memory?

So you say that there are cases where swapping to normal RAM can eat
up all RAM.

So the first heuristic should be: do not allow for *all* enclaves
together to use up more than X percent of normal RAM during EPC reclaim.

X percent being, say, 90% of all RAM. For example. I guess 10% should
be enough for normal operation but someone who's more knowledgeable in
system limits could chime in here.

Then, define a per-enclave limit which says, an enclave can use Y % of
memory for swapping when trying to reclaim EPC memory. And that can be
something like:

	90 % RAM
	--------
	total amount of enclaves currently on the system

And you can obviously create scenarios where creating too many enclaves
can bring the system into a situation where it doesn't do any forward
progress.

But you probably can cause the same with overcommitting with VMs so
perhaps it would be a good idea to look how overcommitting VMs and
limits there are handled.

Bottom line is: the logic should be for the most common cases to
function properly, out-of-the-box, without knobs. And then to keep the
system operational by preventing enclaves from bringing it down to a
halt just by doing EPC reclaim.

Does that make more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
