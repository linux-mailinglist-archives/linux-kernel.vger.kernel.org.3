Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CF58AC79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbiHEOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiHEOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:44:02 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01732449
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:43:58 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oJyYN-0002GP-LH; Sat, 06 Aug 2022 00:43:55 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2rBEim0d3PF84l7Ts8fBV8GsOZev/K2yihZ3pwg7wg=; b=ooCFXFk4kKHVcGcfyUpwfZMnnG
        ljDcO8JUkAKWYyjguJ3KTUKYkIQkA/Vhsq8KX4i8YT4pvlKrLXsnNj6y07cbVwSuoq7NfKE/8pFRm
        9jB7ABmdUEaX1nBFixylDKmKM50UVFYNfasVbO3o0I2lYzR429avrgIAg+bX4b0RCR9o=;
Message-ID: <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
Date:   Fri, 5 Aug 2022 22:43:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
Content-Language: en-AU
In-Reply-To: <Yu0nWro4xXURbSX6@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/8/22 22:21, Mika Westerberg wrote:

> They are pretty standard so I suspect myself the display side of things.
> Not sure if it is possible (I think it is from sysfs /sys/class/drm/*)
> to disable the tunneled DP connections and see if that makes it not
> hang. Alternatively you can try to comment out the call to
> tb_tunnel_dp() from the driver. Let me know if you want me to make hack
> patch that does it for you.
> 

I used this :

iff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9a3214fb5038..eae7523af78b 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -865,7 +865,7 @@ static void tb_tunnel_dp(struct tb *tb)
         struct tb_cm *tcm = tb_priv(tb);
         struct tb_port *port, *in, *out;
         struct tb_tunnel *tunnel;
-
+       return;
         if (!tb_acpi_may_tunnel_dp()) {
                 tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
                 return;

I'm now using Linus GIT head. No change in behaviour really.

No tunnels were created. None of the TB displays light up in Linux or BIOS. System still locks
up on reboot and the first time I attempted to compose this reply it locked up hard before I
had a chance to finish it because I attempted to verify the devices were present with an lspci -tv.

If I do an lspci -tv after the module load, it locks hard instantly and reproducibly.

[   79.583747] ACPI: bus type thunderbolt registered
[   79.583776] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[   79.583830] thunderbolt 0000:05:00.0: total paths: 12
[   79.583836] thunderbolt 0000:05:00.0: IOMMU DMA protection is disabled
[   79.583975] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   79.583987] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   79.583997] thunderbolt 0000:05:00.0: control channel created
[   79.584000] thunderbolt 0000:05:00.0: ICM not supported on this controller
[   79.584006] thunderbolt 0000:05:00.0: freeing RX ring 0
[   79.584012] thunderbolt 0000:05:00.0: freeing TX ring 0
[   79.584018] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   79.584025] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   79.584031] thunderbolt 0000:05:00.0: control channel created
[   79.584032] thunderbolt 0000:05:00.0: using software connection manager
[   79.584033] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
[   79.584033] thunderbolt 0000:05:00.0: control channel starting...
[   79.584033] thunderbolt 0000:05:00.0: starting TX ring 0
[   79.584041] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   79.584042] thunderbolt 0000:05:00.0: starting RX ring 0
[   79.584050] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   79.584053] thunderbolt 0000:05:00.0: security level set to user
[   79.584207] thunderbolt 0000:05:00.0: current switch config:
[   79.584207] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
[   79.584208] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   79.584209] thunderbolt 0000:05:00.0:   Config:
[   79.584209] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[   79.584210] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   79.589326] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
[   79.629264] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
[   79.631185] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.631187] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.631188] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.631188] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.631189] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.633105] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.633106] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.633107] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.633107] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.633108] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.635021] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.635022] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.635022] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.635023] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.635023] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.636946] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.636948] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.636949] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.636949] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.636950] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.637201] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   79.637202] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   79.637202] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.637203] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   79.637203] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.637457] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   79.637458] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   79.637458] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.637459] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   79.637459] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.638225] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
[   79.638225] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
[   79.638226] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.638226] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   79.638227] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.638481] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   79.638482] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.638482] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.638483] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.638483] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.638737] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   79.638738] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.638738] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.638739] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.638739] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.639248] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   79.639249] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   79.639250] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.639250] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.639251] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.639761] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   79.639761] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   79.639762] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.639762] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.639763] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.640017] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   79.640018] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.640018] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.640019] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.640019] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.640269] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   79.640270] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.640270] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.640271] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.640271] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.640272] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
[   79.640272] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
[   79.645393] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
[   79.645393] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
[   79.645519] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
[   79.645647] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
[   79.645902] thunderbolt 0000:05:00.0: current switch config:
[   79.645902] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   79.645903] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   79.645903] thunderbolt 0000:05:00.0:   Config:
[   79.645904] thunderbolt 0000:05:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[   79.645905] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   79.650512] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   79.667922] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x97)
[   80.161623] thunderbolt 0000:05:00.0: 3: DROM version: 1
[   80.162643] thunderbolt 0000:05:00.0: 3: uid: 0x1000100189170
[   80.165591] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.165592] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.165593] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.165593] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.165594] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.168535] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.168536] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.168536] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.168537] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.168537] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.171478] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.171479] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.171480] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.171480] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.171481] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.174422] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.174425] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.174426] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.174426] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.174427] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.174427] thunderbolt 0000:05:00.0: 3:5: disabled by eeprom
[   80.174428] thunderbolt 0000:05:00.0: 3:6: disabled by eeprom
[   80.175315] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.175316] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.175316] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.175317] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.175317] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.176215] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.176216] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.176216] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.176217] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.176217] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.176217] thunderbolt 0000:05:00.0: 3:9: disabled by eeprom
[   80.177111] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   80.177112] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.177113] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.177113] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.177114] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.178262] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   80.178265] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   80.178265] thunderbolt 0000:05:00.0:   Max counters: 2
[   80.178266] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.178266] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.178267] thunderbolt 0000:05:00.0: 3:12: disabled by eeprom
[   80.178268] thunderbolt 0000:05:00.0: 3:13: disabled by eeprom
[   80.196125] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
[   80.196137] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   80.196139] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   80.196638] thunderbolt 0000:05:00.0: 3:3: is connected, link is up (state: 2)
[   80.196907] thunderbolt 0000:05:00.0: current switch config:
[   80.196908] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   80.196909] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   80.196909] thunderbolt 0000:05:00.0:   Config:
[   80.196910] thunderbolt 0000:05:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[   80.196911] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   80.201502] thunderbolt 0000:05:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   80.218910] thunderbolt 0000:05:00.0: 303: reading drom (length: 0x97)
[   80.712612] thunderbolt 0000:05:00.0: 303: DROM version: 1
[   80.713636] thunderbolt 0000:05:00.0: 303: uid: 0x100010102a740
[   80.716580] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.716581] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.716582] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.716583] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.716583] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.719523] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.719525] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.719526] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.719526] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.719526] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.722467] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.722468] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.722469] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.722469] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.722470] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.725411] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.725412] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.725413] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.725413] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.725414] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.725414] thunderbolt 0000:05:00.0: 303:5: disabled by eeprom
[   80.725415] thunderbolt 0000:05:00.0: 303:6: disabled by eeprom
[   80.726307] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.726308] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.726309] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.726309] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.726310] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.727201] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.727202] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.727203] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.727203] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.727204] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.727204] thunderbolt 0000:05:00.0: 303:9: disabled by eeprom
[   80.728099] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   80.728100] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.728101] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.728101] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.728102] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.729251] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   80.729252] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   80.729253] thunderbolt 0000:05:00.0:   Max counters: 2
[   80.729253] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.729254] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.729254] thunderbolt 0000:05:00.0: 303:12: disabled by eeprom
[   80.729255] thunderbolt 0000:05:00.0: 303:13: disabled by eeprom
[   80.747201] thunderbolt 0000:05:00.0: 303: TMU: current mode: bi-directional, HiFi
[   80.747218] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   80.747220] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   80.747333] thunderbolt 0000:05:00.0: 303:1: is unplugged (state: 7)
[   80.747585] thunderbolt 0000:05:00.0: 303:11: DP adapter HPD set, queuing hotplug
[   80.747840] thunderbolt 0000:05:00.0: 3:11: DP adapter HPD set, queuing hotplug
[   80.748864] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 0:9
[   80.748992] thunderbolt 0000:05:00.0: 0:9:  In HopID: 8 => Out port: 3 Out HopID: 8
[   80.748993] thunderbolt 0000:05:00.0: 0:9:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.748994] thunderbolt 0000:05:00.0: 0:9:    Counter enabled: 0 Counter index: 2047
[   80.748995] thunderbolt 0000:05:00.0: 0:9:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.748996] thunderbolt 0000:05:00.0: 0:9:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.749120] thunderbolt 0000:05:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   80.749121] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.749122] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   80.749122] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.749123] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.749124] thunderbolt 0000:05:00.0: path discovery complete
[   80.749632] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 3:10
[   80.749760] thunderbolt 0000:05:00.0: 3:10:  In HopID: 8 => Out port: 1 Out HopID: 8
[   80.749761] thunderbolt 0000:05:00.0: 3:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.749761] thunderbolt 0000:05:00.0: 3:10:    Counter enabled: 0 Counter index: 2047
[   80.749762] thunderbolt 0000:05:00.0: 3:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.749763] thunderbolt 0000:05:00.0: 3:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.749888] thunderbolt 0000:05:00.0: 0:3:  In HopID: 8 => Out port: 9 Out HopID: 8
[   80.749888] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.749889] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   80.749890] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.749890] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.749891] thunderbolt 0000:05:00.0: path discovery complete
[   80.750016] thunderbolt 0000:05:00.0: 0:9 <-> 3:a (PCI): discovered
[   80.750400] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 3:7
[   80.750528] thunderbolt 0000:05:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   80.750529] thunderbolt 0000:05:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.750529] thunderbolt 0000:05:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   80.750530] thunderbolt 0000:05:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.750531] thunderbolt 0000:05:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.750656] thunderbolt 0000:05:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   80.750657] thunderbolt 0000:05:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.750657] thunderbolt 0000:05:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   80.750658] thunderbolt 0000:05:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.750659] thunderbolt 0000:05:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.750659] thunderbolt 0000:05:00.0: path discovery complete
[   80.751168] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 303:10
[   80.751296] thunderbolt 0000:05:00.0: 303:10:  In HopID: 8 => Out port: 3 Out HopID: 8
[   80.751297] thunderbolt 0000:05:00.0: 303:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.751297] thunderbolt 0000:05:00.0: 303:10:    Counter enabled: 0 Counter index: 2047
[   80.751298] thunderbolt 0000:05:00.0: 303:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.751299] thunderbolt 0000:05:00.0: 303:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.751424] thunderbolt 0000:05:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   80.751425] thunderbolt 0000:05:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.751426] thunderbolt 0000:05:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   80.751427] thunderbolt 0000:05:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.751427] thunderbolt 0000:05:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.751428] thunderbolt 0000:05:00.0: path discovery complete
[   80.751552] thunderbolt 0000:05:00.0: 3:7 <-> 303:a (PCI): discovered
[   80.752064] thunderbolt 0000:05:00.0: 0:5: DP IN resource available
[   80.752192] thunderbolt 0000:05:00.0: 0:6: DP IN resource available
[   80.752330] thunderbolt 0000:05:00.0: 303:11: DP OUT resource available
[   80.752451] thunderbolt 0000:05:00.0: 3:11: DP OUT resource available


Regards,
Brad
