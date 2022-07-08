Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38DE56B88E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiGHLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiGHLaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:30:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CCBCA8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:29:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h132so6588056ybb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Znf5kwic3swsEPm/VX1nhdtTQ2a4clPVk80deBD+g1Y=;
        b=aIrhRPwmtS7jdp+GoA5OzkTK3M2lsGW6uVDvlhCzP8iYXs1ude3Id9tbr5pcjY977+
         jpRPa2RfavV4pWJCowLsDzp8HoW5uEgN8R7Mf+fxOi7RnfNaNZvl/CvdsUG0sEub924t
         YXyVKXunoXH1Xxb0qisdSklipYjZcmf9eIbezhgr07vJ7kH+n8QuJz8fMptrcgAiYnro
         g6Fr7rKNuh7cK685D9oy+BSU4PtxTMLYNtavOrAS5OuPNRkolH99tC+sII8fTyAhB/UY
         Uhn8bMuF3e8dpWNr9an9pOTm8DPW81x56aOBQ3FVLyK8SClPN4sKno90TFuwf1P2L31Y
         4FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Znf5kwic3swsEPm/VX1nhdtTQ2a4clPVk80deBD+g1Y=;
        b=LS4bjH/6ZIWrhyUNDYmmLGVDdaBNZMsV3omQGhN7HCk/RvfJVPVyywRTzNdbPPuBNP
         eArPvsZ6RulbAb6paxtA60+FooWDu9/ML6DEkuvG5d4LzTJayTp6cfDwLxjZ3hpPirQp
         c4SHrGin5euOD0ChH7MMGX95bB5FEIeTfxMlMDjf+azmR2RpkMrbxO/Yxsmu59a9CWWI
         dciJrIcwRUln3HEktJFtIr3lDb83/O+bjmWPwmVpv1eyZtRVD7pip7rVE6WMaQVQwKZJ
         mh18h6gwU1F1zjpJxoCStiYtCd86QQqIq6aDMKNTVrzvaPxiwszCAR2ig6u+1Ip3c3+e
         JBXQ==
X-Gm-Message-State: AJIora9b3LGpTPXh7C7/+9uZ5AkBAyCVKU92nq0cSUJjHuq7ScibB78A
        UzAT1Tfw0V0kLXMqo+TeSPyfPuOkgNHtUTWv/J73a4uN+Qk=
X-Google-Smtp-Source: AGRyM1tEg9RcoPDzQ0HUZg42icoAq3a7h+ylR6/AYWxuzRcKugx0qE8bC4/Qd5pG3DV7+vMU9z8cSABFuJOWgKoH1W0=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr2961375ybs.93.1657279797818; Fri, 08 Jul
 2022 04:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com> <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
In-Reply-To: <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 13:29:21 +0200
Message-ID: <CAHp75VcgwMBeo_q1rH3rt=Ax_AmzBeM2CAWXkCYwwhYdhCquZw@mail.gmail.com>
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

On Fri, Jul 8, 2022 at 12:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 11:03 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
> >
> > Add strsplit_u32() and its __user variant to allow for splitting
> > specified string into array of u32 tokens.
>
> And I believe we have more of this done in old code.
> Since all callers use ',' as a delimiter, have you considered using
> get_options()?
>
> > Originally this functionality was added for the SOF sound driver. As
> > more users are on the horizon, relocate it so it becomes a common good.
>
> Maybe it can be fixed just there.

Forgot to add that we (trying to) don't accept new code in the lib
w.o. test cases. get_options() is somehow covered. If you have
different test cases in mind, do not hesitate to add!

-- 
With Best Regards,
Andy Shevchenko
