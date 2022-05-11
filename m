Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D595233C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiEKNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiEKNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:16:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D13737A5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:16:54 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTAJl-1nMUMU0DoV-00UdE7 for <linux-kernel@vger.kernel.org>; Wed, 11 May
 2022 15:16:53 +0200
Received: by mail-yb1-f176.google.com with SMTP id w187so3966666ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:16:52 -0700 (PDT)
X-Gm-Message-State: AOAM532/dDvQKDpwLCOgmwSH+TtWgbkKI8ts7F5Ocm0MkP1vvLWG5Y+C
        a+ImcpXf6nVmx9rSmxuAu7VHGsD64mdo/EecOgY=
X-Google-Smtp-Source: ABdhPJzjzK2c0HYzD54ViFfsViBA7dUBZkZuUKLlDcXKMgucWge5xfkzz8FPcF+ReJpaInrLq2KkRZXy6+IosZ2mHrU=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr22788047ybf.480.1652275011850; Wed, 11
 May 2022 06:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220506192957.24889-1-nick.hawkins@hpe.com> <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com> <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck> <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1AG5RXW74LbskwMh1yJzXUjrzdL=iqaVz_7W2hExVuGw@mail.gmail.com> <EA4DD6D7-4A9A-41E1-ABE3-B1F3A60D973E@hpe.com>
In-Reply-To: <EA4DD6D7-4A9A-41E1-ABE3-B1F3A60D973E@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 15:16:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3zvF7f1Fo_toLT+iTNzG5Vih+Py69tRwqa8A3Xe2KcVw@mail.gmail.com>
Message-ID: <CAK8P3a3zvF7f1Fo_toLT+iTNzG5Vih+Py69tRwqa8A3Xe2KcVw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
To:     "Verdun, Jean-Marie" <verdun@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9osd6HXrVeui4eqaWcqRurITB5ajinHJAKfBKuRPpNoYAKsW+W/
 qcFACKV3tYwm4QSGBFGljqO+AMo0dxZK9eFJ7BBZ7hZyDNuHvRQT17/bHb2+KD8RGAAYWBc
 Rgt8a11AdcJedIPkxZ1GFDZ451iT16rQvqeVK5eA+ofaFiS9QFocqQw1ZKbI2K2FoFnYmz8
 OOaW8eWJSFd2GYyssSeWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJhK7GQ62to=:Ku4VcZ822jMpFcCI/ebfFq
 fCayE3iUywaANWbi1CWBYOO9YL5SsMyoGzM4lzDjA4CjnU+NGr4GndMXw/QKfxWcRDbzCTTUk
 frLIKcSFaA2GTBsGXLBVLPsHlaPUWdiPKzn3/E9UgpF79cxZbw3Pt7UbtkiWz5berxQ+zFrzV
 2J3cUBprsxbg8hxY+6c9G1rtdCuzra0fnfTrn862rJ7Ekmg+ke+KJXFL25CwhgzRFwTdMZgIX
 vL6OQHR0tQabtpN2qrZALJN1ZwZmGqjVstk5F2NUFWJJfmQmxgwmPQBXRS6lE9ZvbcIcdTjro
 sPt28BJWJ/w1h8oaRAGK573E/PvK4oZ4eKoXq9jKcsGdLvN2zLS9B6NUMN5fZnKvOpG91tA8K
 Jr7UzyCKxyt2N6iaYHbAVSHHTuAkH7nOiGWTwvsLpSNjfZnpu6zd6UGVocjaMGtCkrJzMXhBk
 d87XkpLF3CDKHDXTzWKWMS0bTzDOStz0Mbw0m+TcB53iICovybIn3RO/sv4dnSAkNY22tCYeF
 4ipyY0fkNVfbcFtvcHRIRiNRk94ULvsDcqgHdyw/lWRCfLnm4FTefacrjmHSlvh7urDloBTt6
 2yTaH2NNfX94FGusoETZ1JZUECEFLu7JnJE6/uKsztyVkFsIitThG7u1odfU4ycAs/saVrgxn
 qzHiUPdnJljcP13NTpDNnP8BU+Xc9l2ewEm7OmtEinhzpn83g0NHaXXSocdBAWSZ3zRS1MN5K
 fbAI0k5EwnvV6kl3w57HYTJF5QmKc4ADjXq+4LJoPFAmu3FMu13f2s8UTsfnYH9oD7s3x8+1K
 aQXEdi5pzFCcSRHItdIHuS+luk+H/7XSGJUMF48f9lPIFEjoqI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 2:59 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
>
> Hi Arnd,
>
> >    If it doesn't work, then there is no point trying. You could try
> >    changing the exception
> >    handling so it searches the ex_table for Undefined Instruction
> >    exceptions as well,
> >    but that's probably more complicated.
>
> I looked yesterday evening and share Will's point of view, I don't
> really see how it could work and believe unfortunately that
> we have to stay with the undef_hook approach. Let's us know if
> you believe some improvements are required to the current patch.
>
> Let's see the positive aspect we learnt something, and if we have
> to face additional issue, we have that option open.

The current patch looks reaonable to me then, please add

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

and submit it to Russell's patch tracker at
https://www.arm.linux.org.uk/developer/patches/info.php

with one small change applied: the 'oslsr_fault' variable should
be marked "static".

> Side question: Does any of you will attend Open Source Summit North America ?
> I will be there with Nick and HPE team to introduce our GXP Asic during a couple
> of talks. Would be great if we could spend some time together.

I have no plans to attend at the moment.

        Arnd
