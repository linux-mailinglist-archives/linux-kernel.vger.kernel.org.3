Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D770C46D65A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhLHPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhLHPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638975796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0rnmLYR2bGbskKPMuNtMTb9vCsJDvOb8DdKbW9eR5k=;
        b=SeBr/jT3Ni+2sg7dR7hZoZcGV0g4pMxeLzjrG+OwA3AhlupGzFqtWkYSwISV12fPLv6I69
        IZ2NVbGBa5A2y6gazKk7NQVO70A25cP2lnC9DE4D13P2PWUbJ+PPIxtNxvNdGEa/O+eC6n
        zT7G7WmHckJz9i3Nsojlib3isKbDUGI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-61AxcQ-HP8av8kxN2UFFfw-1; Wed, 08 Dec 2021 10:03:14 -0500
X-MC-Unique: 61AxcQ-HP8av8kxN2UFFfw-1
Received: by mail-pg1-f199.google.com with SMTP id z4-20020a656104000000b00321790921fbso1458792pgu.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0rnmLYR2bGbskKPMuNtMTb9vCsJDvOb8DdKbW9eR5k=;
        b=L6bXDoVnBxlA1HudZH7pUzil71M/2FguRy0qno7vHZY/WR2L2QaNoPr5dsoPlc+/19
         VcaYC9jT/SYgOE4FcofCPxwhz5m766N8dsqyLeYt2leWhCiwpHbZZ0h1bSA7di4RKcMo
         2cxyxwsvR57rcT0GfwGH8TTCfOyRC4MzQFvPpy+wbq7WSiCZq9PCIVNIRV3TR8TGeW+U
         YGYFgN0AockOWlL+J9i723QtWP2gYlPRKyXLNP2uA9U+t9SWDNHtj75JYdVNbe6BdJCP
         jwRVciVXZS1fKPBqinQNJqEmekfrngllUzzbBHTWwQR6XdTnKdkL00rVekpgrx361chn
         30iQ==
X-Gm-Message-State: AOAM533BMlXgCAgoNsWLho/NE9c/fdECEaMRKiLdxJKMGWpFSebrPgBL
        x0Uq7459Y4ZjY5Xtd1Wsgmi/e4+OMHqROMgGm8r2JTdWZUrMw2AjYiDsUr367hmjn37NPrctc/q
        MPKOgDCpFpJhRAxOqnTiHLy1I9lFA6OlW8rjQTiZV
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr8092431pjb.173.1638975793407;
        Wed, 08 Dec 2021 07:03:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywtfz1ltbCX4prsJ8HbqB9JwqPfaHTvYGKf+nVFZN2jXpJAsM7q+H1iNlV/lsatBP8IZ65BiteYAl2G/zyQQo=
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr8092399pjb.173.1638975793135;
 Wed, 08 Dec 2021 07:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20211201164301.44653-1-tero.kristo@linux.intel.com> <20211201164301.44653-2-tero.kristo@linux.intel.com>
In-Reply-To: <20211201164301.44653-2-tero.kristo@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Dec 2021 16:03:02 +0100
Message-ID: <CAO-hwJLUA8ErS-s3mA351WH48ebXCYJ-s5xj-oVarqAz43DUkg@mail.gmail.com>
Subject: Re: [RFCv3 1/7] HID: Add map_msc() to avoid boilerplate code
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
> Since we are going to have more MSC events too, add map_msc() that can
> be used to fill in necessary fields and avoid boilerplate code.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This one looks good to me and I should be able to take it in v5.17.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-input.c | 6 ++----
>  include/linux/hid.h     | 4 ++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2c72ce4147b1..39ebedb2323b 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -52,6 +52,7 @@ static const struct {
>  #define map_rel(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_REL, (c))
>  #define map_key(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_KEY, (c))
>  #define map_led(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_LED, (c))
> +#define map_msc(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_MSC, (c))
>
>  #define map_abs_clear(c)       hid_map_usage_clear(hidinput, usage, &bit, \
>                 &max, EV_ABS, (c))
> @@ -872,10 +873,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>
>                 case 0x5b: /* TransducerSerialNumber */
>                 case 0x6e: /* TransducerSerialNumber2 */
> -                       usage->type = EV_MSC;
> -                       usage->code = MSC_SERIAL;
> -                       bit = input->mscbit;
> -                       max = MSC_MAX;
> +                       map_msc(MSC_SERIAL);
>                         break;
>
>                 default:  goto unknown;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index e95800bab56a..96eaca0d5322 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -766,6 +766,10 @@ static inline void hid_map_usage(struct hid_input *hidinput,
>                 bmap = input->ledbit;
>                 limit = LED_MAX;
>                 break;
> +       case EV_MSC:
> +               bmap = input->mscbit;
> +               limit = MSC_MAX;
> +               break;
>         }
>
>         if (unlikely(c > limit || !bmap)) {
> --
> 2.25.1
>

