Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF858D55E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiHII3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiHII3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:29:48 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA9656D;
        Tue,  9 Aug 2022 01:29:47 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l18so8010557qvt.13;
        Tue, 09 Aug 2022 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=atLp2imtTuw79d2ygzD1oZH2HrahdMCGvtEG58ejNaM=;
        b=UJ3RaIj6CaDvFVKBXqaBm5uH8j7ybaSbEYHtAKuTGsAlTctYhmT2717QZyLImA9fRe
         n0wQ35iMTC8z8wZdc3XaJF/rpF5GCS/T+kQhOGWztSq5+6sWRhe5CnSGaYd1MAm0r05r
         rwHPEGXoDIvL33flYx4a/HVPB4WKFiHQse/lxwwG/VWDJXzEowDwRQyzcqnA5bkuzLjK
         hM/x2DF62aeEfeErrHpH7/maOBppYsfdP0837SLlAvnNiZ/ckV5hU5e96ziQfaEc40KH
         LMlTsaX/un6uEAfTDKKxwqK1iMfglliFPMXBbkyMa20+vS4Kzxb1Q7WxjCJf3Sl0xhS7
         yVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=atLp2imtTuw79d2ygzD1oZH2HrahdMCGvtEG58ejNaM=;
        b=3Yua8ZYUiWOtnsL+8v8VJi7KnDmxKH2ZaQmBrAzEN74SBXBx7ElNb9IpvgymFVn9GR
         WsaRuyOeapRaLH8Ig/GBGWPM7EQjxRM4mvhF5VcnA0HQGyjuNwuJNAlyhiDitxxR3HY4
         wgpmskoqNbbHTx3yWpey83A7w+bACROYM3d8+O6KoTHj+/o75usFYOYKRPZBBr1jMfSQ
         Lo7ZS5keRkmSeS98FmWTmaRzrdlC1Jzh57jGrJ1R1DmXMeFe00u8RHkpNJyt/JUo/GDE
         wveUVFXsBiFP8cBXoTOS6MIS8et+E8EahgR3lqT7ODiZ+83ObVhozhvf2tdvgWStdfH3
         zSoQ==
X-Gm-Message-State: ACgBeo05+W1xqzzM8a0/BtfhZMaJ2Z4UBj8KwJ5OQ6WhNDASpOodT7Y+
        6ZRUbk73GWxZEmpJsGP3RqHWma2XmnZ8toAWi1xW6Iu1Uvw=
X-Google-Smtp-Source: AA6agR6EvcCiRFbsFiWUKkksOl22iM7Bw4TB5xNEmHK9dQn3XwceJCsxMRtUQrih86Pcc93LOWrJWf7B8R4MuZFESVA=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr18992238qvq.64.1660033786643; Tue, 09
 Aug 2022 01:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-4-luke@ljones.dev>
 <CAHp75VdNa8csSF5Je87kOzC3EQ4yetZqpxXFZu1D7C4A6XCTNg@mail.gmail.com> <X5LBGR.15DO7CCYH6ER@ljones.dev>
In-Reply-To: <X5LBGR.15DO7CCYH6ER@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:29:09 +0200
Message-ID: <CAHp75Ve4kFJz-4QqpUYTujQRkOkFZ+w01eHRwZyvQAA+GkNG9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] asus-wmi: Implement TUF laptop keyboard power states
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 1:27 AM Luke Jones <luke@ljones.dev> wrote:

...

> >>  +       if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot,
> >> &awake, &sleep, &keyboard) != 5)
> >>  +               return -EINVAL;
> >
> > Same Q here: wouldn't it be better to put each of the parameters to a
> > separate sysfs node? Or look at the LED ABI (that what Pavel mentioned
> > for multi-color patterns) and see if there are already some
> > established ways of how to represent necessary information?
>
> Same argument I make for the RGB mode nodes. But here I think it's
> probably even more pertinent. The reasons I would like to keep this as
> one node are:
>
> - It's separate to the RGB part
> - We can't read the device to set defaults on boot

Hmm... Maybe it's done via one of the WMI calls?

> - Because of the above, if we set a default and the user wants to
> change perhaps "sleep", then we're going to have to write some
> incorrect guess data since the write requires all the flags at once
> - One way to improve the UX is to add _show, but then this has to
> display incorrect data on boot
> - We end up with 5 more nodes
>
> The same reasons above apply to the RGB nodes, which right now I'm of
> two minds about. We'll see which way the RGB mode patch goes after some
> daily use.

I just realized that in previous mail I mentioned Device Tree which is
irrelevant here. We can't use it on x86 traditional platforms, so it
means that platform should somehow pass the data to the OS one way or
another. If there is no way to read back (bad designed interfaces),
then we can only reset to whatever user provides.

-- 
With Best Regards,
Andy Shevchenko
