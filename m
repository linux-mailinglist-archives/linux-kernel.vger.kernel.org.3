Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D349C272
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiAZEFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiAZEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:05:48 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C1C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:05:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 23so67676507ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p/L0DuUuVHknH8fGhtQHEJub+4n9C+9W04Ffm4OFeY=;
        b=WXJ9d82Gn42UZlHVH9evCW6lxaIkMgv6rfjDv2QVSKXoLkfCEWDV8Za8GVLdA5nD//
         tDI43EFhICjvwPM9Ck9XbnOe4rGAXb/RJ1jJVyKotBAznxc0YkhwiB6Wr9PkekeCEhlV
         cVKM+yncek19fCUPqHiu8VysIm3J1J46N1+vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p/L0DuUuVHknH8fGhtQHEJub+4n9C+9W04Ffm4OFeY=;
        b=7Cipk43gY69md5rpj56rGV4kCWpKCmsqE1TWP/gdrbpoYNIl1rFHa7/bSYGQmHqatc
         XGlfI/cmamZth43jfhDilRRkfHXtwstwUpJTvqfjyXV2iJVCZYsaY43Of7/g/wt4f5oQ
         o4ix4WOCooD0TrGJOwaSAaRCSlku7PTnzvbbRb6xzg39LgiCs2tyLij2ByyUVpbMxh7S
         eKpD9R6s/so8maYGfQe0agZrkvEz2M3ldRzDXw+2eZ+7wj5pucQtUQ7wXKP7N/g9kwc7
         XyJI7fQVXN+Fsym5sPqs0cfoRRqTFxGNYD6iZgyVHEOPfbyCvLkrhswrOjm7okzcWNcK
         IN7A==
X-Gm-Message-State: AOAM5320bWbXbx4LOpR4aPpGxChx8myBz2iz3WnkML8ZxFh4d65IcV/I
        IlXm7g/6Pnd21ygtRsoX/Ldx+44GaSnKFJQqAcRUNA==
X-Google-Smtp-Source: ABdhPJzkwL+15+kP9VV/u2MQM4VhezwDP2zw50P3YCt8RtHzZMchgScUL7NhFnFkT3iDxbpBTpc/EXkLHBNBOlyPK7E=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr22285946ybt.656.1643169947334;
 Tue, 25 Jan 2022 20:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20220126012203.2979709-1-pmalani@chromium.org> <YfDEHoYkLc6zjSxj@google.com>
In-Reply-To: <YfDEHoYkLc6zjSxj@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 25 Jan 2022 20:05:36 -0800
Message-ID: <CACeCKafqQmb7jjzweaRq2ETBbPk_2HE8FbFLMdfcCD8PrdckoQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC device
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for your review.

On Tue, Jan 25, 2022 at 7:46 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Wed, Jan 26, 2022 at 01:22:03AM +0000, Prashant Malani wrote:
> > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> > Reported-by: Alyssa Ross <hi@alyssa.is>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> With a minor comment,
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
>
> > @@ -1076,6 +1076,12 @@ static int cros_typec_probe(struct platform_device *pdev)
> >
> >       typec->dev = dev;
> >       typec->ec = dev_get_drvdata(pdev->dev.parent);
> > +
>
> I would prefer to remove the blank line to make it look like an integrated block.

I actually prefer it as it is. typec->dev is not really part of this
"integrated block", and I don't want to add another space there.
In any case, since this is a very minor style nit, I will address it
in case there is another version required due to other comments.

>
> > +     if (!typec->ec) {
> > +             dev_err(dev, "couldn't find parent EC device\n");
> > +             return -ENODEV;
> > +     }
> > +

Best,

-Prashant
