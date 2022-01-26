Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD02649D21C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiAZS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiAZS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:57:09 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:57:08 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id k31so1623226ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI//2/YDsPncsQcF4ZJwL9Ncxnx2PuFuGkTk1XFTyY0=;
        b=eUZJwqDtEMS1SLfHgHDSdSdDGh69drRy6edRXHgj2IOZ4O1pDGzkqSOVguZ0BhB4P+
         dIDljXOtCGovo1gyJQWSOyWCX1rpIA08j5uGUpsfvl5/WPctfj7gjgZJ+0NtsH+5G+Qr
         rDdb7goZkYAGupvxymqh01F/+O2qOslpAltXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI//2/YDsPncsQcF4ZJwL9Ncxnx2PuFuGkTk1XFTyY0=;
        b=cZhFqHomsPcjVv09bAkG5awCJZMET7WMIz8nJmoEb46CgzI8fv0cg98ygqajAY2MiF
         GaEsFP7rAV/Dn6iTGqVnmiBtJODNF8Bui6iAgURw3d480DNqekelFy9/vnXw+KPYVJ8I
         d6bY4edR1xFLeRAnlHcWg95zGSll5tWk9ACLx/8PL1QSOTdM2BlHhzBvRJ/CLnoc7Gwx
         /j/z+jDsxKOHomo2FPaSx4LVsD3Dg8CuEG0V/J6JczZvewzFHkxt6hLJEFCdW2S6AKds
         XI1B0EJIqacjkfINTaHh069WbvvgvYPHHrIUJ1lW7EFpQ5xhLRa49WSWuFdSwAxBkzAG
         Dvmw==
X-Gm-Message-State: AOAM533EPhuGqdZyQVHKDFat8Ku8q+0vN3iMGb4wbRXx8RCJ+RBaOFR0
        DGJAc2t/AjNdQpnRWc8a7jGkRUfNFVoXLWdg1tJVIA==
X-Google-Smtp-Source: ABdhPJxGfFNM0avof/HDQxdJacpsdRmpZGczH4ph3KfkeAMBRioe+XmK0oN7AT9BQqo0Ch69Kbpw0vsdl2THfhJPedM=
X-Received: by 2002:a25:24d:: with SMTP id 74mr369914ybc.449.1643223427987;
 Wed, 26 Jan 2022 10:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20220126012203.2979709-1-pmalani@chromium.org>
 <YfDEHoYkLc6zjSxj@google.com> <CACeCKafqQmb7jjzweaRq2ETBbPk_2HE8FbFLMdfcCD8PrdckoQ@mail.gmail.com>
 <CABXOdTemE9TOhOXy27beoEvj_6eTcwUj_A6=DMhEmMgCsqXRnQ@mail.gmail.com>
In-Reply-To: <CABXOdTemE9TOhOXy27beoEvj_6eTcwUj_A6=DMhEmMgCsqXRnQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 26 Jan 2022 10:56:58 -0800
Message-ID: <CACeCKadMZrFkjmyrO4Spb0Psd5-PZO8fTN6NdMgmsTEsLnT7Qg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC device
To:     Guenter Roeck <groeck@google.com>
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

Hey Guenter,

On Wed, Jan 26, 2022 at 7:33 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Jan 25, 2022 at 8:05 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Tzung-Bi,
> >
> > Thanks for your review.
> >
> > On Tue, Jan 25, 2022 at 7:46 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > >
> > > On Wed, Jan 26, 2022 at 01:22:03AM +0000, Prashant Malani wrote:
> > > > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> > > > Reported-by: Alyssa Ross <hi@alyssa.is>
> > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > >
> > > With a minor comment,
> > > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> > >
> > > > @@ -1076,6 +1076,12 @@ static int cros_typec_probe(struct platform_device *pdev)
> > > >
> > > >       typec->dev = dev;
> > > >       typec->ec = dev_get_drvdata(pdev->dev.parent);
> > > > +
> > >
> > > I would prefer to remove the blank line to make it look like an integrated block.
> >
> > I actually prefer it as it is. typec->dev is not really part of this
> > "integrated block", and I don't want to add another space there.
>
> But on the other side the check is part of the "integrated block".
> Maybe add an empty line between the two assignments if you want a
> separation.

OK. I'll add the space before it.

Thanks,
