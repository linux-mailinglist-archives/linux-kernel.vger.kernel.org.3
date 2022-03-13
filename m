Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1C4D75F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiCMOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiCMOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:53:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDD888E9;
        Sun, 13 Mar 2022 07:52:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b16so15484650ioz.3;
        Sun, 13 Mar 2022 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/XezRwvh2gzL6Ttf5VHhgwtutiLUu4G+QBeYqkcdxc=;
        b=JlswR+2w6s45M6iLlDIZMJkpJdKO1GUMNUv2bF5jmu+WIK6sGHxzY8408fzrsdZMCr
         gNyxbdC4rA/9nhGriZeyQFWJT4gL8H2tLm8EHhLuXbfCVMT9YbCDzp+cU/MbGXSd3HkX
         lO3iX4hAVSmpCejNwl8qkyoLTGvkItlx0bUkyToXQcclkqebDr0MpMjgH8jBXaNgc3vM
         NgmbaoaGrJnqcHsvvlBNp/lNPK0HeOM32TyFFIQgMMU7yjo1p7gxbwep7M7RgLfvxd7v
         cqC4HgyK5VNf9MzPWXtrMx7x1dOE/PAoyNfKndC4e5HxBUlxtRQ0kx+3+I2AkFQJRus6
         dtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/XezRwvh2gzL6Ttf5VHhgwtutiLUu4G+QBeYqkcdxc=;
        b=8Qgkuk0v71tf0imNlIvsfOvcF8EFdR1IZgoNLrO7huxCSi96nSJLjYBh9fzCsRUyFR
         wAF5X7t7rEgHTHG3COE0pQfByHu4keU2yuX7RQ+HXdfLi6XK0wT6Yy2eDA+a6Nz7po6I
         MQ9HWELVUwim3BNUJFjYav/EbB/hBdD8vIsyWVnUH23ib6YxCFLvizeLJbmXz2G7axTf
         8/1tV3ZlqzjsIXgrKcHetIhYcQMNFVwnpkbdUy3zN05LY1lDzdansMRjmYmUrY/1oKtj
         G9I941eLglMMI7fFkrsyH284D2mmR5mzhj6jarJbf8048Q0K2e31IWQw3wl5RpArZxPW
         isNA==
X-Gm-Message-State: AOAM533oRskQPTRDehB8pbu83/KDXeHdMKopYz64XFdVRDQbE0hAR4EU
        oc2ZKK/N/4nP1f+6ExTXgsZ180gHbNFwjdyITvFcolpn
X-Google-Smtp-Source: ABdhPJw7YFcidFnVOL/eCTnU0sWP31A2Zyx0IitwSpYV1dPANnItK2s6TayRSMvVa4aPhLMb8ER31D2QQ7Oc8kGww8Q=
X-Received: by 2002:a05:6638:a2f:b0:314:b8b9:1c21 with SMTP id
 15-20020a0566380a2f00b00314b8b91c21mr16766450jao.22.1647183165672; Sun, 13
 Mar 2022 07:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
 <20220311082944.4881-1-jj251510319013@gmail.com>
In-Reply-To: <20220311082944.4881-1-jj251510319013@gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 13 Mar 2022 15:52:35 +0100
Message-ID: <CA+fCnZeXMKXBzJm=akMNm4OVN53T_1aQw4n+yYZ6Vkqmj8+KAQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: raw-gadget: return -EINVAL if no proper ep
 address available
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Ming Chen <jj251510319013@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 9:30 AM Wei Ming Chen <jj251510319013@gmail.com> wrote:
>
> If we try to use raw_ioctl_ep_enable() for ep5in on a hardware that
> only support from ep1-ep4 for both in and out direction, it will return
> -EBUSY originally.
>
> I think it will be more intuitive if we return -EINVAL, because -EBUSY
> sounds like ep5in is not available now, but might be available in the
> future.
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>
> Changes in v2:
> - Rename variable from ep_num_matched to ep_props_matched
> - Incorporate the patch from Andrey Konovalov that cover
>   the foloowing cases:
>     1. If there are no endpoints that match the provided descriptor, return
>        EINVAL.
>     2. If there are matching endpoints, but they are all already enabled,
>        return EBUSY.
>
>  drivers/usb/gadget/legacy/raw_gadget.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index d86c3a36441e..e5707626c4d4 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>         unsigned long flags;
>         struct usb_endpoint_descriptor *desc;
>         struct raw_ep *ep;
> +       bool ep_props_matched = false;
>
>         desc = memdup_user((void __user *)value, sizeof(*desc));
>         if (IS_ERR(desc))
> @@ -787,13 +788,14 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>
>         for (i = 0; i < dev->eps_num; i++) {
>                 ep = &dev->eps[i];
> -               if (ep->state != STATE_EP_DISABLED)
> -                       continue;
>                 if (ep->addr != usb_endpoint_num(desc) &&
>                                 ep->addr != USB_RAW_EP_ADDR_ANY)
>                         continue;
>                 if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
>                         continue;
> +               ep_props_matched = true;
> +               if (ep->state != STATE_EP_DISABLED)
> +                       continue;
>                 ep->ep->desc = desc;
>                 ret = usb_ep_enable(ep->ep);
>                 if (ret < 0) {
> @@ -815,8 +817,13 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>                 goto out_unlock;
>         }
>
> -       dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
> -       ret = -EBUSY;
> +       if (!ep_props_matched) {
> +               dev_dbg(&dev->gadget->dev, "fail, bad endpoint descriptor\n");
> +               ret = -EINVAL;
> +       } else {
> +               dev_dbg(&dev->gadget->dev, "fail, no endpoints available\n");
> +               ret = -EBUSY;
> +       }
>
>  out_free:
>         kfree(desc);
> --
> 2.25.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Greg, could you consider picking this up?

Thanks!
