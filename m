Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80E494569
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiATBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:10:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:3686 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbiATBKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642641012; x=1674177012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXSZgDNrrxuM7Lyil7Vv3r9uQW3g8t0ZCsUgknmFUw8=;
  b=hxd0W2EGqaGMWC4GpQnUE0BuZGWlOYPkxx4D+PKJ9xuiHLdDlMQzdlN6
   ngAw3uRqLya0In+cQI3hnNNv8+hRrNUUwVpSgNkZDt2dRh/kHcAj2oPPh
   LDGeaiVuJSWwoE9i/ETgsrXpQ82e5c0OicR4y4I/mJMzvegOIqzs05Rtn
   tRq7/ojBn6uQ9cQF95H2YuU2kbEFLl47XLXl8pzc7ewgHQ2raselPJMvD
   FO8fgIpRhsJxVnYPw0sLk7mwlBB0dIBcq7/3LwKz85OMRb3w+m5jVnLvL
   kUQixRRqmmT4h/vXhy4S09rQxufNYDm+BsQ0z2+XzEm4LBQNSpm0Ihp4O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269638006"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="269638006"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 17:10:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="595592779"
Received: from krziegle-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.144.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 17:10:09 -0800
Date:   Wed, 19 Jan 2022 17:10:08 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Matthew D Roper <matthew.d.roper@intel.com>,
        hariom.pandey@intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Message-ID: <20220120011008.6tmvfnvr2zqedhkj@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <CAKMK7uEjj-Od3B=RtQDV_7ibDOsY6WxKGiJXt0MYq3C6kaVPcQ@mail.gmail.com>
 <20201119191932.GA121237@bjorn-Precision-5520>
 <CAJmaN=kU4Rf62rZt-eDWW5M2CPHmxA4ZzX+AXJx6vjVhoGn13w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJmaN=kU4Rf62rZt-eDWW5M2CPHmxA4ZzX+AXJx6vjVhoGn13w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrecting this thread after the other discussion on stolen memory
for Intel integrated GPU when there are Intel discrete GPU present:
https://lore.kernel.org/linux-pci/20220118200145.GA887728@bhelgaas/

see below.

On Thu, Nov 19, 2020 at 02:01:50PM -0800, Jesse Barnes wrote:
>On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Jesse]
>>
>> On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
>> > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter wrote:
>> > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wrote:
>> > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen wrote:
>> > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
>> > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
>> > > > > > > > >
>> > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
>> > > > > > > > > > JSL re-uses the same stolen memory as ICL and EHL.
>> > > > > > > > > >
>> > > > > > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
>> > > > > > > > > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
>> > > > > > > > >
>> > > > > > > > > I don't plan to do anything with this since previous similar patches
>> > > > > > > > > have gone through some other tree, so this is just kibitzing.
>> > > > > > > > >
>> > > > > > > > > But the fact that we have this long list of Intel devices [1] that
>> > > > > > > > > constantly needs updates [2] is a hint that something is wrong.
>> > > > > > > >
>> > > > > > > > We add an entry for every new integrated graphics platform. Once the
>> > > > > > > > platform is added, there have not been changes lately.
>> > > > > > > >
>> > > > > > > > > IIUC the general idea is that we need to discover Intel gfx memory by
>> > > > > > > > > looking at device-dependent config space and add it to the E820 map.
>> > > > > > > > > Apparently the quirks discover this via PCI config registers like
>> > > > > > > > > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
>> > > > > > > > > global "intel_graphics_stolen_res"?
>> > > > > > > >
>> > > > > > > > We discover what is called the graphics data stolen memory. It is regular
>> > > > > > > > system memory range that is not CPU accessible. It is accessible by the
>> > > > > > > > integrated graphics only.
>> > > > > > > >
>> > > > > > > > See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
>> > > > > > > >
>> > > > > > > > > That's not the way this should work.  There should some generic, non
>> > > > > > > > > device-dependent PCI or ACPI method to discover the memory used, or at
>> > > > > > > > > least some way to do it in the driver instead of early arch code.
>> > > > > > > >
>> > > > > > > > It's used by the early BIOS/UEFI code to set up initial framebuffer.
>> > > > > > > > Even if i915 driver is never loaded, the memory ranges still need to
>> > > > > > > > be fixed. They source of the problem is that the OEM BIOS which are
>> > > > > > > > not under our control get the programming wrong.
>> > > > > > > >
>> > > > > > > > We used to detect the memory region size again at i915 initialization
>> > > > > > > > but wanted to eliminate the code duplication and resulting subtle bugs
>> > > > > > > > that caused. Conclusion back then was that storing the struct resource
>> > > > > > > > in memory is the best trade-off.
>> > > > > > > >
>> > > > > > > > > How is this *supposed* to work?  Is there something we can do in E820
>> > > > > > > > > or other resource management that would make this easier?
>> > > > > > > >
>> > > > > > > > The code was added around Haswell (HSW) device generation to mitigate
>> > > > > > > > bugs in BIOS. It is traditionally hard to get all OEMs to fix their
>> > > > > > > > BIOS when things work for Windows. It's only later years when some
>> > > > > > > > laptop models are intended to be sold with Linux.
>> > > > > > > >
>> > > > > > > > The alternative would be to get all the OEM to fix their BIOS for Linux,
>> > > > > > > > but that is not very realistic given past experiences. So it seems
>> > > > > > > > a better choice to to add new line per platform generation to make
>> > > > > > > > sure the users can boot to Linux.
>> > > > > > >
>> > > > > > > How does Windows do this?  Do they have to add similar code for each
>> > > > > > > new platform?
>> > > > > >
>> > > > > > Windows is chicken and doesn't move any mmio bar around on its own.
>> > > > > > Except if the bios explicitly told it somehow (e.g. for the 64bit bar
>> > > > > > stuff amd recently announced for windows, that linux supports since
>> > > > > > years by moving the bar). So except if you want to preemptively
>> > > > > > disable the pci code that does this anytime there's an intel gpu, this
>> > > > > > is what we have to do.
>> > > > >
>> > > > > I think Windows *does* move BARs (they use the more generic
>> > > > > terminology of "rebalancing PNP resources") in some cases [3,4].  Of
>> > > > > course, I'm pretty sure Windows will only assign PCI resources inside
>> > > > > the windows advertised in the host bridge _CRS.
>> > > > >
>> > > > > Linux *used* to ignore that host bridge _CRS and could set BARs to
>> > > > > addresses that appeared available but were in fact used by the
>> > > > > platform somehow.  But Linux has been paying attention to host bridge
>> > > > > _CRS for a long time now, so it should also only assign resources
>> > > > > inside those windows.
>> > > >
>> > > > If this behaviour is newer than the addition of these quirks then yeah
>> > > > they're probably not needed anymore, and we can move all this back
>> > > > into the driver. Do you have the commit when pci core started
>> > > > observing _CRS on the host bridge?
>> > >
>> > > I think the most relevant commit is this:
>> > >
>> > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS info by default on 2008 and newer machines")
>> > >
>> > > but the earliest quirk I found is over three years later:
>> > >
>> > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for reserving Intel graphics stolen memory v5")
>> > >
>> > > So there must be something else going on.  814c5f1f52a4 mentions a
>> > > couple bug reports.  The dmesg from 66726 [5] shows that we *are*
>> > > observing the host bridge _CRS, but Linux just used the BIOS
>> > > configuration without changing anything:
>> > >
>> > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff] usable
>> > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff] reserved
>> > >   PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>> > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-0xffff_ffff]
>> > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
>> > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
>> > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-0xfe9f_ffff]
>> > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-0x7f8f_ffff 64bit pref]
>> > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
>> > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
>> > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected with stolen region: [0x7f80_0000 - 0x8000_0000]
>> > >
>> > > So the BIOS programmed the 00:1c.0 bridge prefetchable window to
>> > > [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks that's a conflict.
>> > >
>> > > On this system, there are no PCI BARs in that range.  01:00.0 looks
>> > > like a Ralink RT3090 Wireless 802.11n device that only has a
>> > > non-prefetchable BAR at [mem 0xfe90_0000-0xfe90_ffff].
>> > >
>> > > I don't know the details of the conflict.  IIUC, Joonas said the
>> > > stolen memory is accessible only by the integrated graphics, not by
>> > > the CPU.  The bridge window is CPU accessible, of course, and the
>> > > [mem 0x7f70_0000-0x7f8f_ffff] range contains the addresses the CPU
>> > > uses for programmed I/O to BARs below the bridge.
>> > >
>> > > The graphics accesses sound like they would be DMA in the *bus*
>> > > address space, which is frequently, but not always, identical to the
>> > > CPU address space.
>> >
>> > So apparently on some platforms the conflict is harmless because the
>> > BIOS puts BARs and stuff over it from boot-up, and things work:
>> > 0b6d24c01932 ("drm/i915: Don't complain about stolen conflicts on
>> > gen3") But we also had conflict reports on other machines.
>>
>> The bug reports mentioned in 814c5f1f52a4 ("x86: add early quirk for
>> reserving Intel graphics stolen memory v5") and 0b6d24c01932
>> ("drm/i915: Don't complain about stolen conflicts on gen3") seem to be
>> basically complaints about the *message*, not anything that's actually
>> broken.
>>
>> Jesse's comment [6]:
>>
>>   Given the decode priority on our GMCHs, it's fine if the regions
>>   overlap.  However it doesn't look like there's a nice way to detect
>>   it.  In this case, part of the range occupied by the stolen space is
>>   simply "reserved" per the E820, but the rest of it is under the bus
>>   0 range (which kind of makes sense too).
>>
>> sounds relevant but I don't know enough to interpret it.  I added
>> Jesse in case he wants to comment.
>>
>> > GPU does all its access with CPU address space (after the iommu, which
>> > is entirely integrated). So I'm not sure whether we've seen something
>> > go boom or whether reserving that resource was just precaution in
>> > eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't
>> > conflict"), it's all a bit way back in history.
>> >
>> > So really not sure what to do here or what the risks are.
>>
>> I'm not either.  Seems like we're not really converging on anything
>> useful we can do at this point.  The only thing I can think of would
>> be to collect data about actual failures (not just warning messages).
>> That might lead to something we could improve in the future.
>
>I don't have any brilliant ideas here unfortunately.  Maybe it's worth
>talking to some of the Windows folks internally to see how these
>ranges are handled these days and matching it?  Historically this has
>been an area fraught with danger because getting things wrong can lead
>to corruption of various kinds or boot hangs.

We could try something else, but if there are bios bugs for old systems
preventing us to do this entirely in i915, I'm not sure that would
solve it.

What if we phase out the quirks for new platforms? Idea would be to
revive eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't conflict")
adapted to the current code. Then we can move some o the latest
platforms and watch out for regressions. At least we would stop
additions to this early-quirk.c

Another idea: wouldn't DECLARE_PCI_FIXUP_EARLY work? AFAICS this is
early enough to reserve the memory.

Also We could add only those systems where we reproduce bugs
rather than preemptively adding them to the table - it would at least
allow to catch those bugs in bioses rather than hiding them.


Lucas De Marchi

>
>Jesse
