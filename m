Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802C947D750
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhLVTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhLVTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:01:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C375C061574;
        Wed, 22 Dec 2021 11:01:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so12257986eds.10;
        Wed, 22 Dec 2021 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebMfnC/V0caOay+nHxFuXTzPz0oNSzLMhvwXV9X78Lw=;
        b=J2RThtJcY2lkrdaELyqc8cJ6+7n0hPxXGITheMhhOSNXzYofmJD3tz3nC0OA6QbNOz
         l34HE1IB0RdeIQAsuUpUVS2FkVLw1UHWJXVhSCwSwdDDRoRLk61gPM95All/WbZ6chU6
         Qr6D/9dGh5wPuAxt+ujGXl3OE3UTe25OmsJsZQTpsdxQBL+arzFyMw07avzBpadRqMZX
         7G6+DQvSp9/3HeS0qu3wkrZ2swFX4HH6J02WRvrvbtuXpEU1IlGyQr6jMkS+hXKkoI6y
         92WPq6l0hGo+/WiSZI7N8pCfJkZIICHY6YNSV0eztd3q2bGCF/oHZ6uSB2BbODny06rx
         grOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebMfnC/V0caOay+nHxFuXTzPz0oNSzLMhvwXV9X78Lw=;
        b=0Rz+mSJhMN6Jilh5O+sM2o6uB3Zzu8cABGHMJBMeW92+l8Olh7FD+LxKs1WN0M3G4u
         ZnAaNIofQbHF2HtSPhOLFkfo3psXw+NdxOCTNHiyFRz1kP/+0jr1HOzS/7S+jPDnrXW8
         yVorQ4F2csqEiQUmQezit950KJXy5KlDdMKqYUwqjaM3SFCL6OZKOHXM7pTDIBGga+h9
         uT346QWbuJVX0AcfE0FwPniuO8gZVUVpzNvWq07g6iURvP/eq2trFjEpUnPLR5A5+V8H
         SWMku8yKdbUIdRkjBLZqqmskeEF1kQ0kio2MinJPZ2ywht58tnEvung5kXWva8EPhp1H
         /TbQ==
X-Gm-Message-State: AOAM5306nBXoIQxG94PsKL2vRzkr0h8YKXwKcJ5Vvo2DJcv/FUl5gs7h
        MuY+dp5Jktd1l+v147JkbHsgIWzZQDpMmzDvwZm6MzBGEBc=
X-Google-Smtp-Source: ABdhPJwH+EIAmTseU+k1GPGYcuzIJevqEO7yJQuz7JQr5du/Kic7kMSMgsyioRH2zdVnPDGdW0WH7I79dEG9NgKcyYs=
X-Received: by 2002:aa7:cd75:: with SMTP id ca21mr4044255edb.242.1640199677226;
 Wed, 22 Dec 2021 11:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-11-liambeguin@gmail.com>
 <CAHp75VeGNuYiqqHzv9cAbHKy-h3dnazf2YEvgJ4fwb88wgY48w@mail.gmail.com> <YcNzkbSsG1wyz2MV@shaak>
In-Reply-To: <YcNzkbSsG1wyz2MV@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 20:59:19 +0200
Message-ID: <CAHp75VfQ0C8uZ0=8U4F1DS0v-DpBnzZM+QCxQG33FMJU2m-dOA@mail.gmail.com>
Subject: Re: [PATCH v11 10/15] iio: afe: rescale: make use of units.h
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:51 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 02:33:52PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > Thanks! The important part of this conversion is to get one trick,
> > i.e. NANO and GIGA are both represented by 10^9. We need to be sure
> > that here we use the proper sign of the power of these numbers. So
> > please double check in all cases that the chosen SI prefixes are
> > correct from the power sign point of view, e.g. it is 10^-9 and not
> > 10^9 or otherwise.
>
> I get the difference, but I guess I'm not sure I understand how you want me to
> use them. I was using NANO here as that made most sense for me.
>
> If we go by the positive vs. negative powers of ten, I should always use
> GIGA as we're multiplying by 10^9 and dividing by 10^9. Is that what you
> expected?

You should get the proper power after the operation.
Write a formula (mathematically speaking) and check each of them for this.

10^-5/10^-9 == 1*10^4 (Used NANO)
10^-5/10^9 == 1/10^-14 (Used GIGA)

See the difference?

In the similar way for values of e.g. 10^5.

-- 
With Best Regards,
Andy Shevchenko
