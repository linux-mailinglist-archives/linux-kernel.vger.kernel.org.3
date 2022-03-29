Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5804EAE07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiC2NCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiC2NCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:02:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D736A412
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648558823; x=1680094823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zEa6R7bw5cSg85cbi5Cm+P+P1C62JAt+xmiinkvjWgo=;
  b=hI6B0wOkiJmYx4sOoYU9mjrDHRzgeJbXYOscKveXKaIIFDutpA0e0UfQ
   VGkHVzsUlP7MUGvPqkvXKWnESOAC6jfgdIlW1WOHiriLfWnHa0PmgV7qT
   G5/Awu2CcErsL7/lp62fTff4AKluuM7+5u5SV/zFMsc2v3weRSdie3ZyL
   aXW+MtuTBkZlnO5EIeLdqUdU7snq0eSWsl0amHac+zU+ScyPRuCeUJapg
   oUmuOH/zINJrtidEwmhAXnVC84DP44n+z8ZuXr00E0KfjzYFeW0ot1pMz
   9daFDHT6wMWFQy27+nKRK3Osn+2YKRR5F0HbwSzY0oE8LMJ3dECz9kdbf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256820242"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="256820242"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:00:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="719518002"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:00:20 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 29 Mar 2022 16:00:17 +0300
Date:   Tue, 29 Mar 2022 16:00:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkMC4XnfIZix6kBn@lahna>
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 29, 2022 at 08:35:49PM +0800, Brad Campbell wrote:
> On 29/3/22 19:31, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Mar 29, 2022 at 07:09:36PM +0800, Brad Campbell wrote:
> >> G'day Mika,
> >>
> >> Back in 2019 you assisted me with an issue on an iMac with a "Light Ridge"
> >> controller running a pair of Apple 27" Thunderbolt displays. At the time I
> >> commented they worked when plugged into a port each, however they don't work
> >> when chained.
> >>
> >> Back then things crashed horribly. Now they don't crash, and the PCI devices
> >> all work but there is an issue with the display.
> >>
> >> I'm currently testing on vanilla git-head commit
> >> ae085d7f9365de7da27ab5c0d16b12d51ea7fca9 (Sunday March 27th). A recent
> >> kernel with all the "for 5.18" patches.
> >>
> >> On both the iMac with the "Light Ridge" controller and a MacBookPro with a
> >> "Falcon Ridge" controller the result is the same.
> >>
> >> Plugged into a port each, they work perfectly.
> > 
> > Right, this is because both get their own 10Gb/s lane.
> > 
> >> If I chain them, the first one plugged in works and when the second is
> >> plugged in it's almost like the link is being starved of bandwidth.
> >> Graphical displays like a desktop, or a terminal break up, tear or exhibit
> >> almost white noise/snow on both displays. Solid colours with no gradient
> >> sometimes displays cleanly until something else is displayed and then it
> >> breaks up.
> > 
> > I think this is related to bandwidth management. When you chain two TBT1
> > devices you end up having a single 10Gb/s lane used for both DisplayPort
> > tunnels (this is how Linux does it now). There are no hardware mechanism
> > to negotiate the bandwidth so the first DP tunnel gets dominated over
> > the second one.
> > 
> > I'm not entirely sure how macOS handles this. It may be that it uses one
> > lane for both PCIe and first DP tunnel and the second lane for the
> > second DP tunnel where as Linux just puts all DP through the second
> > lane.
> > 
> > The below completely untested hack patch tries to use different lane for
> > both tunnels. Can you try it out?
> > 
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index cbd0ad85ffb1..6ea4968d3629 100644
> > --- a/drivers/thunderbolt/tb.c
> 
> For all forms of hot-plug this works perfectly! Got it in one.
> 
> I've tried all of the obvious permutations of plug and unplug. Once
> they are up and running it's all good.

Okay good to know.

> Where it falls down is if the machine is booted with the displays
> plugged in. I've attached the dmesg for that at the end. If I leave
> the chain unplugged until the kernel has started to boot and then plug
> it in, it all detects up and runs well.

Indeed, I did not add this to the "discovery" path yet.

I wonder what happens if you change this:

+       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
+                                   first ? 0 : 1);

to this in your tree:

+       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
+                                   first ? 1 : 0);

There are probably other things to consider too but let's check this one
first.

> There is an additional issue that I bumped up against on the laptop once, but it's easier to hit on the iMac. This is the relevant bit of dmesg for that.
> When a (single or chain) display is unplugged, the thunderbolt controller stops seeing plug events. It's effectively dead until rebooted.
> 
> [  144.603624] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  144.603638] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
> [  144.649819] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
> [  144.649836] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
> [  144.649849] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
> [  144.649849] thunderbolt 0000:07:00.0: 0:3: switch unplugged
> [  144.649853] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
> [  144.649854] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
> [  144.649862] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
> [  144.649866] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
> [  144.649883] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  144.650434] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  144.650578] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  144.656146] pci_bus 0000:1c: busn_res: [bus 1c] is released
> [  144.656230] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
> [  144.656299] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
> [  144.656380] pci_bus 0000:1d: busn_res: [bus 1d] is released
> [  144.656463] pci_bus 0000:1e: busn_res: [bus 1e] is released
> [  144.656562] pci_bus 0000:23: busn_res: [bus 23] is released
> [  144.656594] pci_bus 0000:22: busn_res: [bus 22-23] is released
> [  144.656638] pci_bus 0000:21: busn_res: [bus 21-23] is released
> [  144.656698] pci_bus 0000:24: busn_res: [bus 24] is released
> [  144.656751] pci_bus 0000:25: busn_res: [bus 25] is released
> [  144.656779] pci_bus 0000:26: busn_res: [bus 26-35] is released
> [  144.656807] pci_bus 0000:36: busn_res: [bus 36-45] is released
> [  144.656834] pci_bus 0000:20: busn_res: [bus 20-45] is released
> [  144.656869] pci_bus 0000:1f: busn_res: [bus 1f-45] is released
> [  144.656896] pci_bus 0000:46: busn_res: [bus 46-55] is released
> [  144.656923] pci_bus 0000:19: busn_res: [bus 19-55] is released
> [  144.871381] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  145.093518] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x39
> [  145.093536] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 0:7 to 3:10
> [  145.139771] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  145.408226] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  145.533276] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
> [  145.533291] thunderbolt 0000:07:00.0: 0:7: hop deactivation failed for hop 0, index 8
> [  145.533298] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:10 to 0:7
> [  145.676684] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  145.945107] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  145.973104] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
> [  145.973118] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 1, index 8
> [  145.973129] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): deactivating
> [  146.213523] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  146.412874] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
> [  146.481970] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
> [  146.852702] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  147.292462] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  147.292478] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 303:11
> [  147.732238] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
> [  147.732255] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 9
> [  147.732261] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
> [  148.172037] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
> [  148.172051] thunderbolt 0000:07:00.0: 0:c: nfc credits deallocation failed for hop 0
> [  148.172057] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 303:11
> [  148.611855] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
> [  148.611869] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 8
> [  148.611875] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:12
> [  149.051620] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
> [  149.051634] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 2, index 9
> [  149.051640] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
> [  149.051650] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
> [  149.051654] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:7 to 303:10
> [  149.051658] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 303:10 to 3:7
> [  149.051663] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): deactivating
> [  149.491440] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
> [  149.931229] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  150.380986] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  150.381001] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 3:11
> [  150.820803] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
> [  150.820817] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 9
> [  150.820823] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
> [  151.270628] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
> [  151.270642] thunderbolt 0000:07:00.0: 0:d: nfc credits deallocation failed for hop 0
> [  151.270648] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 3:11
> [  151.710341] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
> [  151.710360] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 8
> [  151.710368] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:13
> [  152.160109] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
> [  152.160124] thunderbolt 0000:07:00.0: 0:4: hop deactivation failed for hop 1, index 8
> [  152.160131] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
> [  152.160141] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
> [  152.160144] thunderbolt 0000:07:00.0: 3:b: DP OUT resource unavailable
> [  152.160242] thunderbolt 0-303: device disconnected
> [  152.160292] thunderbolt 0-3: device disconnected
> [  152.160326] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
> [  152.599916] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  152.599930] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [  153.039710] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> [  153.039724] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [  153.039727] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
> [  153.039733] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
> [  153.039736] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039739] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039742] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039745] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039747] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039750] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> [  153.039753] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> 
> Once it gets to here, nothing I plug in gets detected.

It is hard to tell what might be wrong here. Apple systems are not
exactly the most standard ones and it could be that we are simply
missing some magic step. The

  [  145.093518] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x39

tells that the DP adapter config write fails and we do have a quirk in
capabilities (cap.c) for some of the TBT1 controllers. Can you share the
full dmesg from this system so I can check if we cover this controller
in the quirk?
