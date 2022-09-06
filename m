Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B445AE93A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiIFNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiIFNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:16:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDE6C106;
        Tue,  6 Sep 2022 06:16:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a22so7916336qtw.10;
        Tue, 06 Sep 2022 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NoCbebGaOWxkwqZQWcLHo7uI1OK/Nn+DHDHQ7NFsadc=;
        b=jYp77ldm+4lVSZXDHm2hhZj1UVisPG2zTYgIgaIfWxFZW1nIM2l0UC6+Fo6MXviZdR
         Y9P0mg7I4yTrG7pd2splD69vkgwTcj6+0AYqNUUT68bC7+5rRpGCey2s5NFCvXlOK62t
         iTRAsGQWpPEzUOHESPOo5lskqEbuUwGR5eb5/cP+J0R92gipJoOm2/PyaRD0Bm27Ni4F
         EGlHiSRK6HWmpzXVT+QKGrkD4W+zzUf0zRFPAcdx4hR9rvPbeXFNoYOwT0b9yyp51jh7
         u7pRu9aTfjT4Ohqs0XnmK1h4Pk1//urX5l7pdZedkcrA/HkLE/notVUO7QOwm1Nf9zVv
         YS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NoCbebGaOWxkwqZQWcLHo7uI1OK/Nn+DHDHQ7NFsadc=;
        b=gCR3hDxWgZ1IwIp7nJPaVImDEx8YaJDu5q1P+B8ODoCu0kSlUNFO8HbBSyYEgppDdh
         sWezRoYQmhaBDDOJbcP+bP49OIKN8qE8Fp3bM96IfhDQGMKDhahFMrhz+3Pv8iyv6iO4
         q5YnMeaJ5A2uU2gr85YeLqvHCuLxSAGpgPSW7VzA3pM/FMrwDzOD0i31QvHBPZhISRBT
         1eKg13SFlu1unpQthH+XwqK6nyRqhSXjYRO7Qxkj6vUUx1Sgqw/4qUpEdkrXeeQn18Aa
         t8KEwlfUPMhAV/MQAnynfXc7F4du93p2g/6yg/NXnagab+0HVFZWg8GRWa37ZDubMBne
         9/yQ==
X-Gm-Message-State: ACgBeo1F+V1lOow1ErY3Yux4/ThrIG8BoD4M5O5PDb34fuTsCbqkWwV/
        hLZHv7mQucjGytrfvr/PjnVPrA5hZq6MsdkVskE=
X-Google-Smtp-Source: AA6agR6i7B+oUyRuVMipuDEgzBmFB2WR/0ilFHjBm/eE8ykTIP5wbce/mr2hbsEUK+C6GBDvn2dvfWF75D5NHNiyxcg=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr44328260qtx.481.1662470203427; Tue, 06
 Sep 2022 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
 <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
 <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com> <CAKv63utCSXVgOP4JkEBQSzDWF_s443a-ZbCd8V4tP9=z461McA@mail.gmail.com>
In-Reply-To: <CAKv63utCSXVgOP4JkEBQSzDWF_s443a-ZbCd8V4tP9=z461McA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 16:16:07 +0300
Message-ID: <CAHp75VcAhDPLyS=f07qVyiUY_Bh-ZrovWcajn2UkugQt=OCNNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Sep 6, 2022 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> On Tue, 6 Sept 2022 at 14:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Sep 6, 2022 at 1:52 PM Crt Mori <cmo@melexis.com> wrote:
> > > On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > Very good and documented code, thanks!
> > > > I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> > > > (due to pm_ptr() usage).
> > > > Otherwise, with some nitpicks that wouldn't prevent a green light,
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >
> > > I checked DEFINE_.*_PM_OPS usage around drivers and you either have
> > > SIMPLE (where you define suspend/resume) or you have RUNTIME (for
> > > runtime suspend/resume), but never are those two together. So I am a
> > > bit puzzled how to get this working.
> >
> > The one which suits here is called _DEFINE_DEV_PM_OPS(). But it's
> > basically the same what you put here with the possible unused case.
> >
> I thought underscore prefixed macros are the ones not to be used
> directly by drivers. I also found no occurrence in current drivers, so
> it was not something that was done so far?

Looks like... Okay, then let's leave it to the maintainer to decide.

-- 
With Best Regards,
Andy Shevchenko
