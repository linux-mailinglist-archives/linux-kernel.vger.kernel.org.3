Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E367349F761
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiA1KhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiA1KhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:37:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29EBC061714;
        Fri, 28 Jan 2022 02:37:01 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nDOcl-0007kO-ER; Fri, 28 Jan 2022 11:36:59 +0100
Message-ID: <371027df-7f32-edab-208d-d4cdd2202ba6@leemhuis.info>
Date:   Fri, 28 Jan 2022 11:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
        Takashi Iwai <tiwai@suse.com>
References: <eb6d86eb-d156-d7ac-0965-181719023d51@molgen.mpg.de>
 <CABBYNZLENxvXMCh6XbBSnu0jasV1F0QestEK5v2mnNUpJdw3Vw@mail.gmail.com>
 <cf71bdea-ec22-e4c9-016c-69e94a130607@molgen.mpg.de>
 <a93c0fa7-7b84-6aea-265b-c913e0c84678@molgen.mpg.de>
 <d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Unable to transfer big files to Nokia N9
In-Reply-To: <d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643366222;859ced8c;
X-HE-SMSGID: 1nDOcl-0007kO-ER
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 16.01.22 14:27, Paul Menzel wrote:
> #regzbot introduced: 81be03e026dc0c16dc1c64e088b2a53b73caa895

thx for getting regzbot involved, much appreciated!

> Dear Luiz,
> 
> It turns out there was a regression in Linux 5.16-rc1.

@bt-maintaners, what's the status here? Paul reported that over ten days
ago and there wasn't a single reply. Or did the discussion move
somewhere else?

@Paul: just wondering, did you give 5.17-rc1 a try? Might be worth a
shot, if only to confirm the issue is still present.

Ciao, Thorsten

> Am 20.12.21 um 22:31 schrieb Paul Menzel:
> 
>> Am 01.12.21 um 23:07 schrieb Paul Menzel:
>>
>>> Am 01.12.21 um 19:29 schrieb Luiz Augusto von Dentz:
>>>
>>>> On Wed, Dec 1, 2021 at 9:39 AM Paul Menzel <pmenzel@molgen.mpg.de>
>>>> wrote:
>>>
>>>>> For the first time, I wanted to transfer a 2 MB PDF file from a Dell
>>>>> Latitude E7250 with Debian sid/unstable with Linux 5.16-rc1 to a Nokia
>>>>> N9 (MeeGo/Harmattan). Using the package *bluez-obexd* 5.61-1 and GNOME
>>>>> 41, the device was found, and paired fine. Then I selected to transfer
>>>>> the 2 MB file, and after starting for a second, it timed out after the
>>>>> progress bar moves forward ones and failed.
>>>>>
>>>>> The systemd journal contains:
>>>>>
>>>>>       obexd[21139]: Transfer(0x56243fe4f790) Error: Timed out
>>>>> waiting for response
>>>>>
>>>>> Testing with a a 5 byte test text file, worked fine. Also testing
>>>>> with a
>>>>> Galaly M32, both files were transferred without problems (though
>>>>> slowly
>>>>> with 32 KB/s.)
>>>>>
>>>>> Trying to connect to the device with bluetoothctl failed for me,
>>>>> and the
>>>>> journal contained, it failed.
>>>>>
>>>>>       $ bluetoothctl
>>>>>       Agent registered
>>>>>       [bluetooth]# connect 40:98:4E:5B:CE:XX
>>>>>       Attempting to connect to 40:98:4E:5B:CE:XX
>>>>>       Failed to connect: org.bluez.Error.Failed
>>>>>
>>>>>       bluetoothd[21104]: src/service.c:btd_service_connect()
>>>>> a2dp-source profile connect failed for 40:98:4E:5B:CE:B3: Protocol
>>>>> not available
>>>>>
>>>>> As the Nokia N9 was once pretty popular in the Linux community, I am
>>>>> pretty sure, it used to work fine in the past, and there is some
>>>>> regression. It’d be great, if you could give me some hints how to
>>>>> further debug the issue.
>>>>
>>>> We will need some logs, obexd and btmon, if possible.
>>>
>>> I only managed to get the btmon trace [1]. I did `sudo modprobe -r
>>> btusb` and `sudo btmon -w /dev/shm/trace.log`.
>>>
>>> Linux messages:
>>>
>>>      [29880.100381] calling  btusb_driver_init+0x0/0x1000 [btusb] @
>>> 28716
>>>      [29880.239603] usbcore: registered new interface driver btusb
>>>      [29880.239608] initcall btusb_driver_init+0x0/0x1000 [btusb]
>>> returned 0 after 135952 usecs
>>>      [29880.240706] Bluetooth: hci0: unexpected event for opcode 0x0500
>>>      [29880.241598] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0
>>> build 3 week 17 2014
>>>      [29880.241605] Bluetooth: hci0: Intel device is already patched.
>>> patch num: 32
>>>
>>>  From the system journal:
>>>
>>>      Dez 01 22:52:19 ersatz obexd[21139]: Transfer(0x56243fe53dd0)
>>> Error: Timed out waiting for response
>>
>> Were you able to see anything in the attached logs? If the obexd logs
>> are missing, can you please tell how I should capture them?
>>
>> I also tested with Ubuntu 20.04 (*linux-image-5.11.0-27-generic*) and
>> 21.10 (*linux-image-5.13.0-19-generic*) live systems booted from a USB
>> storage device, and transferring `/usr/bin/systemctl`
>> (`/lib/systemd/systemd`) with size of 1.8 MB worked fine.
>>
>> Could there be a regression in that area? Unfortunately, it’s not easy
>> for me to do a bisection on the device at hand.
>>
>> (Would it be possible to do with QEMU and USB controller and Bluetooth
>> device passthrough? How can I transfer the file on the command line so
>> I wouldn’t need to install a desktop environment?)
> 
> Turns out, that is indeed possible [2], but turned out to be cumbersome,
> as I hit the regression [3], which seems to have been fixed by commit
> 95655456e7ce (Bluetooth: btintel: Fix broken LED quirk for legacy ROM
> devices) merged in the current Linux 5.17 cycle this week.
> 
> As a work around, I applied a hunk from Takashi’s patch.
> 
> -       { USB_DEVICE(0x8087, 0x0a2a), .driver_info =
> BTUSB_INTEL_COMBINED },
> +       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> + BTUSB_INTEL_BROKEN_INITIAL_NCMD },
> 
> My problem with the Nokia N9 is still present in Linus’ master branch.
> 
> Then I built a minimal Linux kernel for QEMU, and ran:
> 
>     qemu-system-x86_64 -cpu host -m 2G -enable-kvm \
>       -usb -device usb-host,vendorid=0x8087,productid=0x0a2a \
>       -drive file=/dev/shm/debian-64.img,format=raw,if=virtio \
>       -net nic -net user,hostfwd=tcp::22223-:22 \
>       -kernel /dev/shm/bzImage -append "root=/dev/vda1 rw quiet"
> 
> In the Debian sid/unstable VM, I used
> 
>     ssh root@localhost -p 22223
> 
> I once had to pair the VM with the Nokia N9 in bluetoothctl, and then
> started `/usr/libexec/bluetooth/obexd`, and ran `obexctl`, and connected
> first with `connect`, and then ran `send /lib/systemd/systemd` to
> transfer the file. In the problematic cases it stopped/hung after the
> first progress message.
> 
>     # obexctl
>     [NEW] Client /org/bluez/obex
>     [obex]# connect 40:98:4E:5B:CE:XX
>     Attempting to connect to 40:98:4E:5B:CE:XX
>     [NEW] Session /org/bluez/obex/client/session0 [default]
>     [NEW] ObjectPush /org/bluez/obex/client/session0
>     Connection successful
>     [40:98:4E:5B:CE:XX]# send /lib/systemd/systemd
>     Attempting to send /lib/systemd/systemd to
> /org/bluez/obex/client/session0
>     [NEW] Transfer /org/bluez/obex/client/session0/transfer0
>     Transfer /org/bluez/obex/client/session0/transfer0
>         Status: queued
>         Name: systemd
>         Size: 1841712
>         Filename: /lib/systemd/systemd
>         Session: /org/bluez/obex/client/session0
>     [CHG] Transfer /org/bluez/obex/client/session0/transfer0 Status: active
>     [CHG] Transfer /org/bluez/obex/client/session0/transfer0
> Transferred: 32737 (@32KB/s 00:55)
>     [CHG] Transfer /org/bluez/obex/client/session0/transfer0 Status: error
>     [DEL] Transfer /org/bluez/obex/client/session0/transfer0
> 
> Some manual bisection of Linux releases, verified, that the regression
> was introduced in Linux 5.16-rc1. (Lucky me, I started using Bluetooth
> with the Nokia with Linux 5.16-rc1.) Then I verified it was introduced
> by the Bluetooth pull request for Linux 5.16. Then I picked commit
> 81be03e026dc0c16dc1c64e088b2a53b73caa895 due to the commit message, and
> bisected from there, and it turns out, that this commit is actually
> introducing the regression.
> 
>     $ git bisect good
>     81be03e026dc0c16dc1c64e088b2a53b73caa895 is the first bad commit
>     commit 81be03e026dc0c16dc1c64e088b2a53b73caa895
>     Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Date:   Fri Sep 3 15:27:32 2021 -0700
> 
>         Bluetooth: RFCOMM: Replace use of memcpy_from_msg with
> bt_skb_sendmmsg
> 
>         This makes use of bt_skb_sendmmsg instead using memcpy_from_msg
> which
>         is not considered safe to be used when lock_sock is held.
> 
>         Also make rfcomm_dlc_send handle skb with fragments and queue
> them all
>         atomically.
> 
>         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>         Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
>      net/bluetooth/rfcomm/core.c | 50
> ++++++++++++++++++++++++++++++++++++++-------
>      net/bluetooth/rfcomm/sock.c | 46
> +++++++++--------------------------------
>      2 files changed, 53 insertions(+), 43 deletions(-)
> 
> Unfortunately, the patch does not cleanly revert, so users have to wait
> until an expert can take a look, and come up with a fix.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: For the records:
> 
>     $ git bisect log
>     # bad: [81be03e026dc0c16dc1c64e088b2a53b73caa895] Bluetooth: RFCOMM:
> Replace use of memcpy_from_msg with bt_skb_sendmmsg
>     # good: [49d8a5606428ca0962d09050a5af81461ff90fbb] Bluetooth: fix
> init and cleanup of sco_conn.timeout_work
>     git bisect start '81be03e026dc0' 'HEAD^'
>     # good: [904c139a2517191e48f9cb1bb2d611ae59434009] Bluetooth: Add
> support for msbc coding format
>     git bisect good 904c139a2517191e48f9cb1bb2d611ae59434009
>     # good: [8bba13b1d08d42e2e8308924fa5c1551a7b2b011] Bluetooth:
> btintel: Fix incorrect out of memory check
>     git bisect good 8bba13b1d08d42e2e8308924fa5c1551a7b2b011
>     # good: [38f64f650dc0e44c146ff88d15a7339efa325918] Bluetooth: Add
> bt_skb_sendmsg helper
>     git bisect good 38f64f650dc0e44c146ff88d15a7339efa325918
>     # good: [0771cbb3b97d3c1d68eecd7f00055f599954c34e] Bluetooth: SCO:
> Replace use of memcpy_from_msg with bt_skb_sendmsg
>     git bisect good 0771cbb3b97d3c1d68eecd7f00055f599954c34e
>     # first bad commit: [81be03e026dc0c16dc1c64e088b2a53b73caa895]
> Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>> [1]: https://owww.molgen.mpg.de/~pmenzel/trace.log.7z
> [2]:
> https://lore.kernel.org/linux-bluetooth/5891f0d5-8d51-9da5-7663-718f301490b1@molgen.mpg.de/T/#u
> 
> [3]:
> https://lore.kernel.org/linux-bluetooth/20211202162256.31837-1-tiwai@suse.de/
> 
> 
> 
