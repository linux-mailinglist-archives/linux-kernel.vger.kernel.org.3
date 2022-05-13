Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224F5262FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380696AbiEMNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346448AbiEMNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:25:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC5C9EC4;
        Fri, 13 May 2022 06:25:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d22so7920206plr.9;
        Fri, 13 May 2022 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2Uq3anO9XsQ/izX2BhZt6ctVSGq//1grHAsTj5b3w0=;
        b=GQhMzNiBhd6HkxmvVKKiAYtBGSqks4sziBmI/N6TTtOwxKE1oYKX6hmOGQrswXBmOC
         Mwvy3HLOp1fl+gtgR4zP/QKxKXcwzHw3kfT/FLHb4gDPd+7n0gQtgGsRbP9pjDPVe9uI
         IWnsHIX2WyDZfl8ysop9xkBHih3GEJVqlzO2UMnZOkARlyFrW/wQ6UnDesD0ff/QVeVp
         /djBbBf9A5FYjmXPl5JeaLeGD6O1hQQmRfZ/pF0HkanD6a4ydjfTSn0V2h2/B0XPBI9n
         +VeWS3i/m+geDIjUgH2Kji5wImr8mfmpVMWyEKB52ZztadHOOUmWMtwJLFRp6URpQ+Ug
         obDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2Uq3anO9XsQ/izX2BhZt6ctVSGq//1grHAsTj5b3w0=;
        b=zITT56hSS1CKkR6INSX/u/pttxJdd6d1Kh7pDWjNYi4YiS4HFfP3hn0lUx8tK4ZGYu
         Db87SsaRTk0Ede2jylspcyyaTAEamddnc6S+Qri/PBy0ApS5F3CCSNhEiyjpOe9jqKk4
         nzEvrh4EVIUunyJvYU3HA77m6XFM3YKGRMDlP/bI5DYA9sL8BWkU9DZjeUm/4vjmQsLE
         Ht+7ZY+8GMA9rosL/Qym7kaWtNYY36jb0BfvCnenIWRdz4VDFWrgKRH8uPTylui8BmKk
         JLuIFUNDzGlkZzGPk9VWb7R1DVK38y90nV7mIgKGuXkinnJ0fWUT88qU/yAJxspvwqEF
         HnUw==
X-Gm-Message-State: AOAM530stHG6u94gA2f+nymVhhFBgomD3nS8ZP4zMQr124e/W54pHbKf
        oRGJfuY87RzsMlHgs5x0rnEjg6Hav3NFN3H0nQ==
X-Google-Smtp-Source: ABdhPJzlPJMtmgNFFRsuCblpOfj4Uc8gFbbJSUP+a66fiJ9tu2Ns/kxPMQZVKTRmRB5P0RXrYb1bDL4IHDJvenJNoYs=
X-Received: by 2002:a17:90a:db45:b0:1d9:29d0:4c6e with SMTP id
 u5-20020a17090adb4500b001d929d04c6emr4965915pjx.46.1652448319067; Fri, 13 May
 2022 06:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220513124303.2192981-1-zheyuma97@gmail.com> <E8995590-F2D5-4E8E-80EF-874AFFB72784@holtmann.org>
In-Reply-To: <E8995590-F2D5-4E8E-80EF-874AFFB72784@holtmann.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 13 May 2022 21:25:08 +0800
Message-ID: <CAMhUBjm_XrOg=EGTZoAe=BprtffAFu+qB2r4Zi_6V_e4Kns+SA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: bfusb: Check the endpoint type at probe
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 8:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Zheyu,
>
> > The driver reported an warning in usb_submit_urb() which is caused by
> > wrong endpoint type.
> >
> > [    3.295630] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> > [    3.295916] WARNING: CPU: 0 PID: 33 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> > [    3.298155] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> > [    3.302451] Call Trace:
> > [    3.302580]  <TASK>
> > [    3.302698]  bfusb_rx_submit+0x24e/0x390 [bfusb]
> > [    3.302938]  bfusb_open+0x50/0x90 [bfusb]
> >
> > Fix this by checking the endpoint type at first.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> > drivers/bluetooth/bfusb.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> > index cab93935cc7f..447b6876c552 100644
> > --- a/drivers/bluetooth/bfusb.c
> > +++ b/drivers/bluetooth/bfusb.c
> > @@ -613,7 +613,9 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
> >       bulk_out_ep = &intf->cur_altsetting->endpoint[0];
> >       bulk_in_ep  = &intf->cur_altsetting->endpoint[1];
> >
> > -     if (!bulk_out_ep || !bulk_in_ep) {
> > +     if (!bulk_out_ep || !bulk_in_ep ||
> > +             !usb_endpoint_is_bulk_out(&bulk_out_ep->desc) ||
> > +             !usb_endpoint_is_bulk_in(&bulk_in_ep->desc)) {
> >               BT_ERR("Bulk endpoints not found");
> >               goto done;
> >       }
>
> how are you getting this. This driver only works on one specific piece of hardware.

Actually, I used a virtual device to test the driver, and got the above warning.
The USB device may be programmable and malicious, so the driver should
carefully treat the input that the device provided.

Regards,
Zheyu Ma
