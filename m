Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCE46D6CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhLHPXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235878AbhLHPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638976777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBq1iNWuKAbDrZ8J23xOdNqfh1OrTD+2svsf/GF1r6U=;
        b=cUSDCH+lwc5untfWTam8d+gKaxaIHQAvrbPi5LlleRM5dbZSitmjRl9Sz93NJvWSk9ku7w
        T1BQ5+Iqooh90r/xB9ziE+LUHzBNQk5PeU5Mqt7ZlCpt2NGXtQhY0hgmkDtHT1cOqHHgJS
        iiOLFAN6yOkCCui+4b5im+Hmhs1DJMU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-6u8aIVwaPraYhSrElBAxEw-1; Wed, 08 Dec 2021 10:19:36 -0500
X-MC-Unique: 6u8aIVwaPraYhSrElBAxEw-1
Received: by mail-pf1-f198.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so1726825pfm.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBq1iNWuKAbDrZ8J23xOdNqfh1OrTD+2svsf/GF1r6U=;
        b=4Rqo//OyTMsfgZ0/6K7grEk+hTfrDKeA9dFQX6i9GlB8Q4z/FNss7A2u5zFt95gJgN
         8DQaIEf6YdfizPXx5DrIVPpANYv9vIoWma8lX8VRnZwABJfShtJrNCTpeXkApTUuIoOk
         jS5nNe7vtjsCV5U5XUSCcaGVxD6mwK5iAw6sa/v1wZTvZd1dLRmqCaesEDkA1gzHtMHB
         k2Co2kMaDp7zy984aCusI2jDJDL80qYn5qx5Ufde1aNviSb/mWakX7QVadX5M0AJUP/1
         iJuaDz0sSuHU8ZCgcoE53/6mMFXUlhSHmN6e8Tr3znVacncqfRFWyuahWqeEE6ZhjXK0
         Fttg==
X-Gm-Message-State: AOAM531/TifP/9LbfCO/aButJbtA2V7gRlIW3X1YdShTQ9mkX6OoSB/Y
        7SNYTz9FunO5HU4oyYTF+gDdolRqrmZMC/7ABaHio22+0molMHOGXS6z4Iam2UYmNY1ZRwQMofU
        YKxdechKi2a7kcoqXv9VZmuzabsvS+/hN0lJdu65k
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr7910562pjb.113.1638976775683;
        Wed, 08 Dec 2021 07:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwklgyiSO6Zvc5u9rR6zXqW094LW7vRS1FrHYnDwUZd466ZCWZfjkhr+OZulvTLLRJpkV6JmzebqkIaq9LDa/8=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr7910531pjb.113.1638976775444;
 Wed, 08 Dec 2021 07:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20211201164301.44653-1-tero.kristo@linux.intel.com> <20211201164301.44653-5-tero.kristo@linux.intel.com>
In-Reply-To: <20211201164301.44653-5-tero.kristo@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Dec 2021 16:19:24 +0100
Message-ID: <CAO-hwJKikRFfqXfEG-oU8Hg6v78b9928XKEdh-Uti97Jsy=Z0g@mail.gmail.com>
Subject: Re: [RFCv3 4/7] HID: input: Make hidinput_find_field() static
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 5:43 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> This function is not called outside of hid-input.c so we can make it
> static.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-input.c | 4 ++--
>  include/linux/hid.h     | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b428ee9b4d9b..f6332d269d49 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1477,7 +1477,8 @@ void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
>  }
>  EXPORT_SYMBOL_GPL(hidinput_report_event);
>
> -int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field)
> +static int hidinput_find_field(struct hid_device *hid, unsigned int type,
> +                              unsigned int code, struct hid_field **field)
>  {
>         struct hid_report *report;
>         int i, j;
> @@ -1492,7 +1493,6 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
>         }
>         return -1;
>  }
> -EXPORT_SYMBOL_GPL(hidinput_find_field);
>
>  struct hid_field *hidinput_get_led_field(struct hid_device *hid)
>  {
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 96eaca0d5322..3f1fd4fcf1a9 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -636,7 +636,6 @@ extern void hidinput_disconnect(struct hid_device *);
>
>  int hid_set_field(struct hid_field *, unsigned, __s32);
>  int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
> -int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
>  struct hid_field *hidinput_get_led_field(struct hid_device *hid);
>  unsigned int hidinput_count_leds(struct hid_device *hid);
>  __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
> --
> 2.25.1
>

