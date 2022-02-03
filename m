Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90D4A872A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiBCPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiBCPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:00:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39459C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:00:47 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6ECD51EC052A;
        Thu,  3 Feb 2022 16:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643900440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m8C3LmFdF+yIq/Ez2lpJJRNqMHAsVF0UghKIYYxcc5Q=;
        b=AHgf2LGoBFYQ9mOvGnq14yM8c9Arx3ifM1r8rDRSshJnCnw/U7qmOil7Zm4SOt9WTEgVid
        v6oKR8vTe2qCtjv5utW83NayIRix2gF8X8Pleg20IXIeMMoPp1i7QLalE+ji3CFX/NeQ0q
        zZvtQ5TiN8rLVDcQOY3fyNMfmFuE//A=
Date:   Thu, 3 Feb 2022 16:00:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 19/29] x86/topology: Disable CPU online/offline control
 for TDX guests
Message-ID: <YfvuFADTO/f1UTG1@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-20-kirill.shutemov@linux.intel.com>
 <87o83qw2m5.ffs@tglx>
 <87leyuw2ib.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87leyuw2ib.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:11:56AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 02 2022 at 01:09, Thomas Gleixner wrote:
> 
> > On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> >>  static bool intel_cc_platform_has(enum cc_attr attr)
> >>  {
> >> -	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
> >> +	switch (attr) {
> >> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> >> +	case CC_ATTR_HOTPLUG_DISABLED:
> 
> Not that I care much, but I faintly remember that I suggested that in
> one of the gazillion of threads.

Right, and yeah, adding a separate attribute is ok too but we already
have a hotplug disable method. Why can't this call

	cpu_hotplug_disable()

on the TDX init path somewhere and have this be even simpler?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
