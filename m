Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9881E474921
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhLNRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbhLNRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:18:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F55FC061574;
        Tue, 14 Dec 2021 09:18:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so64601258eda.12;
        Tue, 14 Dec 2021 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4k5xaxFhaWmmMpFWuwoV5BzpXXgW4I+HqRbm5rb7jQ=;
        b=E/0G7D28L5ngV0FeoItTWxWCu93mlXAxXRQGbhVuVR/4XZx1fRJ30udAun2qn4uj5G
         x+WdA2mCOnVS9EBKt3++NrkzRMRzd1225YRW0PXZuPOX/hyWYE3vt4VZPBZHAALjIoLl
         3qjAFrCGDteLu5JFgajrUCBMaZsMiOI4N6WlGy12nTIlbmZmp14zXehZA7xnZyYTG16T
         uF/IDmhPRBcENwdV7m8w6edfxhjEqYoDmo8VbI/v+WvFtPdW7GtUbevbwomTgfHUdDpG
         dXY6LzDz4Ap5dlYCrL4K49eRnqBqBBq0osDjRwUPt+EZIRVkG0MvSFQLqoboygwLvfXl
         0q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4k5xaxFhaWmmMpFWuwoV5BzpXXgW4I+HqRbm5rb7jQ=;
        b=hemOKwTgswOxM9CnV9j0C3AufB7oVB6VFv8ivrr4m2BHurWjQRlFJ2YZo4sgHlcL8C
         5KGN1f7AtlXe4GpMUDVZiWm6LthU/fGF139H0nk1B915w9iqeNAOeg5lGBAx1EKBg+9p
         RKTZy0GRH/St3CLFIUEYH3tzL68IYvZZnuvEx1+i3/Htdzlec51jwPftqiCmiZPpXWaw
         8FIQt8G2dnrojCistUZfDQnACbTx0KBEdOO4bkmBn+++eW8x7pszzu5l4wy51ZDbycjT
         CNzlbxRaVJ7S7p3KN0M8+JqAoLEyBUEk8rQlvhV8+AjMdDIhe0AhCComwuFU+tGTth8S
         Uwmg==
X-Gm-Message-State: AOAM530HfrqMQR9lDDRiPfLf1VXyhZL9f+XaDOeq51spKSqwNUyXKkOl
        LQLaCvecvWgNiFiqp2H41Yu6QzvW3CR6pvNNlDg=
X-Google-Smtp-Source: ABdhPJzvpULuko8jJTmI6gtokS4SL3ehpvJGK6X1x3V2r6BF2DkuActxc/xuzD9om2ud1n0bwycObZY3BBBvqdpIxMI=
X-Received: by 2002:a17:906:af1a:: with SMTP id lx26mr7201191ejb.44.1639502300844;
 Tue, 14 Dec 2021 09:18:20 -0800 (PST)
MIME-Version: 1.0
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
 <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com> <0f6621e5-f014-27c9-be8b-6c32ab994304@quicinc.com>
In-Reply-To: <0f6621e5-f014-27c9-be8b-6c32ab994304@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Dec 2021 19:16:50 +0200
Message-ID: <CAHp75VdL3hmr23CcJLDpvbHaKv5HrDZjmVQpCnRNmPM7nEx6WQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] pinctrl: qcom: Extract chip specific LPASS LPI code
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, plai@codeaurora.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:15 PM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
> On 12/8/2021 11:58 AM, Andy Shevchenko wrote:

...

> >> +#define NO_SLEW                                -1
> > Naming sucks for the header.
> >
> > LPI_NO_SLEW ?
>
> Actually it's already mainline code. Just these patches are
> rearrangement of old code.
>
> still do you suggest to change?

I would, but this means it should be in a separate change.

...

> >> +struct lpi_pingroup {
> >> +       const char *name;
> >> +       const unsigned int *pins;
> >> +       unsigned int npins;
> >> +       unsigned int pin;
> >> +       /* Bit offset in slew register for SoundWire pins only */
> >> +       int slew_offset;
> >> +       unsigned int *funcs;
> >> +       unsigned int nfuncs;
> >> +};
> > Are you going to convert this to use struct group_desc?

Any comments on this? It sounds like further improvements.

-- 
With Best Regards,
Andy Shevchenko
