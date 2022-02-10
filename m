Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA64B04CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiBJFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:21:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBJFVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:21:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70FECD6;
        Wed,  9 Feb 2022 21:21:41 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o3so4022891qtm.12;
        Wed, 09 Feb 2022 21:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNDjuCPLook++LlbEgpTlBYkW8kYYECY5ZtnjFkCIxM=;
        b=EFEKrnKYrNHDaX7gmz71gQVO0DR/GnQH0gDBWSew2LoN//FOhXFP+jyPJTWjsDrVl4
         vF0juWvmn8Us8/Sm3MtbgG0Bn+JrBmE6REEhm/PtP1bitSdWyXZA+XsYBNDe/LzTEAe6
         PRWP1BAfYyzHca7k7b0MKaTm6BIoLYaAKRVcK6rCo9AXa1Nh2LKGrdrBdozE2PJex7Ag
         dIA5lN/+Ojo3fCp+GkOpvU9Mxt+NoPBFenC/Z/bR5ht9BXq399ufM1UCbcca0HrYUXfu
         FSBSBwytsrQ+CMEPHEd5Jm0WIGATjFtXbf1qKrMw1QFD7YewwqFB7ZxCXrONCBdnDGYx
         Fz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNDjuCPLook++LlbEgpTlBYkW8kYYECY5ZtnjFkCIxM=;
        b=fpZiwkawrnu4LuBK7WrtDCwXL7x38OpHTnx8/NGnHBBQ1wm1MiHHhl2bif9ARL+e/M
         620AoU30Y+J/YidXTWac+XOLsrtpj5Iug9wlLbGIaPI/OgBoyVJ+J30fwbj9PjzyAfzp
         VoPdUVl4sIQA8I4JY2RCLlVvfR3vZIZmPzQT9LV+RxxSCCMX2N5GwXRFmUHXyKjRhBT9
         oNy9CD4nFH7jTIgGRtXrEcW2IkIjSPuwVTr1bucYCR50f/2PvgF7NPo4kFzuyGwNGrg3
         JOR9HmmQd0mRRt0qkkUMODgwoRpv5jMEO02A0qKnvo/LGm4MBbyNkW182Ua8iCUdXVQx
         YqKQ==
X-Gm-Message-State: AOAM532c7SpNBYfKB5D65tus66Wp6lsspOGurrQXc2D6Ql1NxaWNkmq8
        Y4BSTPArONFSzxUM0bKjGTgQv6s5Andl8VRU4AF5wfSJyUE5fw==
X-Google-Smtp-Source: ABdhPJzoZ/fj4TkDdMJI9jKvZ92q78C13EhqjLL2YZA3zvvG6PBD9uUROCgGUK6FYXxgbzGS3e6osHMOpirfrUIcV8U=
X-Received: by 2002:ac8:5a54:: with SMTP id o20mr3798702qta.654.1644470500864;
 Wed, 09 Feb 2022 21:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com> <20220203143226.4023622-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-11-benjamin.tissoires@redhat.com>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Wed, 9 Feb 2022 21:21:25 -0800
Message-ID: <CAF8JNhKbEWj1b4o2Uv7snXa_JGt0bk5wyUGP4_77aHTLhPRT3w@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Took a while for me to find the right device and setup the proper
system for the testing. This block missing the serial number:

input_event(input, EV_MSC, MSC_SERIAL, 0);

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
