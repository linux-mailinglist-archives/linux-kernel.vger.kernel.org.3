Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C54F12C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356273AbiDDKLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiDDKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B157255B1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649066989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2auGM2TB1AM3HEKB6SIDRfPtgarOCPALoc7tLqerik=;
        b=aAZR2fDs4DMupzKhUJQTDWWy5tRbz0U2eGatHGPDCmKX87tZANY2NBgtotGcwZDR7maWx0
        1+MQSKqy269aihhNxrE9pDrfzs3Tc6snJpReqzobOqHewzKlgUT4wPMsN74S/GJWDPSJ/3
        dCdevAoVpX6RCcQueEqQSMRdQid7ADg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-yeyhHIXMOnChypV-kYXF-A-1; Mon, 04 Apr 2022 06:09:48 -0400
X-MC-Unique: yeyhHIXMOnChypV-kYXF-A-1
Received: by mail-pl1-f200.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso3237756pll.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2auGM2TB1AM3HEKB6SIDRfPtgarOCPALoc7tLqerik=;
        b=V4SpIhDHPSfl7JoTSWl/OOQYWcSl+Bfw77G7u8C/4Qb6v4WvqQ1ptt1Vld6kZeo1JT
         11nUtFXPJo2FTp4BrWDvzjP4dMsIlbrzShh5C5rGLkYE78/SMAPc1rC1R+SN+erWmFEi
         afpMoyz8d/OXX1q2VqjVPqN1se/LoMrI9JaGLwxXfSstYTO6lisaH0lX3FKC331KRIXM
         G9aRF61AGYiKyRBuBpvY4lc+FzzS52Gdd89rwEMH+1fnnmW4sIr4ow4F30oZF0mh06h5
         kDKi3qFeXAanfW/ux3sVrdUEjaplX8xLLkdG6mi87ehiHvT6gFw4B/IX8F2ba8Rt+PyD
         SlVg==
X-Gm-Message-State: AOAM531cH4HnbglKw1zYji90dg7G8EbmFfbJJyVhwJ/eb6ue35apE4u9
        jkRA29X58N/EUoUUhxVimgOjex3aOQxSVvJquNXoHp0GHSQqV/E4tZRk1fZBwmJQLO9/jCT3Kj+
        qiCj3SvnCNFgUanpD0maozuKQjCb8woCv/XCsRazL
X-Received: by 2002:a17:90b:224b:b0:1c6:f027:90b1 with SMTP id hk11-20020a17090b224b00b001c6f02790b1mr25423415pjb.173.1649066986969;
        Mon, 04 Apr 2022 03:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+h90XXAkBxlJPjBFuLx4qxEOIdjAEdrdK7/no9eE8WTxd9QEgUhDWaO3mq+sKV8Jb4/qGr0egPLtc8H2fF9Y=
X-Received: by 2002:a17:90b:224b:b0:1c6:f027:90b1 with SMTP id
 hk11-20020a17090b224b00b001c6f02790b1mr25423383pjb.173.1649066986556; Mon, 04
 Apr 2022 03:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <CO6PR03MB6241CB276FCDC7F4CEDC34F6E1E29@CO6PR03MB6241.namprd03.prod.outlook.com>
In-Reply-To: <CO6PR03MB6241CB276FCDC7F4CEDC34F6E1E29@CO6PR03MB6241.namprd03.prod.outlook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 4 Apr 2022 12:09:35 +0200
Message-ID: <CAO-hwJKTi6A=3nw6yFbvASgSqH_UwED7MEabiKKEnbFUB55UXg@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: add quirks to enable Lenovo X12 trackpoint
To:     Tao Jin <tao-j@outlook.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

Hi,

On Sun, Apr 3, 2022 at 6:58 PM Tao Jin <tao-j@outlook.com> wrote:
>
> This applies the similar quirks used by previous generation devices
> such as X1 tablet for X12 tablet, so that the trackpoint and buttons
> can work.
>
> This patch was applied and tested working on 5.17.1 .
>
> Signed-off-by: Tao Jin <tao-j@outlook.com>

Thanks a lot for the patch.

I have added the CC: stable@vger.kernel.org tag and pushed the patch
to for-5.18/upstream-fixes

Cheers,
Benjamin

> ---
>  drivers/hid/hid-ids.h        | 1 +
>  drivers/hid/hid-multitouch.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 78bd3dd..aca7909 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -760,6 +760,7 @@
>  #define USB_DEVICE_ID_LENOVO_X1_COVER  0x6085
>  #define USB_DEVICE_ID_LENOVO_X1_TAB    0x60a3
>  #define USB_DEVICE_ID_LENOVO_X1_TAB3   0x60b5
> +#define USB_DEVICE_ID_LENOVO_X12_TAB   0x60fe
>  #define USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E    0x600e
>  #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D     0x608d
>  #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019     0x6019
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 99eabfb..0dece60 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2034,6 +2034,12 @@ static const struct hid_device_id mt_devices[] = {
>                            USB_VENDOR_ID_LENOVO,
>                            USB_DEVICE_ID_LENOVO_X1_TAB3) },
>
> +       /* Lenovo X12 TAB Gen 1 */
> +       { .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> +               HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
> +                          USB_VENDOR_ID_LENOVO,
> +                          USB_DEVICE_ID_LENOVO_X12_TAB) },
> +
>         /* MosArt panels */
>         { .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
>                 MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> --
> 2.35.1
>

