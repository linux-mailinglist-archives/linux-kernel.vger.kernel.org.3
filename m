Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEF4EAD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiC2Mhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiC2Mhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:37:41 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1F18D28B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:35:53 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1nZB4g-0003aZ-9E; Tue, 29 Mar 2022 22:35:50 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qyAlA/IQZ8meM4jD7T7Ve2mbEh/siYizFFYu6wk271s=; b=u/u1P8Ugv3T9SUOxBckEbxVc0L
        QHymTH/EXYR2GebSoshcmbuOBKo7vrU89+QSErPRAcri8uhXHGILRmVk9AQSwQXdzbyzQiVy//5nj
        CJfbpomCaiVd+jU2zP6t6DIG+EbTl4lM9fQ2bU27DFbhOAlRxyhzjrf6jxMtLA/4O5BY=;
Message-ID: <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
Date:   Tue, 29 Mar 2022 20:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YkLt+/kJ54fwCYgy@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/3/22 19:31, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Mar 29, 2022 at 07:09:36PM +0800, Brad Campbell wrote:
>> G'day Mika,
>>
>> Back in 2019 you assisted me with an issue on an iMac with a "Light Ridge"
>> controller running a pair of Apple 27" Thunderbolt displays. At the time I
>> commented they worked when plugged into a port each, however they don't work
>> when chained.
>>
>> Back then things crashed horribly. Now they don't crash, and the PCI devices
>> all work but there is an issue with the display.
>>
>> I'm currently testing on vanilla git-head commit
>> ae085d7f9365de7da27ab5c0d16b12d51ea7fca9 (Sunday March 27th). A recent
>> kernel with all the "for 5.18" patches.
>>
>> On both the iMac with the "Light Ridge" controller and a MacBookPro with a
>> "Falcon Ridge" controller the result is the same.
>>
>> Plugged into a port each, they work perfectly.
> 
> Right, this is because both get their own 10Gb/s lane.
> 
>> If I chain them, the first one plugged in works and when the second is
>> plugged in it's almost like the link is being starved of bandwidth.
>> Graphical displays like a desktop, or a terminal break up, tear or exhibit
>> almost white noise/snow on both displays. Solid colours with no gradient
>> sometimes displays cleanly until something else is displayed and then it
>> breaks up.
> 
> I think this is related to bandwidth management. When you chain two TBT1
> devices you end up having a single 10Gb/s lane used for both DisplayPort
> tunnels (this is how Linux does it now). There are no hardware mechanism
> to negotiate the bandwidth so the first DP tunnel gets dominated over
> the second one.
> 
> I'm not entirely sure how macOS handles this. It may be that it uses one
> lane for both PCIe and first DP tunnel and the second lane for the
> second DP tunnel where as Linux just puts all DP through the second
> lane.
> 
> The below completely untested hack patch tries to use different lane for
> both tunnels. Can you try it out?
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index cbd0ad85ffb1..6ea4968d3629 100644
> --- a/drivers/thunderbolt/tb.c

For all forms of hot-plug this works perfectly! Got it in one.

I've tried all of the obvious permutations of plug and unplug. Once they are up and running it's all good.

Where it falls down is if the machine is booted with the displays plugged in. I've attached the dmesg for that at the end. If I leave the chain unplugged until the kernel has started to boot and then plug it in, it all detects up and runs well.

There is an additional issue that I bumped up against on the laptop once, but it's easier to hit on the iMac. This is the relevant bit of dmesg for that.
When a (single or chain) display is unplugged, the thunderbolt controller stops seeing plug events. It's effectively dead until rebooted.

[  144.603624] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  144.603638] thunderbolt 0000:07:00.0: acking hot unplug event on 0:4
[  144.649819] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[  144.649836] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[  144.649849] pcieport 0000:19:04.0: pciehp: pciehp_isr: no response from device
[  144.649849] thunderbolt 0000:07:00.0: 0:3: switch unplugged
[  144.649853] pcieport 0000:20:04.0: pciehp: pciehp_isr: no response from device
[  144.649854] thunderbolt 0000:07:00.0: 0:7 <-> 3:a (PCI): deactivating
[  144.649862] pcieport 0000:06:04.0: pciehp: Slot(4-1): Link Down
[  144.649866] pcieport 0000:06:04.0: pciehp: Slot(4-1): Card not present
[  144.649883] pcieport 0000:19:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[  144.650434] pcieport 0000:20:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[  144.650578] pcieport 0000:20:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[  144.656146] pci_bus 0000:1c: busn_res: [bus 1c] is released
[  144.656230] pci_bus 0000:1b: busn_res: [bus 1b-1c] is released
[  144.656299] pci_bus 0000:1a: busn_res: [bus 1a-1c] is released
[  144.656380] pci_bus 0000:1d: busn_res: [bus 1d] is released
[  144.656463] pci_bus 0000:1e: busn_res: [bus 1e] is released
[  144.656562] pci_bus 0000:23: busn_res: [bus 23] is released
[  144.656594] pci_bus 0000:22: busn_res: [bus 22-23] is released
[  144.656638] pci_bus 0000:21: busn_res: [bus 21-23] is released
[  144.656698] pci_bus 0000:24: busn_res: [bus 24] is released
[  144.656751] pci_bus 0000:25: busn_res: [bus 25] is released
[  144.656779] pci_bus 0000:26: busn_res: [bus 26-35] is released
[  144.656807] pci_bus 0000:36: busn_res: [bus 36-45] is released
[  144.656834] pci_bus 0000:20: busn_res: [bus 20-45] is released
[  144.656869] pci_bus 0000:1f: busn_res: [bus 1f-45] is released
[  144.656896] pci_bus 0000:46: busn_res: [bus 46-55] is released
[  144.656923] pci_bus 0000:19: busn_res: [bus 19-55] is released
[  144.871381] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  145.093518] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x39
[  145.093536] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 0:7 to 3:10
[  145.139771] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  145.408226] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  145.533276] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[  145.533291] thunderbolt 0000:07:00.0: 0:7: hop deactivation failed for hop 0, index 8
[  145.533298] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 3:10 to 0:7
[  145.676684] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  145.945107] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  145.973104] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[  145.973118] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 1, index 8
[  145.973129] thunderbolt 0000:07:00.0: 0:c <-> 303:b (DP): deactivating
[  146.213523] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  146.412874] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
[  146.481970] thunderbolt 0000:07:00.0: acking hot unplug event on 0:3
[  146.852702] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  147.292462] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  147.292478] thunderbolt 0000:07:00.0: deactivating Video path from 0:12 to 303:11
[  147.732238] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[  147.732255] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 9
[  147.732261] thunderbolt 0000:07:00.0: 0:c: adding -5 NFC credits to 5
[  148.172037] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
[  148.172051] thunderbolt 0000:07:00.0: 0:c: nfc credits deallocation failed for hop 0
[  148.172057] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:12 to 303:11
[  148.611855] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[  148.611869] thunderbolt 0000:07:00.0: 0:c: hop deactivation failed for hop 0, index 8
[  148.611875] thunderbolt 0000:07:00.0: deactivating AUX RX path from 303:11 to 0:12
[  149.051620] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[  149.051634] thunderbolt 0000:07:00.0: 0:3: hop deactivation failed for hop 2, index 9
[  149.051640] thunderbolt 0000:07:00.0: 0: released DP resource for port 12
[  149.051650] thunderbolt 0000:07:00.0: 3:7 <-> 303:a (PCI): deactivating
[  149.051654] thunderbolt 0000:07:00.0: deactivating PCIe Down path from 3:7 to 303:10
[  149.051658] thunderbolt 0000:07:00.0: deactivating PCIe Up path from 303:10 to 3:7
[  149.051663] thunderbolt 0000:07:00.0: 0:d <-> 3:b (DP): deactivating
[  149.491440] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x3c
[  149.931229] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  150.380986] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  150.381001] thunderbolt 0000:07:00.0: deactivating Video path from 0:13 to 3:11
[  150.820803] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x12
[  150.820817] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 9
[  150.820823] thunderbolt 0000:07:00.0: 0:d: adding -5 NFC credits to 5
[  151.270628] thunderbolt 0000:07:00.0: 0: timeout writing config space 1 to 0x4
[  151.270642] thunderbolt 0000:07:00.0: 0:d: nfc credits deallocation failed for hop 0
[  151.270648] thunderbolt 0000:07:00.0: deactivating AUX TX path from 0:13 to 3:11
[  151.710341] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[  151.710360] thunderbolt 0000:07:00.0: 0:d: hop deactivation failed for hop 0, index 8
[  151.710368] thunderbolt 0000:07:00.0: deactivating AUX RX path from 3:11 to 0:13
[  152.160109] thunderbolt 0000:07:00.0: 0: timeout reading config space 0 from 0x10
[  152.160124] thunderbolt 0000:07:00.0: 0:4: hop deactivation failed for hop 1, index 8
[  152.160131] thunderbolt 0000:07:00.0: 0: released DP resource for port 13
[  152.160141] thunderbolt 0000:07:00.0: 303:b: DP OUT resource unavailable
[  152.160144] thunderbolt 0000:07:00.0: 3:b: DP OUT resource unavailable
[  152.160242] thunderbolt 0-303: device disconnected
[  152.160292] thunderbolt 0-3: device disconnected
[  152.160326] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[  152.599916] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  152.599930] thunderbolt 0000:07:00.0: 0:c: DP IN available
[  153.039710] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
[  153.039724] thunderbolt 0000:07:00.0: 0:d: DP IN available
[  153.039727] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
[  153.039733] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
[  153.039736] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039739] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039742] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039745] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039747] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039750] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
[  153.039753] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring

Once it gets to here, nothing I plug in gets detected.


This is the Laptop dmesg from boot with the display chain plugged in.

[    0.000000] Linux version 5.17.0+ (brad@bklaptop) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #35 SMP PREEMPT_DYNAMIC Tue Mar 29 19:37:34 AWST 2022
[    0.000000] Command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008ad0ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ad10000-0x000000008ad52fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008ad53000-0x000000008ad61fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ad62000-0x000000008ad8efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008ad8f000-0x000000008ae38fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008ae39000-0x000000008ae8efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008ae8f000-0x000000008aed1fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008aed2000-0x000000008aefefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008aeff000-0x000000008af83fff] usable
[    0.000000] BIOS-e820: [mem 0x000000008af84000-0x000000008afeffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008aff0000-0x000000008affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000008b000000-0x000000008f9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe10000-0x00000000ffe3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000046f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d4c190-0x73d5c1cf] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] e820: update [mem 0x73d6f190-0x73d6fd98] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000008efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000073d4c18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d4c190-0x0000000073d5c1cf] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d5c1d0-0x0000000073d6f18f] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6f190-0x0000000073d6fd98] usable
[    0.000000] reserve setup_data: [mem 0x0000000073d6fd99-0x000000008ad0ffff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ad10000-0x000000008ad52fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000008ad53000-0x000000008ad61fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ad62000-0x000000008ad8efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008ad8f000-0x000000008ae38fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008ae39000-0x000000008ae8efff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008ae8f000-0x000000008aed1fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008aed2000-0x000000008aefefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008aeff000-0x000000008af83fff] usable
[    0.000000] reserve setup_data: [mem 0x000000008af84000-0x000000008afeffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008aff0000-0x000000008affffff] usable
[    0.000000] reserve setup_data: [mem 0x000000008b000000-0x000000008f9fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffe10000-0x00000000ffe3ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000046f5fffff] usable
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=0x8ad8e000 ACPI 2.0=0x8ad8e014 SMBIOS=0x8ad11000 
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookPro11,1/Mac-189A3D4F975D5FFC, BIOS 432.60.3.0.0 10/27/2021
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2599.997 MHz processor
[    0.000115] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000118] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000126] last_pfn = 0x46f600 max_arch_pfn = 0x400000000
[    0.000212] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001095] last_pfn = 0x8b000 max_arch_pfn = 0x400000000
[    0.001142] Using GB pages for direct mapping
[    0.002200] Secure boot disabled
[    0.002201] RAMDISK: [mem 0x7076d000-0x70e8ffff]
[    0.002204] ACPI: Early table checksum verification disabled
[    0.002206] ACPI: RSDP 0x000000008AD8E014 000024 (v02 APPLE )
[    0.002211] ACPI: XSDT 0x000000008AD8E1C0 0000A4 (v01 APPLE  Apple00  00000000      01000013)
[    0.002216] ACPI: FACP 0x000000008AD8C000 0000F4 (v05 APPLE  Apple00  00000000 Loki 0000005F)
[    0.002221] ACPI: DSDT 0x000000008AD7F000 007681 (v03 APPLE  MacBookP 00110001 INTL 20100915)
[    0.002224] ACPI: FACS 0x000000008AD18000 000040
[    0.002227] ACPI: FACS 0x000000008AD18000 000040
[    0.002229] ACPI: HPET 0x000000008AD8B000 000038 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002232] ACPI: APIC 0x000000008AD8A000 0000BC (v02 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002235] ACPI: SBST 0x000000008AD88000 000030 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002238] ACPI: ECDT 0x000000008AD87000 000053 (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002241] ACPI: SSDT 0x000000008AD7E000 00010B (v01 APPLE  SataAhci 00001000 INTL 20100915)
[    0.002244] ACPI: SSDT 0x000000008AD7D000 000024 (v01 APPLE  SmcDppt  00001000 INTL 20100915)
[    0.002247] ACPI: SSDT 0x000000008AD7A000 000FE9 (v01 APPLE  SDUsbLpt 00001000 INTL 20100915)
[    0.002250] ACPI: SSDT 0x000000008AD76000 000032 (v01 APPLE  SsdtS3   00001000 INTL 20100915)
[    0.002254] ACPI: SSDT 0x000000008AD73000 0028B2 (v01 APPLE  PcieTbt  00001000 INTL 20100915)
[    0.002257] ACPI: SSDT 0x000000008AD66000 0000B8 (v01 APPLE  Sdxc     00001000 INTL 20100915)
[    0.002260] ACPI: SSDT 0x000000008AD65000 0003E0 (v01 APPLE  SaHdaCdc 00001000 INTL 20100915)
[    0.002263] ACPI: SSDT 0x000000008AD64000 000594 (v01 PmRef  Cpu0Ist  00003000 INTL 20100915)
[    0.002266] ACPI: SSDT 0x000000008AD63000 000B83 (v01 PmRef  CpuPm    00003000 INTL 20100915)
[    0.002269] ACPI: DMAR 0x000000008AD62000 000088 (v01 APPLE  HSW      00000001 AAPL 00000001)
[    0.002272] ACPI: MCFG 0x000000008AD89000 00003C (v01 APPLE  Apple00  00000001 Loki 0000005F)
[    0.002274] ACPI: Reserving FACP table memory at [mem 0x8ad8c000-0x8ad8c0f3]
[    0.002276] ACPI: Reserving DSDT table memory at [mem 0x8ad7f000-0x8ad86680]
[    0.002278] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002279] ACPI: Reserving FACS table memory at [mem 0x8ad18000-0x8ad1803f]
[    0.002280] ACPI: Reserving HPET table memory at [mem 0x8ad8b000-0x8ad8b037]
[    0.002281] ACPI: Reserving APIC table memory at [mem 0x8ad8a000-0x8ad8a0bb]
[    0.002282] ACPI: Reserving SBST table memory at [mem 0x8ad88000-0x8ad8802f]
[    0.002283] ACPI: Reserving ECDT table memory at [mem 0x8ad87000-0x8ad87052]
[    0.002285] ACPI: Reserving SSDT table memory at [mem 0x8ad7e000-0x8ad7e10a]
[    0.002286] ACPI: Reserving SSDT table memory at [mem 0x8ad7d000-0x8ad7d023]
[    0.002287] ACPI: Reserving SSDT table memory at [mem 0x8ad7a000-0x8ad7afe8]
[    0.002288] ACPI: Reserving SSDT table memory at [mem 0x8ad76000-0x8ad76031]
[    0.002289] ACPI: Reserving SSDT table memory at [mem 0x8ad73000-0x8ad758b1]
[    0.002290] ACPI: Reserving SSDT table memory at [mem 0x8ad66000-0x8ad660b7]
[    0.002292] ACPI: Reserving SSDT table memory at [mem 0x8ad65000-0x8ad653df]
[    0.002293] ACPI: Reserving SSDT table memory at [mem 0x8ad64000-0x8ad64593]
[    0.002294] ACPI: Reserving SSDT table memory at [mem 0x8ad63000-0x8ad63b82]
[    0.002295] ACPI: Reserving DMAR table memory at [mem 0x8ad62000-0x8ad62087]
[    0.002296] ACPI: Reserving MCFG table memory at [mem 0x8ad89000-0x8ad8903b]
[    0.002302] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.002323] Zone ranges:
[    0.002324]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002326]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002328]   Normal   [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002329] Movable zone start for each node
[    0.002330] Early memory node ranges
[    0.002331]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.002333]   node   0: [mem 0x0000000000059000-0x000000000008efff]
[    0.002334]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.002335]   node   0: [mem 0x0000000000100000-0x000000008ad0ffff]
[    0.002336]   node   0: [mem 0x000000008ad53000-0x000000008ad61fff]
[    0.002337]   node   0: [mem 0x000000008ad8f000-0x000000008ae38fff]
[    0.002339]   node   0: [mem 0x000000008ae8f000-0x000000008aed1fff]
[    0.002340]   node   0: [mem 0x000000008aeff000-0x000000008af83fff]
[    0.002340]   node   0: [mem 0x000000008aff0000-0x000000008affffff]
[    0.002341]   node   0: [mem 0x0000000100000000-0x000000046f5fffff]
[    0.002344] Initmem setup node 0 [mem 0x0000000000001000-0x000000046f5fffff]
[    0.002348] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002350] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002351] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002375] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.006131] On node 0, zone DMA32: 67 pages in unavailable ranges
[    0.006137] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006139] On node 0, zone DMA32: 86 pages in unavailable ranges
[    0.006142] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.006144] On node 0, zone DMA32: 108 pages in unavailable ranges
[    0.030224] On node 0, zone Normal: 20480 pages in unavailable ranges
[    0.030257] On node 0, zone Normal: 2560 pages in unavailable ranges
[    0.030265] Reserving Intel graphics memory at [mem 0x8ba00000-0x8f9fffff]
[    0.030384] ACPI: PM-Timer IO Port: 0x1808
[    0.030391] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030393] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030394] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030395] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030396] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030397] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030398] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030399] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030409] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.030412] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030415] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030418] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030420] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030423] TSC deadline timer available
[    0.030424] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.030446] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030448] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.030451] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.030453] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
[    0.030454] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.030456] PM: hibernation: Registered nosave memory: [mem 0x73d4c000-0x73d4cfff]
[    0.030458] PM: hibernation: Registered nosave memory: [mem 0x73d5c000-0x73d5cfff]
[    0.030460] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030462] PM: hibernation: Registered nosave memory: [mem 0x73d6f000-0x73d6ffff]
[    0.030464] PM: hibernation: Registered nosave memory: [mem 0x8ad10000-0x8ad52fff]
[    0.030466] PM: hibernation: Registered nosave memory: [mem 0x8ad62000-0x8ad8efff]
[    0.030468] PM: hibernation: Registered nosave memory: [mem 0x8ae39000-0x8ae8efff]
[    0.030470] PM: hibernation: Registered nosave memory: [mem 0x8aed2000-0x8aefefff]
[    0.030473] PM: hibernation: Registered nosave memory: [mem 0x8af84000-0x8afeffff]
[    0.030475] PM: hibernation: Registered nosave memory: [mem 0x8b000000-0x8f9fffff]
[    0.030476] PM: hibernation: Registered nosave memory: [mem 0x8fa00000-0xe00f7fff]
[    0.030477] PM: hibernation: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.030478] PM: hibernation: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff]
[    0.030479] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.030480] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xffe0ffff]
[    0.030481] PM: hibernation: Registered nosave memory: [mem 0xffe10000-0xffe3ffff]
[    0.030482] PM: hibernation: Registered nosave memory: [mem 0xffe40000-0xffffffff]
[    0.030484] [mem 0x8fa00000-0xe00f7fff] available for PCI devices
[    0.030488] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.030494] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.030677] percpu: Embedded 52 pages/cpu s173096 r8192 d31704 u524288
[    0.030685] pcpu-alloc: s173096 r8192 d31704 u524288 alloc=1*2097152
[    0.030688] pcpu-alloc: [0] 0 1 2 3 
[    0.030709] Built 1 zonelists, mobility grouping on.  Total pages: 4105486
[    0.030711] Kernel command line: ro root=UUID=c500d66c-50ec-42a2-a333-eb48d6c9d97b thunderbolt.dyndbg initrd=boot\initrd.img-5.17.0+
[    0.031577] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.031994] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.032035] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.080035] Memory: 15923600K/16683256K available (10248K kernel code, 2251K rwdata, 2740K rodata, 996K init, 740K bss, 759396K reserved, 0K cma-reserved)
[    0.080068] random: get_random_u64 called from cache_random_seq_create+0x63/0x150 with crng_init=0
[    0.080136] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.080771] Dynamic Preempt: voluntary
[    0.080797] rcu: Preemptible hierarchical RCU implementation.
[    0.080799] 	Trampoline variant of Tasks RCU enabled.
[    0.080800] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.081771] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.081996] Console: colour dummy device 80x25
[    0.082323] printk: console [tty0] enabled
[    0.082332] ACPI: Core revision 20211217
[    0.082431] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.082434] APIC: Switch to symmetric I/O mode setup
[    0.082437] DMAR: Host address width 39
[    0.082439] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.082445] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.082449] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.082455] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.082458] DMAR: RMRR base: 0x0000008b800000 end: 0x0000008f9fffff
[    0.082462] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.082465] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.083061] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.083550] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257a391c223, max_idle_ns: 440795220104 ns
[    0.083559] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.99 BogoMIPS (lpj=25999970)
[    0.083564] pid_max: default: 32768 minimum: 301
[    0.093556] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093556] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.093556] CPU0: Thermal monitoring enabled (TM1)
[    0.093556] process: using mwait in idle threads
[    0.093556] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.093556] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.093556] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.093556] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.093556] Spectre V2 : Vulnerable
[    0.093556] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.093556] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.093556] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.093556] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.093556] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.093556] SRBDS: Mitigation: Microcode
[    0.093556] MDS: Mitigation: Clear CPU buffers
[    0.093556] Freeing SMP alternatives memory: 28K
[    0.093556] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1220
[    0.093556] smpboot: CPU0: Intel(R) Core(TM) i5-4278U CPU @ 2.60GHz (family: 0x6, model: 0x45, stepping: 0x1)
[    0.093556] cblist_init_generic: Setting adjustable number of callback queues.
[    0.093556] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.093556] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.093556] ... version:                3
[    0.093556] ... bit width:              48
[    0.093556] ... generic registers:      4
[    0.093556] ... value mask:             0000ffffffffffff
[    0.093556] ... max period:             00007fffffffffff
[    0.093556] ... fixed-purpose events:   3
[    0.093556] ... event mask:             000000070000000f
[    0.093556] rcu: Hierarchical SRCU implementation.
[    0.093556] smp: Bringing up secondary CPUs ...
[    0.093556] x86: Booting SMP configuration:
[    0.093556] .... node  #0, CPUs:      #1 #2
[    0.093556] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.093556]  #3
[    0.093556] smp: Brought up 1 node, 4 CPUs
[    0.093556] smpboot: Max logical packages: 1
[    0.093556] smpboot: Total of 4 processors activated (20799.97 BogoMIPS)
[    0.093556] devtmpfs: initialized
[    0.093556] ACPI: PM: Registering ACPI NVS region [mem 0x8ad10000-0x8ad52fff] (274432 bytes)
[    0.093556] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.093556] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.093556] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.093556] thermal_sys: Registered thermal governor 'step_wise'
[    0.093556] thermal_sys: Registered thermal governor 'user_space'
[    0.093556] cpuidle: using governor ladder
[    0.093556] cpuidle: using governor menu
[    0.093556] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.093556] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.093556] PCI: not using MMCONFIG
[    0.093556] PCI: Using configuration type 1 for base access
[    0.093556] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.093556] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.093556] cryptd: max_cpu_qlen set to 1000
[    0.093556] ACPI: Disabled all _OSI OS vendors
[    0.093556] ACPI: Added _OSI(Module Device)
[    0.093556] ACPI: Added _OSI(Processor Device)
[    0.093556] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.093556] ACPI: Added _OSI(Processor Aggregator Device)
[    0.093556] ACPI: Added _OSI(Linux-Dell-Video)
[    0.093556] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.093556] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.093556] ACPI: Added _OSI(Darwin)
[    0.095344] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.095710] ACPI: EC: EC started
[    0.095713] ACPI: EC: interrupt blocked
[    0.097071] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.097074] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.097259] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.097574] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.097610] ACPI Error: Needed type [Reference], found [Integer] 000000008f49646e (20211217/exresop-69)
[    0.097610] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20211217/dswexec-434)
[    0.097610] ACPI Error: Aborting method \_PR.CPU0._PDC due to previous error (AE_AML_OPERAND_TYPE) (20211217/psparse-531)
[    0.097610] ACPI: Dynamic OEM Table Load:
[    0.097610] ACPI: SSDT 0xFFFF9D0500AF1000 00067C (v01 PmRef  ApIst    00003000 INTL 20100915)
[    0.097610] ACPI: Dynamic OEM Table Load:
[    0.097610] ACPI: SSDT 0xFFFF9D0500C8F200 000119 (v01 PmRef  ApCst    00003000 INTL 20100915)
[    0.097610] ACPI: Interpreter enabled
[    0.097610] ACPI: PM: (supports S0 S3 S4 S5)
[    0.097610] ACPI: Using IOAPIC for interrupt routing
[    0.097610] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.097610] PCI: MMCONFIG at [mem 0xe0000000-0xe9bfffff] reserved in ACPI motherboard resources
[    0.097610] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.097610] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.107469] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.107476] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SHPCHotplug AER PCIeCapability LTR DPC]
[    0.107482] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-9b] only partially covers this bridge
[    0.107639] PCI host bridge to bus 0000:00
[    0.107642] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.107645] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.107648] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.107651] pci_bus 0000:00: root bus resource [mem 0x8fa00000-0xfeafffff window]
[    0.107654] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.107658] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.107669] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.107748] pci 0000:00:02.0: [8086:0a2e] type 00 class 0x030000
[    0.107757] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 64bit]
[    0.107764] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff 64bit pref]
[    0.107770] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    0.107781] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.107785] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.107875] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.107884] pci 0000:00:03.0: reg 0x10: [mem 0xb0c10000-0xb0c13fff 64bit]
[    0.107999] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.108014] pci 0000:00:14.0: reg 0x10: [mem 0xb0c00000-0xb0c0ffff 64bit]
[    0.108065] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.108247] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.108266] pci 0000:00:16.0: reg 0x10: [mem 0xb0c2a100-0xb0c2a11f 64bit]
[    0.108327] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.108378] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.108394] pci 0000:00:1b.0: reg 0x10: [mem 0xb0c14000-0xb0c17fff 64bit]
[    0.108454] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.108513] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.108572] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.108589] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.108592] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.108682] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    0.108749] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.108765] pci 0000:00:1c.1: Enabling MPC IRBNCE
[    0.108768] pci 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[    0.108858] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    0.108924] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.108940] pci 0000:00:1c.2: Enabling MPC IRBNCE
[    0.108943] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[    0.109031] pci 0000:00:1c.4: [8086:9c18] type 01 class 0x060400
[    0.109096] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.109112] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.109115] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.109211] pci 0000:00:1c.5: [8086:9c1a] type 01 class 0x060400
[    0.109277] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.109293] pci 0000:00:1c.5: Enabling MPC IRBNCE
[    0.109295] pci 0000:00:1c.5: Intel PCH root port ACS workaround enabled
[    0.109389] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.109538] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.109554] pci 0000:00:1f.3: reg 0x10: [mem 0xb0c2a000-0xb0c2a0ff 64bit]
[    0.109572] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.109654] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.109713] pci 0000:02:00.0: [14e4:1570] type 00 class 0x048000
[    0.109736] pci 0000:02:00.0: reg 0x10: [mem 0xb0b00000-0xb0b0ffff 64bit]
[    0.109752] pci 0000:02:00.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.109768] pci 0000:02:00.0: reg 0x20: [mem 0xb0a00000-0xb0afffff 64bit]
[    0.109862] pci 0000:02:00.0: supports D1
[    0.109864] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.109967] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.109973] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.109978] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.110038] pci 0000:03:00.0: [14e4:43ba] type 00 class 0x028000
[    0.110061] pci 0000:03:00.0: reg 0x10: [mem 0xb0800000-0xb0807fff 64bit]
[    0.110076] pci 0000:03:00.0: reg 0x18: [mem 0xb0400000-0xb07fffff 64bit]
[    0.110197] pci 0000:03:00.0: supports D1 D2
[    0.110200] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.110342] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.110348] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.110412] pci 0000:05:00.0: [8086:156d] type 01 class 0x060400
[    0.110466] pci 0000:05:00.0: enabling Extended Tags
[    0.110548] pci 0000:05:00.0: supports D1 D2
[    0.110550] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133583] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.133589] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.133593] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.133599] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.133703] pci 0000:06:00.0: [8086:156d] type 01 class 0x060400
[    0.133761] pci 0000:06:00.0: enabling Extended Tags
[    0.133845] pci 0000:06:00.0: supports D1 D2
[    0.133847] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.133958] pci 0000:06:03.0: [8086:156d] type 01 class 0x060400
[    0.134016] pci 0000:06:03.0: enabling Extended Tags
[    0.134099] pci 0000:06:03.0: supports D1 D2
[    0.134101] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134209] pci 0000:06:04.0: [8086:156d] type 01 class 0x060400
[    0.134258] pci 0000:06:04.0: enabling Extended Tags
[    0.134345] pci 0000:06:04.0: supports D1 D2
[    0.134347] pci 0000:06:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134450] pci 0000:06:05.0: [8086:156d] type 01 class 0x060400
[    0.134500] pci 0000:06:05.0: enabling Extended Tags
[    0.134587] pci 0000:06:05.0: supports D1 D2
[    0.134589] pci 0000:06:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134693] pci 0000:06:06.0: [8086:156d] type 01 class 0x060400
[    0.134742] pci 0000:06:06.0: enabling Extended Tags
[    0.134828] pci 0000:06:06.0: supports D1 D2
[    0.134830] pci 0000:06:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.134940] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.134948] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.134952] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.134960] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.135036] pci 0000:07:00.0: [8086:156c] type 00 class 0x088000
[    0.135059] pci 0000:07:00.0: reg 0x10: [mem 0xb0d00000-0xb0d3ffff]
[    0.135073] pci 0000:07:00.0: reg 0x14: [mem 0xb0d40000-0xb0d40fff]
[    0.135140] pci 0000:07:00.0: enabling Extended Tags
[    0.135250] pci 0000:07:00.0: supports D1 D2
[    0.135252] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.163593] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.163604] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.163723] pci 0000:08:00.0: [8086:1513] type 01 class 0x060400
[    0.163827] pci 0000:08:00.0: enabling Extended Tags
[    0.163983] pci 0000:08:00.0: supports D1 D2
[    0.163985] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.193591] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.193600] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.193605] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.193612] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.193703] acpiphp: Slot [1] registered
[    0.193728] acpiphp: Slot [2] registered
[    0.193752] acpiphp: Slot [3] registered
[    0.193775] acpiphp: Slot [4] registered
[    0.193799] acpiphp: Slot [5] registered
[    0.193854] pci 0000:09:00.0: [8086:1513] type 01 class 0x060400
[    0.193964] pci 0000:09:00.0: enabling Extended Tags
[    0.194123] pci 0000:09:00.0: supports D1 D2
[    0.194125] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194298] pci 0000:09:01.0: [8086:1513] type 01 class 0x060400
[    0.194408] pci 0000:09:01.0: enabling Extended Tags
[    0.194567] pci 0000:09:01.0: supports D1 D2
[    0.194569] pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.194724] pci 0000:09:02.0: [8086:1513] type 01 class 0x060400
[    0.194834] pci 0000:09:02.0: enabling Extended Tags
[    0.194992] pci 0000:09:02.0: supports D1 D2
[    0.194994] pci 0000:09:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195155] pci 0000:09:04.0: [8086:1513] type 01 class 0x060400
[    0.195265] pci 0000:09:04.0: enabling Extended Tags
[    0.195426] pci 0000:09:04.0: supports D1 D2
[    0.195428] pci 0000:09:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.195602] pci 0000:09:05.0: [8086:1513] type 01 class 0x060400
[    0.195697] pci 0000:09:05.0: enabling Extended Tags
[    0.195858] pci 0000:09:05.0: supports D1 D2
[    0.195860] pci 0000:09:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.196049] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.196067] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.196079] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.196171] acpiphp: Slot [1-1] registered
[    0.196229] pci 0000:0a:00.0: [12d8:400c] type 01 class 0x060400
[    0.196586] pci 0000:0a:00.0: supports D1 D2
[    0.196588] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.223598] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.223617] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.223790] pci 0000:0b:03.0: [12d8:400c] type 01 class 0x060400
[    0.224101] pci 0000:0b:03.0: supports D1 D2
[    0.224103] pci 0000:0b:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224298] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.224321] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.224479] pci 0000:0c:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.224527] pci 0000:0c:00.0: reg 0x10: [mem 0xb1101000-0xb1101fff]
[    0.224816] pci 0000:0c:00.0: supports D1 D2
[    0.224818] pci 0000:0c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.224968] pci 0000:0c:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.225015] pci 0000:0c:00.1: reg 0x10: [mem 0xb1100000-0xb1100fff]
[    0.225304] pci 0000:0c:00.1: supports D1 D2
[    0.225307] pci 0000:0c:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.225432] pci 0000:0c:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.225479] pci 0000:0c:00.2: reg 0x10: [mem 0xb1102000-0xb11020ff]
[    0.225767] pci 0000:0c:00.2: supports D1 D2
[    0.225769] pci 0000:0c:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.226010] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.226033] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.226196] pci 0000:0d:00.0: [14e4:16b0] type 00 class 0x020000
[    0.226260] pci 0000:0d:00.0: reg 0x10: [mem 0xbd300000-0xbd30ffff 64bit pref]
[    0.226303] pci 0000:0d:00.0: reg 0x18: [mem 0xbd310000-0xbd31ffff 64bit pref]
[    0.226616] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.253614] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.253642] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.253754] pci 0000:0e:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.253818] pci 0000:0e:00.0: reg 0x10: [mem 0xb1000000-0xb1000fff 64bit]
[    0.254144] pci 0000:0e:00.0: supports D1 D2
[    0.254146] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.283613] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.283631] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.283807] pci 0000:0f:00.0: [8086:1513] type 01 class 0x060400
[    0.283965] pci 0000:0f:00.0: enabling Extended Tags
[    0.284202] pci 0000:0f:00.0: supports D1 D2
[    0.284204] pci 0000:0f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.313604] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.313622] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.313635] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.313758] acpiphp: Slot [1-2] registered
[    0.313784] acpiphp: Slot [2-1] registered
[    0.313810] acpiphp: Slot [3-1] registered
[    0.313835] acpiphp: Slot [4-1] registered
[    0.313917] pci 0000:10:00.0: [8086:1513] type 01 class 0x060400
[    0.314082] pci 0000:10:00.0: enabling Extended Tags
[    0.314324] pci 0000:10:00.0: supports D1 D2
[    0.314326] pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.314569] pci 0000:10:01.0: [8086:1513] type 01 class 0x060400
[    0.314734] pci 0000:10:01.0: enabling Extended Tags
[    0.314974] pci 0000:10:01.0: supports D1 D2
[    0.314976] pci 0000:10:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315203] pci 0000:10:02.0: [8086:1513] type 01 class 0x060400
[    0.315368] pci 0000:10:02.0: enabling Extended Tags
[    0.315608] pci 0000:10:02.0: supports D1 D2
[    0.315610] pci 0000:10:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.315841] pci 0000:10:04.0: [8086:1513] type 01 class 0x060400
[    0.315983] pci 0000:10:04.0: enabling Extended Tags
[    0.316227] pci 0000:10:04.0: supports D1 D2
[    0.316229] pci 0000:10:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316475] pci 0000:10:05.0: [8086:1513] type 01 class 0x060400
[    0.316617] pci 0000:10:05.0: enabling Extended Tags
[    0.316861] pci 0000:10:05.0: supports D1 D2
[    0.316863] pci 0000:10:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.317133] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.317159] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.317176] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.317294] acpiphp: Slot [1-3] registered
[    0.317373] pci 0000:11:00.0: [12d8:400c] type 01 class 0x060400
[    0.317862] pci 0000:11:00.0: supports D1 D2
[    0.317864] pci 0000:11:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.318147] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.318173] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.318408] pci 0000:12:03.0: [12d8:400c] type 01 class 0x060400
[    0.318831] pci 0000:12:03.0: supports D1 D2
[    0.318833] pci 0000:12:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319089] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.319120] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.319333] pci 0000:13:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.319397] pci 0000:13:00.0: reg 0x10: [mem 0xb0f01000-0xb0f01fff]
[    0.319791] pci 0000:13:00.0: supports D1 D2
[    0.319793] pci 0000:13:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.319996] pci 0000:13:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.320060] pci 0000:13:00.1: reg 0x10: [mem 0xb0f00000-0xb0f00fff]
[    0.320454] pci 0000:13:00.1: supports D1 D2
[    0.320456] pci 0000:13:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.320617] pci 0000:13:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.320681] pci 0000:13:00.2: reg 0x10: [mem 0xb0f02000-0xb0f020ff]
[    0.321077] pci 0000:13:00.2: supports D1 D2
[    0.321079] pci 0000:13:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.321414] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.321445] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.321670] pci 0000:14:00.0: [14e4:16b0] type 00 class 0x020000
[    0.321756] pci 0000:14:00.0: reg 0x10: [mem 0xbd200000-0xbd20ffff 64bit pref]
[    0.321813] pci 0000:14:00.0: reg 0x18: [mem 0xbd210000-0xbd21ffff 64bit pref]
[    0.322239] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.322557] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.322597] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.322752] pci 0000:15:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.322838] pci 0000:15:00.0: reg 0x10: [mem 0xb0e00000-0xb0e00fff 64bit]
[    0.323278] pci 0000:15:00.0: supports D1 D2
[    0.323280] pci 0000:15:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.323574] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.323600] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.323738] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.323872] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.324074] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.324224] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.324294] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.324302] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.324307] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.324314] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.324357] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.324457] pci 0000:04:00.0: [1c5c:174a] type 00 class 0x010802
[    0.324482] pci 0000:04:00.0: reg 0x10: [mem 0xb0900000-0xb0903fff 64bit]
[    0.324493] pci 0000:04:00.0: reg 0x18: [mem 0xb0905000-0xb0905fff]
[    0.324505] pci 0000:04:00.0: reg 0x1c: [mem 0xb0904000-0xb0904fff]
[    0.324658] pci 0000:04:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:1c.5 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.324864] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.324870] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.324895] pci_bus 0000:00: on NUMA node 0
[    0.325635] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.325638] ACPI: PCI: Interrupt link LNKA disabled
[    0.325672] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.325674] ACPI: PCI: Interrupt link LNKB disabled
[    0.325706] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.325708] ACPI: PCI: Interrupt link LNKC disabled
[    0.325739] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.325742] ACPI: PCI: Interrupt link LNKD disabled
[    0.325773] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.325775] ACPI: PCI: Interrupt link LNKE disabled
[    0.325807] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.325809] ACPI: PCI: Interrupt link LNKF disabled
[    0.325841] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.325843] ACPI: PCI: Interrupt link LNKG disabled
[    0.325874] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.325877] ACPI: PCI: Interrupt link LNKH disabled
[    0.326025] ACPI: EC: interrupt unblocked
[    0.326028] ACPI: EC: event unblocked
[    0.326036] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.326040] ACPI: EC: GPE=0x4e
[    0.326043] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.326048] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
[    0.326104] iommu: Default domain type: Translated 
[    0.326107] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.326149] SCSI subsystem initialized
[    0.326156] libata version 3.00 loaded.
[    0.326213] Registered efivars operations
[    0.326317] PCI: Using ACPI for IRQ routing
[    0.331529] PCI: pci_cache_line_size set to 64 bytes
[    0.331778] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.331780] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.331781] e820: reserve RAM buffer [mem 0x73d4c190-0x73ffffff]
[    0.331782] e820: reserve RAM buffer [mem 0x73d6f190-0x73ffffff]
[    0.331783] e820: reserve RAM buffer [mem 0x8ad10000-0x8bffffff]
[    0.331785] e820: reserve RAM buffer [mem 0x8ad62000-0x8bffffff]
[    0.331787] e820: reserve RAM buffer [mem 0x8ae39000-0x8bffffff]
[    0.331788] e820: reserve RAM buffer [mem 0x8aed2000-0x8bffffff]
[    0.331789] e820: reserve RAM buffer [mem 0x8af84000-0x8bffffff]
[    0.331790] e820: reserve RAM buffer [mem 0x8b000000-0x8bffffff]
[    0.331791] e820: reserve RAM buffer [mem 0x46f600000-0x46fffffff]
[    0.331806] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.331806] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.331806] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.331806] vgaarb: loaded
[    0.331806] clocksource: Switched to clocksource tsc-early
[    0.331806] pnp: PnP ACPI init
[    0.331806] system 00:00: [mem 0xfed00000-0xfed03fff] has been reserved
[    0.331806] system 00:01: [io  0xffff] has been reserved
[    0.331806] system 00:01: [io  0x1800-0x187f] has been reserved
[    0.331806] system 00:01: [io  0x0800-0x087f] has been reserved
[    0.331806] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.331806] system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.331806] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.331806] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.331806] system 00:03: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.331806] system 00:03: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.331806] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.331806] system 00:03: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.331806] system 00:03: [mem 0xff000000-0xffffffff] could not be reserved
[    0.331806] system 00:03: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.331806] system 00:04: [mem 0x20000000-0x201fffff] could not be reserved
[    0.331806] system 00:04: [mem 0x40000000-0x401fffff] could not be reserved
[    0.331806] pnp: PnP ACPI: found 5 devices
[    0.331806] pci 0000:00:02.0: assigning 3 device properties
[    0.331806] pci 0000:07:00.0: assigning 9 device properties
[    0.331806] pci 0000:08:00.0: assigning 3 device properties
[    0.331806] pci 0000:0f:00.0: assigning 3 device properties
[    0.331806] pci 0000:0e:00.0: assigning 2 device properties
[    0.331806] pci 0000:15:00.0: assigning 2 device properties
[    0.331806] pci 0000:00:1b.0: assigning 4 device properties
[    0.335638] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.335677] NET: Registered PF_INET protocol family
[    0.335841] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.338524] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.338559] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.338782] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.338926] TCP: Hash tables configured (established 131072 bind 65536)
[    0.338956] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.338999] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.339068] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.339143] RPC: Registered named UNIX socket transport module.
[    0.339147] RPC: Registered udp transport module.
[    0.339151] RPC: Registered tcp transport module.
[    0.339154] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.339166] pci 0000:06:00.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.339174] pci 0000:06:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 07] add_size 200000 add_align 100000
[    0.339188] pci 0000:10:04.0: bridge window [io  0x1000-0x0fff] to [bus 16] add_size 1000
[    0.339194] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 16] add_size 200000 add_align 100000
[    0.339202] pci 0000:10:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 16] add_size 200000 add_align 100000
[    0.339210] pci 0000:10:05.0: bridge window [io  0x1000-0x0fff] to [bus 17] add_size 1000
[    0.339216] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 17] add_size 200000 add_align 100000
[    0.339224] pci 0000:10:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 17] add_size 200000 add_align 100000
[    0.339232] pci 0000:0f:00.0: bridge window [io  0x1000-0x0fff] to [bus 10-17] add_size 2000
[    0.339239] pci 0000:09:04.0: bridge window [io  0x1000-0x0fff] to [bus 0f-17] add_size 3000
[    0.339246] pci 0000:09:05.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.339252] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.339259] pci 0000:09:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.339268] pci 0000:08:00.0: bridge window [io  0x1000-0x0fff] to [bus 09-18] add_size 4000
[    0.339276] pci 0000:06:04.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    0.339282] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
[    0.339289] pci 0000:06:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 39] add_size 200000 add_align 100000
[    0.339297] pci 0000:06:06.0: bridge window [io  0x1000-0x0fff] to [bus 6b] add_size 1000
[    0.339303] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6b] add_size 200000 add_align 100000
[    0.339311] pci 0000:06:06.0: bridge window [mem 0x00100000-0x000fffff] to [bus 6b] add_size 200000 add_align 100000
[    0.339323] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.339337] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.339344] pci 0000:00:1c.1:   bridge window [mem 0xb0a00000-0xb0bfffff]
[    0.339350] pci 0000:00:1c.1:   bridge window [mem 0x90000000-0x9fffffff 64bit pref]
[    0.339360] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.339366] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb08fffff]
[    0.339382] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339389] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339395] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339400] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339407] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339413] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339419] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339424] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339430] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339435] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339441] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339446] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339451] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339456] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339461] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339465] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339471] pci 0000:06:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.339476] pci 0000:06:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339482] pci 0000:06:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339488] pci 0000:06:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339494] pci 0000:06:06.0: BAR 7: no space for [io  size 0x1000]
[    0.339498] pci 0000:06:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339503] pci 0000:06:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339508] pci 0000:06:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339514] pci 0000:06:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339519] pci 0000:06:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339525] pci 0000:06:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339530] pci 0000:06:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339536] pci 0000:06:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339542] pci 0000:06:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339548] pci 0000:06:00.0: BAR 7: no space for [io  size 0x1000]
[    0.339553] pci 0000:06:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339558] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.339566] pci 0000:06:00.0:   bridge window [mem 0xb0d00000-0xb0dfffff]
[    0.339580] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339585] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339590] pci 0000:08:00.0: BAR 7: no space for [io  size 0x4000]
[    0.339594] pci 0000:08:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.339601] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339606] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339612] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339618] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339624] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339629] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339633] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339638] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339643] pci 0000:09:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339648] pci 0000:09:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339654] pci 0000:09:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339660] pci 0000:09:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339666] pci 0000:09:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339670] pci 0000:09:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339675] pci 0000:09:04.0: BAR 7: no space for [io  size 0x3000]
[    0.339680] pci 0000:09:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.339686] pci 0000:0b:03.0: PCI bridge to [bus 0c]
[    0.339701] pci 0000:0b:03.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339727] pci 0000:0a:00.0: PCI bridge to [bus 0b-0c]
[    0.339742] pci 0000:0a:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339768] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[    0.339780] pci 0000:09:00.0:   bridge window [mem 0xb1100000-0xb11fffff]
[    0.339801] pci 0000:09:01.0: PCI bridge to [bus 0d]
[    0.339818] pci 0000:09:01.0:   bridge window [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.339834] pci 0000:09:02.0: PCI bridge to [bus 0e]
[    0.339846] pci 0000:09:02.0:   bridge window [mem 0xb1000000-0xb10fffff]
[    0.339867] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339872] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339877] pci 0000:0f:00.0: BAR 7: no space for [io  size 0x2000]
[    0.339882] pci 0000:0f:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.339889] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339894] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339900] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339906] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339912] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339917] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339923] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339928] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339934] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.339939] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339944] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339948] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339954] pci 0000:10:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.339959] pci 0000:10:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339965] pci 0000:10:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.339971] pci 0000:10:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.339977] pci 0000:10:05.0: BAR 7: no space for [io  size 0x1000]
[    0.339981] pci 0000:10:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.339986] pci 0000:10:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.339991] pci 0000:10:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.339997] pci 0000:10:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.340002] pci 0000:10:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.340008] pci 0000:10:04.0: BAR 7: no space for [io  size 0x1000]
[    0.340013] pci 0000:10:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.340019] pci 0000:12:03.0: PCI bridge to [bus 13]
[    0.340038] pci 0000:12:03.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340072] pci 0000:11:00.0: PCI bridge to [bus 12-13]
[    0.340091] pci 0000:11:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340124] pci 0000:10:00.0: PCI bridge to [bus 11-13]
[    0.340140] pci 0000:10:00.0:   bridge window [mem 0xb0f00000-0xb0ffffff]
[    0.340169] pci 0000:10:01.0: PCI bridge to [bus 14]
[    0.340193] pci 0000:10:01.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340214] pci 0000:10:02.0: PCI bridge to [bus 15]
[    0.340230] pci 0000:10:02.0:   bridge window [mem 0xb0e00000-0xb0efffff]
[    0.340258] pci 0000:10:04.0: PCI bridge to [bus 16]
[    0.340297] pci 0000:10:05.0: PCI bridge to [bus 17]
[    0.340336] pci 0000:0f:00.0: PCI bridge to [bus 10-17]
[    0.340352] pci 0000:0f:00.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340365] pci 0000:0f:00.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340386] pci 0000:09:04.0: PCI bridge to [bus 0f-17]
[    0.340398] pci 0000:09:04.0:   bridge window [mem 0xb0e00000-0xb0ffffff]
[    0.340408] pci 0000:09:04.0:   bridge window [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340424] pci 0000:09:05.0: PCI bridge to [bus 18]
[    0.340452] pci 0000:08:00.0: PCI bridge to [bus 09-18]
[    0.340464] pci 0000:08:00.0:   bridge window [mem 0xb0e00000-0xb11fffff]
[    0.340474] pci 0000:08:00.0:   bridge window [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340490] pci 0000:06:03.0: PCI bridge to [bus 08-38]
[    0.340496] pci 0000:06:03.0:   bridge window [io  0x3000-0x3fff]
[    0.340504] pci 0000:06:03.0:   bridge window [mem 0xb0e00000-0xb51fffff]
[    0.340512] pci 0000:06:03.0:   bridge window [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340523] pci 0000:06:04.0: PCI bridge to [bus 39]
[    0.340539] pci 0000:06:05.0: PCI bridge to [bus 3a-6a]
[    0.340545] pci 0000:06:05.0:   bridge window [io  0x4000-0x4fff]
[    0.340553] pci 0000:06:05.0:   bridge window [mem 0xb5200000-0xb91fffff]
[    0.340561] pci 0000:06:05.0:   bridge window [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340572] pci 0000:06:06.0: PCI bridge to [bus 6b]
[    0.340588] pci 0000:05:00.0: PCI bridge to [bus 06-6b]
[    0.340594] pci 0000:05:00.0:   bridge window [io  0x3000-0x4fff]
[    0.340602] pci 0000:05:00.0:   bridge window [mem 0xb0d00000-0xb91fffff]
[    0.340610] pci 0000:05:00.0:   bridge window [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340621] pci 0000:00:1c.4: PCI bridge to [bus 05-6b]
[    0.340626] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    0.340633] pci 0000:00:1c.4:   bridge window [mem 0xb0d00000-0xbd1fffff]
[    0.340639] pci 0000:00:1c.4:   bridge window [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340649] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.340655] pci 0000:00:1c.5:   bridge window [mem 0xb0900000-0xb09fffff]
[    0.340666] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.340671] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.340676] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.340681] pci_bus 0000:00: resource 7 [mem 0x8fa00000-0xfeafffff window]
[    0.340687] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff window]
[    0.340692] pci_bus 0000:02: resource 1 [mem 0xb0a00000-0xb0bfffff]
[    0.340697] pci_bus 0000:02: resource 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.340703] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb08fffff]
[    0.340708] pci_bus 0000:05: resource 0 [io  0x3000-0x5fff]
[    0.340713] pci_bus 0000:05: resource 1 [mem 0xb0d00000-0xbd1fffff]
[    0.340718] pci_bus 0000:05: resource 2 [mem 0xbd200000-0xc93fffff 64bit pref]
[    0.340724] pci_bus 0000:06: resource 0 [io  0x3000-0x4fff]
[    0.340728] pci_bus 0000:06: resource 1 [mem 0xb0d00000-0xb91fffff]
[    0.340733] pci_bus 0000:06: resource 2 [mem 0xbd200000-0xc53fffff 64bit pref]
[    0.340739] pci_bus 0000:07: resource 1 [mem 0xb0d00000-0xb0dfffff]
[    0.340744] pci_bus 0000:08: resource 0 [io  0x3000-0x3fff]
[    0.340748] pci_bus 0000:08: resource 1 [mem 0xb0e00000-0xb51fffff]
[    0.340753] pci_bus 0000:08: resource 2 [mem 0xbd200000-0xc13fffff 64bit pref]
[    0.340759] pci_bus 0000:09: resource 1 [mem 0xb0e00000-0xb11fffff]
[    0.340764] pci_bus 0000:09: resource 2 [mem 0xbd200000-0xbd3fffff 64bit pref]
[    0.340769] pci_bus 0000:0a: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340774] pci_bus 0000:0b: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340779] pci_bus 0000:0c: resource 1 [mem 0xb1100000-0xb11fffff]
[    0.340784] pci_bus 0000:0d: resource 2 [mem 0xbd300000-0xbd3fffff 64bit pref]
[    0.340790] pci_bus 0000:0e: resource 1 [mem 0xb1000000-0xb10fffff]
[    0.340795] pci_bus 0000:0f: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340800] pci_bus 0000:0f: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340806] pci_bus 0000:10: resource 1 [mem 0xb0e00000-0xb0ffffff]
[    0.340811] pci_bus 0000:10: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340817] pci_bus 0000:11: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340822] pci_bus 0000:12: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340827] pci_bus 0000:13: resource 1 [mem 0xb0f00000-0xb0ffffff]
[    0.340832] pci_bus 0000:14: resource 2 [mem 0xbd200000-0xbd2fffff 64bit pref]
[    0.340838] pci_bus 0000:15: resource 1 [mem 0xb0e00000-0xb0efffff]
[    0.340843] pci_bus 0000:3a: resource 0 [io  0x4000-0x4fff]
[    0.340848] pci_bus 0000:3a: resource 1 [mem 0xb5200000-0xb91fffff]
[    0.340853] pci_bus 0000:3a: resource 2 [mem 0xc1400000-0xc53fffff 64bit pref]
[    0.340859] pci_bus 0000:04: resource 1 [mem 0xb0900000-0xb09fffff]
[    0.341255] pci 0000:05:00.0: CLS mismatch (256 != 128), using 64 bytes
[    0.341283] pci 0000:0c:00.0: MSI is not implemented on this device, disabling it
[    0.341288] pci 0000:0c:00.0: PME# is unreliable, disabling it
[    0.341674] pci 0000:0c:00.1: MSI is not implemented on this device, disabling it
[    0.341680] pci 0000:0c:00.1: PME# is unreliable, disabling it
[    0.341786] pci 0000:0c:00.2: MSI is not implemented on this device, disabling it
[    0.341792] pci 0000:0c:00.2: PME# is unreliable, disabling it
[    0.341857] pci 0000:0c:00.2: EHCI: unrecognized capability 00
[    0.341914] pci 0000:13:00.0: MSI is not implemented on this device, disabling it
[    0.341920] pci 0000:13:00.0: PME# is unreliable, disabling it
[    0.342240] pci 0000:13:00.1: MSI is not implemented on this device, disabling it
[    0.342246] pci 0000:13:00.1: PME# is unreliable, disabling it
[    0.342370] pci 0000:13:00.2: MSI is not implemented on this device, disabling it
[    0.342375] pci 0000:13:00.2: PME# is unreliable, disabling it
[    0.342452] pci 0000:13:00.2: EHCI: unrecognized capability 00
[    0.342533] DMAR: No ATSR found
[    0.342536] DMAR: No SATC found
[    0.342540] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.342542] DMAR: IOMMU feature sc_support inconsistent
[    0.342546] DMAR: IOMMU feature pass_through inconsistent
[    0.342548] Unpacking initramfs...
[    0.342555] DMAR: dmar0: Using Queued invalidation
[    0.342564] DMAR: dmar1: Using Queued invalidation
[    0.438728] pci 0000:00:00.0: Adding to iommu group 0
[    0.438760] pci 0000:00:02.0: Adding to iommu group 1
[    0.438781] pci 0000:00:03.0: Adding to iommu group 2
[    0.438802] pci 0000:00:14.0: Adding to iommu group 3
[    0.438832] pci 0000:00:16.0: Adding to iommu group 4
[    0.438852] pci 0000:00:1b.0: Adding to iommu group 5
[    0.438872] pci 0000:00:1c.0: Adding to iommu group 6
[    0.438892] pci 0000:00:1c.1: Adding to iommu group 7
[    0.438912] pci 0000:00:1c.2: Adding to iommu group 8
[    0.438931] pci 0000:00:1c.4: Adding to iommu group 9
[    0.438951] pci 0000:00:1c.5: Adding to iommu group 10
[    0.438986] pci 0000:00:1f.0: Adding to iommu group 11
[    0.439007] pci 0000:00:1f.3: Adding to iommu group 11
[    0.439026] pci 0000:02:00.0: Adding to iommu group 12
[    0.439045] pci 0000:03:00.0: Adding to iommu group 13
[    0.439064] pci 0000:05:00.0: Adding to iommu group 14
[    0.439085] pci 0000:06:00.0: Adding to iommu group 15
[    0.439104] pci 0000:06:03.0: Adding to iommu group 16
[    0.439125] pci 0000:06:04.0: Adding to iommu group 17
[    0.439145] pci 0000:06:05.0: Adding to iommu group 18
[    0.439165] pci 0000:06:06.0: Adding to iommu group 19
[    0.439174] pci 0000:07:00.0: Adding to iommu group 15
[    0.439182] pci 0000:08:00.0: Adding to iommu group 16
[    0.439191] pci 0000:09:00.0: Adding to iommu group 16
[    0.439200] pci 0000:09:01.0: Adding to iommu group 16
[    0.439210] pci 0000:09:02.0: Adding to iommu group 16
[    0.439218] pci 0000:09:04.0: Adding to iommu group 16
[    0.439227] pci 0000:09:05.0: Adding to iommu group 16
[    0.439236] pci 0000:0a:00.0: Adding to iommu group 16
[    0.439246] pci 0000:0b:03.0: Adding to iommu group 16
[    0.439254] pci 0000:0c:00.0: Adding to iommu group 16
[    0.439262] pci 0000:0c:00.1: Adding to iommu group 16
[    0.439270] pci 0000:0c:00.2: Adding to iommu group 16
[    0.439279] pci 0000:0d:00.0: Adding to iommu group 16
[    0.439287] pci 0000:0e:00.0: Adding to iommu group 16
[    0.439296] pci 0000:0f:00.0: Adding to iommu group 16
[    0.439305] pci 0000:10:00.0: Adding to iommu group 16
[    0.439313] pci 0000:10:01.0: Adding to iommu group 16
[    0.439322] pci 0000:10:02.0: Adding to iommu group 16
[    0.439330] pci 0000:10:04.0: Adding to iommu group 16
[    0.439339] pci 0000:10:05.0: Adding to iommu group 16
[    0.439347] pci 0000:11:00.0: Adding to iommu group 16
[    0.439356] pci 0000:12:03.0: Adding to iommu group 16
[    0.439365] pci 0000:13:00.0: Adding to iommu group 16
[    0.439374] pci 0000:13:00.1: Adding to iommu group 16
[    0.439382] pci 0000:13:00.2: Adding to iommu group 16
[    0.439392] pci 0000:14:00.0: Adding to iommu group 16
[    0.439400] pci 0000:15:00.0: Adding to iommu group 16
[    0.439419] pci 0000:04:00.0: Adding to iommu group 20
[    0.441516] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.441521] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.441525] software IO TLB: mapped [mem 0x000000006c76d000-0x000000007076d000] (64MB)
[    0.441536] ACPI: bus type thunderbolt registered
[    0.441709] thunderbolt 0000:07:00.0: total paths: 12
[    0.441972] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.442009] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.442030] thunderbolt 0000:07:00.0: control channel created
[    0.442034] thunderbolt 0000:07:00.0: ICM not supported on this controller
[    0.442046] thunderbolt 0000:07:00.0: freeing RX ring 0
[    0.442055] thunderbolt 0000:07:00.0: freeing TX ring 0
[    0.442069] thunderbolt 0000:07:00.0: allocating TX ring 0 of size 10
[    0.442079] thunderbolt 0000:07:00.0: allocating RX ring 0 of size 10
[    0.442090] thunderbolt 0000:07:00.0: control channel created
[    0.442093] thunderbolt 0000:07:00.0: using software connection manager
[    0.442096] thunderbolt 0000:07:00.0: device link creation from 0000:06:00.0 failed
[    0.442144] thunderbolt 0000:07:00.0: created link from 0000:06:03.0
[    0.442160] thunderbolt 0000:07:00.0: created link from 0000:06:04.0
[    0.442176] thunderbolt 0000:07:00.0: created link from 0000:06:05.0
[    0.442192] thunderbolt 0000:07:00.0: created link from 0000:06:06.0
[    0.442331] thunderbolt 0000:07:00.0: NHI initialized, starting thunderbolt
[    0.442333] thunderbolt 0000:07:00.0: control channel starting...
[    0.442335] thunderbolt 0000:07:00.0: starting TX ring 0
[    0.442343] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.442347] thunderbolt 0000:07:00.0: starting RX ring 0
[    0.442355] thunderbolt 0000:07:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    0.442359] thunderbolt 0000:07:00.0: security level set to user
[    0.442522] thunderbolt 0000:07:00.0: current switch config:
[    0.442525] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
[    0.442529] thunderbolt 0000:07:00.0:   Max Port Number: 12
[    0.442531] thunderbolt 0000:07:00.0:   Config:
[    0.442533] thunderbolt 0000:07:00.0:    Upstream Port Number: 5 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.442536] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.444230] Freeing initrd memory: 7308K
[    0.555337] thunderbolt 0000:07:00.0: initializing Switch at 0x0 (depth: 0, up port: 5)
[    0.555977] thunderbolt 0000:07:00.0: 0: DROM version: 1
[    0.557382] thunderbolt 0000:07:00.0: 0: uid: 0x1000f0811ee60
[    0.559302] thunderbolt 0000:07:00.0:  Port 1: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.559306] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.559307] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.559308] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.559310] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.561221] thunderbolt 0000:07:00.0:  Port 2: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.561224] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.561225] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.561226] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.561227] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.563142] thunderbolt 0000:07:00.0:  Port 3: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.563144] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.563145] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.563146] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.563147] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565062] thunderbolt 0000:07:00.0:  Port 4: 8086:156d (Revision: 0, TB Version: 1, Type: Port (0x1))
[    0.565064] thunderbolt 0000:07:00.0:   Max hop id (in/out): 15/15
[    0.565066] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565067] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    0.565068] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    0.565830] thunderbolt 0000:07:00.0:  Port 5: 8086:156d (Revision: 0, TB Version: 1, Type: NHI (0x2))
[    0.565832] thunderbolt 0000:07:00.0:   Max hop id (in/out): 11/11
[    0.565833] thunderbolt 0000:07:00.0:   Max counters: 16
[    0.565834] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.565835] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.566086] thunderbolt 0000:07:00.0:  Port 6: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566088] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566089] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566090] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566091] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566343] random: fast init done
[    0.566343] thunderbolt 0000:07:00.0:  Port 7: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566348] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566350] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566351] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566352] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566598] thunderbolt 0000:07:00.0:  Port 8: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566600] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566601] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566602] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566603] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566854] thunderbolt 0000:07:00.0:  Port 9: 8086:156d (Revision: 0, TB Version: 1, Type: PCIe (0x100101))
[    0.566856] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    0.566857] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.566858] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    0.566859] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    0.566860] thunderbolt 0000:07:00.0: 0:a: disabled by eeprom
[    0.567110] thunderbolt 0000:07:00.0:  Port 11: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567112] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567113] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567114] thunderbolt 0000:07:00.0:   NFC Credits: 0xf0000b
[    0.567115] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.567366] thunderbolt 0000:07:00.0:  Port 12: 8086:156d (Revision: 0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.567368] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    0.567369] thunderbolt 0000:07:00.0:   Max counters: 2
[    0.567370] thunderbolt 0000:07:00.0:   NFC Credits: 0xf00000
[    0.567371] thunderbolt 0000:07:00.0:   Credits (total/control): 15/0
[    0.572358] thunderbolt 0000:07:00.0: 0: TMU: current mode: HiFi
[    0.572488] thunderbolt 0000:07:00.0: 0:1: is connected, link is up (state: 2)
[    0.572741] thunderbolt 0000:07:00.0: current switch config:
[    0.572742] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    0.572744] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    0.572746] thunderbolt 0000:07:00.0:   Config:
[    0.572746] thunderbolt 0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x1 Enabled: 1, PlugEventsDelay: 255ms
[    0.572749] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.577349] thunderbolt 0000:07:00.0: initializing Switch at 0x1 (depth: 1, up port: 1)
[    0.594755] thunderbolt 0000:07:00.0: 1: reading drom (length: 0x97)
[    1.088413] thunderbolt 0000:07:00.0: 1: DROM version: 1
[    1.089437] thunderbolt 0000:07:00.0: 1: uid: 0x1000100189170
[    1.092380] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.092383] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.092384] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.092385] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.092386] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.095323] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.095325] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.095326] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.095327] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c0000e
[    1.095328] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.098267] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.098269] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.098270] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.098271] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.098272] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101211] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.101213] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.101214] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.101215] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.101216] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.101217] thunderbolt 0000:07:00.0: 1:5: disabled by eeprom
[    1.101218] thunderbolt 0000:07:00.0: 1:6: disabled by eeprom
[    1.102107] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.102109] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.102110] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.102111] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.102112] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.103002] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.103005] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.103006] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.103007] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.103008] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.103009] thunderbolt 0000:07:00.0: 1:9: disabled by eeprom
[    1.103899] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.103901] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.103902] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.103903] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.103904] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.105051] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.105054] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.105055] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.105056] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.105057] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.105058] thunderbolt 0000:07:00.0: 1:c: disabled by eeprom
[    1.105059] thunderbolt 0000:07:00.0: 1:d: disabled by eeprom
[    1.122959] thunderbolt 0000:07:00.0: 1: TMU: current mode: bi-directional, HiFi
[    1.122975] thunderbolt 0-1: new device found, vendor=0x1 device=0x8002
[    1.122979] thunderbolt 0-1: Apple, Inc. Thunderbolt Display
[    1.123471] thunderbolt 0000:07:00.0: 1:3: is connected, link is up (state: 2)
[    1.123727] thunderbolt 0000:07:00.0: current switch config:
[    1.123728] thunderbolt 0000:07:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.123729] thunderbolt 0000:07:00.0:   Max Port Number: 13
[    1.123731] thunderbolt 0000:07:00.0:   Config:
[    1.123731] thunderbolt 0000:07:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x301 Enabled: 1, PlugEventsDelay: 255ms
[    1.123733] thunderbolt 0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.128335] thunderbolt 0000:07:00.0: initializing Switch at 0x301 (depth: 2, up port: 3)
[    1.145741] thunderbolt 0000:07:00.0: 301: reading drom (length: 0x97)
[    1.621354] random: crng init done
[    1.639398] thunderbolt 0000:07:00.0: 301: DROM version: 1
[    1.640422] thunderbolt 0000:07:00.0: 301: uid: 0x100010102a740
[    1.643365] thunderbolt 0000:07:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.643367] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.643369] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.643370] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.643371] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.646309] thunderbolt 0000:07:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.646311] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.646312] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.646313] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.646314] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.649252] thunderbolt 0000:07:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.649255] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.649256] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.649257] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.649258] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.652196] thunderbolt 0000:07:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    1.652198] thunderbolt 0000:07:00.0:   Max hop id (in/out): 63/63
[    1.652199] thunderbolt 0000:07:00.0:   Max counters: 32
[    1.652200] thunderbolt 0000:07:00.0:   NFC Credits: 0x3c00000
[    1.652201] thunderbolt 0000:07:00.0:   Credits (total/control): 60/2
[    1.652202] thunderbolt 0000:07:00.0: 301:5: disabled by eeprom
[    1.652204] thunderbolt 0000:07:00.0: 301:6: disabled by eeprom
[    1.653092] thunderbolt 0000:07:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.653094] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.653095] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.653096] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.653097] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.653988] thunderbolt 0000:07:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    1.653990] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.653991] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.653992] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.653993] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.653994] thunderbolt 0000:07:00.0: 301:9: disabled by eeprom
[    1.654884] thunderbolt 0000:07:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    1.654887] thunderbolt 0000:07:00.0:   Max hop id (in/out): 8/8
[    1.654888] thunderbolt 0000:07:00.0:   Max counters: 1
[    1.654889] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.654890] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.656036] thunderbolt 0000:07:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    1.656038] thunderbolt 0000:07:00.0:   Max hop id (in/out): 9/9
[    1.656039] thunderbolt 0000:07:00.0:   Max counters: 2
[    1.656040] thunderbolt 0000:07:00.0:   NFC Credits: 0x700000
[    1.656041] thunderbolt 0000:07:00.0:   Credits (total/control): 7/0
[    1.656042] thunderbolt 0000:07:00.0: 301:c: disabled by eeprom
[    1.656043] thunderbolt 0000:07:00.0: 301:d: disabled by eeprom
[    1.674373] thunderbolt 0000:07:00.0: 301: TMU: current mode: bi-directional, HiFi
[    1.674389] thunderbolt 0-301: new device found, vendor=0x1 device=0x8002
[    1.674392] thunderbolt 0-301: Apple, Inc. Thunderbolt Display
[    1.674503] thunderbolt 0000:07:00.0: 301:1: is unplugged (state: 7)
[    1.674757] thunderbolt 0000:07:00.0: 301:b: DP adapter HPD set, queuing hotplug
[    1.675141] thunderbolt 0000:07:00.0: 0:3: is unplugged (state: 7)
[    1.676677] thunderbolt 0000:07:00.0: 0:6 <-> 1:a (PCI): discovered
[    1.679236] thunderbolt 0000:07:00.0: 0:b <-> 1:b (DP): discovered
[    1.680900] thunderbolt 0000:07:00.0: 1:7 <-> 301:a (PCI): discovered
[    1.681286] thunderbolt 0000:07:00.0: 0:b: DP IN resource available
[    1.681287] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
[    1.681415] thunderbolt 0000:07:00.0: 301:b: DP OUT resource available
[    1.681420] thunderbolt 0000:07:00.0: looking for DP IN <-> DP OUT pairs:
[    1.681428] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.681433] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.681435] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.681437] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    1.681439] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.681544] thunderbolt 0000:07:00.0: 0:b: in use
[    1.681672] thunderbolt 0000:07:00.0: 0:c: DP IN available
[    1.681800] thunderbolt 0000:07:00.0: 301:b: DP OUT available
[    1.681803] thunderbolt 0000:07:00.0: 0: allocated DP resource for port 12
[    1.681806] thunderbolt 0000:07:00.0: 301:b: calculating available bandwidth
[    1.681935] thunderbolt 0000:07:00.0: 0:1: link total bandwidth 9000 Mb/s
[    1.681940] thunderbolt 0000:07:00.0: 1:1: link total bandwidth 9000 Mb/s
[    1.682056] thunderbolt 0000:07:00.0: 1:3: link total bandwidth 9000 Mb/s
[    1.682060] thunderbolt 0000:07:00.0: 301:3: link total bandwidth 9000 Mb/s
[    1.682063] thunderbolt 0000:07:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    1.682072] thunderbolt 0000:07:00.0: 0:c <-> 301:b (DP): activating
[    1.682076] thunderbolt 0000:07:00.0: activating Video path from 0:12 to 301:11
[    1.682080] thunderbolt 0000:07:00.0: 301:4: adding 12 NFC credits to 0
[    1.682182] thunderbolt 0000:07:00.0: 1:2: adding 12 NFC credits to 14
[    1.682272] Initialise system trusted keyrings
[    1.682297] workingset: timestamp_bits=62 max_order=22 bucket_order=0
[    1.682310] thunderbolt 0000:07:00.0: 0:c: adding 12 NFC credits to 0
[    1.682565] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.682568] thunderbolt 0000:07:00.0: 301:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    1.682571] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.682574] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.682577] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.682581] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.682820] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.682823] thunderbolt 0000:07:00.0: 1:2:  In HopID: 10 => Out port: 4 Out HopID: 8
[    1.682826] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.682829] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.682831] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.682834] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683077] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.683079] thunderbolt 0000:07:00.0: 0:c:  In HopID: 9 => Out port: 2 Out HopID: 10
[    1.683082] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    1.683085] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.683088] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    1.683090] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683206] thunderbolt 0000:07:00.0: path activation complete
[    1.683208] thunderbolt 0000:07:00.0: activating AUX TX path from 0:12 to 301:11
[    1.683333] thunderbolt 0000:07:00.0: 301:4: Writing hop 2
[    1.683336] thunderbolt 0000:07:00.0: 301:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    1.683339] thunderbolt 0000:07:00.0: 301:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683342] thunderbolt 0000:07:00.0: 301:4:    Counter enabled: 0 Counter index: 2047
[    1.683345] thunderbolt 0000:07:00.0: 301:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.683348] thunderbolt 0000:07:00.0: 301:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683496] NFS: Registering the id_resolver key type
[    1.683502] Key type id_resolver registered
[    1.683504] Key type id_legacy registered
[    1.683518] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.683564] Key type asymmetric registered
[    1.683570] Asymmetric key parser 'x509' registered
[    1.683590] thunderbolt 0000:07:00.0: 1:2: Writing hop 1
[    1.683593] thunderbolt 0000:07:00.0: 1:2:  In HopID: 11 => Out port: 4 Out HopID: 9
[    1.683596] thunderbolt 0000:07:00.0: 1:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683599] thunderbolt 0000:07:00.0: 1:2:    Counter enabled: 0 Counter index: 2047
[    1.683602] thunderbolt 0000:07:00.0: 1:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.683605] thunderbolt 0000:07:00.0: 1:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683844] thunderbolt 0000:07:00.0: 0:c: Writing hop 0
[    1.683846] thunderbolt 0000:07:00.0: 0:c:  In HopID: 8 => Out port: 2 Out HopID: 11
[    1.683849] thunderbolt 0000:07:00.0: 0:c:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.683852] thunderbolt 0000:07:00.0: 0:c:    Counter enabled: 0 Counter index: 2047
[    1.683854] thunderbolt 0000:07:00.0: 0:c:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.683857] thunderbolt 0000:07:00.0: 0:c:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.683972] thunderbolt 0000:07:00.0: path activation complete
[    1.683974] thunderbolt 0000:07:00.0: activating AUX RX path from 301:11 to 0:12
[    1.684828] pcieport 0000:06:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.684856] thunderbolt 0000:07:00.0: 0:2: Writing hop 2
[    1.684859] thunderbolt 0000:07:00.0: 0:2:  In HopID: 9 => Out port: 12 Out HopID: 8
[    1.684862] thunderbolt 0000:07:00.0: 0:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.684865] thunderbolt 0000:07:00.0: 0:2:    Counter enabled: 0 Counter index: 2047
[    1.684868] thunderbolt 0000:07:00.0: 0:2:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    1.684869] thunderbolt 0000:07:00.0: 0:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685014] thunderbolt 0000:07:00.0: 1:4: Writing hop 1
[    1.685016] thunderbolt 0000:07:00.0: 1:4:  In HopID: 8 => Out port: 2 Out HopID: 9
[    1.685017] thunderbolt 0000:07:00.0: 1:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685019] thunderbolt 0000:07:00.0: 1:4:    Counter enabled: 0 Counter index: 2047
[    1.685020] thunderbolt 0000:07:00.0: 1:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.685022] thunderbolt 0000:07:00.0: 1:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685070] pcieport 0000:06:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685268] thunderbolt 0000:07:00.0: 301:b: Writing hop 0
[    1.685271] thunderbolt 0000:07:00.0: 301:b:  In HopID: 8 => Out port: 4 Out HopID: 8
[    1.685272] thunderbolt 0000:07:00.0: 301:b:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    1.685274] thunderbolt 0000:07:00.0: 301:b:    Counter enabled: 0 Counter index: 2047
[    1.685275] thunderbolt 0000:07:00.0: 301:b:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    1.685277] thunderbolt 0000:07:00.0: 301:b:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    1.685343] pcieport 0000:06:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685399] thunderbolt 0000:07:00.0: path activation complete
[    1.685492] pcieport 0000:06:05.0: enabling device (0000 -> 0003)
[    1.685603] pcieport 0000:06:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.685875] pcieport 0000:06:06.0: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.688396] pcieport 0000:09:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.688723] pcieport 0000:09:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.692060] pcieport 0000:10:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.692477] pcieport 0000:10:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    1.693419] ACPI: AC: AC Adapter [ADP1] (off-line)
[    1.693485] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.693520] ACPI: button: Lid Switch [LID0]
[    1.693555] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.693605] ACPI: button: Power Button [PWRB]
[    1.693643] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.693662] ACPI: button: Sleep Button [SLPB]
[    1.693698] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.693727] ACPI: button: Power Button [PWRF]
[    1.694025] smbus_hc ACPI0001:00: SBS HC: offset = 0x20, query_bit = 0x10
[    2.084427] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (battery present)
[    2.094060] hpet_acpi_add: no address or irqs in _CRS
[    2.095215] loop: module loaded
[    2.095456] nvme nvme0: pci function 0000:04:00.0
[    2.095778] tun: Universal TUN/TAP device driver, 1.6
[    2.095854] mousedev: PS/2 mouse device common for all mice
[    2.095872] rtc_cmos 00:02: RTC can wake from S4
[    2.096122] rtc_cmos 00:02: registered as rtc0
[    2.096159] rtc_cmos 00:02: setting system clock to 2022-03-29T11:59:31 UTC (1648555171)
[    2.096164] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
[    2.096349] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    2.096362] intel_pstate: Intel P-state driver initializing
[    2.096463] efifb: probing for efifb
[    2.096475] efifb: framebuffer at 0xa0000000, using 16000k, total 16000k
[    2.096477] efifb: mode is 2560x1600x32, linelength=10240, pages=1
[    2.096480] efifb: scrolling: redraw
[    2.096481] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.099678] Console: switching to colour frame buffer device 320x100
[    2.102699] fb0: EFI VGA frame buffer device
[    2.102766] NET: Registered PF_PACKET protocol family
[    2.102785] Key type dns_resolver registered
[    2.102951] microcode: sig=0x40651, pf=0x40, revision=0x26
[    2.102994] microcode: Microcode Update Driver: v2.2.
[    2.102998] IPI shorthand broadcast: enabled
[    2.103016] AVX2 version of gcm_enc/dec engaged.
[    2.103053] AES CTR mode by8 optimization enabled
[    2.103173] sched_clock: Marking stable (2101571718, 1596895)->(2126440420, -23271807)
[    2.103233] registered taskstats version 1
[    2.103240] Loading compiled-in X.509 certificates
[    2.151368] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) 
[    2.169559] nvme nvme0: 4/0/0 default/read/poll queues
[    2.174555]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    2.342092] Freeing unused kernel image (initmem) memory: 996K
[    2.393654] Write protecting the kernel read-only data: 16384k
[    2.394001] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    2.394174] Freeing unused kernel image (rodata/data gap) memory: 1356K
[    2.394191] Run /init as init process
[    2.394198]   with arguments:
[    2.394200]     /init
[    2.394201]   with environment:
[    2.394202]     HOME=/
[    2.394203]     TERM=linux
[    2.447245] udevd[942]: starting version 3.2.9
[    2.447977] udevd[943]: starting eudev-3.2.9
[    2.472473] ACPI: bus type USB registered
[    2.472620] usbcore: registered new interface driver usbfs
[    2.472649] usbcore: registered new interface driver hub
[    2.472678] usbcore: registered new device driver usb
[    2.478504] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.478618] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.480102] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x000000000004b810
[    2.480285] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.17
[    2.480308] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.480326] usb usb1: Product: xHCI Host Controller
[    2.480337] usb usb1: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.480349] usb usb1: SerialNumber: 0000:00:14.0
[    2.480480] hub 1-0:1.0: USB hub found
[    2.480503] hub 1-0:1.0: 9 ports detected
[    2.481218] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.481237] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.481275] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.481370] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.17
[    2.481396] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.481416] usb usb2: Product: xHCI Host Controller
[    2.481430] usb usb2: Manufacturer: Linux 5.17.0+ xhci-hcd
[    2.481446] usb usb2: SerialNumber: 0000:00:14.0
[    2.481614] hub 2-0:1.0: USB hub found
[    2.481745] hub 2-0:1.0: 4 ports detected
[    2.482996] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.483195] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.545303] applesmc: key=571 fan=1 temp=32 index=31 acc=0 lux=2 kbd=1
[    2.545465] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    2.553629] tg3 0000:0d:00.0 eth0: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[    2.553669] tg3 0000:0d:00.0 eth0: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.553697] tg3 0000:0d:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.553711] tg3 0000:0d:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.644243] tg3 0000:14:00.0 eth1: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[    2.644288] tg3 0000:14:00.0 eth1: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    2.644320] tg3 0000:14:00.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    2.644347] tg3 0000:14:00.0 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    2.723618] tsc: Refined TSC clocksource calibration: 2599.999 MHz
[    2.723627] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a3b2ad7e, max_idle_ns: 440795282337 ns
[    2.723652] clocksource: Switched to clocksource tsc
[    2.763615] usb 1-3: new full-speed USB device number 2 using xhci_hcd
[    2.956261] usb 1-3: New USB device found, idVendor=05ac, idProduct=8290, bcdDevice= 1.69
[    2.956266] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.956268] usb 1-3: Product: Bluetooth USB Host Controller
[    2.956270] usb 1-3: Manufacturer: Broadcom Corp.
[    2.963223] hid: raw HID events driver (C) Jiri Kosina
[    2.967806] usbcore: registered new interface driver usbhid
[    2.967808] usbhid: USB HID core driver
[    2.968579] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:05AC:8290.0001/input/input4
[    3.033708] hid-generic 0003:05AC:8290.0001: input,hidraw0: USB HID v1.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input0
[    3.033837] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:05AC:8290.0002/input/input5
[    3.034415] hid-generic 0003:05AC:8290.0002: input,hidraw1: USB HID v1.11 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input1
[    3.103822] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
[    3.136366] usb 2-3: New USB device found, idVendor=05ac, idProduct=8406, bcdDevice= 8.20
[    3.136382] usb 2-3: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    3.136384] usb 2-3: Product: Card Reader
[    3.136385] usb 2-3: Manufacturer: Apple
[    3.136396] usb 2-3: SerialNumber: 000000000820
[    3.139801] usb-storage 2-3:1.0: USB Mass Storage device detected
[    3.139888] scsi host0: usb-storage 2-3:1.0
[    3.139991] usbcore: registered new interface driver usb-storage
[    3.140193] usbcore: registered new interface driver uas
[    3.283614] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    3.469334] usb 1-5: New USB device found, idVendor=05ac, idProduct=0259, bcdDevice= 2.24
[    3.469350] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.469351] usb 1-5: Product: Apple Internal Keyboard / Trackpad
[    3.469353] usb 1-5: Manufacturer: Apple Inc.
[    3.478644] input: Apple Inc. Apple Internal Keyboard / Trackpad as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:05AC:0259.0003/input/input6
[    3.543758] apple 0003:05AC:0259.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input0
[    3.543956] apple 0003:05AC:0259.0004: hidraw3: USB HID v1.11 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-5/input1
[    4.165623] scsi 0:0:0:0: Direct-Access     APPLE    SD Card Reader   3.00 PQ: 0 ANSI: 6
[    4.166191] sd 0:0:0:0: [sda] Media removed, stopped polling
[    4.166281] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.166828] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    6.008925] process '/usr/bin/fstype' started with executable stack
[    6.088823] PM: Image not found (code -22)
[    6.090825] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[    6.090829] PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]
[    6.090831] PM: hibernation: Marking nosave pages: [mem 0x0008f000-0x0008ffff]
[    6.090832] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[    6.090834] PM: hibernation: Marking nosave pages: [mem 0x73d4c000-0x73d4cfff]
[    6.090836] PM: hibernation: Marking nosave pages: [mem 0x73d5c000-0x73d5cfff]
[    6.090837] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    6.090838] PM: hibernation: Marking nosave pages: [mem 0x73d6f000-0x73d6ffff]
[    6.090839] PM: hibernation: Marking nosave pages: [mem 0x8ad10000-0x8ad52fff]
[    6.090841] PM: hibernation: Marking nosave pages: [mem 0x8ad62000-0x8ad8efff]
[    6.090842] PM: hibernation: Marking nosave pages: [mem 0x8ae39000-0x8ae8efff]
[    6.090844] PM: hibernation: Marking nosave pages: [mem 0x8aed2000-0x8aefefff]
[    6.090846] PM: hibernation: Marking nosave pages: [mem 0x8af84000-0x8afeffff]
[    6.090848] PM: hibernation: Marking nosave pages: [mem 0x8b000000-0xffffffff]
[    6.091867] PM: hibernation: Basic memory bitmaps created
[    6.092567] PM: hibernation: Basic memory bitmaps freed
[    6.268197] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Quota mode: disabled.
[    6.407358] udevd[1205]: starting version 3.2.9
[    6.431424] udevd[1206]: starting eudev-3.2.9
[    6.496759] Linux agpgart interface v0.103
[    6.502273] ACPI: bus type drm_connector registered
[    6.512529] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    6.520105] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input7
[    6.522268] tg3 0000:0d:00.0 eth2: renamed from eth0
[    6.524274] usbcore: registered new interface driver bcm5974
[    6.541011] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    6.542410] checking generic (a0000000 fa0000) vs hw (b0000000 400000)
[    6.542414] checking generic (a0000000 fa0000) vs hw (a0000000 10000000)
[    6.542416] fb0: switching to i915 from EFI VGA
[    6.544438] Console: switching to colour dummy device 80x25
[    6.544730] i915 0000:00:02.0: vgaarb: deactivate vga console
[    6.544778] i915 0000:00:02.0: [drm] Transparent Hugepage support is recommended for optimal performance when IOMMU is enabled!
[    6.544798] i915 0000:00:02.0: [drm] DMAR active, disabling use of stolen memory
[    6.550715] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    6.593976] snd_hda_codec_cirrus hdaudioC1D0: autoconfig for CS4208: line_outs=2 (0x12/0x13/0x0/0x0/0x0) type:speaker
[    6.593989] snd_hda_codec_cirrus hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    6.593995] snd_hda_codec_cirrus hdaudioC1D0:    hp_outs=1 (0x10/0x0/0x0/0x0/0x0)
[    6.594001] snd_hda_codec_cirrus hdaudioC1D0:    mono: mono_out=0x0
[    6.594005] snd_hda_codec_cirrus hdaudioC1D0:    dig-out=0x21/0x0
[    6.594008] snd_hda_codec_cirrus hdaudioC1D0:    inputs:
[    6.594012] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1c
[    6.594016] snd_hda_codec_cirrus hdaudioC1D0:      Mic=0x18
[    6.605452] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.605649] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    6.605658] cfg80211: failed to load regulatory.db
[    6.609866] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
[    6.611748] brcmfmac 0000:03:00.0: enabling device (0000 -> 0002)
[    6.612255] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[    6.612885] input: HDA Intel PCH SPDIF as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[    6.642979] Bluetooth: Core ver 2.22
[    6.643021] NET: Registered PF_BLUETOOTH protocol family
[    6.643024] Bluetooth: HCI device and connection manager initialized
[    6.643028] Bluetooth: HCI socket layer initialized
[    6.643030] Bluetooth: L2CAP socket layer initialized
[    6.643035] Bluetooth: SCO socket layer initialized
[    6.644815] usbcore: registered new interface driver btusb
[    6.654309] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    6.655039] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  post: no)
[    6.655465] acpi device:02: registered as cooling_device4
[    6.655547] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input11
[    6.655675] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    6.733833] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[    6.734032] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.bin failed with error -2
[    6.734810] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.Apple Inc.-MacBookPro11,1.txt failed with error -2
[    6.734824] brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt failed with error -2
[    6.746944] udevd[1237]: Unable to EVIOCGABS device "/dev/input/event6"
[    6.746955] udevd[1237]: Unable to EVIOCGABS device "/dev/input/event6"
[    6.746960] udevd[1237]: Unable to EVIOCGABS device "/dev/input/event6"
[    6.746965] udevd[1237]: Unable to EVIOCGABS device "/dev/input/event6"
[    6.772925] Bluetooth: hci0: BCM: chip id 102 build 0729
[    6.773932] Bluetooth: hci0: BCM: product 05ac:8290
[    6.774876] Bluetooth: hci0: BCM: features 0x2f
[    6.790925] Bluetooth: hci0: BlueZ 5.50
[    6.821570] fbcon: i915drmfb (fb0) is primary device
[    7.246024] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
[    7.246047] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[    7.246610] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[    8.334691] Console: switching to colour frame buffer device 320x90
[    8.354101] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    8.421833] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[    8.422091] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[    8.422534] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[    8.422947] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[    8.423864] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input16
[    8.651739] Adding 19528700k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:19528700k SS
[    8.663693] EXT4-fs (nvme0n1p4): re-mounted. Quota mode: disabled.
[   14.900072] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: disabled.
[   15.106143] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   18.840023] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   18.840026] Bluetooth: BNEP filters: protocol multicast
[   18.840029] Bluetooth: BNEP socket layer initialized
[   19.188102] broken atomic modeset userspace detected, disabling atomic

