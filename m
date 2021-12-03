Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFF467F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbhLCVVc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Dec 2021 16:21:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58837 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243299AbhLCVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:21:32 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE174CED20;
        Fri,  3 Dec 2021 22:18:06 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <s5h4k7qtakt.wl-tiwai@suse.de>
Date:   Fri, 3 Dec 2021 22:18:06 +0100
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9C896BDF-FBB1-4C3D-B98E-79D818191DBC@holtmann.org>
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de>
 <6191d067-4eae-4776-5840-1d826113a6d5@molgen.mpg.de>
 <s5h4k7qtakt.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

>>>>> It seems that a few more Intel chips require the workaround for the
>>>>> broken initial command.  At least, per openSUSE Bugzilla reports,
>>>>> 8087:0a2a and 8087:0026 need BTUSB_INTEL_BROKEN_INITIAL_NCMD flag.
>>>>> 
>>>>> Fixes: 83f2dafe2a62 ("Bluetooth: btintel: Refactoring setup routine for legacy ROM sku")
>>>>> Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193124
>>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>>> 
>>>> 
>>>> […]
>>>> 
>>>> I have a Dell Latitude E7250 with
>>>> 
>>>>     Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless interface
>>>> 
>>>> and Bluetooth seems to work fine minus some Linux warnings [1] and a
>>>> problem transferring greater than some bytes files with the Nokia N9
>>>> [2].
>>>> 
>>>> Linux 5.16-rc3, Dell Inc. Latitude E7250/0TVD2T, BIOS A19 01/23/2018:
>>>> 
>>>> ```
>>>> $ sudo dmesg | grep -i bluet
>>>> [    8.173417] calling  bt_init+0x0/0xb3 [bluetooth] @ 301
>>>> [    8.173439] Bluetooth: Core ver 2.22
>>>> [    8.173463] NET: Registered PF_BLUETOOTH protocol family
>>>> [    8.173464] Bluetooth: HCI device and connection manager initialized
>>>> [    8.173467] Bluetooth: HCI socket layer initialized
>>>> [    8.173470] Bluetooth: L2CAP socket layer initialized
>>>> [    8.173473] Bluetooth: SCO socket layer initialized
>>>> [    8.173475] initcall bt_init+0x0/0xb3 [bluetooth] returned 0 after 35 usecs
>>>> [    8.216875] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
>>>> [    8.233515] bluetooth hci0: firmware: direct-loading firmware intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
>>>> [    8.233520] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
>>>> [    8.540884] Bluetooth: hci0: unexpected event for opcode 0xfc2f
>>>> [    8.558942] Bluetooth: hci0: Intel BT fw patch 0x32 completed & activated
>>>> ```
>>> 
>>> Thanks, so this seems depending on the hardware, maybe a subtle
>>> difference matters.  As far as I read the code changes, the workaround
>>> was applied in the past unconditionally, so it must be fairly safe
>>> even if the chip works as is.
>> 
>> Maybe add that to the commit message?
> 
> Maybe, if the upstream agrees with that.  More comments needed from
> Intel, as it's a kind of black magic.
> 
>>> Or, for avoiding the unnecessarily application of the workaround,
>>> should it be changed as a fallback after the failure at the first
>>> try...?
>> 
>> Reading through the openSUSE Bugzilla issue, the failure is:
>> 
>>    Bluetooth: hci0: Reading Intel version command failed (-110)
>>    Bluetooth: hci0: command 0xfc05 tx timeout
>> 
>> I couldn’t find the report for 8087:0a2a in the issue.
> 
> There two different machines in the report.
> 
>> Can you check,
>> what firmware is used?
> 
> It's the place before loading the firmware, so the firmware version
> doesn't matter.

I want to apply this quirk to as little devices as possible. It is one of these quirks we have to hardcode per USB VID:PID since we can’t auto-detect which boot loader is faulty.

So before I blacklist them, we better get a good understand of which they are. Can you include a btmon trace for that part. You most likely have to blacklist btusb.ko, start btmon and then load btusb.ko manually. One with and one without the quirk. And add that to the commit message.

We then try to find that module internally. It must be some SKU that we didn’t have in our test rack.

Regards

Marcel

