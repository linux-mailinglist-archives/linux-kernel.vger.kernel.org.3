Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2755947D804
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbhLVTw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLVTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:52:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DEC061574;
        Wed, 22 Dec 2021 11:52:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o20so12713271eds.10;
        Wed, 22 Dec 2021 11:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1YmzyqKunimqWaVF3yJd/7NDiiGqAFWnFSlTBlAVPg=;
        b=GTLJojEKS5Vc9mcvt/7bC4Y8lrntWb8Br+oJUwnQRRFNKSUfA3xa1T+YZadk272RLu
         hXYrblyg31LTczpWQW/0FSOxPSZiMBVEaVZMJIdT45iPAKCX6GcQHilBrF8JxX7V5WpT
         5ijHmZc3Ed/8evxl77EeAP+VVcWZH0hVB/UJdG4UCueYagZNVduIkEUpTbkUxBltuCqt
         KyxOHVGEQcltmJwviPQeDF9WM/vZJV4SY87OWvRJFM10WLO45Z6+Vx6rS9pkwnHrQqtc
         gdft3aXRBHHirLYHW7oPeR5mahrJbSBX59FOkxT7Sj/t07X086lL1+tlGbJoVboMwfTw
         LX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1YmzyqKunimqWaVF3yJd/7NDiiGqAFWnFSlTBlAVPg=;
        b=1uPchw0USQq+FWz1GGLq66fl0MaO0aWAGCjSmYcryImiJ1Iu5ute04BdwJX6KOxl0z
         44mRfMjTcB2Xe15h7VBW/9LLhuORxG83SHdZmZIUA6RmYMSsaDtftLjYUvPatQdMemSH
         Z9ZNoEyyc0I1ica6Hu2YtM3C20MQvHEiFWvD0pxn/Rrj6wSmaXw0GXXvwh0wmLJaEhJv
         +g4a1yy8duhEFLdaanIeLkQCrp//NCaDV0W/JOsbvS77EYsn06rxV3pJLcOfm7yV80Q9
         BAZjNhdliAVPvr7BqyUi5OaH5uiI40ufrC2QjOuyG4i8jHRYo9SuNzQEb/B2iqjI4u7m
         X5fw==
X-Gm-Message-State: AOAM530GgDy324udzdJxZHJZ2S6zzETqJLqz5ieSY9g85zJm70qtjLIb
        hwE9GAtr/hkz6p2Q+wrKjvzqUgCiG9KL2SWT4ao=
X-Google-Smtp-Source: ABdhPJzZBJPZqZ6Hh1v+62kno3+ZHdacoQt5hdcufeZ9qIkjbxmXX4krXdi79FAqhtBFYd54EzuAX/4OewKuZdQBpxE=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr3703357ejc.132.1640202746578;
 Wed, 22 Dec 2021 11:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-5-liambeguin@gmail.com>
 <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
 <YcNscJ/fQhI7h6Uq@shaak> <CAHp75Vf6iN7yEdubKFkf+fXupVTco-toZN=a5+KNXG4Yv6oT3Q@mail.gmail.com>
 <YcN/kkazUGyyazNF@shaak>
In-Reply-To: <YcN/kkazUGyyazNF@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 21:50:28 +0200
Message-ID: <CAHp75VfGJwfCiwt1mfnqnBWd0MPMmVk-oheh1===ero2ErbXJg@mail.gmail.com>
Subject: Re: [PATCH v11 04/15] iio: afe: rescale: expose scale processing function
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

On Wed, Dec 22, 2021 at 9:42 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 08:52:30PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 8:20 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > On Wed, Dec 22, 2021 at 12:21:01PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > > > Missed types.h and forward declarations like

^^^^ (1)

> > > > struct device;
> > >
> > > Okay. will add linux/types.h

^^^^ (2)

> > What about forward declaration?
>
> I'm not sure I understand what you mean here.

In (1) I have mentioned header and forward declaration. You agreed in
(2) to add a header. What about forward declaration?

-- 
With Best Regards,
Andy Shevchenko
