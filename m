Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C485463C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhK3Qoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:44:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhK3Qob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:44:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA16621709;
        Tue, 30 Nov 2021 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638290470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grx6q1E7RERw3cBzyxiNzngPamOtKv/XGOH3SSpIJ28=;
        b=MmPbvVcCIWG8rrUliwMcGzENVIt0YTNbWjxD3OZT8QWab4KxXKHJefZquPZtsLcMMROGDm
        IfbPcnzuiEEBjqKpshkX6rmO8hjLDinNvk/DK1sra3NrRiIYaCnpvJmbesx9gn0eAztHFk
        Of8PphI2rDmpR4d9F9Ff/NsIGXtk8C0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638290470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grx6q1E7RERw3cBzyxiNzngPamOtKv/XGOH3SSpIJ28=;
        b=EWVsTwGznmAyWqsVln/e5RUXz1i3GT2Yf/uqkrY26UWVZeE/VVHfrTfbCl6tF5OLw+GynO
        JHMqdUUJddJCkADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6705913D5C;
        Tue, 30 Nov 2021 16:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LbGTFyZUpmH2egAAMHmgww
        (envelope-from <jroedel@suse.de>); Tue, 30 Nov 2021 16:41:10 +0000
Date:   Tue, 30 Nov 2021 17:41:08 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv3 0/4] Add generic MMIO instruction deconding to be used
 in SEV and TDX
Message-ID: <YaZUJIXJC2OVFSth@suse.de>
References: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 06:45:51PM +0300, Kirill A. Shutemov wrote:
> Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
> handle MMIO.
> 
> Extract insn_decode_mmio() from SEV code. TDX will also use this helper.
> 
> v3:
>  - Handle insn_get_opcode() in is_string_insn()
> v2:
>  - insn_get_modrm_reg_ptr() returns unsigned long pointer now (PeterZ);
>  - Handle insn_get_opcode() failure in insn_decode_mmio() (PeterZ);
> 
> Kirill A. Shutemov (4):
>   x86/insn-eval: Handle insn_get_opcode() failure
>   x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
>   x86/insn-eval: Introduce insn_decode_mmio()
>   x86/sev-es: Use insn_decode_mmio() for MMIO implementation
> 
>  arch/x86/include/asm/insn-eval.h |  13 +++
>  arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
>  arch/x86/lib/insn-eval.c         | 109 +++++++++++++++++++-
>  3 files changed, 160 insertions(+), 133 deletions(-)

Testing looks good here:

Tested-by: Joerg Roedel <jroedel@suse.de>

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

