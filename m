Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883CD58D71D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiHIKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiHIKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:05:50 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7A1EAC9;
        Tue,  9 Aug 2022 03:05:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h4so1526352qtj.11;
        Tue, 09 Aug 2022 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HpV0EZlE6e2eMaIDjSXTXeDXEgMdjAMNL8wCEK+p54E=;
        b=mvMw6HWzHYGqJL1YzvSDBuaEdia2JKkV0rDdQ5umIkSddHt3+PpIwToiaGCieH/W2X
         +NadBjIyiPUd0dEJjmjmEYQIgu/+VARH9C5jOxS0+FvXBVxSquQY5qf921j73td5q/ZS
         2RqbWhE9XAOSDThaTP6m8jAtmAHJAESdpwO3GYujg0Sg9GkdCF5oLJIz+9Hzy5VIm/g0
         mDUsNt2epRrD3yJwzBqiMiP1Icu6c+w0fLTq/nNUDRKh8T72nZYtriPQdi7b7o4WrvUp
         ZpbeOV9l1ul7xbiIoERIiSa8n+8xBiqaAEclpdWWjsiimQ3brrXczqbf+H8Rg5hLO8Qs
         fmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HpV0EZlE6e2eMaIDjSXTXeDXEgMdjAMNL8wCEK+p54E=;
        b=r5JTgwGeIDL5N5K/EZ+o0vTUKwEmM8hHw/16qg6usehRV+E51r/0+bY3xe1Gur5HTD
         +3cgL0icutmNBK1tb/DFTegp1p8i6Y+4+CHTMnqY0/uZrAfG8U8krdxdd91MFTG8LkaY
         JC1SMCdjKgPeohBaL6jhEygCDXD4tAU6nX9bBjMorJSRYR50ToN9uqf+hB6Zt08GCGRa
         KmRC3XcLP+P8kvg2pvlmqgaCvZXPAWoYhrDOAxBSj+pFc0r5eOJgrz+qfdxz2kGGm4Qe
         5xaVd+3cJgLxcHNX9SN7qb3+7JF8EVtmSbDk1Pe38XhgL91JRlSxisvgs+2mzRDRRteF
         FXgw==
X-Gm-Message-State: ACgBeo2pKTIfOMNJ7t/drKa4omeOgMBmoHtAtqYMr7J0574qmjoUCM4o
        9CKb/ZHzjtX81sWzLJryY6/1HUVCWQnwbDavDp0=
X-Google-Smtp-Source: AA6agR4MsNhXIU3cv2AEBAfhtZglFFnZ4N4k6S92h6seiRzhEB7hemu1tcOyGGvXMKc7cToH6wPh2DSMAYzKS5e9t6o=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr2654179qtx.195.1660039549237; Tue, 09
 Aug 2022 03:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru> <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220806155523.37c3e587@jic23-huawei> <20220809095251.vpp6arac3pkntdlo@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220809095251.vpp6arac3pkntdlo@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 12:05:12 +0200
Message-ID: <CAHp75Vc9LGX-=Y2smOrKuAgSRrhA0AgGuBE-0=_-q78FpSB6ag@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 11:52 AM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Sat, Aug 06, 2022 at 03:55:23PM +0100, Jonathan Cameron wrote:
> > > > > +       indio_dev->modes = 0; /* setup buffered mode later */
> > > >
> > > > Why explicit assignment to 0? Doesn't kzalloc() do it for you?
> > >
> > > kzalloc() will do it for me, of course. Previously, I initialized modes to
> > > INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> > > suggested to replace it with 0.
> >
> > I did?  I wonder what I was smoking that day.
> > Should be set to INDIO_DIRECT_MODE as you had it previously.
> >
> > (From what I recall it will work either way but we have in the past had
> > core code that checked this and may do again in the future so drivers should
> > still be setting it to specify they provide sysfs interfaces to directly read
> > the channels).
>
> Jonathan, really sorry I referred to you. I'm confused. This comment was
> from Andy in the v3 discussion:
>
> https://lore.kernel.org/linux-iio/CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com/

Indeed. I was confused by the comment. My understanding at that time
was that the triggered mode is inevitable and hence assigning to
something which _will_ be reassigned later makes a little sense. So,
does it mean that triggered mode is optional and might not be set? In
such a case the comment is misleading.

-- 
With Best Regards,
Andy Shevchenko
