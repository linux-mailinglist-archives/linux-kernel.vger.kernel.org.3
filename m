Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8742538A48
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbiEaDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiEaDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:50:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61192D24
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:50:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1029037pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sq2FUzjdnXuANpbZR+IVbyfs31ZNc8ckL7u/UNxQuao=;
        b=dq9/SXyaEGDWomJVOjaKba4nM6Z7MZlNHLlIpdet6ErkLlW3nPN9hCZlM4VpnIJuw8
         Doe8FmILSs0rmf3Df9lZt7sxInRCO7xqP/+4TI7jFCfsYYoUAGb992F4WqP2dcPvJK9F
         5F+xa8bb1kEc/yKjwgOzcRPJuAGjXFSbEgQchNWuSDvx7BGz9K2vvvKC2ARLjTykQQKA
         j+WI5l6jvH3rO4MWdNDm6hJJJ9o3N4MLYsoV/V3KonX+o7i6xCQ7QZ2moUDsuewFwR9R
         bwDp41c/fwt6H6fwGS1PXsBImjbCGwV712J5LwyU0f9ov2obiFA13zxbTGj+Vv6BeWDa
         Bdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sq2FUzjdnXuANpbZR+IVbyfs31ZNc8ckL7u/UNxQuao=;
        b=wnSWhVA5VDl686gKyEFmMj/onMw1L7uCSh9TmzQNiAWEZ8E4rB0a9ykw4pZMyEZzTN
         X2Jb7li0P1LDrHZyNGFt+TTvKdli0lngrQTyUGxBJCv/x17myQpPVsB94yUvyUs9fk2O
         NsvZMFVnNUfhQTeABCBdZItUiolP8CrqesLUW3UJnpokxv8Utxh47WcG0CvLHzcpcbKu
         ejXdwWJHht50TQmkICmpy2KKqKrqJPShnjCGZhaJKrVOiCC+V/ig0xaqKzjO2tG4H5Zu
         jsKhDJQYnaJn3F+iaAzPudPu7uyjsu7pjiI9AbXVepqiF7V5sYYjamAslfD91oak5/5s
         MZdw==
X-Gm-Message-State: AOAM532Qg9M38N2rGDfjoNqE27nPYgGZI9j9yCV4XmA3LVaPiaXPC+Cl
        eEqHPXUNShrlW36FOie34VheP32IEN0AAMFrMw==
X-Google-Smtp-Source: ABdhPJzCo4nXWZJuphdowXSZQd1NTJB3Jgk53K52U1vyf2bP/wUfKbvaRWsOv4v0BoT1fk4A5EBvcPjNfCv39K8TaKs=
X-Received: by 2002:a17:90a:b88:b0:1df:2b03:20c with SMTP id
 8-20020a17090a0b8800b001df2b03020cmr26343035pjr.46.1653969030095; Mon, 30 May
 2022 20:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220529065839.3817434-1-zheyuma97@gmail.com> <6294DED6.70904@gmail.com>
In-Reply-To: <6294DED6.70904@gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 31 May 2022 11:50:18 +0800
Message-ID: <CAMhUBjng1qc3iL8CeDZ+095xHr+LDy6ay9ojRfTho2ayTsO05w@mail.gmail.com>
Subject: Re: [PATCH v3] char: xillybus: Check endpoint type at probe time
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, May 30, 2022 at 11:13 PM Eli Billauer <eli.billauer@gmail.com> wrote:
>
> On 29/05/22 09:58, Zheyu Ma wrote:
> >   static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
> >   {
> > +     int ret;
> > +     struct usb_endpoint_descriptor *in, *out;
> > +
> > +     ret = usb_find_common_endpoints(xdev->intf->cur_altsetting,&in,&out, NULL, NULL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (in->bEndpointAddress != (IN_EP_NUM | USB_DIR_IN) ||
> > +             out->bEndpointAddress != (MSG_EP_NUM | USB_DIR_OUT))
> > +             return -EINVAL;
> > +
> >
> As far as I understand, this finds the first BULK endpoints in both
> directions, and verifies that their addresses are MSG_EP_NUM and
> IN_EP_NUM. Because both of these happen to equal 1, I suppose this
> indeed checks the right thing. But am I right that this won't work if
> either MSG_EP_NUM or IN_EP_NUM have a value that isn't 1? Not that I
> think that will ever happen, but still.

Indeed, the correctness of this code comes from the fact that both
MSG_EP_NUM and IN_EP_NUM are the first bulk endpoint, without such an
assumption this check does not hold.
I did this just for convenience, we can also use
xillyusb_check_endpoint() to check them.

> > +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 addr)
> > +{
> > +     int i;
> > +     struct usb_host_interface *if_desc = xdev->intf->altsetting;
> > +
> > +     for (i = 0; i<  if_desc->desc.bNumEndpoints; i++) {
> > +             struct usb_endpoint_descriptor *ep =&if_desc->endpoint[i].desc;
> > +
> > +             if (ep->bEndpointAddress == addr&&  usb_endpoint_is_bulk_out(ep))
> > +                     return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >
> >
> Given that you've added this function, why isn't it used in
> xillyusb_setup_base_eps()?

It is feasible to use this function for checking in
xillyusb_setup_base_eps(), perhaps with some modifications. Anyway, I
will do so in the next version of the patch.

Thanks,
Zheyu Ma
