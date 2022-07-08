Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23956B8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiGHLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiGHLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:47:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B568E951D3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:47:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f73so6561279yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LXcNpiL0hugCcH3yPL4TbK7rxIaV5AKYrpbt4Nl4sQ=;
        b=V7bktCTJf9G6gqkLOYPmGR9Uh2eHfOZUgCs4tdTkpPxghs3aZzaZxMM5EaO05LZVbh
         jJ9/vn/oMbawWLJPrFb3h1v6mvjeR3EPg4pbWOxBS/oZu+V8DBiypl9w8fiVghF1g3EW
         gTuGwQ3o3t0Bm/oHPxSSzK3yF9j0aZkhZgzhn26e+VzfIS3NFaDWhGJfvMldbBYgEaB5
         H5xuFgRAyUp4aCFvmyndkXi9dWuu3Xpj6uqWT4Bwt6s+T/NctA4wDoN+kcMZw+Km54kx
         pCpkHMe7iZkGA8z+UjYeSaKH12QoLc+gH8YPPN3x0sSZH6+baAz5GQVIriMYTDENsw2D
         IsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LXcNpiL0hugCcH3yPL4TbK7rxIaV5AKYrpbt4Nl4sQ=;
        b=ILAvnLshL1oVyc3oWA7jDM9BETONhA6/rWQdYHZHE2UVjyb+tmqkT3+KldTsuoUnhf
         hMPIUBpJANQOvZ0b755mTOGFEbyJ6fcXYhLYjKr3Fw42SOI1CLsuxaC/lphUwLuYZTBQ
         ZP7nHMWgu0bOOIj8sIUezEKlbIZZlncmfTFoZ9tjCQHZ2uHf42loI7OZTHeYr3/2t/RV
         1y/beZLwZI0+/xlRS90Ua8uEEWhq19+g8RCUcI3rlkFxIyCpmRsB3ZT9f59EnfhDgSQU
         CG+oJnc5PCX4MFvLYIaObj27z85JtPiqEe/1Lb/+MlIqgxRBWR3cPGrvUbdn0Z8Hi/QE
         fySQ==
X-Gm-Message-State: AJIora+RyHp241zJ3lXg18LKMHH45QnNrgkEyD8Ui1utaD15cFkLMvis
        5OvS+9235Ug+qQRg95moH9X6BkyVCC7L4HEQmu8=
X-Google-Smtp-Source: AGRyM1tdP4x7JQy/x8EF4GTgKqBJp8bVVhJs9zL0bB2Xb32Aq50XDeqCZxjHY+getXx/QdxDCe7PG4rZ4CDZs0+VldA=
X-Received: by 2002:a05:6902:154c:b0:66e:8254:146e with SMTP id
 r12-20020a056902154c00b0066e8254146emr3318465ybu.570.1657280852776; Fri, 08
 Jul 2022 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com> <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
In-Reply-To: <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 13:46:56 +0200
Message-ID: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Fri, Jul 8, 2022 at 1:33 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
> On 2022-07-08 12:22 PM, Andy Shevchenko wrote:
> > On Thu, Jul 7, 2022 at 11:03 AM Cezary Rojewski
> > <cezary.rojewski@intel.com> wrote:
> >>
> >> Add strsplit_u32() and its __user variant to allow for splitting
> >> specified string into array of u32 tokens.
> >
> > And I believe we have more of this done in old code.
> > Since all callers use ',' as a delimiter, have you considered using
> > get_options()?
>
>
> Thanks for your input, Andy.
>
> When I'd written the very first version of this function many months
> ago, get_options() looked as it does not fulfill our needs. It seems to
> be true even today: caller needs to know the number of elements in an
> array upfront.

Have you read a kernel doc for it? It does return the number of
elements at the first pass.

> Also, kstrtox() takes into account '0x' and modifies the
> base accordingly if that's the case. simple_strtoull() looks as not
> capable of doing the same thing.

How come?! It does parse all known prefixes: 0x, 0, +, -.

> The goal is to be able to parse input such as:
>
> 0x1000003,0,0,0x1000004,0,0
>
> into a sequence of 6 uints, filling the *tkns and *num_tkns for the caller.

Yes. Have you checked the test cases for get_options()?

> >> Originally this functionality was added for the SOF sound driver. As
> >> more users are on the horizon, relocate it so it becomes a common good.
> >
> > Maybe it can be fixed just there.
>
> avs-driver, which is also part of the ASoC framework has very similar
> debug-interface. I believe there's no need to duplicate the functions -
> move them to common code instead.

Taking the above into account, please try to use get_options() and
then tell me what's not working with it. If so, we will add test cases
to get_options() and fix it.

-- 
With Best Regards,
Andy Shevchenko
