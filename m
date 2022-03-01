Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C564C8932
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiCAKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiCAKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6812059383
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646130258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n4x9XMBl4+PDcJH0WYTd/mxQmBLZ1Jz9DQ+RKwvFd+c=;
        b=BMW/QILmLIuwhGUZKwVSXnpKLlfomUtw6ErGaF4T2dUvVy6RYT5ewaUKOWoibkKCkH8q63
        i9psGDb8ribAYoPjo3xaMtzSbNH58mg+a5YVQpLY+TuZ/i9ao8b+R1ZzyLvumJ4xlIS93D
        dRqJpTxqhfgR5qEv52z4ckprVXuJd+E=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-_LpRQ2gPOR2lz2ZEqGYgvQ-1; Tue, 01 Mar 2022 05:24:17 -0500
X-MC-Unique: _LpRQ2gPOR2lz2ZEqGYgvQ-1
Received: by mail-pf1-f198.google.com with SMTP id h128-20020a625386000000b004f10a219a98so9557062pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4x9XMBl4+PDcJH0WYTd/mxQmBLZ1Jz9DQ+RKwvFd+c=;
        b=ia0bFldGkBWZrKiGNiqdlDZdv9s1GQ9v6GsDOA5hT7cqNl0afa0nEM/01nIJz4Hoha
         Vxo6yDGdsV0t2fRYWzL6pBgaHdPcIGZSBezLsRWS2sHb+aS3r5Djc79HVciaOG6H73On
         2Nh5WyR07v9yxeKMIXJIgGU1Y8m3r/AuKCeKpFe/H9OgsNVrO1B5cq6+ZBuGGpSkxsPs
         BljvgXj+aeCyncJpxscl6mo2dCqIyVIcDV+AYeGRiodJHSK6NCZM6vRyoUXeFsiN25TS
         9BfN8NIHpnkC8QXrLyyya9Sf9y44mD2DeQh3HJjZd7VJGursLQe1pCXbWIeog1aIodKn
         LP+g==
X-Gm-Message-State: AOAM533UeecwVQQZfkDq+ttWYz5CNYSYnfqMeLq0tll8QxsiNnvl0Clh
        Wlk5bhOHVemVLfCODKVYlOiPJA8BhWQ3GlLPPcFU/SOqG0rdHsCVB82wvI2+9N4DHEnDUq1d47q
        50Mr4AstLdM69I3f1dj/My1PZt9XoEZpHs51wmytF
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id g2-20020a17090adac200b001bdfecf6bd1mr5438293pjx.113.1646130255904;
        Tue, 01 Mar 2022 02:24:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRiyUvQuNCG0CWeOIgtG4PltzTvJEIrudhTzB+/LMvoxrlGu5P89HlGkwPMXIg4WNmID92uFtp/3ZRNtEFwW0=
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id
 g2-20020a17090adac200b001bdfecf6bd1mr5438260pjx.113.1646130255539; Tue, 01
 Mar 2022 02:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
 <Yh3LC8WtLdgQNyQI@google.com>
In-Reply-To: <Yh3LC8WtLdgQNyQI@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 1 Mar 2022 11:24:04 +0100
Message-ID: <CAO-hwJL2vn7-CzHAE_0S7_04oPjyfopKTD=5srwPQY0nXTxusQ@mail.gmail.com>
Subject: Re: [PATCH v3] HID: Add mapping for KEY_DICTATE
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     William Mahon <wmahon@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 8:28 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Feb 18, 2022 at 09:59:08PM +0000, William Mahon wrote:
> > Numerous keyboards are adding dictate keys which allows for text
> > messages to be dictated by a microphone.
> >
> > This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
> > usage code to this new keycode. Additionally hid-debug is adjusted to
> > recognize this new usage code as well.
>
> Jiri, Benjamin, OK for me to pick it up?

If you are happy with the mapping:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(and yes, please take it through your tree, same for the other one).

Cheers,
Benjamin

>
> >
> > Signed-off-by: William Mahon <wmahon@google.com>
> > ---
> >
> >  drivers/hid/hid-debug.c                | 1 +
> >  drivers/hid/hid-input.c                | 1 +
> >  include/uapi/linux/input-event-codes.h | 1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> > index 26c31d759914..8aa68416b1d7 100644
> > --- a/drivers/hid/hid-debug.c
> > +++ b/drivers/hid/hid-debug.c
> > @@ -969,6 +969,7 @@ static const char *keys[KEY_MAX + 1] = {
> >       [KEY_ASSISTANT] = "Assistant",
> >       [KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
> >       [KEY_EMOJI_PICKER] = "EmojiPicker",
> > +     [KEY_DICTATE] = "Dictate",
> >       [KEY_BRIGHTNESS_MIN] = "BrightnessMin",
> >       [KEY_BRIGHTNESS_MAX] = "BrightnessMax",
> >       [KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 112901d2d8d2..ce2b75a67cb8 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -992,6 +992,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
> >               case 0x0cd: map_key_clear(KEY_PLAYPAUSE);       break;
> >               case 0x0cf: map_key_clear(KEY_VOICECOMMAND);    break;
> >
> > +             case 0x0d8: map_key_clear(KEY_DICTATE);         break;
> >               case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);    break;
> >
> >               case 0x0e0: map_abs_clear(ABS_VOLUME);          break;
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index 225ec87d4f22..4db5d41848e4 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -612,6 +612,7 @@
> >  #define KEY_ASSISTANT                0x247   /* AL Context-aware desktop assistant */
> >  #define KEY_KBD_LAYOUT_NEXT  0x248   /* AC Next Keyboard Layout Select */
> >  #define KEY_EMOJI_PICKER     0x249   /* Show/hide emoji picker (HUTRR101) */
> > +#define KEY_DICTATE          0x24a   /* Start or Stop Voice Dictation Session (HUTRR99) */
> >
> >  #define KEY_BRIGHTNESS_MIN           0x250   /* Set Brightness to Minimum */
> >  #define KEY_BRIGHTNESS_MAX           0x251   /* Set Brightness to Maximum */
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
>
> --
> Dmitry
>

