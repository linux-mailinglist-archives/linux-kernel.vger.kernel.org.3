Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4447428F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhLNMaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229703AbhLNMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639485010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTyFG3YsB7tsSM37catQ8Lu85xm2DMPfWO+OkIfmBBA=;
        b=I3q8W67chYcLkBoLRkk/iG2CcmfPBK8R7pSN8ILaY1pvRUp2gZZnA3bkQ1v3nTNYz3ufhW
        ksFT+kPdpODqZSZ7nNs22+u6Y0AUe7wdkxgM9lDOkmgZbcLgoJEiACZHWW5hehd9nXaxkI
        bnvtwMI5VnZP3nZHNRqsk8eKKib5rBc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-romoSP4AN6GdzyJ5UtyBuQ-1; Tue, 14 Dec 2021 07:30:09 -0500
X-MC-Unique: romoSP4AN6GdzyJ5UtyBuQ-1
Received: by mail-pj1-f70.google.com with SMTP id mv1-20020a17090b198100b001a67d5901d2so15100750pjb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTyFG3YsB7tsSM37catQ8Lu85xm2DMPfWO+OkIfmBBA=;
        b=Brx/QekdfVuMaMqGPjI6aD87JYv5tHSaYCNH202leSyKgJJTP9M16DWV/6lHWouWLw
         i8TiBOmb9+6YdWmiCp2rDPK3AJy1yTHAWWLTLMIBjPWv/GNqt8H4xBXD3XFVMcTU6Zdl
         DuXP8GkyBB0KGMQOrcvhzpzqbmxTVza+LvdTvBli2ZwRcJhO4Ac4kgT5/3Qt8Donme0L
         4Wu99ymQpepw+RIPo75caUehceL+dKbVRqR+zwcibLkLTmb9aDkZbk5VFxgoe0wMdIRP
         lffk5NAM53IIF43yuNNIgcgE0NO4RBph7BaCP6JvpqkKIZzUqVZTOISjJtdXvASZCHB9
         RI4A==
X-Gm-Message-State: AOAM532s5ImhsuXbCNHb6FImgMidFHahIS4k96zH5cHmToYsPRBdBUAr
        zD0imrHf42oN8QEaYOQjV1dLhW890xyvhXaAHbODG0Z4PFAXNys8pKFwIO1WTke19DL7jLGKcO1
        t0QByQZaVwgy1Ax4lLX/SkxO2nY9CSZxg0t/lUUyb
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id i11-20020a1709026acb00b0014276c3d35fmr5472922plt.89.1639485008526;
        Tue, 14 Dec 2021 04:30:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6mDUnSBRe9EuywU5VMlaoigZvD5cthorjYWy2TS8h5Ou6Ps7fBokraV9xsXSIWnH5IKI0i8VhUTjngJhNgWo=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr5472887plt.89.1639485008236; Tue, 14
 Dec 2021 04:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20211109082610.131341-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211109082610.131341-1-chi.minghao@zte.com.cn>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Dec 2021 13:29:57 +0100
Message-ID: <CAO-hwJL5wqfF48FFyGXFyLcuRJ0czJJjt9g=7jfdcSCumACfcQ@mail.gmail.com>
Subject: Re: [PATCH] drivers:hid: use swap() to make code cleaner
To:     cgel.zte@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 9, 2021 at 9:26 AM <cgel.zte@gmail.com> wrote:
>
> From: chiminghao <chi.minghao@zte.com.cn>
>
> Fix the following coccicheck REVIEW:
> Use swap() instead of reimplementing it.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---

Amended the commit title to match what we do generally in the HID tree
and applied to for-5.17/thrustmaster.

Thanks for the patch!

Cheers,
Benjamin

>  drivers/hid/hid-tmff.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
> index 90acef304536..4040cd98dafe 100644
> --- a/drivers/hid/hid-tmff.c
> +++ b/drivers/hid/hid-tmff.c
> @@ -78,7 +78,6 @@ static int tmff_play(struct input_dev *dev, void *data,
>         struct hid_field *ff_field = tmff->ff_field;
>         int x, y;
>         int left, right;        /* Rumbling */
> -       int motor_swap;
>
>         switch (effect->type) {
>         case FF_CONSTANT:
> @@ -104,11 +103,8 @@ static int tmff_play(struct input_dev *dev, void *data,
>                                         ff_field->logical_maximum);
>
>                 /* 2-in-1 strong motor is left */
> -               if (hid->product == THRUSTMASTER_DEVICE_ID_2_IN_1_DT) {
> -                       motor_swap = left;
> -                       left = right;
> -                       right = motor_swap;
> -               }
> +               if (hid->product == THRUSTMASTER_DEVICE_ID_2_IN_1_DT)
> +                       swap(left, right);
>
>                 dbg_hid("(left,right)=(%08x, %08x)\n", left, right);
>                 ff_field->value[0] = left;
> --
> 2.25.1
>

