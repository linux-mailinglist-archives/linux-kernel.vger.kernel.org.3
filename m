Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091A247B53D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhLTVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:31:49 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51875 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231488AbhLTVbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:31:47 -0500
Received: from [192.168.0.2] (ip5f5aed30.dynamic.kabel-deutschland.de [95.90.237.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 360AD61EA1927;
        Mon, 20 Dec 2021 22:31:46 +0100 (CET)
Message-ID: <a93c0fa7-7b84-6aea-265b-c913e0c84678@molgen.mpg.de>
Date:   Mon, 20 Dec 2021 22:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Unable to transfer big files to Nokia N9
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <eb6d86eb-d156-d7ac-0965-181719023d51@molgen.mpg.de>
 <CABBYNZLENxvXMCh6XbBSnu0jasV1F0QestEK5v2mnNUpJdw3Vw@mail.gmail.com>
 <cf71bdea-ec22-e4c9-016c-69e94a130607@molgen.mpg.de>
In-Reply-To: <cf71bdea-ec22-e4c9-016c-69e94a130607@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Luiz,


Am 01.12.21 um 23:07 schrieb Paul Menzel:

> Am 01.12.21 um 19:29 schrieb Luiz Augusto von Dentz:
> 
>> On Wed, Dec 1, 2021 at 9:39 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
>>> For the first time, I wanted to transfer a 2 MB PDF file from a Dell
>>> Latitude E7250 with Debian sid/unstable with Linux 5.16-rc1 to a Nokia
>>> N9 (MeeGo/Harmattan). Using the package *bluez-obexd* 5.61-1 and GNOME
>>> 41, the device was found, and paired fine. Then I selected to transfer
>>> the 2 MB file, and after starting for a second, it timed out after the
>>> progress bar moves forward ones and failed.
>>>
>>> The systemd journal contains:
>>>
>>>       obexd[21139]: Transfer(0x56243fe4f790) Error: Timed out waiting 
>>> for response
>>>
>>> Testing with a a 5 byte test text file, worked fine. Also testing with a
>>> Galaly M32, both files were transferred without problems (though slowly
>>> with 32 KB/s.)
>>>
>>> Trying to connect to the device with bluetoothctl failed for me, and the
>>> journal contained, it failed.
>>>
>>>       $ bluetoothctl
>>>       Agent registered
>>>       [bluetooth]# connect 40:98:4E:5B:CE:XX
>>>       Attempting to connect to 40:98:4E:5B:CE:XX
>>>       Failed to connect: org.bluez.Error.Failed
>>>
>>>       bluetoothd[21104]: src/service.c:btd_service_connect() 
>>> a2dp-source profile connect failed for 40:98:4E:5B:CE:B3: Protocol 
>>> not available
>>>
>>> As the Nokia N9 was once pretty popular in the Linux community, I am
>>> pretty sure, it used to work fine in the past, and there is some
>>> regression. It’d be great, if you could give me some hints how to
>>> further debug the issue.
>>
>> We will need some logs, obexd and btmon, if possible.
> 
> I only managed to get the btmon trace [1]. I did `sudo modprobe -r 
> btusb` and `sudo btmon -w /dev/shm/trace.log`.
> 
> Linux messages:
> 
>      [29880.100381] calling  btusb_driver_init+0x0/0x1000 [btusb] @ 28716
>      [29880.239603] usbcore: registered new interface driver btusb
>      [29880.239608] initcall btusb_driver_init+0x0/0x1000 [btusb] returned 0 after 135952 usecs
>      [29880.240706] Bluetooth: hci0: unexpected event for opcode 0x0500
>      [29880.241598] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
>      [29880.241605] Bluetooth: hci0: Intel device is already patched. patch num: 32
> 
>  From the system journal:
> 
>      Dez 01 22:52:19 ersatz obexd[21139]: Transfer(0x56243fe53dd0) Error: Timed out waiting for response

Were you able to see anything in the attached logs? If the obexd logs 
are missing, can you please tell how I should capture them?

I also tested with Ubuntu 20.04 (*linux-image-5.11.0-27-generic*) and 
21.10 (*linux-image-5.13.0-19-generic*) live systems booted from a USB 
storage device, and transferring `/usr/bin/systemctl` 
(`/lib/systemd/systemd`) with size of 1.8 MB worked fine.

Could there be a regression in that area? Unfortunately, it’s not easy 
for me to do a bisection on the device at hand.

(Would it be possible to do with QEMU and USB controller and Bluetooth 
device passthrough? How can I transfer the file on the command line so I 
wouldn’t need to install a desktop environment?)


Kind regards,

Paul


> [1]: https://owww.molgen.mpg.de/~pmenzel/trace.log.7z
