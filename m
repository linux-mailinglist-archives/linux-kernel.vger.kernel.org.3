Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558747D8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhLVVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhLVVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:34:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612CC061574;
        Wed, 22 Dec 2021 13:34:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y22so13721298edq.2;
        Wed, 22 Dec 2021 13:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQlQlYrZXdOlmemUUXiF4Fhovo2L1S/LzruvfN712uY=;
        b=br4b7Dx3l6Zfp65HGNkqUIOl6r/hzzYAYN2NdDkPMpX0mGBSMDJh7KeVbsx8yT7QTR
         Ex5+LyzbOoGmM//h1zL/FSTfdOe6Im+MWg49HVf3yg0R61kP3Y4ryyBzk3qPUHMuLnvE
         oPbLLiZQ0ICHlTkTsV/f3gkmZAXBsjODurvhCCGiWRTdWUBXffBYlYWUy9a9IGxc2MlP
         dbQqsqsHrMtP/0ClN2GWH2W7SCveLV5d4s9e9o6A0FeDoxwJamNN+Slbgn/To6H8sf/z
         vkyb+1skGRbW4rNR8rLLokkhnvZSNqQm/ZCCBgd5L24nIKTJ9kQRO/sDk8MZUUqO6bkO
         /C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQlQlYrZXdOlmemUUXiF4Fhovo2L1S/LzruvfN712uY=;
        b=cSO+MUVeHSSJsRGUzqA7H5lmjZH3qlnBHdbCsbALbH8Op3BbtwVLh96XGzXlqJ3UlA
         2Kgoh5VrGkVHo6PdyL6ZkCbmvW9up7VFLzh62WEd1g/1/R9T1Uh0IRINUQNGHouIdvMp
         DyOgSP/hi3XVe3vZdXhp+MjN/gTzh8q1oe5bGrjK0DK76FtE+YJqtBlEdLot52KNtddg
         sdZlFw33ZXV/AJMuF4wXM05azUE5IyGC+ibEpVmQ7qoihZzLQoxvKXQuO9jSR+n4dq2x
         FFbYwfgxvA0ZTQoefQOldO0kw4CfHdtk8K1ft6dNmVHDMJftgzU+zFJOOkvezjLHTnKr
         RS9Q==
X-Gm-Message-State: AOAM530MWS9bifgi+BFR7W7Lns8LIczDQY4mt+E3598fFFAqyrP4iOEI
        1t3Wn+Vz3GCYwvxJy99LUcQylId/n1aYTqXSpXk=
X-Google-Smtp-Source: ABdhPJxPcjYs5SH3P+Dvg2BhIowtF8SCyB4m0E2WIuGCd+CxC0ZdFvR74vmCCjoZgGk3P++JhhtkmIQ57SBR0JaSFUc=
X-Received: by 2002:a17:906:c450:: with SMTP id ck16mr3745748ejb.579.1640208862599;
 Wed, 22 Dec 2021 13:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
 <YcNwt5RFMNFUimD/@shaak> <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
 <YcODglDWiknz2oeV@shaak>
In-Reply-To: <YcODglDWiknz2oeV@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 23:32:24 +0200
Message-ID: <CAHp75Vejfr_S7iK7fAvs7ELxE1TJUECvmKv0-G5Zwunyc6nDQA@mail.gmail.com>
Subject: Re: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer overflow
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

On Wed, Dec 22, 2021 at 9:59 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 08:56:12PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 8:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > > > > -               tmp = 1 << *val2;
> > > >
> > > > At some point this should be BIT()
> >
> > Forgot to add, If it's 64-bit, then BIT_ULL().
> >
> > > I'm not against changing this, but (to me at least) 1 << *val2 seems
> > > more explicit as we're not working with bitfields. No?
> >
> > You may add a comment. You may use int_pow(), but it will be suboptimal.
> >
> > > > Rule of thumb (in accordance with C standard), always use unsigned
> > > > value as left operand of the _left_ shift.
> > >
> > > Right, that makes sense! In practice though, since we'll most likely
> > > never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
> > > enough to simply typecast?
> > >
> > >         tmp = 1 << (unsigned int)*val2;
> >
> > No, it's about the _left_ operand.
> > I haven't checked if tmp is 64-bit, then even that would be still wrong.
>
> Okay so your recommendation is to not use a left shift?

No, I recommend not to use int type as a _leftside_ operand.
BIT() / BIT_ULL() does a left shift anyway.

> I can look into that but given how unlikely it is to fall into those bad
> cases, I'd rather keep things as they are. Would that be okay?

> Also, I don't think using BIT() or BIT_ULL() would address this as they
> both do the same shift, with no extra checks.

They do slightly different versions of it. They use an unsigned int type.

Open coded or not, it's up to you. Just convert to unsigned int.

-- 
With Best Regards,
Andy Shevchenko
