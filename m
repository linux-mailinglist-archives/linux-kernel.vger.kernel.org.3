Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFE56BDC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiGHP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbiGHP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:29:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DA201AC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:29:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i14so18645764yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMEGxIrE4woAf5cnzkZ+3hQp7ZS3VGf+M1Bxpp05xRA=;
        b=ecaQUHS0lHe+xS7QeRj1P7pinsI/NrxvyEsdPWpDaG8YB0F0Gz5iEiFh9Ln9piexBw
         zQwkOUXEIc0AVVNGhpCiTO4NKOH6r0qPLtCr0wX5GBIgI6AjppwEqmpJ6EA45WJ7GniL
         H0cMz3WrgzTFVKC1UyQdBTLpO3kJ17s0sw0uPGMmQSrdlmq80M+yFSD1NuE9jEaBnymI
         Ff+/kJsyLWJ3zVjyZgsEau9JwoRRBMKgEwL7wpIWCP2wI9w0zmjWCToJ4h+VEKDTKIDl
         quGIcI3DxzcnjRkhNk83S6Gb79aPn+5X6FJWpwiFoxfQM4WzORdTLgDcc02w7Ir8g2Ww
         Te2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMEGxIrE4woAf5cnzkZ+3hQp7ZS3VGf+M1Bxpp05xRA=;
        b=pprOfhhHHMIeOz7PhKCyMUXKYEVoZU8UD2461D/vLWmsf6if5BjOt+iLRbb9CWQZcp
         tefKit0FJ+PGGxeoLV1Ef6jQkL2mP1FomuSfDmkwJR5IPCO2wNdKn1URo7xKwJW12HTF
         8WoOA0XzxUHM9K8Ms9P0hupITfl7L6qwHp8ZcJnnQ5BSxunNAJOSqYAYGHF+C0h9hKmw
         f37AydzHSfggUAHGSkrWsmqNVa0YRz8cKf6iwvLi6pVHTn4wzIyHrNhF2yZsdUeURow3
         A3QJYOM+a8DVuUJHTg/UCQcnouBtZyfSqpYGxoDr/yik5Db8hycOjMQBOMFkp02FZQD9
         TceQ==
X-Gm-Message-State: AJIora+qcmn7/RZLuEs/auG81tE4ioHS+6SC1zG1ZPaWsgsK1E8LpKqP
        mFFdh25+cePnmzG5l0eDE94ruEVHv8+/IcyiIbk=
X-Google-Smtp-Source: AGRyM1swmlKZ4XV6RN24eaRkZwJll3K67xeqgJ9qYHEzq8RVNfkeSaXb0i1fFJ5yeI+4TVhowP1eXn8EehYYfXKEa3Q=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr4250392ybg.460.1657294159638; Fri, 08
 Jul 2022 08:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com> <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com> <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com> <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
In-Reply-To: <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:28:43 +0200
Message-ID: <CAHp75VcUmy3xa3kKQSsiG84f3VWd83xt9ZTGnAdA3Ub1PJ7raw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 5:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jul 8, 2022 at 2:34 PM P=C3=A9ter Ujfalusi
> <peter.ujfalusi@linux.intel.com> wrote:

...

> (it may be casted to struct tokens { int n; u32 v[]; })

On second thought it is better not to do this (it will work on x86,
but in general it may be surprising on BE-64).

--=20
With Best Regards,
Andy Shevchenko
