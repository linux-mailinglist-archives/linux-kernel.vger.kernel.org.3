Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61EF5AC60B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiIDTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:20:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994D1ADAC;
        Sun,  4 Sep 2022 12:20:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kh8so5205691qvb.1;
        Sun, 04 Sep 2022 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ylmQbLNcXArcx2T18HQa+1UhiZ6tItjmMAQcUFUjyzo=;
        b=q57xgdVAAEK8pSr9sj2gBRWm6w2UPOI5fYE65EZjXxlN5y61EkhZswF7TIlhFlv3Mh
         q3djfE/VzFg0LPVymHa4nmGocfJ+sd1QqkyIiSmus26uoLKk6PPkFdRKa9/1uTji0VHY
         2A7vx8HZ1earBnJtNf0IaOjR05uoTsBvTLA+4o6vm319C6XKC2Z+QJa6s90JhzfdTQSf
         WI2R8Ba51PSueUW1dZ4yXNw7NOZzI6kb7S9CnQXTgPY7luVb9VfbaA4/SpVG6XocRtGF
         iHrd4WLVuIwCrjyzgXgRUzMSzULaWmxOph70b/WoBepH8OJcrrKBTXWVL+LZznmjxrrE
         ftxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ylmQbLNcXArcx2T18HQa+1UhiZ6tItjmMAQcUFUjyzo=;
        b=4iOpRSViunezoUaxGyjbcapiwzGBEN9fmzoqszjGGZeXnbklv4yeudESnXFgPKnlhg
         1MvYPrdi59wy9g1q27VfvbJxstpBuqsapXH+tGNI9t9fzAVQGane4KPU/9Lwgofonqeb
         bNa+JGbjtYCl902FSOxx/0qtnq2i9ZvVNrlw4qWd/EX81QDfe4wgfptJUTrCiUqTuvOk
         K4ooCEtgjV/v9eZcCkfEqzUtFfZJfbY8RonysULxyA56UFPq4Hu7CCog37SFM144ZRzV
         hVeeyFTEVTGnIiZZvV3wVn8dHXVmURBNIwHktQCqGBzDnRBtsyABICq3un3g7qXFxXrY
         9T2Q==
X-Gm-Message-State: ACgBeo2KQmKJPgk3WcIPvDLdC7ESgu0yuVUrFdlMvljgj0SyqujESED8
        mC17UHcsdOAa9lfdpxHdzgPYaBlFoq1NAYcLNes=
X-Google-Smtp-Source: AA6agR4KiFwQ1CNJPfxi1qbsH9IyNiFfvb4kiHCDlP67AqmzL8Skx2d/YRndh7prCZLCCy6ZnEdzBLZXd+Z62H+ISMc=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr28292109qvb.82.1662319219518; Sun, 04
 Sep 2022 12:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220903222422.3426156-1-cmo@melexis.com> <20220904154923.33b79d83@jic23-huawei>
 <CAKv63uviUbiAy6tYjkqFP-Qgs7dwAV5BPrr2aTTxQyjPBeA+Og@mail.gmail.com> <20220904165634.5cde87fd@jic23-huawei>
In-Reply-To: <20220904165634.5cde87fd@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Sep 2022 22:19:43 +0300
Message-ID: <CAHp75VdVLO5J-S7PPupJv0K0T5UAovCUP_0ZobyKaoHHtE-YuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: temperature: mlx90632 Change return value of
 sensor measurement channel
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio <linux-iio@vger.kernel.org>,
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

On Sun, Sep 4, 2022 at 7:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 4 Sep 2022 17:27:28 +0200
> Crt Mori <cmo@melexis.com> wrote:
> > On Sun, 4 Sept 2022 at 17:23, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Sun,  4 Sep 2022 00:24:22 +0200
> > > cmo@melexis.com wrote:
> > >
> > > > From: Crt Mori <cmo@melexis.com>
> > > >
> > > > The current EINVAL value is more applicable to embedded library, where
> > > > user can actually put the fixed value to the sensor. In case of the
> > > > driver if the value of the channel is invalid it is better in inform
> > > > userspace that Channel was out of range as that implies more to internal
> > > > driver error than invalid input. It also makes for easier debugging of
> > > > where the error comes from during the development.
> > > >
> > > > Signed-off-by: Crt Mori <cmo@melexis.com>
> > > Hmm. That's an obscure return value - I think it's mostly going to confuse
> > > anyone who ever gets it.  So not sure this change is wise even though the
> > > descriptive text for that one does seem very much suited to this usecase.
> > >
> > I did get it few times during the development due to read when sensor
> > is not busy, but the measurement data not yet updated correctly due to
> > powermode switch. I think I added enough delays all around to avoid
> > hitting it and with proper power mode switching, but there might be a
> > case, so it will be easier to spot in the source code in future. I
> > would not remove it, if that is what you are proposing.
>
> I meant leave it as EINVAL. The users of ECHRNG are very very
> few in number, so I don't have a good understanding of it's expected
> uses..

The problem with EINVAL is that it happens in 95% of error cases and
you really need to rebuild the module to get it where it occurs. I
kinda tend to acknowledge the patch, because we still miss the JSON
error reporting in the kernel which would fix most annoying problems
with debugging kernel code.

-- 
With Best Regards,
Andy Shevchenko
