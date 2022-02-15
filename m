Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C834B6693
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiBOIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:52:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiBOIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D267113AEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644915129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TU7ldoK47WToUElKtf/UxscSFIaxADWVweJyYJBAbQ8=;
        b=f/WONHE+/qUzbCxUbI+4/Md5lVq9QGzN+xo394MNeS903Jf8RIbhcj1gv94lBoaV0ow8Zd
        LA6BEwsPpL65HPM+EbvpV4ZlkY1MIUnG9LD+sF0BEP9vSBtU8ASrNhrh7xOBfFP0sZzupg
        BcOsNA9aku31xXs91KEQ9extJvcP3ts=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-jGLtodEJNxOrJeksLvOWcQ-1; Tue, 15 Feb 2022 03:52:07 -0500
X-MC-Unique: jGLtodEJNxOrJeksLvOWcQ-1
Received: by mail-pl1-f199.google.com with SMTP id 9-20020a170902c20900b0014dc0faf52fso7894233pll.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU7ldoK47WToUElKtf/UxscSFIaxADWVweJyYJBAbQ8=;
        b=BQQM5DLQQheEsmULdtNn2ipzGx7sy/iMzJtBkQ6HraKHBRCSckUSI0J/rtjVhPK/HJ
         ati0tDExjSOly57u0jMlTvKmO6//pwM7EsmT8nVrAz9yIFgIlKtsrQ2g/snM3cKUYk4l
         P3QAs+va/0/kvmrT815bjCFGca+N9pb/lHJLoIsCG1wDG22+l2ysV7zPtRw2anFlypKL
         +nPvbSc9XscF1dixaw3rhnhJ83vUY1opY+FfgS6PFmwEj3Hj5L1RwjmVdIQBIstesOKW
         OUkivjc5ij5bNB1g94/SfNhBLzWFXfKPWOiJE3l5v9S7L7OIv4MEvOhoUI0mZxsqecyE
         PYvA==
X-Gm-Message-State: AOAM531F/84ld34mwJCMPNjCUfUE0jL1Yt5VQx0kQ9fKeyyOgyyiW47W
        qKBpjQEsmINJNqVMHaXWrbgnJkNgRQF6Dbmmi12QG4gXdOUW2xMtj9DKmEWC36nKUZo0Rci7T1j
        ni9v6FGw4BObRElA2Jdg32jsxfDsDjQGonSLIH846
X-Received: by 2002:a17:90a:a384:b0:1b9:4d24:967e with SMTP id x4-20020a17090aa38400b001b94d24967emr3155267pjp.246.1644915125102;
        Tue, 15 Feb 2022 00:52:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMJCFbk2QM8TtCUwhQWq371+FzVya/RdjWjxN5Kn00dG6LDhzzEtbMCd++YqzxeOoIJUrEX38+AjCANmJB6Ds=
X-Received: by 2002:a17:90a:a384:b0:1b9:4d24:967e with SMTP id
 x4-20020a17090aa38400b001b94d24967emr3155247pjp.246.1644915124775; Tue, 15
 Feb 2022 00:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
 <20220203143226.4023622-11-benjamin.tissoires@redhat.com> <CAF8JNhKbEWj1b4o2Uv7snXa_JGt0bk5wyUGP4_77aHTLhPRT3w@mail.gmail.com>
 <CAF8JNhLeOn==FhaujjYY7o+f3J7xQcitdUUUJOOeZL1QEGKhRA@mail.gmail.com>
 <CAO-hwJ+NVb=Z0=1jeLuCFjGPAXnjn6hgHDjWx0+ETcE3uQhhzQ@mail.gmail.com> <CAF8JNhLUWJXbWG2rsYZvemm+3LbHA0QwAND05h9oM74LKDAfLA@mail.gmail.com>
In-Reply-To: <CAF8JNhLUWJXbWG2rsYZvemm+3LbHA0QwAND05h9oM74LKDAfLA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 15 Feb 2022 09:51:53 +0100
Message-ID: <CAO-hwJJcfA4keCgSyszrs9RF__AbqS8YNJ+MW2+bPgTiwzoiwg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] HID: input: remove the need for HID_QUIRK_INVERT
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 3:04 AM Ping Cheng <pinglinux@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 2:23 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Ping,
> >
> > On Thu, Feb 10, 2022 at 6:44 AM Ping Cheng <pinglinux@gmail.com> wrote:
> > >
> > > Sorry for the noise. Hit the wrong buttons...
> > >
> > > On Wed, Feb 9, 2022 at 9:21 PM Ping Cheng <pinglinux@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 3, 2022 at 6:33 AM Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > >
> > > > > HID_QUIRK_INVERT is kind of complex to deal with and was bogus.
> > > > >
> > > > > Furthermore, it didn't make sense to use a global per struct hid_device
> > > > > quirk for something dynamic as the current state.
> > > > >
> > > > > Store the current tool information in the report itself, and re-order
> > > > > the processing of the fields to enforce having all the tablet "state"
> > > > > fields before getting to In Range and other input fields.
> > > > >
> > > > > This way, we now have all the information whether a tool is present
> > > > > or not while processing In Range.
> > > > >
> > > > > This new behavior enforces that only one tool gets forwarded to userspace
> > > > > at the same time, and that if either eraser or invert is set, we enforce
> > > > > BTN_TOOL_RUBBER.
> > > > >
> > > > > Note that the release of the previous tool now happens in its own EV_SYN
> > > > > report so userspace doesn't get confused by having 2 tools.
> > > > >
> > > > > These changes are tested in the following hid-tools regression tests:
> > > > > https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
> > > > >
> > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - rework the entire tool switching, this makes the processing
> > > > >   slightly more complex but is better for existing userspace.
> > > > > ---
> > > > >  drivers/hid/hid-input.c | 98 +++++++++++++++++++++++++++++++++++++----
> > > > >  include/linux/hid.h     |  6 ++-
> > > > >  2 files changed, 95 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > > > > index 61d91117f4ae..9f8853640648 100644
> > > > > --- a/drivers/hid/hid-input.c
> > > > > +++ b/drivers/hid/hid-input.c
> > > > > @@ -63,8 +63,11 @@ static const struct {
> > > > >   * This still leaves us 65535 individual priority values.
> > > > >   */
> > > > >  static const __u32 hidinput_usages_priorities[] = {
> > > > > +       HID_DG_ERASER,          /* Eraser (eraser touching) must always come before tipswitch */
> > > > >         HID_DG_INVERT,          /* Invert must always come before In Range */
> > > > > -       HID_DG_INRANGE,
> > > > > +       HID_DG_TIPSWITCH,       /* Is the tip of the tool touching? */
> > > > > +       HID_DG_TIPPRESSURE,     /* Tip Pressure might emulate tip switch */
> > > > > +       HID_DG_INRANGE,         /* In Range needs to come after the other tool states */
> > > > >  };
> > > > >
> > > > >  #define map_abs(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
> > > > > @@ -1365,9 +1368,38 @@ static void hidinput_handle_scroll(struct hid_usage *usage,
> > > > >         input_event(input, EV_REL, usage->code, hi_res);
> > > > >  }
> > > > >
> > > > > +static void hid_report_release_tool(struct hid_report *report, struct input_dev *input,
> > > > > +                                   unsigned int tool)
> > > > > +{
> > > > > +       /* if the given tool is not currently reported, ignore */
> > > > > +       if (!test_bit(tool, input->key))
> > > > > +               return;
> > > > > +
> > > > > +       /*
> > > > > +        * if the given tool was previously set, release it,
> > > > > +        * release any TOUCH and send an EV_SYN
> > > > > +        */
> > > > > +       input_event(input, EV_KEY, BTN_TOUCH, 0);
> > > > > +       input_event(input, EV_KEY, tool, 0);
> > >
> > > Took a while for me to find the right device and setup the proper
> > > system for the testing. This block missing the serial number:
> > >
> > >         input_event(input, EV_MSC, MSC_SERIAL, 0);
> > >
> > > Without this line, the next tool will not get its serial number.
> >
> > I am tempted to simply disregard this request. It has been known for
> > ages that the evdev values are cached, so if you do not have the value
> > you need that means that the value has been sent previously (or you
> > can request it upon start with an ioctl). So in this particular case,
> > I don't really see the logic in forcing the SERIAL into the TOOL type
> > when the tool is clearly unrelated to the serial.
> >
> > My fear here is that by linking together too many axes, we may enter
> > in a state where we can not untangle them when needed.
>
> I see your point. We indeed added those ioctl's in the X driver to
> avoid missing the initial states of some of the key events.
>
> > >
> > > > > +       input_event(input, EV_SYN, SYN_REPORT, 0);
> > > > > +
> > > > > +       report->tool = 0;
> > > > > +}
> > > > > +
> > > > > +static void hid_report_set_tool(struct hid_report *report, struct input_dev *input,
> > > > > +                               unsigned int new_tool)
> > > > > +{
> > > > > +       if (report->tool != new_tool)
> > > > > +               hid_report_release_tool(report, input, report->tool);
> > > > > +
> > > > > +       input_event(input, EV_KEY, new_tool, 1);
> > > > > +       report->tool = new_tool;
> > > > > +}
> > > > > +
> > > > >  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
> > > > >  {
> > > > >         struct input_dev *input;
> > > > > +       struct hid_report *report = field->report;
> > > > >         unsigned *quirks = &hid->quirks;
> > > > >
> > > > >         if (!usage->type)
> > > > > @@ -1418,25 +1450,75 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
> > > > >         }
> > > > >
> > > > >         switch (usage->hid) {
> > > > > +       case HID_DG_ERASER:
> > > > > +               report->tool_active |= !!value;
> > > > > +
> > > > > +               /*
> > > > > +                * if eraser is set, we must enforce BTN_TOOL_RUBBER
> > > > > +                * to accommodate for devices not following the spec.
> > > > > +                */
> > > > > +               if (value)
> > > > > +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> > > > > +               else if (report->tool != BTN_TOOL_RUBBER)
> > > > > +                       /* value is off, tool is not rubber, ignore */
> > > > > +                       return;
> > > > > +
> > > > > +               /* let hid-input set BTN_TOUCH */
> > > > > +               break;
> > > > > +
> > > > >         case HID_DG_INVERT:
> > > > > -               *quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
> > > > > +               report->tool_active |= !!value;
> > > > > +
> > > > > +               /*
> > > > > +                * If invert is set, we store BTN_TOOL_RUBBER.
> > > > > +                */
> > > > > +               if (value)
> > > > > +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> > > > > +               else if (!report->tool_active)
> > > > > +                       /* tool_active not set means Invert and Eraser are not set */
> > > > > +                       hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
> > > > > +
> > > > > +               /* no further processing */
> > > > >                 return;
> > > > >
> > > > >         case HID_DG_INRANGE:
> > > > > -               if (value) {
> > > > > -                       input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
> > > > > -                       return;
> > > > > +               report->tool_active |= !!value;
> > > > > +
> > > > > +               if (report->tool_active) {
> > > > > +                       /*
> > > > > +                        * if tool is not set but is marked as active,
> > > > > +                        * assume ours
> > > > > +                        */
> > > > > +                       if (!report->tool)
> > > > > +                               hid_report_set_tool(report, input, usage->code);
> > > > > +               } else {
> > > > > +                       hid_report_release_tool(report, input, usage->code);
> > > > >                 }
> > > > > -               input_event(input, usage->type, usage->code, 0);
> > > > > -               input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
> > > > > +
> > > > > +               /* reset tool_active for the next event */
> > > > > +               report->tool_active = false;
> > > > > +
> > > > > +               /* no further processing */
> > > > >                 return;
> > > > >
> > > > > +       case HID_DG_TIPSWITCH:
> > > > > +               report->tool_active |= !!value;
> > > > > +
> > > > > +               /* if tool is set to RUBBER we should ignore the current value */
> > > > > +               if (report->tool == BTN_TOOL_RUBBER)
> > > > > +                       return;
> > >
> > > This case should return before HID_DG_INVERT is checked since we may
> > > get TIPSWITCH bit before INVERT. In fact, the device that I tested
> > > sends the tipswatch bit before the invert bit. So, I alway get a PEN
> > > in and out before I get ERASER events, when I bring the pen in with
> > > the side-switch/invert bit pressed.
> > >
> > > However, we know not all devices support INVERT. We probably have to
> > > keep the invert quirk to decide if BTN_TOOL_PEN should be set here or
> > > wait until HID_DG_INVERT is reached.
> >
> > I am under the impression that you completely missed the point of the
> > patch series. This series re-orders the processing of the events, and
> > if you look at the very first hunk in this patch, you'll see that the
> > new processing ensures we treat INVERT and ERASER before TIPSWITCH, no
> > matter the order of the device.
>
> Yeah, I read that part of the code, more than once. But, my evtest
> gave me an extra set of TOOL_PEN events before TOOL_ERASER. I was
> confused too. Then I thought maybe the code still relies on the actual
> order of the usages. Anyway, we've done enough discussion and testing,
> let's move on. The patchset is:
>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> Tested-by: Ping Cheng <ping.cheng@wacom.com>

Thanks for the review.

 However, if the device is not working as expected, can you send me
the hid-recorder[0] output off list so I can diagnose what is
happening?

Cheers,
Benjamin

[0] clone https://gitlab.freedesktop.org/libevdev/hid-tools, then pip
install ., then `sudo hid-recorder`

>
> Thank you for your effort, Benjamin!
> Ping
>
> > So when we process TIPSWITCH here, we are sure that if BTN_TOOL_RUBBER
> > is set, either INVERT or ERASER is set to 1, whether or not they come
> > before or after in the report.
> >
> > >
> > > If you are interested in the evtest output, please let me know. I'll
> > > share it with you offline so we don't abuse this list...
> >
> > evtest is the output of the kernel, and it doesn't give me much more
> > than "it's broken". However, if you can give me the hid-recorder
> > outputs, I'll be able to reproduce locally and compare the output as I
> > fix the code. Of course the best would be to add test cases in the
> > hid-tools repo, but I'll need the hid-recorder anyway to understand
> > what is failing and to be able to write the tests.
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > Cheers,
> > > Ping
> > >
> > > > > +               break;
> > > > > +
> > > > >         case HID_DG_TIPPRESSURE:
> > > > >                 if (*quirks & HID_QUIRK_NOTOUCH) {
> > > > >                         int a = field->logical_minimum;
> > > > >                         int b = field->logical_maximum;
> > > > >
> > > > > -                       input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
> > > > > +                       if (value > a + ((b - a) >> 3)) {
> > > > > +                               input_event(input, EV_KEY, BTN_TOUCH, 1);
> > > > > +                               report->tool_active = true;
> > > > > +                       }
> > > > >                 }
> > > > >                 break;
> > > > >
> > > > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > > > index eaad0655b05c..feb8df61168f 100644
> > > > > --- a/include/linux/hid.h
> > > > > +++ b/include/linux/hid.h
> > > > > @@ -347,7 +347,7 @@ struct hid_item {
> > > > >   */
> > > > >  #define MAX_USBHID_BOOT_QUIRKS 4
> > > > >
> > > > > -#define HID_QUIRK_INVERT                       BIT(0)
> > > > > +/* BIT(0) reserved for backward compatibility, was HID_QUIRK_INVERT */
> > > > >  #define HID_QUIRK_NOTOUCH                      BIT(1)
> > > > >  #define HID_QUIRK_IGNORE                       BIT(2)
> > > > >  #define HID_QUIRK_NOGET                                BIT(3)
> > > > > @@ -515,6 +515,10 @@ struct hid_report {
> > > > >         unsigned maxfield;                              /* maximum valid field index */
> > > > >         unsigned size;                                  /* size of the report (bits) */
> > > > >         struct hid_device *device;                      /* associated device */
> > > > > +
> > > > > +       /* tool related state */
> > > > > +       bool tool_active;                               /* whether the current tool is active */
> > > > > +       unsigned int tool;                              /* BTN_TOOL_* */
> > > > >  };
> > > > >
> > > > >  #define HID_MAX_IDS 256
> > > > > --
> > > > > 2.33.1
> > > > >
> > >
> >
>

