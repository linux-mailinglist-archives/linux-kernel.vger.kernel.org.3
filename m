Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2502E5AEF57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiIFPtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiIFPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:48:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431063D0;
        Tue,  6 Sep 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662476376; x=1694012376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DNga4iNT+UIy0i9CErZMzAatkIfsNy/jUgqH3PWHYd8=;
  b=UtjnCjE/DmBOacMBMgOWes9aeLG2p+u04U2CuyIuAHC8vvLgvBXXQq/R
   x5e8Lo6Tm9QLWK2PZ7TDEu71XhGTmz17kTKI81ASdT+e43CcB5lY9dysS
   kmznLekMluXa3FjZN+cpeniFn2XRleAG9l9+SU70gVI0GsAgwhkhclvQK
   7hIlI1ZdbPaDFqg38UEqP8gtocIN5B6W/i0b90YygWenaooNczCgNCjbB
   fkxuNfxxnDPCh0au6DkvDBPXPBfFhy6CarcXpz8ZMpAG3PU6Cxbgf472f
   S+Ah/BFLriH2W94MyE18jGA/FATgeIj56DVho4+9ZZlRX1WNGSNFE8jxf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296614838"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296614838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="644199099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2022 07:59:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C18F86; Tue,  6 Sep 2022 17:59:49 +0300 (EEST)
Date:   Tue, 6 Sep 2022 17:59:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxdgZavuLU78lqIL@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
 <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
 <YxYXH5dqKqPANeVX@black.fi.intel.com>
 <CAAd53p5tYG=mAR-RSr1g_iznmmcCy1QpthG5vQzr99AP4QLJyg@mail.gmail.com>
 <YxdNKx1OFKsgBUBu@black.fi.intel.com>
 <CAAd53p6nNh1nUSfJgj5db+2B=eOCfiKta5aRiGsE4N0teL9cPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6nNh1nUSfJgj5db+2B=eOCfiKta5aRiGsE4N0teL9cPQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:29:03PM +0800, Kai-Heng Feng wrote:
> On Tue, Sep 6, 2022 at 9:37 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Sep 06, 2022 at 08:57:20PM +0800, Kai-Heng Feng wrote:
> > > On Mon, Sep 5, 2022 at 11:34 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > On Mon, Sep 05, 2022 at 11:21:36PM +0800, Kai-Heng Feng wrote:
> > > > > > Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> > > > > > detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> > > > > > status change at all or is it always 0?
> > > > >
> > > > > It changes only after tb_switch_add() is called.
> > > >
> > > > I doubt tb_switch_add() does anything but instead it is the established
> > > > PCIe tunnel that then shows up as it toggles the Card Present bit or so.
> > > > But that should also trigger PME if the root port is in D3 so you should
> > > > see this wake if everything works accordingly (unless I'm missing
> > > > something).
> > >
> > > You are right. Sometimes it may still fail to detect hotplugged device
> > > right after tb_switch_add().
> > > At which point PCIe tunnels are established? Is it after tb_scan_port()?
> >
> > They are established when userspace writes "1" to ../authorized of the
> > device (not automatically).
> >
> > On Ubuntu that's boltd that handles this so you may need to disable it
> > before you do the experiment.
> 
> In the dmesg it was disabled and "authorized" was 0 originally.

OK.

> >
> > > I found that it's cleaner to wakeup hotplug ports via iterating device
> > > link consumers at the end of tb_scan_port().
> > >
> > > According to your commit b2be2b05cf3b1c7b499d3b05decdcc524879fea7
> > > ("thunderbolt: Create device links from ACPI description"), it states
> > > "The _DSD can be added to tunneled USB3 and PCIe ports, and is needed to
> > > make sure the USB4 NHI is resumed before any of the tunneled ports so
> > > the protocol tunnels get established properly before the actual port
> > > itself is resumed. Othwerwise the USB/PCI core find the link may not be
> > > established and starts tearing down the device stack."
> > >
> > > So isn't waking them up a logical thing to do here?
> >
> > No they should wake up themselves.
> 
> OK.
> 
> >
> > > > So if you do this:
> > > >
> > > > 1. Boot the system up, nothing connected
> > > > 2. Plug in the TBT/USB4 device but do not authorize the PCIe tunnel
> > > > 3. Wait for the TBT/USB4 domain to enter sleep (runtime suspend)
> > > > 4. Authorize the PCIe tunnel
> > > >
> > > >   # echo 1 > .../authorized
> > > >
> > > > The established PCIe tunnel should trigger PME and the root port then
> > > > should be able to detect the PCIe link. Can you add full dmesg with
> > > > "thunderbolt.dyndbg=+p" in the command line to the bug?
> > >
> > > dmesg attached. Unfortunately there's no PME.
> >
> > Hmm, attached to where? Forgot to attach? ;-)
> 
> Oops, it's attached to the Bugzilla now.

Okay I see in the dmesg now that the root port enters D3hot:

[   40.363249] pcieport 0000:00:04.1: saving config space at offset 0x34 (reading 0x50)
[   40.363257] pcieport 0000:00:04.1: saving config space at offset 0x38 (reading 0x0)
[   40.363265] pcieport 0000:00:04.1: saving config space at offset 0x3c (reading 0x200ff)
[   40.365052] pcieport 0000:00:04.1: PME# enabled

and then the PCIe tunnel is authorized:

[   58.936258] thunderbolt 0000:64:00.6: 0:5 <-> 2:6 (PCI): activating
[   58.936270] thunderbolt 0000:64:00.6: activating PCIe Down path from 0:5 to 2:6
[   58.936434] thunderbolt 0000:64:00.6: 2:1: Writing hop 1
[   58.936443] thunderbolt 0000:64:00.6: 2:1:  In HopID: 8 => Out port: 6 Out HopID: 8
[   58.936449] thunderbolt 0000:64:00.6: 2:1:   Weight: 1 Priority: 3 Credits: 32 Drop: 0
[   58.936453] thunderbolt 0000:64:00.6: 2:1:    Counter enabled: 0 Counter index: 2047
[   58.936457] thunderbolt 0000:64:00.6: 2:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   58.936460] thunderbolt 0000:64:00.6: 2:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   58.936786] thunderbolt 0000:64:00.6: 0:5: Writing hop 0
[   58.936795] thunderbolt 0000:64:00.6: 0:5:  In HopID: 8 => Out port: 2 Out HopID: 8
[   58.936800] thunderbolt 0000:64:00.6: 0:5:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   58.936803] thunderbolt 0000:64:00.6: 0:5:    Counter enabled: 0 Counter index: 2047
[   58.936807] thunderbolt 0000:64:00.6: 0:5:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   58.936810] thunderbolt 0000:64:00.6: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   58.936971] thunderbolt 0000:64:00.6: path activation complete
[   58.936979] thunderbolt 0000:64:00.6: activating PCIe Up path from 2:6 to 0:5
[   58.937129] thunderbolt 0000:64:00.6: 0:2: Writing hop 1
[   58.937138] thunderbolt 0000:64:00.6: 0:2:  In HopID: 8 => Out port: 5 Out HopID: 8
[   58.937143] thunderbolt 0000:64:00.6: 0:2:   Weight: 1 Priority: 3 Credits: 32 Drop: 0
[   58.937147] thunderbolt 0000:64:00.6: 0:2:    Counter enabled: 0 Counter index: 2047
[   58.937150] thunderbolt 0000:64:00.6: 0:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   58.937154] thunderbolt 0000:64:00.6: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   58.937453] thunderbolt 0000:64:00.6: 2:6: Writing hop 0
[   58.937462] thunderbolt 0000:64:00.6: 2:6:  In HopID: 8 => Out port: 1 Out HopID: 8
[   58.937467] thunderbolt 0000:64:00.6: 2:6:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   58.937471] thunderbolt 0000:64:00.6: 2:6:    Counter enabled: 0 Counter index: 2047
[   58.937474] thunderbolt 0000:64:00.6: 2:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   58.937478] thunderbolt 0000:64:00.6: 2:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   58.937633] thunderbolt 0000:64:00.6: path activation complete

but this is not detected by the root port so after a while the domain is
suspended as well:

[   84.327759] thunderbolt 0000:64:00.6: 0: suspending switch

What should happen right after the PCIe tunnel activation is that the root port
should get PME / hotplug and it should then find the devices but this for some
reason is not happening.

This reminded me that in Intel hardware there is an ACPI power resource that is
shared between related devices. IIRC there is _PR0() method under the root
port, xHCI and the TBT NHI that returns the same power resource. Now, when the
power resource is turned on for any of the devices the kernel wakes up the rest
too to make sure they get properly re-initialized if they went into
D0unitialized or something like that. The commit that added this is
4533771c1e53 ("ACPI / PM: Introduce concept of a _PR0 dependent device").

I'm not entirely sure if that applies here because none of the devices seem to
enter D3cold, though. Is this working on Windows side and do you know if it
goes into D3cold too?
