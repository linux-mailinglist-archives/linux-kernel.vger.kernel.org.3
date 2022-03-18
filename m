Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED94DD784
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiCRJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCRJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:57:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882D28F80A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:56:04 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A93891EC0644;
        Fri, 18 Mar 2022 10:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647597358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UVZ8FklE/Jk/prMsCHgippETt5S+rrQXSfSrRNUAV2E=;
        b=gOlbFyLuxSiZD1dFJHNVMtFQpJX6EpfRnT3WWznJMUrkEwXvlpH0G5Vkk3Aq1GUDdpoLzw
        4zfkd743OBrSxLEr5KNxeXYtQoUXFGyB3yKO9Uv/YRlyUfZQsDBni1OWgP6vBMv9wmgNms
        l2X1023fZibFOo90coSplkFcYp2K2sA=
Date:   Fri, 18 Mar 2022 10:55:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, dave.hansen@intel.com, mingo@redhat.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        brijesh.singh@amd.com, ak@linux.intel.com, david@redhat.com,
        dan.j.williams@intel.com, wanpengli@tencent.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jmattson@google.com,
        pbonzini@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
        vkuznets@redhat.com, joro@8bytes.org, thomas.lendacky@amd.com,
        sdeep@vmware.com, x86@kernel.org, knsathya@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tony.luck@intel.com
Subject: Re: [PATCHv6 20/30] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <YjRXKYpFxBwdB1go@zn.tnic>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
 <3D4C3388-DC6A-41A5-A79F-B23FBFFE4E0F@alien8.de>
 <20220317202155.aurobskmy3v57nse@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317202155.aurobskmy3v57nse@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:21:55PM +0300, Kirill A. Shutemov wrote:
> As I said[1],

Whoops, I've missed that in the mail flood, sorry.

> I'm confused by the request. These field initialized at
> build time. I don't see how a single field would work.

So I did take a deeper look last night, trying to see whether the SEV
one - sev_es_trampoline_start - could be assigned at build time already
to pa_trampoline_start so that it is already in the header.

However, you need to have this info available dynamically, during boot
also, so that you can prepare the AP jump table for SEV guests, see
sev_es_setup_ap_jump_table().

Which means, I need a way of communicating the sev_es_trampoline_start
physical address to kernel proper *but*, *also*, I need to not touch the
default trampoline_start for normal booting. And this header is that
communicating.

So yeah, I kinda convinced myself that we cannot assign the proper
trampoline_start at boot time - which we can do with trickery to modify
that arch/x86/realmode/rm/pasyms.h generated addition to the linker
script. We need to be able to assign it at *boot* time so we need both
addresses.

Oh well, forget what I said initially.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
