Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A44463B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhK3QQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:16:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:30423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhK3QQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:16:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223477101"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223477101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:13:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="512253127"
Received: from felsner-mobl2.ger.corp.intel.com (HELO [10.249.36.147]) ([10.249.36.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:13:28 -0800
Subject: Re: [RFCv2 0/8] USI stylus support series
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
 <CAO-hwJLq6Jnvos=CR_-D6FD-7W56q2eYRVyRMbmE5NFaXLHrng@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
Message-ID: <4c87f439-f6d0-97e7-156e-90e9baab4b01@linux.intel.com>
Date:   Tue, 30 Nov 2021 18:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJLq6Jnvos=CR_-D6FD-7W56q2eYRVyRMbmE5NFaXLHrng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 30/11/2021 16:44, Benjamin Tissoires wrote:
> Hi Tero,
>
> On Fri, Nov 26, 2021 at 2:02 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Hi,
>>
>> This series is an update based on comments from Benjamin. What is done
>> is this series is to ditch the separate hid-driver for USI, and add the
>> generic support to core layers. This part basically brings the support
>> for providing USI events, without programmability (patches 1-6).
> That part seems to be almost good for now. I have a few things to check:
> - patch2: "HID: hid-input: Add suffix also for HID_DG_PEN" I need to
> ensure there are no touchscreens affected by this (there used to be a
> mess with some vendors where they would not declare things properly)
> - patch5: "HID: core: map USI pen style reports directly" this one
> feels plain wrong. I would need to have a look at the report
> descriptor but this is too specific in a very generic code

Relevant part of the report descriptor is here:

     Field(8)
       Physical(Digitizers.Stylus)
       Logical(Digitizers.Preferred Line Style)
       Application(Digitizers.Pen)
       Usage(6)
         Digitizers.Ink
         Digitizers.Pencil
         Digitizers.Highlighter
         Digitizers.Chisel Marker
         Digitizers.Brush
         Digitizers.No Preference
       Logical Minimum(1)
       Logical Maximum(6)
       Physical Minimum(0)
       Physical Maximum(255)
       Unit Exponent(-1)
       Unit(SI Linear : Centimeter)
       Report Size(8)
       Report Count(1)
       Report Offset(88)
       Flags( Variable Absolute NoPreferredState )

To me, it looks almost like it is a bug in the report descriptor itself; 
as you see there are 6 usage values but the report size / count is 1 
byte. The fact that there are 6 usage values in the field confuses 
hid-core. Basically the usage values are used as encoded content for the 
field.

Alternatively I think this could be patched up in the BPF program, as I 
am modifying the content of the raw hid report already; I could just as 
well modify this one also. Or, maybe I could fix the report descriptor 
itself to act as a sane variable, as I am parsing the report descriptor 
already?

>
>> Additionally, a HID-BPF based sample is provided which can be used to
>> program / query pen parameters in comparison to the old driver level
>> implementation (patches 7-8, patch #8 is an incremental change on top of
>> patch #7 which just converts the fifo to socket so that the client can
>> also get results back from the server.)
> After a few more thoughts, I wondered what your input is on this. We
> should be able to do the very same with plain hidraw... However, you
> added a `hid/raw_event` processing that will still be kept in the
> kernel, so maybe bpf would be useful for that at least.

Yes, plain hidraw can be sort of used to program the values, however the 
interface is kind of annoying to use for the USI pens. You need to be 
touching the display with the pen before anything is accepted. Maybe 
writing some support code to the libevdev would help.

The hidraw hook is needed for processing the cached values also, USI 
pens report their parameters with a delay of some few hundred ms 
depending on controller vendor. And in some cases they don't report 
anything back before forcibly querying the value from the controller, 
and also the write mechanism acts differently; some controllers report 
the programmed value back, others keep reporting the old value until the 
pen leaves the screen and touches it again.


>
>> The whole series is based on top of Benjamin's hid-bpf support work, and
>> I've pushed a branch at [1] with a series that works and brings in
>> the dependency. There are also a few separate patches in this series to
>> fix the problems I found from Benjamin's initial work for hid-bpf; I
>> wasn't able to get things working without those. The branch is also
>> based on top of 5.16-rc2 which required some extra changes to the
>> patches from Benjamin.
> Yeah, I also rebased on top of 5.16 shortly after sharing that branch
> and got roughly the same last fix (HID: bpf: compile fix for
> bpf_hid_foreach_rdesc_item). I am *very* interested in your "HID: bpf:
> execute BPF programs in proper context" because that is something that
> was bothering me a lot :)

Right, I think I have plenty of lockdep / scheduler checks enabled in my 
kernel. They generate plenty of spam with i2c-hid without that patch. 
The same issue may not be visible with some other low level hid devices 
though, I don't have testing capability for anything but the i2c-hid 
right now. I2C is quite notorious for the locking aspects as it is slow 
and is used to control some pretty low level stuff like power management 
etc.

>
> "HID: bpf: add expected_attach_type to bpf prog during detach" is
> something I'll need to bring in too
>
> but "HID: bpf: fix file mapping" is actually wrong. I initially wanted
> to attach BPF programs to hidraw, but shortly realized that this is
> not working because the `hid/rdesc_fixup` kills the hidraw node and so
> releases the BPF programs. The way I am now attaching it is to use the
> fd associated with the modalias in the sysfs file (for instance: `sudo
> ./hid_surface_dial /sys/bus/hid/devices/0005:045E:091B.*/modalias`).
> This way, the reference to the struct hid_device is kept even if we
> disconnect the device and reprobe it.
Ok I can check this out if it works me also. The samples lead me to 
/dev/hidraw usage.
>
> Thanks again for your work, and I'd be curious to have your thoughts
> on hid-bpf and if you think it is better than hidraw/evdev write/new
> ioctls for your use case.

The new driver was 777 lines diff, the BPF one is 496 lines so it 
appears smaller. The driver did support two different vendors though 
(ELAN+Goodix, with their specific quirks in place), the BPF only a 
single one right now (ELAN).

The vendor specific quirks are a question, do we want to support that 
somehow in a single BPF binary, or should we attach vendor specific BPF 
programs?

Chromium-os devices are one of the main customers for USI pens right 
now, and I am not sure how well they will take the BPF concept. :) I did 
ask their feedback though, and I'll come back on this once I have something.

Personally, I don't have much preference either way at this moment, both 
seem like feasible options. I might lean a bit towards evdev/ioctl as it 
seems a cleaner implementation as of now. The write mechanism I 
implemented for the USI-BPF is a bit hacky, as it just directly writes 
to a shared memory buffer and the buffer gets parsed by the kernel part 
when it processes hidraw event. Anyways, do you have any feedback on 
that part? BPF is completely new to me again so would love to get some 
feedback.

One option is of course to push the write portion of the code to 
userspace and just use hidraw, but we still need to filter out the bogus 
events somehow, and do that in vendor specific manner. I don't think 
this can be done on userspace, as plenty of information that would be 
needed to do this properly has been lost at the input-event level.

-Tero

>
> Cheers,
> Benjamin
>
>> -Tero
>>
>> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
>>
>>
