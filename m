Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD14A6E31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbiBBJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbiBBJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643795677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZM3D7gzWYfBkbqDJgiHcJO8vfBgGoOljpivQC1NMN8=;
        b=Y4gJsk1RDBvf5KUA52Vn1J99ssC4P4/huboXciNPgwZ0Y7QVDyh/TpDCDpHk4LT/mefkW1
        wazH9hSKOunipWcleMBQHj7y+XwfQ01oFUoTBMJF8hAPNC4ZxO2ZHLAc38diI6eMhQF7DZ
        deyAgeIKMOnJalVyJoVGHdVjsdaRTGY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-YljU1eieMR-8Jv5GB245Ew-1; Wed, 02 Feb 2022 04:54:36 -0500
X-MC-Unique: YljU1eieMR-8Jv5GB245Ew-1
Received: by mail-pl1-f199.google.com with SMTP id x11-20020a170902a38b00b0014b620deff1so8338285pla.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 01:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ZM3D7gzWYfBkbqDJgiHcJO8vfBgGoOljpivQC1NMN8=;
        b=YHxjK2ES2lAeeQ8kw4HfZw2o8SiL8j1J+icMq8XE69wWkyTS5d06ULMv/vF6/6JJ2X
         ld7+rUUt3Jmf3+UMucRYdZlkBvPEKp/eMplrz66+vc1Tc0IWlcqnBXE7TYesGmnqJna2
         I+mX1YbgwGB7hqEC+JYQ+yp/6Xhd3s80ZZWYqi1h3PeEy1ztsxDyMtZI0+BJWrveAQPB
         g/+NSZGfWRy01MnrfIPWCJHnt+4GX3urCCkynhJZZaLOCwe93p1afQ4O0TcN9zXpbKzv
         CHwRYZgwtjvIBuH9Sl7iTPLh+Sp6q/Dlo8zI/4UXtE23rK1fP3XNQl2iumYdU1/rubZp
         tE+Q==
X-Gm-Message-State: AOAM532WGGzPfUIPzUGAZYiCpXHp1SwR1SJj8WbtcTsi/FM5cfo8KTzI
        LuM8oVl01rKiMvsaI4KXOgopfWhvQD15lmjbktZ0RFe0ummO6/xX8eOdNLUrHfHI6HKVq7jQRGZ
        ve/okeILvlXn5Zc/EJivBoad8vljhygeVEdaNqFqk
X-Received: by 2002:a17:903:1c2:: with SMTP id e2mr30071706plh.73.1643795674908;
        Wed, 02 Feb 2022 01:54:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIW3+RRUW5vhPwtJYn1LLbrZN10RQ3Dg4P63uFPKBaQIFtjxr1eD6F6vtCxH99ntnub4l1zwteC/bIUDqEvwg=
X-Received: by 2002:a17:903:1c2:: with SMTP id e2mr30071674plh.73.1643795674535;
 Wed, 02 Feb 2022 01:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
 <20220126161832.3193805-11-benjamin.tissoires@redhat.com> <CAF8JNhLCXT7N4DubYYT12eMphDH-6U69ci7zFisJfZwsviJGkQ@mail.gmail.com>
In-Reply-To: <CAF8JNhLCXT7N4DubYYT12eMphDH-6U69ci7zFisJfZwsviJGkQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 2 Feb 2022 10:54:23 +0100
Message-ID: <CAO-hwJ+sBKvE_STnTHsfTTXvZYHn4hcp81h735JUOu3vp7TrXA@mail.gmail.com>
Subject: Re: [PATCH 10/12] HID: input: remove the need for HID_QUIRK_INVERT
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ping,

On Wed, Feb 2, 2022 at 6:43 AM Ping Cheng <pinglinux@gmail.com> wrote:
>
> Hi Benjamin,
>
> Thank you for taking care of the issue. The whole set looks good to me, e=
xcept this one. xf86-input-wacom would not process the events properly if p=
en and eraser events are reported through the same EV_SYN frame. That's mai=
nly because the tool out of prox will reset all values, while some values t=
he next tool may rely on. Please see my detailed comments inline.
>
> On Wed, Jan 26, 2022 at 8:19 AM Benjamin Tissoires <benjamin.tissoires@re=
dhat.com> wrote:
>>
>> HID_QUIRK_INVERT is kind of complex to deal with and was bogus.
>>
>> Furthermore, it didn't make sense to use a global per struct hid_device
>> quirk for something dynamic as the current state.
>>
>> Store the current tool information in the report itself, and re-order
>> the processing of the fields to enforce having all the tablet "state"
>> fields before getting to In Range and other input fields.
>>
>> This way, we now have all the information whether a tool is present
>> or not while processing In Range.
>>
>> This new behavior enforces that only one tool gets forwarded to userspac=
e
>> at the same time, and that if either eraser or invert is set, we enforce
>>
>> BTN_TOOL_RUBBER.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>  drivers/hid/hid-input.c | 66 +++++++++++++++++++++++++++++++++++------
>>  include/linux/hid.h     |  6 +++-
>>  2 files changed, 62 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 61d91117f4ae..2d13d3ad9d3c 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -63,8 +63,11 @@ static const struct {
>>   * This still leaves us 65535 individual priority values.
>>   */
>>  static const __u32 hidinput_usages_priorities[] =3D {
>> +       HID_DG_ERASER,          /* Eraser (eraser touching) must always =
come before tipswitch */
>>         HID_DG_INVERT,          /* Invert must always come before In Ran=
ge */
>> -       HID_DG_INRANGE,
>> +       HID_DG_TIPSWITCH,       /* Is the tip of the tool touching? */
>> +       HID_DG_TIPPRESSURE,     /* Tip Pressure might emulate tip switch=
 */
>> +       HID_DG_INRANGE,         /* In Range needs to come after the othe=
r tool states */
>>  };
>>
>>  #define map_abs(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_AB=
S, (c))
>> @@ -1368,6 +1371,7 @@ static void hidinput_handle_scroll(struct hid_usag=
e *usage,
>>  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field=
, struct hid_usage *usage, __s32 value)
>>  {
>>         struct input_dev *input;
>> +       struct hid_report *report =3D field->report;
>>         unsigned *quirks =3D &hid->quirks;
>>
>>         if (!usage->type)
>> @@ -1418,25 +1422,69 @@ void hidinput_hid_event(struct hid_device *hid, =
struct hid_field *field, struct
>>         }
>>
>>         switch (usage->hid) {
>> +       case HID_DG_ERASER:
>> +               report->tool_active |=3D !!value;
>> +
>> +               /*
>> +                * if eraser is set, we must enforce BTN_TOOL_RUBBER
>> +                * to accommodate for devices not following the spec.
>> +                */
>> +               if (value)
>> +                       report->tool =3D BTN_TOOL_RUBBER;
>> +
>> +               /* let hid-input set BTN_TOUCH */
>> +               break;
>> +
>>         case HID_DG_INVERT:
>> -               *quirks =3D value ? (*quirks | HID_QUIRK_INVERT) : (*qui=
rks & ~HID_QUIRK_INVERT);
>> +               report->tool_active |=3D !!value;
>> +
>> +               /*
>> +                * If invert is set, we store BTN_TOOL_RUBBER.
>> +                */
>> +               if (value)
>> +                       report->tool =3D BTN_TOOL_RUBBER;
>> +
>> +               /* no further processing */
>>                 return;
>>
>>         case HID_DG_INRANGE:
>> -               if (value) {
>> -                       input_event(input, usage->type, (*quirks & HID_Q=
UIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
>> -                       return;
>> -               }
>> -               input_event(input, usage->type, usage->code, 0);
>> -               input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
>> +               report->tool_active |=3D !!value;
>> +
>> +               /*
>> +                * If the tool is in used (any of TipSwitch, Erase, Inve=
rt,
>> +                * InRange), and if tool is not set, store our mapping
>> +                */
>> +               if (report->tool_active && !report->tool)
>> +                       report->tool =3D usage->code;
>> +
>> +               input_event(input, EV_KEY, usage->code, report->tool =3D=
=3D usage->code);
>> +               input_event(input, EV_KEY, BTN_TOOL_RUBBER, report->tool=
 =3D=3D BTN_TOOL_RUBBER);
>
>
> When usage->code changes value, for userspace clients, such as X driver, =
one of the tools in the frame would not have its own input events since the=
re is only one set of input event values in the frame. X driver stores the =
values in different arrays/channels for each tool to post the events for ea=
ch tool after all the values are processed.
>
> If we can always post the tool that goes out of prox with an EV_SYN first=
, the other tool would take the coming input events without problem. The to=
ol that goes out of prox doesn't care about any of the other input events s=
ince its value will be reset.

OK. Right now, this series ensures we get
ERASER/TIPSWITCH/INVERT/INRANGE first before processing any other
events.

Given that ERASER/TIPSWITCH are responsible for BTN_TOUCH, I'd like to
get some clarifications (sorry dumping my brain here):

In the example of the pen moving from erasing to touching without the
intent to erase:

The HID event sequence would be:
Eraser: 1, Invert: 1, Tipswitch: 0, InRange: 1, X, Y, etc...
then
Eraser: 0, Invert: 0, Tipswitch: 1, InRange: 1, X, Y, etc...

In this current series we would get:
BTN_TOUCH 1, BTN_TOOL_RUBBER 1, X, Y, etc...
then
BTN_TOUCH 0, BTN_TOUCH 1, BTN_TOOL_PEN 1, BTN_TOOL_RUBBER 0, X, Y, etc...

(yeah, oops, there are 2 BTN_TOUCH in this sequence)

A naive change would do (instead of the last evdev event):
BTN_TOUCH 0, BTN_TOUCH 1, BTN_TOOL_RUBBER 0, *EV_SYN*, BTN_TOOL_PEN 1,
X, Y, etc...

However, I wonder if we should not have instead:
BTN_TOUCH 0, BTN_TOOL_RUBBER 0, *EV_SYN*, BTN_TOUCH 1, BTN_TOOL_PEN 1,
X, Y, etc...

That change should be easy to handle actually.

I am a little bit more concerned the other way around:
touching without the intent to erase to erase:
HID events:
Eraser: 0, Invert: 0, Tipswitch: 1, InRange: 1, X, Y, etc...
Eraser: 1, Invert: 1, Tipswitch: 0, InRange: 1, X, Y, etc...

The current series gives:
BTN_TOUCH 1, BTN_TOOL_PEN 1, X, Y, etc...
then
BTN_TOOL_PEN 1, BTN_TOOL_RUBBER 1, X, Y, etc...

(no BTN_TOUCH events)

And I think to get to the "correct" sequence I would have to store more sta=
tes:
BTN_TOUCH 0, BTN_TOOL_PEN 0, *EV_SYN*, BTN_TOUCH 1, BTN_TOOL_RUBBER 1,
X, Y, etc...

I think the main problem is how to handle BTN_TOUCH correctly (and
PRESSURE is also in the middle). When this event is not set, it should
be easier to add the EV_SYN between the BTN_TOOL_*.

>
> We could update X driver, if libinput is capable of processing two tools =
in the same EV_SYN frame. This is more like a special multi-pen situation w=
here two styli share the same set of input event values. The regular multi-=
pen logic would not process it right, I think.

Well, there is already the problem of that BTN_TOUCH 0/1 in one frame
that is not very clean. And if we can not break userspace that would
be best (note that the current kernel is completely sending random
events for those transitions, so in a way it's still slightly better).

Cheers,
Benjamin

>
> Cheers,
> Ping
>
>> +
>> +               /* reset tool and tool_active for the next event */
>> +               report->tool =3D 0;
>> +               report->tool_active =3D false;
>> +
>> +               /* no further processing */
>>                 return;
>>
>> +       case HID_DG_TIPSWITCH:
>> +               report->tool_active |=3D !!value;
>> +
>> +               /* if tool is set we should ignore the current value */
>> +               if (report->tool)
>> +                       return;
>> +
>> +               break;
>> +
>>         case HID_DG_TIPPRESSURE:
>>                 if (*quirks & HID_QUIRK_NOTOUCH) {
>>                         int a =3D field->logical_minimum;
>>                         int b =3D field->logical_maximum;
>>
>> -                       input_event(input, EV_KEY, BTN_TOUCH, value > a =
+ ((b - a) >> 3));
>> +                       if (value > a + ((b - a) >> 3)) {
>> +                               input_event(input, EV_KEY, BTN_TOUCH, 1)=
;
>> +                               report->tool_active =3D true;
>> +                       }
>>                 }
>>                 break;
>>
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index eaad0655b05c..feb8df61168f 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -347,7 +347,7 @@ struct hid_item {
>>   */
>>  #define MAX_USBHID_BOOT_QUIRKS 4
>>
>> -#define HID_QUIRK_INVERT                       BIT(0)
>> +/* BIT(0) reserved for backward compatibility, was HID_QUIRK_INVERT */
>>  #define HID_QUIRK_NOTOUCH                      BIT(1)
>>  #define HID_QUIRK_IGNORE                       BIT(2)
>>  #define HID_QUIRK_NOGET                                BIT(3)
>> @@ -515,6 +515,10 @@ struct hid_report {
>>         unsigned maxfield;                              /* maximum valid=
 field index */
>>         unsigned size;                                  /* size of the r=
eport (bits) */
>>         struct hid_device *device;                      /* associated de=
vice */
>> +
>> +       /* tool related state */
>> +       bool tool_active;                               /* whether the c=
urrent tool is active */
>> +       unsigned int tool;                              /* BTN_TOOL_* */
>>  };
>>
>>  #define HID_MAX_IDS 256
>> --
>> 2.33.1
>>

