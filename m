Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDA4AD9E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiBHNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbiBHNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:31:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FAC008632;
        Tue,  8 Feb 2022 05:30:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s13so52195895ejy.3;
        Tue, 08 Feb 2022 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zn8j9RvF8sN37KxxL6wEwSYmGl957jUTVtDp4sYAYew=;
        b=GNeIrOwpq1o9cmnL4aXmZbDPovCccFuZVp2HgvOAeqdz2H28ScjkM7nTfLEtv/FQIZ
         tspj1jK84yz0jdp/ghc02iuDEWdR3aukOC2Ou08ignbMFR5/MqoSjAcQF+NGPSXiDTc9
         9R9S+jfm7PM9WwNEYR+JGSTrZJcpuaepSKkqlA99WKZq1t30ZWOWv9Y4CBglag2oEVu7
         jEfU2NYDE/f06qPYmcvIc/tJMsb55QIH06qaKXQAiTaKH3LkaEIq9xCNM1XbSHsPIWrJ
         DR427Ys4ZHrBj+EkJKhDrr3V6p9tN2/UsWwKSid5SBZPzmHEqV9sgMsb629TKg4rUw3y
         GN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zn8j9RvF8sN37KxxL6wEwSYmGl957jUTVtDp4sYAYew=;
        b=fEQrhFN5JqRvRlkMw+Yc6fvZ3M4MYdlXEHAGHMksGlhboSDdo582ZXQesC5SGvE6sk
         7HJu004nJqj8DuKwCieICmDltiSZla49QNzTZvm1DiwuxLYuMsPhlBu6iZHmyIIEc5GS
         TeyDySm8mEwhPOt5gj+3jzk0u6I624oNeWECfkrAr3J2KJ/ypSoNSiyNlFr+eZN4mZJt
         shjJ0Ofs3eCbu3Bj6qk4npWc9IbxXIpoTazodD5A6wREepoHMVLxyGMCJbHDq8PksRMD
         OtfcgraYdiPWDszqWWtOVBKDhkGOVgZnkrU1/1HB4plunRDnXghUl3uZXap8Chx7Jjus
         iEKg==
X-Gm-Message-State: AOAM531qFvFRF8yqE7A9WC29zRIHW+1e8N9z2y47uEh8/mm7/jd03W8A
        j0GbgJ7w41ZHg8QsANZo1jMdYGEzBS6eywI2LWg=
X-Google-Smtp-Source: ABdhPJwUqqSi96+UE8xWbPqPBedxmQQZyjz6mzdVGlsakiJaBzjT5+Uul5wvv6Z5WzgwE+zszvPH1wk6bNn/QbK0xZk=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr3619855ejc.579.1644327007184;
 Tue, 08 Feb 2022 05:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
 <YgEv/MIydfZlL1zQ@smile.fi.intel.com> <CAMRc=MdrTuJiRhxPvhuos02eDc3eUS1fXNJr2xwCCG9C82tAVA@mail.gmail.com>
In-Reply-To: <CAMRc=MdrTuJiRhxPvhuos02eDc3eUS1fXNJr2xwCCG9C82tAVA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Feb 2022 15:29:31 +0200
Message-ID: <CAHp75VcKEjRE5qGAoMf07PG9+tMDP60W5DsFSpcYQmGVgLiu8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] gpiolib: A fix and a few cleanups
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Tue, Feb 8, 2022 at 3:16 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Mon, Feb 7, 2022 at 3:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 01, 2022 at 05:27:54PM +0200, Andy Shevchenko wrote:
> > > Patch 1 is a fix for wrong error code to user space.
> > > Patches 2-4 are small cleanups.
> >
> > > Can be routed via my tree, or directly into GPIO, whatever maintainers
> > > prefer.
> >
> > Bart, if the series is okay for you tell me which route to take?
>
> Queued the first one for fixes and 2-4 for v5.18.

Thank you!

-- 
With Best Regards,
Andy Shevchenko
