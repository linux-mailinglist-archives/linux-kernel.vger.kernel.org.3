Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB042472B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhLML20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232733AbhLML2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639394903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49IXfwSMYuzdL01r4rIJ5dsEZzYtD7h3rOZZT+C9p4U=;
        b=E4cDhG9EiD2nqHJ2kAXEyZU47cJ84sGCQBQtOGbfTPnpqPS+7ITiCWQwmUgvgyv0kMzk80
        Dh9jl521R1VHsQu5CPoXC2OeFY8gBlkGEzQa8EKrZkrRBuKo5clCPtwShEXiOp6YcQe8/H
        ViAdEORJkMYjyKUsHk5bqH+Sko5BjFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-17AJkUrPNZK51aNPUdPJZw-1; Mon, 13 Dec 2021 06:28:20 -0500
X-MC-Unique: 17AJkUrPNZK51aNPUdPJZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC692801962;
        Mon, 13 Dec 2021 11:28:18 +0000 (UTC)
Received: from [10.39.195.18] (unknown [10.39.195.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA024ABA9;
        Mon, 13 Dec 2021 11:28:17 +0000 (UTC)
Message-ID: <b9ca5d3b-abda-5195-4c17-fa3b49d37334@redhat.com>
Date:   Mon, 13 Dec 2021 12:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: logitech-dj: add support for the new lightspeed
 receiver iteration
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>
References: <20210123180334.3062995-1-lains@archlinux.org>
 <CAO-hwJKdfAy9i28iFEKi5DWU0SPOopiEyjT_2HdpL7ahFhdGFg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAO-hwJKdfAy9i28iFEKi5DWU0SPOopiEyjT_2HdpL7ahFhdGFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Mon, Mar 1, 2021 at 3:46 PM Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
> On Sat, Jan 23, 2021 at 7:03 PM Filipe Laíns <lains@archlinux.org> wrote:
> >
> > From: Filipe Laíns <lains@riseup.net>
> >
> > Tested with the G Pro X Superlight. libratbag sees the device, as
> > expected, and input events are passing trough.
> >
> > https://github.com/libratbag/libratbag/pull/1122
> >
> > The receiver has a quirk where the moused interface doesn't have a
> > report ID, I am not sure why, perhaps they forgot. All other interfaces
> > have report IDs so I am left scratching my head.
> > Since this driver doesn't have a quirk system, I simply implemented it
> > as a different receiver type, which is true, it just wouldn't be the
> > prefered approach :P
> >
> > Signed-off-by: Filipe Laíns <lains@riseup.net>
> > ---
> >  drivers/hid/hid-ids.h         |  1 +
> >  drivers/hid/hid-logitech-dj.c | 49 +++++++++++++++++++++++++----------
> >  2 files changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 4c5f23640f9c..8eac3c93fa38 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -803,6 +803,7 @@
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1      0xc539
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1    0xc53f
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY 0xc53a
> > +#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2    0xc547
> >  #define USB_DEVICE_ID_SPACETRAVELLER   0xc623
> >  #define USB_DEVICE_ID_SPACENAVIGATOR   0xc626
> >  #define USB_DEVICE_ID_DINOVO_DESKTOP   0xc704
> > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > index 1401ee2067ca..6596c81947a8 100644
> > --- a/drivers/hid/hid-logitech-dj.c
> > +++ b/drivers/hid/hid-logitech-dj.c
> > @@ -114,6 +114,7 @@ enum recvr_type {
> >         recvr_type_dj,
> >         recvr_type_hidpp,
> >         recvr_type_gaming_hidpp,
> > +       recvr_type_gaming_hidpp_missing_mse_report_id,  /* lightspeed receiver missing the mouse report ID */
> >         recvr_type_mouse_only,
> >         recvr_type_27mhz,
> >         recvr_type_bluetooth,
> > @@ -1360,6 +1361,7 @@ static int logi_dj_ll_parse(struct hid_device *hid)
> >                 dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
> >                         __func__, djdev->reports_supported);
> >                 if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
> > +                   djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp_missing_mse_report_id ||
> >                     djdev->dj_receiver_dev->type == recvr_type_mouse_only)
> >                         rdcat(rdesc, &rsize, mse_high_res_descriptor,
> >                               sizeof(mse_high_res_descriptor));
> > @@ -1605,19 +1607,35 @@ static int logi_dj_raw_event(struct hid_device *hdev,
> >                         data[0] = data[1];
> >                         data[1] = 0;
> >                 }
> > -               /*
> > -                * Mouse-only receivers send unnumbered mouse data. The 27 MHz
> > -                * receiver uses 6 byte packets, the nano receiver 8 bytes.
> > -                */
> > -               if (djrcv_dev->unnumbered_application == HID_GD_MOUSE &&
> > -                   size <= 8) {
> > -                       u8 mouse_report[9];
> > -
> > -                       /* Prepend report id */
> > -                       mouse_report[0] = REPORT_TYPE_MOUSE;
> > -                       memcpy(mouse_report + 1, data, size);
> > -                       logi_dj_recv_forward_input_report(hdev, mouse_report,
> > -                                                         size + 1);
> > +
> > +
> > +               if (djrcv_dev->unnumbered_application == HID_GD_MOUSE) {
> > +                       /*
> > +                        * Mouse-only receivers send unnumbered mouse data. The 27 MHz
> > +                        * receiver uses 6 byte packets, the nano receiver 8 bytes.
> > +                        */
> > +                       if (size <= 8) {
> > +                               u8 mouse_report[9];
>
> Hmm, as stated above, the 27 MHz receiver already does the exact same thing.
>
> Can't we just bump the array size and check above to the following:
>
> if (size <= 16) {
>   u8 mouse_report[17];
>
> The property "djrcv_dev->unnumbered_application" is based on the
> report descriptor entirely, and they are just following the HID norm
> here. So I think this should be enough.

I've been pinged last week about the G Pro X superlight, and Peter found
that this patch never got into upstream.

AFAICT, compared to upstream the following code change should have the
same effect that what you proposed here:
---
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 7106b921b53c..f5cdfce272e7 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1691,11 +1691,12 @@ static int logi_dj_raw_event(struct hid_device *hdev,
                 }
                 /*
                  * Mouse-only receivers send unnumbered mouse data. The 27 MHz
-                * receiver uses 6 byte packets, the nano receiver 8 bytes.
+                * receiver uses 6 byte packets, the nano receiver 8 bytes and
+                * some gaming ones are using 16 bytes.
                  */
                 if (djrcv_dev->unnumbered_application == HID_GD_MOUSE &&
-                   size <= 8) {
-                       u8 mouse_report[9];
+                   size <= 16) {
+                       u8 mouse_report[17];
  
                         /* Prepend report id */
                         mouse_report[0] = REPORT_TYPE_MOUSE;
---

Would you mind sending a v2 of the patch updated to the current for-next so we can schedule this for 5.17?


Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> > +
> > +                               /* Prepend report id */
> > +                               mouse_report[0] = REPORT_TYPE_MOUSE;
> > +                               memcpy(mouse_report + 1, data, size);
> > +                               logi_dj_recv_forward_input_report(hdev, mouse_report,
> > +                                                                 size + 1);
> > +
> > +                       /*
> > +                        * A variant of the ligtpseed receivers is missing the mouse
> > +                        * report ID.
> > +                        */
> > +                       } else if (djrcv_dev->type == recvr_type_gaming_hidpp_missing_mse_report_id) {
> > +                               u8 mouse_report[17];
> > +
> > +                               /* Prepend report id */
> > +                               mouse_report[0] = REPORT_TYPE_MOUSE;
> > +                               memcpy(mouse_report + 1, data, size);
> > +                               logi_dj_recv_forward_input_report(hdev, mouse_report,
> > +                                                                 size + 1);
> > +                       }
> >                 }
> >
> >                 return false;
> > @@ -1688,6 +1706,7 @@ static int logi_dj_probe(struct hid_device *hdev,
> >         case recvr_type_dj:             no_dj_interfaces = 3; break;
> >         case recvr_type_hidpp:          no_dj_interfaces = 2; break;
> >         case recvr_type_gaming_hidpp:   no_dj_interfaces = 3; break;
> > +       case recvr_type_gaming_hidpp_missing_mse_report_id: no_dj_interfaces = 3; break;
> >         case recvr_type_mouse_only:     no_dj_interfaces = 2; break;
> >         case recvr_type_27mhz:          no_dj_interfaces = 2; break;
> >         case recvr_type_bluetooth:      no_dj_interfaces = 2; break;
> > @@ -1886,6 +1905,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> >                 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
> >          .driver_data = recvr_type_gaming_hidpp},
> > +       { /* Logitech lightspeed receiver (0xc547) */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > +               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2),
> > +        .driver_data = recvr_type_gaming_hidpp_missing_mse_report_id},
> >         { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
> >          .driver_data = recvr_type_27mhz},
> > --
> > 2.30.0
> >

