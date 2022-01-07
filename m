Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2D486DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiAFXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:25:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B456C061245;
        Thu,  6 Jan 2022 15:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5701AB82484;
        Thu,  6 Jan 2022 23:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E3C36AE3;
        Thu,  6 Jan 2022 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641511498;
        bh=r4egbbxEUrCO6NmZqm/NKgi1nELauu4UYRmMyY1HgZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pE/iDWIK0U8YpkKchQ2VsYn/TYIu5/vYVCeV12mPRPPuKdvkM+m4qbmHJug2IQyFS
         KFAxb8s2A3dE95Id5EgiFr36B6PUzQ3ulGC1nVX94bK0p7gafbmFQ9VUtGXkYFI1iu
         0BSK+x4FjI6xNPodoL24qmHE/UuS58YowP/TgEqlhlgDxExzd0jwMpwIfhDlJASXBG
         01HMHdc7ZqV+rUrdAxYuEIqhPmu3XVQNBjftCUkDPVjhmfsjJzlIa3dMJa/devVqSE
         VmMtSkUhuJmYIW79IOeDKq/GMstVcU5aD1JhIlKLRtaVLMKZpY9ivKzEH+Y0kXEOac
         L44Fzb0ReUVcA==
Date:   Thu, 6 Jan 2022 17:24:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/PCI: Add support for the Intel 82378ZB/82379AB
 (SIO/SIO.A) PIRQ router
Message-ID: <20220106232456.GA334344@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2201022030220.56863@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:24:52PM +0000, Maciej W. Rozycki wrote:
> The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
> ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
> that is exactly the same as that of the PIIX and ICH southbridges (or 
> actually the other way round, given that the SIO ASIC was there first).
> 
> An earlier version of the SIO, the 82378IB[3][4], does not implement PCI 
> interrupt steering however, so we need to exclude it by checking the low 
> nibble of the PCI Revision Identification Register[5][6] for being at 
> least 3.
> 
> There is a note in the 82379AB specification update[7] saying that the 
> device ID for that chip is 0x7, rather than 0x484 as stated in the 
> datasheet[8].  It looks like a red herring however, for no report has 
> been ever seen with that value quoted and it matches the documented 
> default value of the PCI Command Register, which comes next after the 
> PCI Device Identification Register, so it looks like a copy-&-paste 
> editorial mistake.
> 
> NB the 82378ZB has been commonly used with smaller DEC Alpha systems 
> with the contents of the Revision Identification Register reported as 
> one of 0x3, 0x43, or 0x84, so the masking of the high nibble seems 
> indeed right by empirical observation.  The value in the high nibble 
> might be either random, or depend on the batch, or correspond to some 
> other state such as reset straps.
> 
> References:
> 
> [1] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
>     290473-004, December 1994, Section 4.1.26 "PIRQ[3:0]#--PIRQ Route 
>     Control Registers"
> 
> [2] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.25. "PIRQ[3:0]#--PIRQ Route Control Registers", p. 48
> 
> [3] "82378IB System I/O (SIO)", Intel Corporation, Order Number:
>     290473-002, April 1993, Section 5.8.7.7 "Edge and Level Triggered
>     Modes"
> 
> [4] "82378IB to 82378ZB Errata Fix and Feature Enhancement Conversion
>     FOL933002-01",
>     <https://web.archive.org/web/19990421045433/http://support.intel.com/support/chipsets/420/8511.htm>
> 
> [5] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
>     290473-004, December 1994, Section 4.1.5. "RID--Revision 
>     Identification Register"
> 
> [6] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.5. "RID--Revision Identification Register", p. 34
> 
> [7] "Intel 82379AB (SIO.A) System I/O Component Specification Update", 
>     Intel Corporation, Order Number: 297734-001, May, 1996, "Component 
>     Identification via Programming Interface", p. 5
> 
> [8] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.2. "DID--Device Identification Register", p. 33
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
> 
>  Reposting as it seems to have been missed and now needs to be regenerated 
> to resolve a merge conflict with a later change that did make it.
> 
>  Please apply.

No objection from me, but I know zero about this code, so I'll let the
x86/IRQ guys deal with this.

> Changes from v2:
> 
> - Regenerate for a merge conflict.
> 
> Changes from v1:
> 
> - Add [PATCH] annotation (umm...).
> 
> - Fix RID values listed to include 0x84 rather than 0x83 (braino).
> ---
>  arch/x86/pci/irq.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> linux-x86-pirq-router-sio.diff
> Index: linux-macro/arch/x86/pci/irq.c
> ===================================================================
> --- linux-macro.orig/arch/x86/pci/irq.c
> +++ linux-macro/arch/x86/pci/irq.c
> @@ -801,11 +801,18 @@ static __init int intel_router_probe(str
>  		return 0;
>  
>  	switch (device) {
> +		u8 rid;
>  	case PCI_DEVICE_ID_INTEL_82375:
>  		r->name = "PCEB/ESC";
>  		r->get = pirq_esc_get;
>  		r->set = pirq_esc_set;
>  		return 1;
> +	case PCI_DEVICE_ID_INTEL_82378:
> +		pci_read_config_byte(router, PCI_REVISION_ID, &rid);
> +		/* Tell 82378IB (rev < 3) and 82378ZB/82379AB apart.  */
> +		if ((rid & 0xfu) < 3)
> +			break;
> +		fallthrough;
>  	case PCI_DEVICE_ID_INTEL_82371FB_0:
>  	case PCI_DEVICE_ID_INTEL_82371SB_0:
>  	case PCI_DEVICE_ID_INTEL_82371AB_0:
> @@ -847,7 +854,7 @@ static __init int intel_router_probe(str
>  	case PCI_DEVICE_ID_INTEL_ICH10_3:
>  	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0:
>  	case PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1:
> -		r->name = "PIIX/ICH";
> +		r->name = "SIO/PIIX/ICH";
>  		r->get = pirq_piix_get;
>  		r->set = pirq_piix_set;
>  		return 1;
> @@ -866,7 +873,7 @@ static __init int intel_router_probe(str
>  	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
>  	||  (device >= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
>  	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
> -		r->name = "PIIX/ICH";
> +		r->name = "SIO/PIIX/ICH";
>  		r->get = pirq_piix_get;
>  		r->set = pirq_piix_set;
>  		return 1;
