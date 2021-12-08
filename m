Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA546D0A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhLHKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:14:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49818 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhLHKOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:14:06 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B64E91EC04EC;
        Wed,  8 Dec 2021 11:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638958229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DpqXWMf3G5gZNv0d220PhTyu5Y62F7o91lIeySiWr5s=;
        b=nN0vx6QK48dPO4Egzyeff6bSZCydmc5t9l/MCVGNJ5N+8xVRvsBYVldAxIkB0eD7srP+oz
        RFruwsxuI94VGdN1hllSGkZulEzcbVB1l3cmgFVGzRGu7glNh814PPYy2qOq5Y0UG122j/
        OXedxb7Ky1ZIGwReu29lOjzxEMzT96w=
Date:   Wed, 8 Dec 2021 11:10:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YbCEl9kqhTz2iOY2@zn.tnic>
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org>
 <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f25d95e6-e129-597b-5d93-d7264feae8b8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:36:50AM -0800, Dave Hansen wrote:
> On 11/16/21 8:21 AM, Jarkko Sakkinen wrote:
> > The amount of SGX memory on the system is determined by the BIOS and it
> > varies wildly between systems.  It can be from dozens of MB's on desktops
> > or VM's, up to many GB's on servers.  Just like for regular memory, it is
> > sometimes useful to know the amount of usable SGX memory in the system.
> > 
> > Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an arch
> > specific attribute group, and add an attribute for the amount of SGX
> > memory in bytes to each NUMA node:
> > 
> > /sys/devices/system/node/nodeX/x86/sgx_total_bytes
> 
> There's some context missing here:

I'll say. "it is sometimes useful" is not the proper argumentation for
adding new stuff.

> This serves the same function for SGX memory as /proc/meminfo or
> /sys/devices/system/node/nodeX/meminfo does for normal RAM.  It
> enumerates how much physical SGX memory is present so that you can size
> enclaves on different systems.
> 
> This specific file (sgx_total_bytes) is needed today to help drive the
> SGX selftests.  The SGX selftests need to create overcommitted enclaves
> which are larger than the physical SGX memory on the system.  They
> currently use a CPUID-based approach which can diverge from the actual
> amount of SGX memory available.  This file ensures that the selftests
> can work efficiently and do not attempt stupid things like creating a
> 100,000 MB enclave on a system with 128 MB  of SGX memory.

Thanks, that's exactly what I was missing. Please stick that explanation
somewhere prominent.

> The nodeX/x86 directory is used because SGX is highly x86-specific.
> It's very unlikely that any other architecture (or even non-Intel x86
> vendor) will ever implement SGX.  It needs its own directory (as opposed
> to being in the nodeX/ "root") because this is expected to be the first
> of a few different things that need to get exported.  This avoids
> cluttering the root with several "sgx_*" files.
> 
> How many of these files will there be?  Just scanning /proc/meminfo,
> these are the no-brainers that we have for RAM, but we need for SGX:
> 
> MemTotal:       xxxx kB // sgx_total_bytes (this patch)
> MemFree:        yyyy kB // sgx_free_bytes
> SwapTotal:      zzzz kB // sgx_swapped_bytes
> 
> So, at *least* three.  I think we will eventually end up needing
> something more along the lines of a dozen.

Oh well, I guess.

I was going to propose to make that

	...nodeX/sgx/

but having it be arch-specific would mean that theoretically we could
add some non-sgx files there too, in the future, and if/when needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
