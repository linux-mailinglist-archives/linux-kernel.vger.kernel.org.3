Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83DC46130D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354403AbhK2LH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:07:29 -0500
Received: from foss.arm.com ([217.140.110.172]:35932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236585AbhK2LF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:05:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3405B1042;
        Mon, 29 Nov 2021 03:02:09 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCE23F694;
        Mon, 29 Nov 2021 03:02:08 -0800 (PST)
Date:   Mon, 29 Nov 2021 11:02:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Linux 5.16-rc3
Message-ID: <20211129110202.GA23795@lpieralisi>
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net>
 <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
 <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 08:17:33PM -0800, Guenter Roeck wrote:
> On 11/28/21 7:07 PM, Randy Dunlap wrote:
> > 
> > 
> > On 11/28/21 17:59, Guenter Roeck wrote:
> > > On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
> > > > So rc3 is usually a bit larger than rc2 just because people had some
> > > > time to start finding things.
> > > > 
> > > > So too this time, although it's not like this is a particularly big
> > > > rc3. Possibly partly due to the past week having been Thanksgiving
> > > > week here in the US. But the size is well within the normal range, so
> > > > if that's a factor, it's not been a big one.
> > > > 
> > > > The diff for rc3 is mostly drivers, although part of that is just
> > > > because of the removal of a left-over MIPS Netlogic driver which makes
> > > > the stats look a bit wonky, and is over a third of the whole diff just
> > > > in itself.
> > > > 
> > > > If you ignore that part, the statistics look a bit more normal, but
> > > > drivers still dominate (network drivers, sound and gpu are the big
> > > > ones, but there is noise all over). Other than that there's once again
> > > > a fair amount of selftest (mostly networking), along with core
> > > > networking, some arch updates - the bulk of it from a single arm64
> > > > uaccess patch, although that's mostly because it's all pretty small -
> > > > and random other changes.
> > > > 
> > > > Full shortlog below.
> > > > 
> > > > Please test,
> > > > 
> > > 
> > > Build results:
> > >     total: 153 pass: 152 fail: 1
> > > Failed builds:
> > >     mips:allmodconfig
> > > Qemu test results:
> > >     total: 482 pass: 482 fail: 0
> > > 
> > > Building mips:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > 
> > > There is still no fix for the mips:allmodconfig build problem as far
> > > as I can see. It is a bit odd, because the fix would be as simple as
> > > 
> > >   config PCIE_MT7621
> > > -    tristate "MediaTek MT7621 PCIe Controller"
> > > -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > > +    bool "MediaTek MT7621 PCIe Controller"
> > > +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> > >       select PHY_MT7621_PCI
> > >       default SOC_MT7621
> > >       help
> > > 
> > > Context: tristate doesn't make sense here because both RALINK and
> > > SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> > > already depends on it. The compile failure is due to missing exported
> > > symbols, and it is only seen if PCIE_MT7621=m - which is only possible
> > > if COMPILE_TEST=y. In other words, the dependencies above are set such
> > > that test builds, and only test builds, fail.
> > > 
> > > The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> > > Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> > > those responsible to see if we can expect a solution sometime soon.
> > 
> > 
> > I sent a patch for this a couple of weeks ago and Sergio replied to it
> > here:
> > 
> > https://lore.kernel.org/linux-pci/CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com/
> > 
> > saying that is a different patch out there but that it had not
> > been reviewed yet.
> > 
> 
> All proposals I have seen assume that PCIE_MT7621=m. As I said, I think
> that it is pointless to do that because the driver can only be built
> as module if COMPILE_TEST=y. We should not [have to] export symbols
> because of that.

Hi Sergio,

can we converge to a fix with this thread background in mind please ?

Thanks,
Lorenzo
