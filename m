Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D633449CE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiAZPdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiAZPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:33:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:33:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l5so52341944edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LpTLyJliuJxLgvINcGGHTCssFGhu4/tQZLGf4U7OIY=;
        b=BotwPb2J1pDMG00td4zlmVziK8SurJLBoDP9KCc2/h75hLOacZO5PoEKTPbilUMSmL
         EZo4B8StUCOfOrx2cOccCZ/aenv0GEAjVA6CfSPY4OPK4yMG4WSveKHKi4T+owCUgjeA
         9RbKdsp+oYh+e8z8nBsBTQlp76OEwpTlPvfbF21msZNcxNzG8DEwavhlIINEk3Qm3CxC
         H40XcVao5UtXv28Iwvw2NTlQ5jkrR7UOqz1Ym2bCbxywPiZrFVvlDwr7u33Pp6KutwP7
         8q1J5Ur4v5GTefeJjTezDHYG4uqFw4siH+jWmlZPT67mHi6sEOOufoNIzLzI/YRucR8+
         6kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LpTLyJliuJxLgvINcGGHTCssFGhu4/tQZLGf4U7OIY=;
        b=WF0sURW1/j+X/4YhpsHlmXxhKvXqKz0F05AR6Nj+4Ul+SKu7WerRpCtbeWZt1iG13T
         rn9X3Zm85xolhJdFtJ3mpg7nyRgguDxN45kQz4ixeCkIFpjOfGo63UtvTGodnHE7u/CL
         JlQhpdOBsLnJoUfN4n0eY/nLrpQc6GDwJVFsvYWRaUYbbngO/qigWsuE/6aRTLtZ3BGp
         4RH5rUPUyAbc/evW1nglUMpXCmMraFNdieXyyF3kcpXMc/fqXwAU0ibNFmTSgMwPIpUP
         qcakTAdG2qh+H8d5tvXMxdG6oLz4mWDPhzzN0JsOx/6bkau/1pZabSUf4TIDrHV01HRa
         ymEA==
X-Gm-Message-State: AOAM530o/fthz7Z3c6qrEzNQYNXG1rOLl7QdAfOh+i16T7bD4Dsj+P/j
        USUc+lWcx7v4xQ/tXNvUBM+unVKf1tvRPeM3mQW9pQ==
X-Google-Smtp-Source: ABdhPJyAtGLzI4bJ46dyj8zSkOfANb/MxA9wx82BBd5Hv8lxryFlBg5LoNbHaFnAiyXng97hpyIiezDab6867WeDZgc=
X-Received: by 2002:a50:cc03:: with SMTP id m3mr25234890edi.356.1643211230186;
 Wed, 26 Jan 2022 07:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20220126012203.2979709-1-pmalani@chromium.org>
 <YfDEHoYkLc6zjSxj@google.com> <CACeCKafqQmb7jjzweaRq2ETBbPk_2HE8FbFLMdfcCD8PrdckoQ@mail.gmail.com>
In-Reply-To: <CACeCKafqQmb7jjzweaRq2ETBbPk_2HE8FbFLMdfcCD8PrdckoQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 26 Jan 2022 07:33:38 -0800
Message-ID: <CABXOdTemE9TOhOXy27beoEvj_6eTcwUj_A6=DMhEmMgCsqXRnQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC device
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alyssa Ross <hi@alyssa.is>, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 8:05 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Tzung-Bi,
>
> Thanks for your review.
>
> On Tue, Jan 25, 2022 at 7:46 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Wed, Jan 26, 2022 at 01:22:03AM +0000, Prashant Malani wrote:
> > > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> > > Reported-by: Alyssa Ross <hi@alyssa.is>
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >
> > With a minor comment,
> > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> >
> > > @@ -1076,6 +1076,12 @@ static int cros_typec_probe(struct platform_device *pdev)
> > >
> > >       typec->dev = dev;
> > >       typec->ec = dev_get_drvdata(pdev->dev.parent);
> > > +
> >
> > I would prefer to remove the blank line to make it look like an integrated block.
>
> I actually prefer it as it is. typec->dev is not really part of this
> "integrated block", and I don't want to add another space there.

But on the other side the check is part of the "integrated block".
Maybe add an empty line between the two assignments if you want a
separation.

> In any case, since this is a very minor style nit, I will address it
> in case there is another version required due to other comments.
>
> >
> > > +     if (!typec->ec) {
> > > +             dev_err(dev, "couldn't find parent EC device\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
>
> Best,
>
> -Prashant
