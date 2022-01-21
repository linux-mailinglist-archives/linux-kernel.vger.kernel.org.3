Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7278495CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbiAUJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiAUJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:22:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D3C061574;
        Fri, 21 Jan 2022 01:22:59 -0800 (PST)
Received: from [IPv6:2a00:c281:14a3:8100:790d:f8e9:248f:920d] (unknown [IPv6:2a00:c281:14a3:8100:790d:f8e9:248f:920d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D983E1F45A16;
        Fri, 21 Jan 2022 09:22:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642756977;
        bh=0TIsGlnLKMUom5ggVD25li7Cq1Lj4YN0nlzLub4RZbg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nVulpkLIhGN9sTcIsd5KLT+Adyk/QC0TpLFvujsCBEcTYb8KUIC45depU9jw339/d
         wopGCXMlnuhvdRNgxyonIAoyUDeY09/DkB8g0r1n/bLIs71L0cIoA/PQo9n+y26w6w
         9CduqbwQ2xCgYMyN8K+RNlXIPAs1ae9uEdTVwLnxYW/NY6+PKkLfJG2sIfPSQRJi+X
         5orh1aDF87gohud81DWvXNHaWI8dJzrIAKuMloNitj2ZR+0JPv8mR2TYwSE6gMAYyZ
         m9swsXbFw57OFW78PbnfT/DG+cPF+BG1X08OUyV+UFShBSEXwEKxtgAT/9aHabUJx3
         dICyRaWXR01EQ==
Subject: Re: [PATCH v4 1/6] staging: media: wave5: Add vpuapi layer
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
 <20211201175613.13710-2-dafna.hirschfeld@collabora.com>
 <CAFr9PX=6Pd1Rg=wJvpuX6WX63L=iAnwPA24e59An3Kac5f_vzA@mail.gmail.com>
 <cdd9b485-364f-c6bd-776f-a0ca2d260762@collabora.com>
 <e9905774-a994-6311-7b53-b40588d4f6ec@collabora.com>
 <CAFr9PXnnGc1TUQBeW8JW9qGewhU99gmRbvzZEsZaDmr12jMg0A@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <25e7d6db-1cff-6fd5-1071-1f21c5ff7a8a@collabora.com>
Date:   Fri, 21 Jan 2022 11:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXnnGc1TUQBeW8JW9qGewhU99gmRbvzZEsZaDmr12jMg0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.21 12:20, Daniel Palmer wrote:
> Hi Dafna,
> 
> On Tue, 14 Dec 2021 at 16:48, Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
>>>>> +static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
>>>>> +{
>>>>> +       u32 gdi_status_check_value = 0x3f;
>>>>> +       u32 data;
>>>>> +
>>>>> +       if (vpu_dev->product_code == WAVE521C_CODE ||
>>>>> +           vpu_dev->product_code == WAVE521_CODE ||
>>>>> +        vpu_dev->product_code == WAVE521E1_CODE)
>>>>> +               gdi_status_check_value = 0x00ff1f3f;
>>>>> +
>>>>> +       return read_poll_timeout(wave5_vdi_read_register, data, data == gdi_status_check_value,
>>>>> +                                0, timeout * 1000, false, vpu_dev, addr);
>>>>> +}
>>>>> +
>>>>
>>>> This looks like it should be s/wave5_vdi_read_register/wave5_read_register/.
>>>> For wave511 addr passed in here is 0x8e14 so well outside of what is
>>>> directly accessible.
>>>
>>> Hi, I didn't understand this explanation. I see that
>>> wave5_read_register eventually calls 'wave5_vdi_read_register'.
>>> Could you please explain in more detail why you think
>>> calling wave5_vdi_read_register is wrong?
> 
> Mainly because the address accessed 0x8e14 but on my machine the
> directly accessible registers end at 0x800.
> 
>> hi, I see know that those backbone address are indeed not read and written directly but
>> the address should be first written to a regsiter W5_VPU_FIO_CTRL_ADDR,
>> and then the content is returned from W5_VPU_FIO_DATA.
> 
> I think so. But as I can't get this driver to fully work yet I can
> only say I think so.

Hi,
Thanks a lot for helping me with compiling the kernel and booting the smart display 'ido-sbc2d70-v1b'.
I am now at a point where the probe of the driver on that board fails with:

[   30.710385] write --> 0x000000f0:0x00000001
[   30.727445] wave5_vpu_reset:1594
[   30.730712] write --> 0x00000070:0x00000000
[   30.734944] wave5_vpu_reset:1652
[   30.738186] write --> 0x00000024:0x00000007
[   30.742382] write --> 0x00000020:0x00018e10
[   40.746598] wave5_vpu_reset:1656
[   40.749849] CPU: 1 PID: 1 Comm: sh Not tainted 5.16.0-11196-gd076cd89f795-dirty #14
[   40.757531] Hardware name: MStar/Sigmastar Armv7 (Device Tree)
[   40.763389]  unwind_backtrace from show_stack+0x10/0x14
[   40.768647]  show_stack from dump_stack_lvl+0x40/0x4c
[   40.773720]  dump_stack_lvl from wave5_wait_bus_busy+0x10/0x44
[   40.779579]  wave5_wait_bus_busy from wave5_vpu_reset+0x28c/0x584
[   40.785696]  wave5_vpu_reset from wave5_vpu_init_with_bitcode+0x58/0xe8
[   40.792337]  wave5_vpu_init_with_bitcode from wave5_vpu_probe+0x2b0/0x560
[   40.799153]  wave5_vpu_probe from platform_probe+0x5c/0xb8
[   40.804663]  platform_probe from really_probe+0xc0/0x2fc
[   40.809998]  really_probe from __driver_probe_device+0x84/0xe4
[   40.815854]  __driver_probe_device from device_driver_attach+0x24/0x50
[   40.822407]  device_driver_attach from bind_store+0x80/0xec
[   40.828002]  bind_store from kernfs_fop_write_iter+0x118/0x1b4
[   40.833860]  kernfs_fop_write_iter from vfs_write+0x308/0x3fc
[   40.839631]  vfs_write from ksys_write+0xa4/0xd4
[   40.844268]  ksys_write from ret_fast_syscall+0x0/0x54
[   40.849427] Exception stack(0xc189dfa8 to 0xc189dff0)
[   40.854497] dfa0:                   004751a8 00000015 00000001 004751a8 00000015 00000001
[   40.862700] dfc0: 004751a8 00000015 00000001 00000004 00000015 bea7eb50 00460a6d 004745e4
[   40.870900] dfe0: 00000000 bea7e924 0045d43f b6f71cf6
[   40.875987] write --> 0x00000020:0x00008e14
[   50.880186] write --> 0x00000024:0x00000000
[   50.884397] write --> 0x00000020:0x00018e10
[   60.888598] vdec 1f344800.video-codec: wave5_vpu_reset failed -16
[   60.894726] vdec 1f344800.video-codec: vpu_init_with_bitcode fail
[   60.900889] vcc_5v: disabling
[   60.903890] vcc_sd: disabling
[   60.904026] vdec 1f344800.video-codec: failed to wave5_vpu_load_firmware: -16
[   60.906869] vcc_4g: disabling
[   60.914729] vdec: probe of 1f344800.video-codec failed with error -16

Were you able to reach a point where the probe succeed ?
Could you write in more detail to which point were you able to make the driver work?
Does the driver code in https://github.com/linux-chenxing/linux/tree/mstar_v5_17_rebase includes a fix to the bug you mentioned above?

Thanks,
Dafna

> 
> Cheers,
> 
> Daniel
> 
