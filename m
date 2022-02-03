Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D94A81A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbiBCJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:42:37 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:49676 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBCJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:42:35 -0500
Date:   Thu, 03 Feb 2022 09:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643881353;
        bh=umsmVBhxBzFpstdXmBJyGNmwtWTplm/datIKdGvTSy8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=VEwp6T3F2Ta5/JoexMTbFv009T0+Piy+ceLsGmnkFfNCUu0+0maTTKMqgziDHSgT/
         KVPWEU9Sq6e0tYAFBjxCsRA8RurlsViLZL6eD3q3FatRtRvc4Af8ksZZBGUghmbrIt
         90mlPKwE99ARvmfow1hv+mWVPTQNr5ulGkoKvaIHPAe2LoPM8wcESVnm+iD1MM4lHx
         1S/U9Qu9u/vNP4XrOHTpmfjRBFwldGXVIcur9IS38WF9DLDQUYBo04M5F7F2kMBGzE
         n/oCwja71K3dTGbQhkdIGxTRHNa2YzgTwenY6rAFn23gVy9dSPFNNvRZz69eYC3ZdX
         XdYvWBtvg4MIQ==
To:     ath10k@lists.infradead.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: QCA6174 connection issues when loading board firmware
Message-ID: <20220203094137.110313-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Scroll down for tl;dr)

Hi,

I'm trying to fix a poor WiFi range issue with QCA6174 on the Xiaomi Mi
Note 2, an Android phone that I'm running the mainline kernel on.

Running `nmcli d wifi list --rescan yes` only shows the router that I'm
sitting next to with weak signal. I'm able to connect to it and use it
but with fluctuating speed. There are many other networks in the area
but none of them are found.

I found that this is caused by the lack of board firmware for this device.
Using the firmware from linux-firmware, this is what I get in dmesg
from ath10k:

[  132.079112] ath10k_pci 0000:01:00.0: qca6174 hw3.2 target 0x05030000 chi=
p_id 0x00342aff sub 0000:0000
[  132.079161] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1 tracing 1=
 dfs 0 testmode 0
[  132.079538] ath10k_pci 0000:01:00.0: firmware ver WLAN.RM.4.4.1-00157-QC=
ARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp crc32 90eebefb
[  132.151817] ath10k_pci 0000:01:00.0: failed to fetch board data for bus=
=3Dpci,vendor=3D168c,device=3D003e,subsystem-vendor=3D0000,subsystem-device=
=3D0000 from ath10k/QCA6174/hw3.0/board-2.bin
[  132.152968] ath10k_pci 0000:01:00.0: board_file api 1 bmi_id N/A crc32 e=
d5f849a
[  132.248837] ath10k_pci 0000:01:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal =
otp max-sta 32 raw 0 hwcrypto 1
[  132.333615] ath: EEPROM regdomain: 0x6c
[  132.333654] ath: EEPROM indicates we should expect a direct regpair map
[  132.333676] ath: Country alpha2 being used: 00
[  132.333693] ath: Regpair used: 0x6c
[  132.377571] ath10k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

After seeing this line:

[  132.151817] ath10k_pci 0000:01:00.0: failed to fetch board data for bus=
=3Dpci,vendor=3D168c,device=3D003e,subsystem-vendor=3D0000,subsystem-device=
=3D0000 from ath10k/QCA6174/hw3.0/board-2.bin

I tried to add the board firmware, which I extracted from the device's
vendor partition. I got a bd30_a4.bin file which is originally loaded by th=
e
QCA_CLD driver of the stock downstream kernel used in Android. I used
ath10k-bdencoder to pack it into a board-2.bin file using this json, which
has the names property taken from the error in dmesg:

[
  {
          "data": "bdf/bd30_a4.bin",
          "names": ["bus=3Dpci,vendor=3D168c,device=3D003e,subsystem-vendor=
=3D0000,subsystem-device=3D0000"]
  }
]

(I placed bd30_a4.bin and this json in a "bdf" directory in the same path
as ath10k-bdencoder)

Using the new board-2.bin which I placed in /lib/firmware/ath10k/QCA6174/hw=
3.0,
ath10k_pci no longer complains about missing board firmware:

[  136.169440] ath10k_pci 0000:01:00.0: qca6174 hw3.2 target 0x05030000 chi=
p_id 0x00342aff sub 0000:0000
[  136.169579] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1 tracing 1=
 dfs 0 testmode 0
[  136.170347] ath10k_pci 0000:01:00.0: firmware ver WLAN.RM.4.4.1-00157-QC=
ARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp crc32 90eebefb
[  136.236498] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A crc32 9=
eaa9261
[  136.338639] ath10k_pci 0000:01:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal =
otp max-sta 32 raw 0 hwcrypto 1
[  136.421749] ath: EEPROM regdomain sanitized
[  136.421771] ath: EEPROM regdomain: 0x64
[  136.421782] ath: EEPROM indicates we should expect a direct regpair map
[  136.421794] ath: Country alpha2 being used: 00
[  136.421802] ath: Regpair used: 0x64
[  136.465447] ath10k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

And now, running `nmcli d wifi list --rescan yes` shows several networks
with good signal strength similar to what I get in Android. However,
as soon as I try to connect to any network, it fails to connect saying
the network is not found, and when listing networks again, I get an empty
list. the networks appear again after a few seconds, but trying to connect
causes the same issue making it impossible to connect to any network.

No messages from ath10k appear in dmesg when this happens. I also tried
enabling ath0k's trace events, but nothing appears in the trace log when
this happens either. I'm not sure how and where to start debugging, so it
would be much appreciated if someone gives me some leads.

I also tried packing the vendor firmware (otp30.bin, qwlan30.bin) using
ath10k-fwencoder and using it alongside the board firmware I packed,
but that didn't change anything.

Also, shouldn't subsystem-vendor and subsystem-device be something other
than 0000:0000?

tl;dr:
 - poor range on QCA6174 without board firmware, loading board firmware
   fixes signal strength but makes chip fail to connect to any network.
 - subsystem-vendor and subsystem-device are zeroes.
=20
Thanks,
Yassine


