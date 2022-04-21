Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C04509C13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387390AbiDUJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387389AbiDUJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A8431A80E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650532353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAsf8msNhJZ+Lu/+Q6XQcyKfvNctUwvpskdLMNyqlx0=;
        b=b9QOGNa4KwXxQNndUCLnK7yOeI94MfBWwCcX5u8BHsvVpQVREEmkwCJ5xIy9+Gdk4Babaf
        P+LC8nCffArBryXoml/1tUt7QcC7eOIvkCOFozmn7FbZlSlYYFJ0/F3Xzb3i2V1uwKt8ze
        KxRUIRdORgFv4zyNXnP/tyoNFluVRxY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-UGZ7L7BNNPKFjNIK6rAVDA-1; Thu, 21 Apr 2022 05:12:32 -0400
X-MC-Unique: UGZ7L7BNNPKFjNIK6rAVDA-1
Received: by mail-pj1-f71.google.com with SMTP id j24-20020a17090aeb1800b001d17733a1a6so4741525pjz.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAsf8msNhJZ+Lu/+Q6XQcyKfvNctUwvpskdLMNyqlx0=;
        b=YpaY1IWds9GxriS+RvQceCvmgU5t/Ym4wwR9tHYRWIu6NQNy/E9kywWnjBJz4y5zq0
         +2JJj929cYyW346SGLlqGXYTp7aHnGfA3YYJpZwpSig3zyCWPAwbttHEijgfu6i2CEvB
         UM5bbCNIgRoW9/ckhc1DLBnsTb/TQmUw4UK3Emq/ArLzglwulcVn9krefuPwCUy23vOP
         qrAwcnCi1xvH5Xi98hgc0cAKMpM7twbblzyc7nVogme2Luc4gzsph/bkIvMNMGu2H531
         0rOEi054Ao5iNgtHFVBZpxVOfW2t95Lyb8HRbIrEnz08W0GuFX3Xmu+oah9b/YtEpToK
         +sRA==
X-Gm-Message-State: AOAM530mKzdKwwzWBiX+qlRCBo97SzhFDjbJ2gb48UwtaXVFmNBqps6o
        pwt3fhHv+v/DevQN+i6ELQ9abKOf2Fqs4GT1iWb/PePMjgiA9+TkEL5ro6sNP6etLa1DMYT1h9A
        LBa4He450zPpuTNrYVw1htJ/3wsCF7xSbfWeP40Jq
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id n1-20020aa79041000000b004fe3d6c1739mr28068961pfo.13.1650532351067;
        Thu, 21 Apr 2022 02:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuons8gIITLhtlNtqZrNYaR/yq6c34TGv1r2bEdYVG5ShaBdCJfi/lU9poZ3LkVz4EbVYTXhjGbNwayoI14m8=
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id
 n1-20020aa79041000000b004fe3d6c1739mr28068941pfo.13.1650532350839; Thu, 21
 Apr 2022 02:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <CO6PR03MB62418A2C022A8E9EDC11A633E1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
In-Reply-To: <CO6PR03MB62418A2C022A8E9EDC11A633E1F39@CO6PR03MB6241.namprd03.prod.outlook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Apr 2022 11:12:20 +0200
Message-ID: <CAO-hwJJE_RAMXQA1kgpxVJWgGOsn64GxbN4fQVq8Dt2xepnYog@mail.gmail.com>
Subject: Re: [PATCH] hid: multitouch: new device class fix Lenovo X12 trackpad sticky
To:     Tao Jin <tao-j@outlook.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 5:16 AM Tao Jin <tao-j@outlook.com> wrote:
>
> The trackpad of the given device sends continuous report of pointers
> status as per wxn8 spec. However, the spec did not clarify when the
> fingers are lifted so fast that between the interval of two report
> frames fingers on pad reduced from >=2 to 0. The second last report
> contains >=2 fingers with tip state 1 and the last report contains only
> 1 finger with tip state 0. Although this can happen unfrequently, a
>   quick fix will be improve the consistency to 100%. A quick fix is to
> disable MT_QUIRK_ALWAYS_VALID and enable MT_QUIRK_NOT_SEEN_MEANS_UP.
> Since it always send reports when fingers on pad
> MT_QUIRK_STICKY_FINGERS is also not needed.

I would really like to see tests for this device added to hid-tools[0].

This would allow me to better understand the issue and also ensure we
are not regressing in the future.

Cheers,
Benjamin


[0] https://gitlab.freedesktop.org/libevdev/hid-tools

>
> In addition to this, I2C device 04CA:00B1 may also need similar class
> but with MT_QUIRK_FORCE_MULTI_INPUT disabled (but it does not harm to
>  enable it on non-multi-input device either). The respective owner has
> been notified and a patch may coming soon after test.
>
> Signed-off-by: Tao Jin <tao-j@outlook.com>
> ---
>  drivers/hid/hid-multitouch.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0dece60..3ea57f3 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -194,6 +194,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
>  #define MT_CLS_WIN_8_FORCE_MULTI_INPUT         0x0015
>  #define MT_CLS_WIN_8_DISABLE_WAKEUP            0x0016
>  #define MT_CLS_WIN_8_NO_STICKY_FINGERS         0x0017
> +#define MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU    0x0018
>
>  /* vendor specific classes */
>  #define MT_CLS_3M                              0x0101
> @@ -286,6 +287,14 @@ static const struct mt_class mt_classes[] = {
>                         MT_QUIRK_WIN8_PTP_BUTTONS |
>                         MT_QUIRK_FORCE_MULTI_INPUT,
>                 .export_all_inputs = true },
> +       { .name = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
> +               .quirks = MT_QUIRK_IGNORE_DUPLICATES |
> +                       MT_QUIRK_HOVERING |
> +                       MT_QUIRK_CONTACT_CNT_ACCURATE |
> +                       MT_QUIRK_WIN8_PTP_BUTTONS |
> +                       MT_QUIRK_FORCE_MULTI_INPUT |
> +                       MT_QUIRK_NOT_SEEN_MEANS_UP,
> +               .export_all_inputs = true },
>         { .name = MT_CLS_WIN_8_DISABLE_WAKEUP,
>                 .quirks = MT_QUIRK_ALWAYS_VALID |
>                         MT_QUIRK_IGNORE_DUPLICATES |
> @@ -783,6 +792,7 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                 case HID_DG_CONFIDENCE:
>                         if ((cls->name == MT_CLS_WIN_8 ||
>                              cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> +                            cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU ||
>                              cls->name == MT_CLS_WIN_8_DISABLE_WAKEUP) &&
>                                 (field->application == HID_DG_TOUCHPAD ||
>                                  field->application == HID_DG_TOUCHSCREEN))
> @@ -2035,7 +2045,7 @@ static const struct hid_device_id mt_devices[] = {
>                            USB_DEVICE_ID_LENOVO_X1_TAB3) },
>
>         /* Lenovo X12 TAB Gen 1 */
> -       { .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> +       { .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
>                 HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
>                            USB_VENDOR_ID_LENOVO,
>                            USB_DEVICE_ID_LENOVO_X12_TAB) },
> --
> 2.35.1
>

