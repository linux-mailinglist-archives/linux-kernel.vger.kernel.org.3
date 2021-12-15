Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B61475C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbhLOPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244242AbhLOPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:55:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C340C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:55:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so77392534edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlGjvd3bAZBF07RocacyyaGPkf9pqsh2yay6ppOULlA=;
        b=maiJbF+Hqds74IzLHNCykuX8HDfI2d1jLprH+MjLSPARk+vOIlX4WH5yRmc9D/LCRe
         9gsp5u1IRVGlWvH4qoPZhOl52T8LkMKiaW9RqBoYT+7Ge4hwvkb2Uw1FiaeRiMIyFMFl
         S0mfKItpD/wCOHRgwoaTYjp5SgHknM8HkeIFf4E6xEm6BzvGa7dkM92mtRL1NCbRvm+0
         +LfpDsnxKTDMrYBjWuLYYkhoLqqTLXAZE7hLTULDnp9DxTaROFZKZo0Ax5eV8pyJEOOn
         UKh/XS89pLZqZTeRxH8fV3VHBsJq1gLpWshork8dXmTTF44o46LFwleLehMWZOvDap6D
         cwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlGjvd3bAZBF07RocacyyaGPkf9pqsh2yay6ppOULlA=;
        b=KOFygVW0uxVB4f821PEYHEulSe7u3yL+WrBDKKW17htkJf0xs9tPY5nHB19FBGhEM8
         ZXEiHiAHAIeeTz9K1PBnAp4EwN77pP3UlVSkYqPwc2Fmac2TVZvPDReEmO7AO6StxJO5
         PooUeVtRwdHqBvYanlGs554KXFFq5hpIcSFbENy7+khfZYc//Xw8wgTmxj6vwEIEE9if
         G2MwRAngqToCEzX5KUaENjwW94eoXO4zgDRAiFNKyLfDWWSViSSo8XsQOf+dNs/iHDbc
         B5CBvQAGDpBZOU5doOtRcHsll7kjy5W5s7Y9W7FLJP/iD2msY5uQ1YJh6KBoJnJ8Bm5d
         MrAw==
X-Gm-Message-State: AOAM533dnF4FdvO1HUmOSqfpo1bsn61uP/Jl3NUSF4nM2pvLvOcIPiVT
        7R9ieN7tfqo/2gn7bt/CStJm1KJtKe7hktOmNKPvJA==
X-Google-Smtp-Source: ABdhPJxxvg2aqv3lFdj27qWiSJGlucd2t7lfYMVkXwhqM1JkRDQEP2QnJAuuekr7/BlbGJRQaKOtpZosmr1p0v7bif4=
X-Received: by 2002:a17:907:9707:: with SMTP id jg7mr11340752ejc.533.1639583734953;
 Wed, 15 Dec 2021 07:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20211209143501.GA3041@kili> <CABXOdTcny657JOxK-iau2Sj06a5hcDOdWFg8wKUNupgAceUU9w@mail.gmail.com>
 <20211215081935.GY1978@kadam>
In-Reply-To: <20211215081935.GY1978@kadam>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Dec 2021 07:55:23 -0800
Message-ID: <CABXOdTceL3RBfzWTZ1SadGLvnRq7P7VdC_jTM5eVRqn3y3vWnQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: fix read overflow in cros_ec_lpc_readmem()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Dec 14, 2021 at 03:02:41PM -0800, Guenter Roeck wrote:
> >  On Thu, Dec 9, 2021 at 6:35 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > If bytes is larger than EC_MEMMAP_SIZE (255) then "EC_MEMMAP_SIZE -
> > > bytes" is a very high unsigned value and basically offset is
> > > accepted.  The second problem is that it uses >= instead of > so this
> > > means that we are not able to read the very last byte.
> > >
> > > Fixes: ec2f33ab582b ("platform/chrome: Add cros_ec_lpc driver for x86 devices")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/platform/chrome/cros_ec_lpc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > > index d6306d2a096f..7e1d175def9f 100644
> > > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > > @@ -290,7 +290,8 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
> > >         char *s = dest;
> > >         int cnt = 0;
> > >
> > > -       if (offset >= EC_MEMMAP_SIZE - bytes)
> > > +       if (offset > EC_MEMMAP_SIZE ||
> > > +           bytes > EC_MEMMAP_SIZE - offset)
> >
> > I think that means we have the same problem if offset >
> > EC_MEMMAP_SIZE, only now that condition isn't detected anymore because
> > EC_MEMMAP_SIZE - offset is a very large number.
>
> That's the bug which my patch addresses.  (My patch is option 1).
>

Ah yes, for some reason I overlooked the "offset > EC_MEMMAP_SIZE"
part in your patch. Sorry, I must have been blind.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

Guenter

> > I think what we really want is
> >         if (offset + bytes > EC_MEMMAP_SIZE)
> > only without the overflow. Not sure how we can get there without
> > checking each part.
> >         if (offset > EC_MEMMAP_SIZE || bytes > EC_MEMMAP_SIZE || bytes
> > + offset > EC_MEMMAP_SIZE)
>
> That is another solution which works.
>
> >                 return -EINVAL;
> > Maybe that ?
> >         if ((u64) offset + bytes > EC_MEMMAP_SIZE)
> >                 return -EINVAL;
>
> A third viable solution.
>
> I generally prefer option 2 to option 3.  I generally use that in code
> that I'm writing.  There was one time Linus said he liked option 1
> which I used here because it works regardless of the types or the valu
> of EC_MEMMAP_SIZE.  This code already used the bytes > size - offset
> idiom so I kept it as similar as possible.
>
> regards,
> dan carpenter
>
