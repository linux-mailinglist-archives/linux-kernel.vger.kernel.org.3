Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32507466864
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359545AbhLBQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:35:40 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35735 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348040AbhLBQfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:35:39 -0500
Received: from [192.168.0.2] (ip5f5aeaa8.dynamic.kabel-deutschland.de [95.90.234.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D289461EA1927;
        Thu,  2 Dec 2021 17:32:14 +0100 (CET)
Message-ID: <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
Date:   Thu, 2 Dec 2021 17:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20211202162256.31837-1-tiwai@suse.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211202162256.31837-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi,


Am 02.12.21 um 17:22 schrieb Takashi Iwai:
> It seems that a few more Intel chips require the workaround for the
> broken initial command.  At least, per openSUSE Bugzilla reports,
> 8087:0a2a and 8087:0026 need BTUSB_INTEL_BROKEN_INITIAL_NCMD flag.
> 
> Fixes: 83f2dafe2a62 ("Bluetooth: btintel: Refactoring setup routine for legacy ROM sku")
> Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193124
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 

[…]

I have a Dell Latitude E7250 with

     Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless 
interface

and Bluetooth seems to work fine minus some Linux warnings [1] and a 
problem transferring greater than some bytes files with the Nokia N9 [2].

Linux 5.16-rc3, Dell Inc. Latitude E7250/0TVD2T, BIOS A19 01/23/2018:

```
$ sudo dmesg | grep -i bluet
[    8.173417] calling  bt_init+0x0/0xb3 [bluetooth] @ 301
[    8.173439] Bluetooth: Core ver 2.22
[    8.173463] NET: Registered PF_BLUETOOTH protocol family
[    8.173464] Bluetooth: HCI device and connection manager initialized
[    8.173467] Bluetooth: HCI socket layer initialized
[    8.173470] Bluetooth: L2CAP socket layer initialized
[    8.173473] Bluetooth: SCO socket layer initialized
[    8.173475] initcall bt_init+0x0/0xb3 [bluetooth] returned 0 after 35 
usecs
[    8.216875] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 
17 2014
[    8.233515] bluetooth hci0: firmware: direct-loading firmware 
intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
[    8.233520] Bluetooth: hci0: Intel Bluetooth firmware file: 
intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
[    8.540884] Bluetooth: hci0: unexpected event for opcode 0xfc2f
[    8.558942] Bluetooth: hci0: Intel BT fw patch 0x32 completed & activated
```


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=215189
[2]: 
https://lore.kernel.org/linux-bluetooth/cf71bdea-ec22-e4c9-016c-69e94a130607@molgen.mpg.de/T/#t
