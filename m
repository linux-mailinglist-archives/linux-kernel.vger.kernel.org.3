Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF64A9217
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356550AbiBDBlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:41:22 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE54C061714;
        Thu,  3 Feb 2022 17:41:21 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 13so3610312qkd.13;
        Thu, 03 Feb 2022 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6fDTKuXLtI8SJK6LHGf2beyOYvIfO4Uy+fn95hCbro=;
        b=lmlE5aHCb3UYmyv2AKB8wzX9vegOiC7nGK+2bAIhjbuK/01j6mz1MFiGlJZCBvWXe2
         T6N0RWff2JPgGOkpb9GepBy4d6TD3Jy88lO52kL+Ccir55Xjes82AWW7OhCGMuE9g1G5
         mfsXK+KpExZqyUiu/Jsh6xb+cm54gorDnrz+aw3R8UqCwtUimWfrjx2mkqfIdE9HBDvF
         TS0/6P7oIZjXQUvwBXCMiGxpnKip6crMu9pM4PmKdaHDf65kXmIJXScPTmND6uc7uaCW
         7eKIAsTXC+0VQmXnKEp6+l94YxkZIjgFI8/ln0RXQHEJ72th8Q/SDxuBtndVdh29tNTs
         rRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6fDTKuXLtI8SJK6LHGf2beyOYvIfO4Uy+fn95hCbro=;
        b=Un9a0Mzn0MR72qaNav+LYxgOG2YCv14DnkUORHoAA0Sjg+rHdD7VoI/BrClAhd4aqN
         gGUYjwHPRE8fNs6RX8KdUufVbe2jQWp8GYyl3jsoGe0T1sODMXrXVXC5V8es/smeFmpI
         RjVr6xMw8TjcqEBBEfPprbGHUvIvUFmY08VGw+M+y7UM7G5oMZDKRVjeCNnfShxnDCTP
         cGSpjrFWIo9DFTdOC1kqHwUSwkrs5p7ptRqSkSMHwHCmPiB4w7dgLb+n1c0CBHMO+iMV
         7I6KNQ0Tp0/O5WAlyDkzj/nYs2sCtFMODEXsfMXJ4C6MbG6G14W/aq9qpZOjtUasTYsi
         tfyQ==
X-Gm-Message-State: AOAM530/NK6JkWjavxI+N4ZYksFf8pZfQ9T4ayrRCJEcdWcgQCSDGAwu
        GFpmCmuPPtCpAYkdFKR7cqEp7Xlfq1ksVuFO3SU=
X-Google-Smtp-Source: ABdhPJx+NpWqNYBqWQ0MiNaiTjO/tNI9Z5DPLf34mjrxrrXQxOE2h2atXjZrtgl0Dokh1gOBf6Km7B5NNOjNOe6xiFs=
X-Received: by 2002:ae9:e004:: with SMTP id m4mr430969qkk.439.1643938880802;
 Thu, 03 Feb 2022 17:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com> <20220203143226.4023622-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-11-benjamin.tissoires@redhat.com>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Thu, 3 Feb 2022 17:41:08 -0800
Message-ID: <CAF8JNhLkihdcXViMNDOk3TfF6eRAJjO_CezL5turdaHA3iRnqw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] HID: input: remove the need for HID_QUIRK_INVERT
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

The logic looks good to me. The whole set is:

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

You may want to wait for a few days to give felixbecker2
(https://github.com/linuxwacom/xf86-input-wacom/issues/186) an
opportunity to test the patchset.

Thank you for your excellent work!
Ping

On Thu, Feb 3, 2022 at 6:33 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> HID_QUIRK_INVERT is kind of complex to deal with and was bogus.
>
> Furthermore, it didn't make sense to use a global per struct hid_device
> quirk for something dynamic as the current state.
>
> Store the current tool information in the report itself, and re-order
> the processing of the fields to enforce having all the tablet "state"
> fields before getting to In Range and other input fields.
>
> This way, we now have all the information whether a tool is present
> or not while processing In Range.
>
> This new behavior enforces that only one tool gets forwarded to userspace
> at the same time, and that if either eraser or invert is set, we enforce
> BTN_TOOL_RUBBER.
>
> Note that the release of the previous tool now happens in its own EV_SYN
> report so userspace doesn't get confused by having 2 tools.
>
> These changes are tested in the following hid-tools regression tests:
> https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ---
>
> Changes in v2:
> - rework the entire tool switching, this makes the processing
>   slightly more complex but is better for existing userspace.
> ---
>  drivers/hid/hid-input.c | 98 +++++++++++++++++++++++++++++++++++++----
>  include/linux/hid.h     |  6 ++-
>  2 files changed, 95 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 61d91117f4ae..9f8853640648 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -63,8 +63,11 @@ static const struct {
>   * This still leaves us 65535 individual priority values.
>   */
>  static const __u32 hidinput_usages_priorities[] = {
> +       HID_DG_ERASER,          /* Eraser (eraser touching) must always come before tipswitch */
>         HID_DG_INVERT,          /* Invert must always come before In Range */
> -       HID_DG_INRANGE,
> +       HID_DG_TIPSWITCH,       /* Is the tip of the tool touching? */
> +       HID_DG_TIPPRESSURE,     /* Tip Pressure might emulate tip switch */
> +       HID_DG_INRANGE,         /* In Range needs to come after the other tool states */
>  };
>
>  #define map_abs(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
> @@ -1365,9 +1368,38 @@ static void hidinput_handle_scroll(struct hid_usage *usage,
>         input_event(input, EV_REL, usage->code, hi_res);
>  }
>
> +static void hid_report_release_tool(struct hid_report *report, struct input_dev *input,
> +                                   unsigned int tool)
> +{
> +       /* if the given tool is not currently reported, ignore */
> +       if (!test_bit(tool, input->key))
> +               return;
> +
> +       /*
> +        * if the given tool was previously set, release it,
> +        * release any TOUCH and send an EV_SYN
> +        */
> +       input_event(input, EV_KEY, BTN_TOUCH, 0);
> +       input_event(input, EV_KEY, tool, 0);
> +       input_event(input, EV_SYN, SYN_REPORT, 0);
> +
> +       report->tool = 0;
> +}
> +
> +static void hid_report_set_tool(struct hid_report *report, struct input_dev *input,
> +                               unsigned int new_tool)
> +{
> +       if (report->tool != new_tool)
> +               hid_report_release_tool(report, input, report->tool);
> +
> +       input_event(input, EV_KEY, new_tool, 1);
> +       report->tool = new_tool;
> +}
> +
>  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
>  {
>         struct input_dev *input;
> +       struct hid_report *report = field->report;
>         unsigned *quirks = &hid->quirks;
>
>         if (!usage->type)
> @@ -1418,25 +1450,75 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>         }
>
>         switch (usage->hid) {
> +       case HID_DG_ERASER:
> +               report->tool_active |= !!value;
> +
> +               /*
> +                * if eraser is set, we must enforce BTN_TOOL_RUBBER
> +                * to accommodate for devices not following the spec.
> +                */
> +               if (value)
> +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> +               else if (report->tool != BTN_TOOL_RUBBER)
> +                       /* value is off, tool is not rubber, ignore */
> +                       return;
> +
> +               /* let hid-input set BTN_TOUCH */
> +               break;
> +
>         case HID_DG_INVERT:
> -               *quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
> +               report->tool_active |= !!value;
> +
> +               /*
> +                * If invert is set, we store BTN_TOOL_RUBBER.
> +                */
> +               if (value)
> +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> +               else if (!report->tool_active)
> +                       /* tool_active not set means Invert and Eraser are not set */
> +                       hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
> +
> +               /* no further processing */
>                 return;
>
>         case HID_DG_INRANGE:
> -               if (value) {
> -                       input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
> -                       return;
> +               report->tool_active |= !!value;
> +
> +               if (report->tool_active) {
> +                       /*
> +                        * if tool is not set but is marked as active,
> +                        * assume ours
> +                        */
> +                       if (!report->tool)
> +                               hid_report_set_tool(report, input, usage->code);
> +               } else {
> +                       hid_report_release_tool(report, input, usage->code);
>                 }
> -               input_event(input, usage->type, usage->code, 0);
> -               input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
> +
> +               /* reset tool_active for the next event */
> +               report->tool_active = false;
> +
> +               /* no further processing */
>                 return;
>
> +       case HID_DG_TIPSWITCH:
> +               report->tool_active |= !!value;
> +
> +               /* if tool is set to RUBBER we should ignore the current value */
> +               if (report->tool == BTN_TOOL_RUBBER)
> +                       return;
> +
> +               break;
> +
>         case HID_DG_TIPPRESSURE:
>                 if (*quirks & HID_QUIRK_NOTOUCH) {
>                         int a = field->logical_minimum;
>                         int b = field->logical_maximum;
>
> -                       input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
> +                       if (value > a + ((b - a) >> 3)) {
> +                               input_event(input, EV_KEY, BTN_TOUCH, 1);
> +                               report->tool_active = true;
> +                       }
>                 }
>                 break;
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index eaad0655b05c..feb8df61168f 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -347,7 +347,7 @@ struct hid_item {
>   */
>  #define MAX_USBHID_BOOT_QUIRKS 4
>
> -#define HID_QUIRK_INVERT                       BIT(0)
> +/* BIT(0) reserved for backward compatibility, was HID_QUIRK_INVERT */
>  #define HID_QUIRK_NOTOUCH                      BIT(1)
>  #define HID_QUIRK_IGNORE                       BIT(2)
>  #define HID_QUIRK_NOGET                                BIT(3)
> @@ -515,6 +515,10 @@ struct hid_report {
>         unsigned maxfield;                              /* maximum valid field index */
>         unsigned size;                                  /* size of the report (bits) */
>         struct hid_device *device;                      /* associated device */
> +
> +       /* tool related state */
> +       bool tool_active;                               /* whether the current tool is active */
> +       unsigned int tool;                              /* BTN_TOOL_* */
>  };
>
>  #define HID_MAX_IDS 256
> --
> 2.33.1
>
