Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7046E4AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhLII70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:59:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:28326 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhLII7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218074053"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="txt'?gz'50?scan'50,208,49,50";a="218074053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 00:55:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="txt'?gz'50?scan'50,208,49,50";a="658688600"
Received: from imihalc-mobl1.ger.corp.intel.com (HELO [10.252.52.209]) ([10.252.52.209])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 00:55:50 -0800
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
 <4c87f439-f6d0-97e7-156e-90e9baab4b01@linux.intel.com>
 <CAO-hwJ+Vt81ZKR0Ywa5ffDW1R586dDcPQgOoe8awUOdYWV0Y7Q@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
Message-ID: <fa6b6276-8afb-521b-889f-1a9c63379b17@linux.intel.com>
Date:   Thu, 9 Dec 2021 10:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+Vt81ZKR0Ywa5ffDW1R586dDcPQgOoe8awUOdYWV0Y7Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F3ABB60F91A5847EC875D22B"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F3ABB60F91A5847EC875D22B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Benjamin,

On 08/12/2021 16:56, Benjamin Tissoires wrote:
> Hi Tero,
>
> On Tue, Nov 30, 2021 at 5:13 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Hi Benjamin,
>>
>> On 30/11/2021 16:44, Benjamin Tissoires wrote:
>>> Hi Tero,
>>>
>>> On Fri, Nov 26, 2021 at 2:02 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>>> Hi,
>>>>
>>>> This series is an update based on comments from Benjamin. What is done
>>>> is this series is to ditch the separate hid-driver for USI, and add the
>>>> generic support to core layers. This part basically brings the support
>>>> for providing USI events, without programmability (patches 1-6).
>>> That part seems to be almost good for now. I have a few things to check:
>>> - patch2: "HID: hid-input: Add suffix also for HID_DG_PEN" I need to
>>> ensure there are no touchscreens affected by this (there used to be a
>>> mess with some vendors where they would not declare things properly)
>>> - patch5: "HID: core: map USI pen style reports directly" this one
>>> feels plain wrong. I would need to have a look at the report
>>> descriptor but this is too specific in a very generic code
>> Relevant part of the report descriptor is here:
>>
>>       Field(8)
>>         Physical(Digitizers.Stylus)
>>         Logical(Digitizers.Preferred Line Style)
>>         Application(Digitizers.Pen)
>>         Usage(6)
>>           Digitizers.Ink
>>           Digitizers.Pencil
>>           Digitizers.Highlighter
>>           Digitizers.Chisel Marker
>>           Digitizers.Brush
>>           Digitizers.No Preference
>>         Logical Minimum(1)
>>         Logical Maximum(6)
>>         Physical Minimum(0)
>>         Physical Maximum(255)
>>         Unit Exponent(-1)
>>         Unit(SI Linear : Centimeter)
>>         Report Size(8)
>>         Report Count(1)
>>         Report Offset(88)
>>         Flags( Variable Absolute NoPreferredState )
>>
>> To me, it looks almost like it is a bug in the report descriptor itself;
>> as you see there are 6 usage values but the report size / count is 1
>> byte. The fact that there are 6 usage values in the field confuses
>> hid-core. Basically the usage values are used as encoded content for the
>> field.
> It took me a few days but I finally understand that this report
> descriptor is actually correct.
>
> The descriptor gives an array of 1 element of size 8, which is enough
> to give an index within the available values being [Digitizers.Ink,
> Digitizers.Pencil, Digitizers.Highlighter, Digitizers.Chisel Marker,
> Digitizers.Brush, Digitizers.No Preference]
>
> Given that logical min is 1, this index is 1-based.
>
> So the job of the kernel is to provide the event
> Digitizers.Highlighter whenever the value here is 3. The mapping 3 <->
> Digitizers.Highlighter is specific to this report descriptor and
> should not be forwarded to user space.

Yes, all this is true. I also see you re-wrote this part a bit in the 
series to add individual events for all the different line styles. I'll 
give this a shot and see how it works out. A problem I see is that we 
need to be able to program the pen line style also somehow, do we just 
set a single pen style to "enabled" and all the rest get set to 
"disabled" under the hood?


>
>> Alternatively I think this could be patched up in the BPF program, as I
>> am modifying the content of the raw hid report already; I could just as
>> well modify this one also. Or, maybe I could fix the report descriptor
>> itself to act as a sane variable, as I am parsing the report descriptor
>> already?
> I couldn't understand the fix you did in the BPF program. Can you
> explain it by also giving me an example of raw event from the device
> and the outputs (fixed and not fixed) of the kernel?

The fix in the BPF code is this (under process_tag()):

                         /*
                          * Force flags for line style. This makes it act
                          * as a simple variable from HID core point of 
view.
                          */
                         bpf_hid_set_data(ctx, (*idx + 1) << 3, 8, 0x2);

After that, the pen line style gets forwarded as a simple integer value 
to input-core / userspace also. raw events did not need modification 
after all, I just modified the report descriptor.

>
>
> Talking about that, I realized that you gave me the report descriptor
> of the Acer panel in an other version of this RFC. Could you give me:
> - the bus used (USB or I2C)?
I have been using I2C in all my testing, the controllers I have access 
to are behind I2C only.
> - the vendor ID?
> - the product ID?
> - and the same for the other panel, with its report descriptor?
>
> This way I can add them in the testsuite, and start playing with them.
Attached a tarball with both descriptors and their corresponding IDs 
(copied the R+N+I data from hid-recorder.)
>
>>>> Additionally, a HID-BPF based sample is provided which can be used to
>>>> program / query pen parameters in comparison to the old driver level
>>>> implementation (patches 7-8, patch #8 is an incremental change on top of
>>>> patch #7 which just converts the fifo to socket so that the client can
>>>> also get results back from the server.)
>>> After a few more thoughts, I wondered what your input is on this. We
>>> should be able to do the very same with plain hidraw... However, you
>>> added a `hid/raw_event` processing that will still be kept in the
>>> kernel, so maybe bpf would be useful for that at least.
>> Yes, plain hidraw can be sort of used to program the values, however the
>> interface is kind of annoying to use for the USI pens. You need to be
>> touching the display with the pen before anything is accepted. Maybe
>> writing some support code to the libevdev would help.
>>
>> The hidraw hook is needed for processing the cached values also, USI
>> pens report their parameters with a delay of some few hundred ms
>> depending on controller vendor. And in some cases they don't report
>> anything back before forcibly querying the value from the controller,
>> and also the write mechanism acts differently; some controllers report
>> the programmed value back, others keep reporting the old value until the
>> pen leaves the screen and touches it again.
> Hmm, not sure I follow this entirely. I guess I would need to have one
> of such devices in my hands :(

Yes, it is kind of confusing, I was also trying to figure out the 
details with a remote proxy (someone telling me how things behave) until 
I decided to order a second chromebook that had the same controller. I 
can try to provide logs of the different cases if you want though. The 
quirks I know of at the moment:

1) controller does not immediately report "correct" values when pen 
touches screen (ELAN)

2) controller does never report "correct" values when pen touches screen 
(must do a force GET_REPORT) (GOODIX)

3) controller does not report "correct" values after SET_REPORT 
(reporting old value) (ELAN)

4) controller responds with bogus data in GET_REPORT (does not know the 
correct value yet) (ELAN + GOODIX)

I believe other vendors have different behavior with their controllers 
also, as the specs are not 100% clear on multiple things.

>
>>
>>>> The whole series is based on top of Benjamin's hid-bpf support work, and
>>>> I've pushed a branch at [1] with a series that works and brings in
>>>> the dependency. There are also a few separate patches in this series to
>>>> fix the problems I found from Benjamin's initial work for hid-bpf; I
>>>> wasn't able to get things working without those. The branch is also
>>>> based on top of 5.16-rc2 which required some extra changes to the
>>>> patches from Benjamin.
>>> Yeah, I also rebased on top of 5.16 shortly after sharing that branch
>>> and got roughly the same last fix (HID: bpf: compile fix for
>>> bpf_hid_foreach_rdesc_item). I am *very* interested in your "HID: bpf:
>>> execute BPF programs in proper context" because that is something that
>>> was bothering me a lot :)
>> Right, I think I have plenty of lockdep / scheduler checks enabled in my
>> kernel. They generate plenty of spam with i2c-hid without that patch.
>> The same issue may not be visible with some other low level hid devices
>> though, I don't have testing capability for anything but the i2c-hid
>> right now. I2C is quite notorious for the locking aspects as it is slow
>> and is used to control some pretty low level stuff like power management
>> etc.
> As a rule of thumb, hid_hw_raw_request() can not and should not be
> called in IRQ.
> I tested your patch with a USB device, and got plenty of complaints too.
>
> I know bpf now has the ability to defer a function call with timers,
> so maybe that's what we need here.
That sounds like something that would work yes, I did use workqueue 
before when this was a separate driver instead of a BPF program.
>
>>> "HID: bpf: add expected_attach_type to bpf prog during detach" is
>>> something I'll need to bring in too
>>>
>>> but "HID: bpf: fix file mapping" is actually wrong. I initially wanted
>>> to attach BPF programs to hidraw, but shortly realized that this is
>>> not working because the `hid/rdesc_fixup` kills the hidraw node and so
>>> releases the BPF programs. The way I am now attaching it is to use the
>>> fd associated with the modalias in the sysfs file (for instance: `sudo
>>> ./hid_surface_dial /sys/bus/hid/devices/0005:045E:091B.*/modalias`).
>>> This way, the reference to the struct hid_device is kept even if we
>>> disconnect the device and reprobe it.
>> Ok I can check this out if it works me also. The samples lead me to
>> /dev/hidraw usage.
>>> Thanks again for your work, and I'd be curious to have your thoughts
>>> on hid-bpf and if you think it is better than hidraw/evdev write/new
>>> ioctls for your use case.
>> The new driver was 777 lines diff, the BPF one is 496 lines so it
>> appears smaller. The driver did support two different vendors though
>> (ELAN+Goodix, with their specific quirks in place), the BPF only a
>> single one right now (ELAN).
>>
>> The vendor specific quirks are a question, do we want to support that
>> somehow in a single BPF binary, or should we attach vendor specific BPF
>> programs?
> Good question.
> The plan I had was to basically pre-compile BPF programs for the
> various devices, but having them separated into generic + vendor
> specifics seems interesting too.
>
> I don't have a good answer right now.
At least for USI purposes, ELAN+GOODIX controllers have pretty different 
quirks for them and it seems like having separate BPF programs might be 
better; trying to get the same BPF program to run for both sounds 
painful (it was rather painful to get this to work for single vendor.)
>
>> Chromium-os devices are one of the main customers for USI pens right
>> now, and I am not sure how well they will take the BPF concept. :) I did
>> ask their feedback though, and I'll come back on this once I have something.
> Cool thanks.
>
>> Personally, I don't have much preference either way at this moment, both
>> seem like feasible options. I might lean a bit towards evdev/ioctl as it
>> seems a cleaner implementation as of now. The write mechanism I
>> implemented for the USI-BPF is a bit hacky, as it just directly writes
>> to a shared memory buffer and the buffer gets parsed by the kernel part
>> when it processes hidraw event. Anyways, do you have any feedback on
>> that part? BPF is completely new to me again so would love to get some
>> feedback.
> Yeah, this feels wrong to me too.
> I guess what we want is to run a BPF call initiated from the
> userspace. I am not sure if this is doable. I'll need to dig further
> too (I am relatively new to BPF too as a matter of facts).

I could not find a way to initiate BPF call from userspace, thats the 
reason I implemented it this way. That said, I don't see any case where 
this would fail though; we only ever write the values from single source 
(userspace) and read them from kernel. If we miss a write, we just get 
the old value and report the change later on.

To initiate a BPF call from userspace we would need some sort of hid-bpf 
callback to a BPF program, which gets triggered by an ioctl or evdev 
write or something coming from userspace. Which brings us back to the 
chicken-egg problem we have with USI right now. :)

-Tero


> Cheers,
> Benjamin
>
>> One option is of course to push the write portion of the code to
>> userspace and just use hidraw, but we still need to filter out the bogus
>> events somehow, and do that in vendor specific manner. I don't think
>> this can be done on userspace, as plenty of information that would be
>> needed to do this properly has been lost at the input-event level.
>>
>> -Tero
>>
>>> Cheers,
>>> Benjamin
>>>
>>>> -Tero
>>>>
>>>> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
>>>>
>>>>

--------------F3ABB60F91A5847EC875D22B
Content-Type: application/gzip;
 name="usi-rdescs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="usi-rdescs.tar.gz"

H4sIAAAAAAAAA+1YS2/kNgzOOb9Cf6CF3pLntthuiwWKPfTUq+0Zo0UPWyQp0J9fkaIkyuNJ
JovMFgGsgx8UxZcoiZ8ejqfH+YdxPj38+PTv091NmkzNewtvFZzkb+wKqU9Z5awxPgR3J5XR
6SXkbczp2z+PT+ODEHd/Pfz5+PT1Mt9L/e+0/XYQSgUrpBPyKOQgpBWjElKJ6OCZKFojRcO3
1UIluhQaewM+B3xG5An12+C3h1FOAb9ZiEd7sSwgBBiicOm5CO+SIcKgcOuQIamLNAS+h/Zt
JH1n1RKfowXJ8wLSkmQlO8l5FMn3wLmyPFFCEHKE3tEDGwwpvZMVs2xRajEplD0ye2T2yOyR
edvIOAsehUUMKKf6kplhix6RzWGgRjEVurUYE0kOzsm2rEuuwzJkuqKxoD0zoC/gbz0O9GUh
SSM6IkvEspxqQCfHtFFaUu/w4iicYj5WaRqVj61KTzzclzR8Q5otCXbmiDJnjtTDUTMJgWYZ
ElgiPU9lOSjhaZEy47e7kNKO5ZihlJbl8DWScmwouceTrSZYeqqZ0jirNqolWOqdZqEX6p3Y
cW+wN/EoyVZWLAmfGCYw2FsmOTJHdFssbm7BbMRT+w6SlrlC4brMaci9GPaAEQMb0jP3BpCQ
88ShMQuuO7uVac14TTO+msQ0cR5FRdWqmuQR93rTu6iY2WhkzHQ0O2aKI1OTOlCkKCzN6618
ozhHStpVJBvx2G2DOYummjkBv01RXYLPfeR+ce0Tm6wNvQvp5RrDuUbTTfGleK48rfzXJ8NU
Igy/6jrb8uzIZklNIR4B4HS0bC/lRvZiWqWxWY8abVv+bqTlD3TT2Z+6XjskEV81hCLg+3wr
y3+QnafcO+hVtPlQViysS1MAczCnenzjNOmR1NV0qlr0sQnRp7ZRk52BCZm6qmAjf845Uf55
Dm8oilsHDatAnpn31UAKUQBK1ltVk67holi+NLozq8iP7MxSgR1SWbur+9v9l4P49OuHL4OU
9gA22J/NQX+ww/3nBPGSt3YxaV7S/z3Hfw+I///4+3bo/2X874Mv+D8YmfiUDl7t+P97NMT/
zl+F/6HyOHUFtCoFkNUXK/Vcv9ZSRgaqJIbKH6l2r/WHklQAQWliYSNLpcwp13+sKE+9Hm1I
vcNIe0GtpLNHuVqizQi3qlXRb1nRb4uPeatdXXzsDr53B5+HlJfc5A5y/pWDDQqetqFgdn93
/KaOO9ucDUt31jbMnOtax452hpyhmFshZ3cdbHZrlCgZMow5mI5Q3GaIqqIcWIcCPSJSDgLb
9YRqYayBrfcIvObgS5UnA7/pWJV6XEtkubSqOCu4lQh9W3b5TkWGZARuE+eRJYwVxotjFMcZ
AW2adAMXDZmiC6W6oBi8NAxe2lpOBTEmnplKMQpyT6z5BsByFM5AzH0+1PKVQS1ew1bwR8g0
admv639D/xv736H7BczDf03/yxXVOZ3aPPpy99FQ9xZO5lmdGAL6vhLLkeda5tsh+fNbnjpx
vIY+D3t0dIJw9P4NyFxJcrZD5myN3AiW573xIizvtb8JLFf9fG1jjzNPvw8szxdt18ByVYDu
c7BcvT9Ynky9Fpar/xOWK/8sLF/lzznn1bA8QdxXw3L1jbBcxStgueoshJvxzbvpU7+PlUyu
N+PtnvoyD0fyv/z0+XfAxgfcFT/6g/wkJSF5Hebk6Sn937+M7/a2t73tbW9729ve1u0/KQEi
pwAoAAA=
--------------F3ABB60F91A5847EC875D22B--
