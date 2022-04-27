Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815BB511F96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiD0Qxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbiD0Qxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:53:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C52386E8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:50:18 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f7ca2ce255so25592797b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCZms/64wZv98QDXbKPIUPXG0OpwNnN6Df097jc0aic=;
        b=S53PanKLcKrQsJL0uSDGCUtBFxMmATCvIDxQR5F80wkfIBe/deKz3sNqWv2b7qrG6f
         jMZ3gEwnweJbB3rX9Ts/EY5k1c5bn8H5j8oFKavxrzuNIZz161MeVXzpf2ugsJnOOnUz
         qrxFhxBJVEiVyZXRRXfB2ZAat8Evv8UVtBL959OwGbU45GJ1fOeV6L+5KX533ZeQ10hO
         NpJf8xmjcbqWi1K6yr7ShDb6kmL4jY+02vwsBlJ5Quv7ERgcJjIDgtrc7aItjxyiCCyU
         S63Hv+ShQDOZFzU3CEa06L6uDpshjW9NiiAipzQXIvabNr38T+yIWto7k+qWboogrjaQ
         sbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCZms/64wZv98QDXbKPIUPXG0OpwNnN6Df097jc0aic=;
        b=yiWgMhZV+velB/YNhqDOFPiTuoyKd13thlfmVn5nIhWP3UF/iQ9EizAruCy77ykr4i
         jie3rn7l6/Suai5vJmaZFflfNWEk5kTKumUlr7qbSzGUfp10ERyMztSw0XWAgTUK3nbm
         M0ztWNNXlattKBiXXB5wKPD8iDraXtoG9cFOXb/Dqmh5Ky2LFBVgAPNOLhj6LbxdXGCj
         j7ERhgtEjiky+mQXHRnI+samWScos2IGVYcPCkIPdNIsIFIGPiQITnVTLUh5dtFno2gZ
         wkz9wQj1Q3O3un9TinsKgfHdwI9OpV9WwHgZi3mvminR3B2ueB1pa6iWdD7BEod9uoZF
         PPqQ==
X-Gm-Message-State: AOAM5302IZio2cfAvlKfdflWf1yrjGtZfDqozN0ArUCU+USq7QIxoq9B
        KUPRtNHKAqNIwuhv4LTKsoVlZn2uxTZF6gmdyGfoyw==
X-Google-Smtp-Source: ABdhPJw3lntb1MUryPz0UopmIAM4JGQHXx3ijeRydsXUCGJOyWC9G7Qn1xrft5hJ+SRoZeDf58/cUlzCXqaJ3qY5XyQ=
X-Received: by 2002:a81:1d4e:0:b0:2f7:be8b:502e with SMTP id
 d75-20020a811d4e000000b002f7be8b502emr23533944ywd.278.1651078217583; Wed, 27
 Apr 2022 09:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220427065233.2075-2-w@1wt.eu> <202204271705.VrWNPv7n-lkp@intel.com>
 <20220427100714.GC1724@1wt.eu> <20220427163554.GA3746@1wt.eu>
In-Reply-To: <20220427163554.GA3746@1wt.eu>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 Apr 2022 09:50:06 -0700
Message-ID: <CANn89iJTg8KZvDQ2wY=psThvS5eFzv0N15FF3CTf3i6qui=wsQ@mail.gmail.com>
Subject: Re: [PATCH net 1/7] secure_seq: return the full 64-bit of the siphash
To:     Willy Tarreau <w@1wt.eu>
Cc:     kernel test robot <lkp@intel.com>, netdev <netdev@vger.kernel.org>,
        kbuild-all@lists.01.org, Jakub Kicinski <kuba@kernel.org>,
        Moshe Kol <moshe.kol@mail.huji.ac.il>,
        Yossi Gilad <yossi.gilad@mail.huji.ac.il>,
        Amit Klein <aksecurity@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 9:35 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Wed, Apr 27, 2022 at 12:07:14PM +0200, Willy Tarreau wrote:
> > On Wed, Apr 27, 2022 at 05:56:41PM +0800, kernel test robot wrote:
> > > Hi Willy,
> > >
> > > I love your patch! Yet something to improve:
> > >
> > > [auto build test ERROR on net/master]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Willy-Tarreau/insufficient-TCP-source-port-randomness/20220427-145651
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 71cffebf6358a7f5031f5b208bbdc1cb4db6e539
> > > config: i386-randconfig-r026-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271705.VrWNPv7n-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> > > reproduce (this is a W=1 build):
> > >         # https://github.com/intel-lab-lkp/linux/commit/01b26e522b598adf346b809075880feab3dcdc08
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Willy-Tarreau/insufficient-TCP-source-port-randomness/20220427-145651
> > >         git checkout 01b26e522b598adf346b809075880feab3dcdc08
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    ld: net/ipv4/inet_hashtables.o: in function `__inet_hash_connect':
> > > >> inet_hashtables.c:(.text+0x187d): undefined reference to `__umoddi3'
> >
> > Argh! indeed, we spoke about using div_u64_rem() at the beginning and
> > that one vanished over time. Will respin it.
>
> I fixed it, built it for i386 and x86_64, tested it on x86_64 and confirmed
> that it still does what I need. The change is only this:
>
> -       offset = (READ_ONCE(table_perturb[index]) + (port_offset >> 32)) % remaining;
> +       div_u64_rem(READ_ONCE(table_perturb[index]) + (port_offset >> 32), remaining, &offset);
>
> I'll send a v2 series in a few hours if there are no more comments.

We really do not need 33 bits here.

I would suggest using a 32bit divide.

offset = READ_ONCE(table_perturb[index]) + (port_offset >> 32));
offset %= remaining;
