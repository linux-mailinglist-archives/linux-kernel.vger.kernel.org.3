Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968C4EEB53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbiDAKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245141AbiDAKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38F61F6379
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648809061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HB17sb3jBRONtjNCCX5ztUyKEeWYo+nlWIhaa49u2tQ=;
        b=NpcRO1z7K2zMN3+zrI67FamZ1Q4HCU0SvgmUBB3TudRTqvFyFmvCeF/E/tnXzih7uAT3VR
        ivPVFvaUZMnzKzJWpT1Fpk5l12rO4wCF08Xf+x2+f7ZxHwHG8BMSaXjfBx52cYNgq2H12I
        yUadVR4DLQgoZ6cvbqoUnswTIIPrtAQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-PrzaM-kvO72YgjeYiTYqgQ-1; Fri, 01 Apr 2022 06:31:00 -0400
X-MC-Unique: PrzaM-kvO72YgjeYiTYqgQ-1
Received: by mail-pl1-f198.google.com with SMTP id s16-20020a170902ea1000b00156547b6480so1316069plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB17sb3jBRONtjNCCX5ztUyKEeWYo+nlWIhaa49u2tQ=;
        b=0WZwtM72TiMMfDdj8587rh36B/GcukxmNH+KoHU5z63zLHDO/8vX8E8t7KnoR1Ccw0
         15LHlg2q3EK2EBsh0CLSkwCbPJq1Wz1aHOAVTy5koG3qImMsWc+L961f2YSMJ+vFnt9y
         cJK63r6Jri/OpymfpaBh7Dai3muXt0jfaozolM51stOLdl1YGDZ8W6eb+EZ5mgqR2W9c
         pGuab9X5F/iZnSYhHNXbzD2pi+GEwZGye9jDj/4wKDADIIFxiIyDS2+8TQ3+VYTdqoAQ
         Y6vXIz5LqbVI3KkFE/04zE6sgx/rVyn9Z/Oq/VZ1womsJ1ueHFYMhROkshVJRZGOR7ai
         NBCQ==
X-Gm-Message-State: AOAM533OA0cyNdtZWFRnTi2JLHaECIhqLoRR/2vyVeZYfKdyGqUjmsry
        SQg1bjK2S874TLOlXd1Xof5mWM3qg13cHDIh2d1hzJGjXhkBB0cyUGElejE3XAvtuxNK1IuKcsL
        pN2RiL/inuzROlDXisatDwQ/DG0MXIxsr9DRbNIhO
X-Received: by 2002:a17:90a:560a:b0:1bc:72e7:3c13 with SMTP id r10-20020a17090a560a00b001bc72e73c13mr11101891pjf.246.1648809058707;
        Fri, 01 Apr 2022 03:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE4Gr323p5yx5ehUX1CWz4BAMECXjHIOw+N0u3oICb+Eh1VLSu7ccsTfq52g2DCY1ED6KGwUjepLJU8E47qJg=
X-Received: by 2002:a17:90a:560a:b0:1bc:72e7:3c13 with SMTP id
 r10-20020a17090a560a00b001bc72e73c13mr11101865pjf.246.1648809058375; Fri, 01
 Apr 2022 03:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220213214924.32407-1-flokli@flokli.de> <20220213214924.32407-2-flokli@flokli.de>
In-Reply-To: <20220213214924.32407-2-flokli@flokli.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 1 Apr 2022 12:30:47 +0200
Message-ID: <CAO-hwJ+AXxf+0TtQ1Zkk9MQNZuBWsa3_eb4aAg_u+-gEuKbLPQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] HID: lenovo: Add support for ThinkPad TrackPoint
 Keyboard II
To:     Florian Klink <flokli@flokli.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        ValdikSS <iam@valdikss.org.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the work Florian, and sorry for the delay.

One comment below:

On Sun, Feb 13, 2022 at 11:01 PM Florian Klink <flokli@flokli.de> wrote:
>
> From: ValdikSS <iam@valdikss.org.ru>
>
> This keyboard has two modes: regular HID and a native mode, which is used
> in Windows driver. Native mode disables (poor) middle mouse button
> scrolling emulation and reports middle button and scrolling events with a
> custom report ID, which could be better handled in the driver.
>
> This commit adds functional button mapping and native scrolling support.
>
> HID collection in Bluetooth mode for custom report ID=5 is broken and
> is patched upon connection. The collection initially contains incorrect
> Usage Minimum/Usage Maximum numbers and, more importantly, marks Input
> as Variable, not Array, while reporting values as in Array.
>
> The keyboard is very similar to Compact USB/Bluetooth Keyboard with
> TrackPoint, that's why this patch reuses all of cptkbd functions, except
> for input mapping.
>
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---
>  drivers/hid/hid-ids.h    |   2 +
>  drivers/hid/hid-lenovo.c | 160 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 156 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 26cee452ec44..16c171d3e116 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -752,7 +752,9 @@
>  #define USB_VENDOR_ID_LENOVO           0x17ef
>  #define USB_DEVICE_ID_LENOVO_TPKBD     0x6009
>  #define USB_DEVICE_ID_LENOVO_CUSBKBD   0x6047
> +#define USB_DEVICE_ID_LENOVO_TPIIUSBKBD        0x60ee
>  #define USB_DEVICE_ID_LENOVO_CBTKBD    0x6048
> +#define USB_DEVICE_ID_LENOVO_TPIIBTKBD 0x60e1
>  #define USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL       0x6049
>  #define USB_DEVICE_ID_LENOVO_TP10UBKBD 0x6062
>  #define USB_DEVICE_ID_LENOVO_TPPRODOCK 0x6067
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 93b1f935e526..a612ae7dfbfc 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -4,6 +4,7 @@
>   *  - ThinkPad USB Keyboard with TrackPoint (tpkbd)
>   *  - ThinkPad Compact Bluetooth Keyboard with TrackPoint (cptkbd)
>   *  - ThinkPad Compact USB Keyboard with TrackPoint (cptkbd)
> + *  - ThinkPad TrackPoint Keyboard II USB/Bluetooth (cptkbd/tpIIkbd)
>   *
>   *  Copyright (c) 2012 Bernhard Seibold
>   *  Copyright (c) 2014 Jamie Lentin <jm@lentin.co.uk>
> @@ -110,6 +111,23 @@ static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
>         0x2a, 0xff, 0xff,       /*  Usage Maximum (65535)               */
>  };
>
> +/* Broken ThinkPad TrackPoint II collection (Bluetooth mode) */
> +static const __u8 lenovo_tpIIbtkbd_need_fixup_collection[] = {
> +       0x06, 0x00, 0xFF,       /* Usage Page (Vendor Defined 0xFF00) */
> +       0x09, 0x01,             /* Usage (0x01) */
> +       0xA1, 0x01,             /* Collection (Application) */
> +       0x85, 0x05,             /*   Report ID (5) */
> +       0x1A, 0xF1, 0x00,       /*   Usage Minimum (0xF1) */
> +       0x2A, 0xFC, 0x00,       /*   Usage Maximum (0xFC) */
> +       0x15, 0x00,             /*   Logical Minimum (0) */
> +       0x25, 0x01,             /*   Logical Maximum (1) */
> +       0x75, 0x01,             /*   Report Size (1) */
> +       0x95, 0x0D,             /*   Report Count (13) */
> +       0x81, 0x02,             /*   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position) */
> +       0x95, 0x03,             /*   Report Count (3) */
> +       0x81, 0x01,             /*   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position) */
> +};
> +
>  static __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>                 unsigned int *rsize)
>  {
> @@ -126,6 +144,19 @@ static __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>                         rdesc[152] = 0x00;
>                 }
>                 break;
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
> +               if (*rsize >= 263 &&
> +                   memcmp(&rdesc[234], lenovo_tpIIbtkbd_need_fixup_collection,
> +                         sizeof(lenovo_tpIIbtkbd_need_fixup_collection)) == 0) {
> +                       rdesc[244] = 0x00; /* usage minimum = 0x00 */
> +                       rdesc[247] = 0xff; /* usage maximum = 0xff */
> +                       rdesc[252] = 0xff; /* logical maximum = 0xff */
> +                       rdesc[254] = 0x08; /* report size = 0x08 */
> +                       rdesc[256] = 0x01; /* report count = 0x01 */
> +                       rdesc[258] = 0x00; /* input = 0x00 */
> +                       rdesc[260] = 0x01; /* report count (2) = 0x01 */
> +               }
> +               break;
>         }
>         return rdesc;
>  }
> @@ -217,6 +248,101 @@ static int lenovo_input_mapping_cptkbd(struct hid_device *hdev,
>         return 0;
>  }
>
> +static int lenovo_input_mapping_tpIIkbd(struct hid_device *hdev,
> +               struct hid_input *hi, struct hid_field *field,
> +               struct hid_usage *usage, unsigned long **bit, int *max)
> +{
> +       /*
> +        * 0xff0a0000 = USB, HID_UP_MSVENDOR = BT.
> +        *
> +        * In BT mode, there are two HID_UP_MSVENDOR pages.
> +        * Use only the page that contains report ID == 5.
> +        */
> +       if (((usage->hid & HID_USAGE_PAGE) == 0xff0a0000 ||
> +           (usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) &&
> +           field->report->id == 5) {
> +               switch (usage->hid & HID_USAGE) {
> +               case 0x00bb: /* Fn-F4: Mic mute */
> +                       map_key_clear(LENOVO_KEY_MICMUTE);
> +                       return 1;
> +               case 0x00c3: /* Fn-F5: Brightness down */
> +                       map_key_clear(KEY_BRIGHTNESSDOWN);
> +                       return 1;
> +               case 0x00c4: /* Fn-F6: Brightness up */
> +                       map_key_clear(KEY_BRIGHTNESSUP);
> +                       return 1;
> +               case 0x00c1: /* Fn-F8: Notification center */
> +                       map_key_clear(KEY_NOTIFICATION_CENTER);
> +                       return 1;
> +               case 0x00bc: /* Fn-F9: Control panel */
> +                       map_key_clear(KEY_CONFIG);
> +                       return 1;
> +               case 0x00b6: /* Fn-F10: Bluetooth */
> +                       map_key_clear(KEY_BLUETOOTH);
> +                       return 1;
> +               case 0x00b7: /* Fn-F11: Keyboard config */
> +                       map_key_clear(KEY_KEYBOARD);
> +                       return 1;
> +               case 0x00b8: /* Fn-F12: User function */
> +                       map_key_clear(KEY_PROG1);
> +                       return 1;
> +               case 0x00b9: /* Fn-PrtSc: Snipping tool */
> +                       map_key_clear(KEY_SELECTIVE_SCREENSHOT);
> +                       return 1;
> +               case 0x00b5: /* Fn-Esc: Fn-lock toggle */
> +                       map_key_clear(KEY_FN_ESC);
> +                       return 1;
> +               }
> +       }
> +
> +       if ((usage->hid & HID_USAGE_PAGE) == 0xffa00000) {
> +               switch (usage->hid & HID_USAGE) {
> +               case 0x00fb: /* Middle mouse (in native USB mode) */
> +                       map_key_clear(BTN_MIDDLE);
> +                       return 1;
> +               }
> +       }
> +
> +       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR &&
> +           field->report->id == 21) {
> +               switch (usage->hid & HID_USAGE) {
> +               case 0x0004: /* Middle mouse (in native Bluetooth mode) */
> +                       map_key_clear(BTN_MIDDLE);
> +                       return 1;
> +               }
> +       }
> +
> +       /* Compatibility middle/wheel mappings should be ignored */
> +       if (usage->hid == HID_GD_WHEEL)
> +               return -1;
> +       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON &&
> +                       (usage->hid & HID_USAGE) == 0x003)
> +               return -1;
> +       if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER &&
> +                       (usage->hid & HID_USAGE) == 0x238)
> +               return -1;
> +
> +       /* Map wheel emulation reports: 0xff10 */
> +       if ((usage->hid & HID_USAGE_PAGE) == 0xff100000) {
> +               field->flags |= HID_MAIN_ITEM_RELATIVE | HID_MAIN_ITEM_VARIABLE;
> +               field->logical_minimum = -127;
> +               field->logical_maximum = 127;
> +
> +               switch (usage->hid & HID_USAGE) {
> +               case 0x0000:
> +                       hid_map_usage(hi, usage, bit, max, EV_REL, REL_HWHEEL);
> +                       return 1;
> +               case 0x0001:
> +                       hid_map_usage(hi, usage, bit, max, EV_REL, REL_WHEEL);
> +                       return 1;
> +               default:
> +                       return -1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int lenovo_input_mapping_scrollpoint(struct hid_device *hdev,
>                 struct hid_input *hi, struct hid_field *field,
>                 struct hid_usage *usage, unsigned long **bit, int *max)
> @@ -326,6 +452,10 @@ static int lenovo_input_mapping(struct hid_device *hdev,
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
>                 return lenovo_input_mapping_cptkbd(hdev, hi, field,
>                                                         usage, bit, max);
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
> +               return lenovo_input_mapping_tpIIkbd(hdev, hi, field,
> +                                                       usage, bit, max);
>         case USB_DEVICE_ID_IBM_SCROLLPOINT_III:
>         case USB_DEVICE_ID_IBM_SCROLLPOINT_PRO:
>         case USB_DEVICE_ID_IBM_SCROLLPOINT_OPTICAL:
> @@ -363,10 +493,12 @@ static int lenovo_send_cmd_cptkbd(struct hid_device *hdev,
>
>         switch (hdev->product) {
>         case USB_DEVICE_ID_LENOVO_CUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
>                 ret = hid_hw_raw_request(hdev, 0x13, buf, 3,
>                                         HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>                 break;
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                 ret = hid_hw_output_report(hdev, buf, 3);
>                 break;
>         default:
> @@ -422,6 +554,8 @@ static ssize_t attr_fn_lock_store(struct device *dev,
>         switch (hdev->product) {
>         case USB_DEVICE_ID_LENOVO_CUSBKBD:
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                 lenovo_features_set_cptkbd(hdev);
>                 break;
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
> @@ -568,6 +702,8 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
>         switch (hdev->product) {
>         case USB_DEVICE_ID_LENOVO_CUSBKBD:
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                 return lenovo_event_cptkbd(hdev, field, usage, value);
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
> @@ -960,8 +1096,9 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
>         struct lenovo_drvdata *cptkbd_data;
>
>         /* All the custom action happens on the USBMOUSE device for USB */
> -       if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD
> -                       && hdev->type != HID_TYPE_USBMOUSE) {
> +       if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
> +           (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD)) &&
> +           hdev->type != HID_TYPE_USBMOUSE) {
>                 hid_dbg(hdev, "Ignoring keyboard half of device\n");
>                 return 0;
>         }
> @@ -977,11 +1114,14 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
>
>         /*
>          * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
> -        * regular keys
> +        * regular keys (Compact only)
>          */
> -       ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
> -       if (ret)
> -               hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
> +       if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
> +           hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {

Is there a chance that other PIDs included in the files are needing that call?
I'm just worried about regressions here.

Beside that question, the series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +               ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
> +               if (ret)
> +                       hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
> +       }
>
>         /* Switch middle button to native mode */
>         ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
> @@ -1088,6 +1228,8 @@ static int lenovo_probe(struct hid_device *hdev,
>                 break;
>         case USB_DEVICE_ID_LENOVO_CUSBKBD:
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                 ret = lenovo_probe_cptkbd(hdev);
>                 break;
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
> @@ -1154,6 +1296,8 @@ static void lenovo_remove(struct hid_device *hdev)
>                 break;
>         case USB_DEVICE_ID_LENOVO_CUSBKBD:
>         case USB_DEVICE_ID_LENOVO_CBTKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +       case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                 lenovo_remove_cptkbd(hdev);
>                 break;
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
> @@ -1172,6 +1316,8 @@ static int lenovo_input_configured(struct hid_device *hdev,
>                 case USB_DEVICE_ID_LENOVO_TPKBD:
>                 case USB_DEVICE_ID_LENOVO_CUSBKBD:
>                 case USB_DEVICE_ID_LENOVO_CBTKBD:
> +               case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> +               case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
>                         if (test_bit(EV_REL, hi->input->evbit)) {
>                                 /* set only for trackpoint device */
>                                 __set_bit(INPUT_PROP_POINTER, hi->input->propbit);
> @@ -1188,7 +1334,9 @@ static int lenovo_input_configured(struct hid_device *hdev,
>  static const struct hid_device_id lenovo_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPIIUSBKBD) },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPIIBTKBD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_III) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_PRO) },
> --
> 2.35.1
>

