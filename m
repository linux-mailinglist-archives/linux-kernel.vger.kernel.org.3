Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224B6480557
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 01:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhL1ASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 19:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhL1ASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 19:18:50 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541DC06173E;
        Mon, 27 Dec 2021 16:18:49 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u22so28007580lju.7;
        Mon, 27 Dec 2021 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoRJS+sCpZjvwrcz0U+sMMRgEmatDpeTiSDhan+RQ8A=;
        b=LiyWyMDkOa2n4RbFcP26E2P2k7zsV2tUTjbDMsRvxCI6VTvgkj5C4txistG/ximQ1v
         xFSciYEzcx1vHYWgtzNUXjdzQv1l/l5wXn81CLT9rvR6kJoS+G+XKNvDz+bUIyunX7/9
         ZPnNPrFTPewkZoVfSeWhvXcAo60dPzF3VHEIRz5m90OwfkJKSlyVICTzZwzI9TmAi5Cs
         4gm0p5QRAtnyq/zcS1f9PjlI/SPLVaaQUARI4IeX5BZrLeXGsugjF0tSQaXB7HGfkCNE
         Qcdr/8Fx+U/GiGL8bhxUFgeBwiwFHK5Ft0jOrRGc55wgfl9MNlhCtgeVaDyY6NpeUmHb
         Z+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoRJS+sCpZjvwrcz0U+sMMRgEmatDpeTiSDhan+RQ8A=;
        b=6Yb2oxBvazSe1X0pdtcUa+SjqxrSpdNPojEjM9/0sZRx0tF5oQNpMJ8IpIsFT/nFcf
         0yPjhKkWKxGU8NErUGMvnuLfZIgacSeJvlQyzfftWJIdqPnCpuactjtMzYQ921sq29fN
         hgUqiQBsr/JWZ4lK7UCtc5f3VgtG1d+4d7QBkWrGvuP6kvtAwgxU2baQdUsAlEw8mlBn
         1cbnnOVlk4SYLZhJ1ivxGIaeSytoM3H219PNAJTHhj/pPrrhbMJTzg+OieR7jakG5s/T
         FgewzfPpun8vaeNTJZ0imI4YlcRdUop4Hwaib+kO3kobKGZXgVIboMT4I1XFwTS5X/Ay
         /Z/Q==
X-Gm-Message-State: AOAM531Ya4BpEan9DxdOaCltOKgy6i9UMnaioCcvpjqv4pijcq8yXnmZ
        VNRbr8YeZ84rtbrV8h2/dvJh4kPUclqEwivVWqk=
X-Google-Smtp-Source: ABdhPJz6nv5GQ0jAE/Fg5EC63gy3TBmbTsKJyjdbpb5yxQ7SK8OknCb2FCbdhjP9gM8c9LtJYhDbVaMhi5RFR2fmrY8=
X-Received: by 2002:a2e:530d:: with SMTP id h13mr15483556ljb.95.1640650728062;
 Mon, 27 Dec 2021 16:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20211227113632.90672-1-jiapeng.chong@linux.alibaba.com> <e689de7b-033b-0ada-5135-faf7fdb1e26b@roeck-us.net>
In-Reply-To: <e689de7b-033b-0ada-5135-faf7fdb1e26b@roeck-us.net>
From:   Aleksandr Mezin <mezin.alexander@gmail.com>
Date:   Tue, 28 Dec 2021 06:18:37 +0600
Message-ID: <CADnvcfJ_ZxQgrsxxAyrEfMLKFZGuGo6CESCWNyWYtPHkA4ZTsQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: Use min() instead of doing it manually
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 9:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/27/21 3:36 AM, Jiapeng Chong wrote:
> > Eliminate following coccicheck warning:
> >
> > ./drivers/hwmon/nzxt-smart2.c:461:12-13: WARNING opportunity for min().
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   drivers/hwmon/nzxt-smart2.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> > index 534d39b8908e..b30de7441fbb 100644
> > --- a/drivers/hwmon/nzxt-smart2.c
> > +++ b/drivers/hwmon/nzxt-smart2.c
> > @@ -458,7 +458,7 @@ static int send_output_report(struct drvdata *drvdata, const void *data,
> >
> >       ret = hid_hw_output_report(drvdata->hid, drvdata->output_buffer,
> >                                  sizeof(drvdata->output_buffer));
> > -     return ret < 0 ? ret : 0;
> > +     return min(ret, 0);
>
> Nack, that is just confusing. ret is an error if < 0, and min obfuscates
> that we want to return an error or 0.
>
> Guenter

Should I change that ternary operator to a full "if" maybe?
Apparently, both some people and some tools read it as "min()".
