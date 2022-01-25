Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0E49AC21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiAYGGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbiAYGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:01:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF525C0C537F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:17:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y27so14048682pfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4bYxTK4CI5NQXpadWMVdmVIRSBqI/OmdC+Kql5VSL7w=;
        b=O4Pvk+PACasjJ/fKSW9Edb8jDXppN9gEi4WADl6EY1ekHMkwcTbzWIPFp9Y8Sq9iYd
         33YFgEkCPkQWHk1QuwAKol2JTbTIoroRs1JveUDeYSaXgrdmQ3f5RDDUPMV/j/uKo0b7
         cwHsktuFtBxwb1kuFdULOYzrSAzaEC8EGB/iJ1p9l+UN9sgiMLnVvl9HLwJcdAbO7Gqc
         +EPsFR3m/UiE9YCch6CD/XYGb2t6iY6rZk31AkIOgW2i5SNfLURoBqh4Z7nG3pvCfXIJ
         jv1XsRekl9wkfk/owm9IMrgsB+2FH1ijPUZDFj9utjNQXgBSlCGMNvjWKPM7XIEyt76S
         CFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4bYxTK4CI5NQXpadWMVdmVIRSBqI/OmdC+Kql5VSL7w=;
        b=l31Jzv+8ArqeaJmK27tvik5K3i7Q0UcMugpUOr67lO4dps8UCme3xWo7FZlvXAKi3h
         XXcCxhwrXyo7TV+WOvr+Ke4WQKj1zMnygMJr4ow3x5eFBmNfokbUxkso9NbrmB1JWvnT
         49zhZcS8L1L+upEwj+G7SBCg9R2AsFUfTZZY8Kf9rvcB3/UAqEDvgg9yf1aV5cUgr0XR
         4AJG1GAXnYjeikPivtwrtMBzBvrRZZLNnfe4IzVlrK1O4/5Wm7JdLzIYHExywfbhaK2Z
         DqSpZgfDhHFLdRYwoKbmeX+ee/pSrnPY0g4WW8KZd2wv4RT6gMnvppI2LRJ36doEOJFV
         SvGw==
X-Gm-Message-State: AOAM530ZpJGqHq5Xr4amUnLCGqbgh8C2BjI3u5fGJz8LurV0tVwaHjDo
        Nb5CwUUBB/1McmuygnDhkqPeMg==
X-Google-Smtp-Source: ABdhPJy7bWTymfwgkDxr9M9Jbam8n9CcObzpLpQO3ICnfsVJeGdaMOhyr9NduX7XdQWH3aT5SBl1Sg==
X-Received: by 2002:a05:6a00:180e:b0:4c8:f0b8:2382 with SMTP id y14-20020a056a00180e00b004c8f0b82382mr8587146pfa.59.1643084224105;
        Mon, 24 Jan 2022 20:17:04 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5978:14f2:157f:f050])
        by smtp.gmail.com with ESMTPSA id y15sm6039953pfi.87.2022.01.24.20.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 20:17:03 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:17:01 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     "Dustin L. Howett" <dustin@howett.net>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: reserve only the I/O ports required
 for the MEC EC
Message-ID: <Ye95vRREnbaLM+EJ@google.com>
References: <20220105031242.287751-1-dustin@howett.net>
 <20220105031242.287751-3-dustin@howett.net>
 <CALtnz63d7utST13=S7UbExDzSE0GnoFA7JowQkkFSqrSUTmCdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtnz63d7utST13=S7UbExDzSE0GnoFA7JowQkkFSqrSUTmCdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:42:29AM +0800, Tzung-Bi Shih wrote:
> On Tue, Jan 25, 2022 at 9:35 AM Dustin L. Howett <dustin@howett.net> wrote:
> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > index 458eb59db2ff..06fdfe365710 100644
> > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > @@ -341,9 +341,14 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> >         u8 buf[2];
> >         int irq, ret;
> >
> > -       if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> > -                                dev_name(dev))) {
> > -               dev_err(dev, "couldn't reserve memmap region\n");
> > +       /*
> > +        * The Framework Laptop (and possibly other non-ChromeOS devices)
> > +        * only exposes the eight I/O ports that are required for the Microchip EC.
> > +        * Requesting a larger reservation will fail.
> > +        */
> > +       if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> > +                                EC_HOST_CMD_MEC_REGION_SIZE, dev_name(dev))) {
> > +               dev_err(dev, "couldn't reserve MEC region\n");
> >                 return -EBUSY;

The original code:
- devm_request_region(dev, EC_LPC_ADDR_MEMMAP, ...) and then
- cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).

After the patch:
- devm_request_region(dev, EC_HOST_CMD_REGION0, ...) and then
- cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).

Does it work if it reads out of request_region range?

> > @@ -366,17 +377,19 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> >                         dev_err(dev, "EC ID not detected\n");
> >                         return -ENODEV;
> >                 }
> > -       }
> >
> > -       if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> > -                                EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > -               dev_err(dev, "couldn't reserve region0\n");
> > -               return -EBUSY;
> > -       }
> > -       if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> > -                                EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > -               dev_err(dev, "couldn't reserve region1\n");
> > -               return -EBUSY;
> > +               /* Reserve the remaining I/O ports required by the non-MEC protocol. */
> > +               if (!devm_request_region(dev, EC_HOST_CMD_REGION0 + EC_HOST_CMD_MEC_REGION_SIZE,
> > +                                        EC_HOST_CMD_REGION_SIZE - EC_HOST_CMD_MEC_REGION_SIZE,
> > +                                        dev_name(dev))) {
> > +                       dev_err(dev, "couldn't reserve remainder of region0\n");
> > +                       return -EBUSY;
> > +               }
> > +               if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> > +                                        EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > +                       dev_err(dev, "couldn't reserve region1\n");
> > +                       return -EBUSY;
> > +               }

The 2 request_region are now guarded by the first "if (buf[0] != 'E' || buf[1] != 'C')".  That is, only non-MEC will request the 2 regions.

Doesn't other MECs (e.g. non-Framework Laptop) need the 2 regions?
