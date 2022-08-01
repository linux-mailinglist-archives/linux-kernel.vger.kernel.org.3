Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35838586794
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHAKjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHAKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:39:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF67371A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:39:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so2173215edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2oZgFsPbP564TnDAd19aoDFaT2m873cI3rCH0wJnmfE=;
        b=T0/nFJyd/jtsmY0hN2oVp9DiTm/fU355tgbDbA42S79k/lP0BupKWI9zsli3nsDV0z
         oWKsEwIjYGE1f+qW7dPs28qwzPSWBpXna87hAmpyLAck/Y15ADxdPwzrsH2Sh5+tVYm2
         Cx4EuGe1ER3vhue1nbXAc9xiNxPVPpQXx1Z4SrQc4rN+bW3AtMZotC3sp84QH5DBzFR5
         XbX4GTXbOGCY6F0IXxKcfluqA6/cUy75gmL21K+4HbqQEkss2XPmIpaxYiLbDq5R888J
         HCaVoEqirpS97wtYEQdc+SJ8CVDxM7Zf+5aT12XhQjX8giM6s13wX2fB10lOydANqOOh
         01lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2oZgFsPbP564TnDAd19aoDFaT2m873cI3rCH0wJnmfE=;
        b=TejgyRD9sM7VTzykUyEEl/jIWUtfhX2+4juy50SxKSZahXd+dwl1gdOobsWRPpmyza
         OcjWwMmIQVJITxdyqZQKTJ/KEnnoIgO3k1pEtnYJ0JUFC9HwsGnASAgT+f4xWGc00bhW
         6Xw2wAET+6dOYjYi91tZkiTOOhPlng9/aZXA1jX7ug/LNhwn1CXrlXfSyYIohcxzg5/c
         AkRwiK26SB/sFI0Cr75KJzU4HMMrA8WQGyE0Vg+vn+g1wBYthTlpW87OMcm30KQc0+3w
         kuY9fi4FsuOB/kTYNli1PnhNbKbdF1YGkWqE3ptpr7N5mo/NH9VP/2lexrGI32zcXu3J
         A6TA==
X-Gm-Message-State: AJIora9mqOlmTXnhQz60oz38UEMLYEFgvigaFvg1zOrJiwrsauUsrQrP
        8O0+Nz7LuOgAnebAPz8GPoLv+31T4ka4CJ3FCOo=
X-Google-Smtp-Source: AGRyM1tmYFGwNiJmNe4S9gp4kmeL2ulpheaf2jkgGD3yu1ZCALn2cGxWNZA22Oq4P89kneJU0rTOY8dWMCgeS3FNJNo=
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id
 p29-20020a056402501d00b00437e000a898mr15348291eda.265.1659350347520; Mon, 01
 Aug 2022 03:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com> <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
 <CAHp75VcmuVcA_heURNh96zBDtpeNvx0t9buDOxnWNoea2G1uDg@mail.gmail.com> <98f1509a-2386-7c8f-cf53-cdb93990aa74@redhat.com>
In-Reply-To: <98f1509a-2386-7c8f-cf53-cdb93990aa74@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 12:38:30 +0200
Message-ID: <CAHp75VcYENL-LqJPzL4mY-cDkZ89m2MM=yRbs+_c4SjHMMvJ5g@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 11:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/1/22 11:29, Andy Shevchenko wrote:
> > On Mon, Aug 1, 2022 at 11:14 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>> On 7/31/22 22:12, Andy Shevchenko wrote:

...

> >>> Note alternatively we could just move the pwm_add_table() to just before the "return 0",
> >>> there is no strict ordering between adding the mfd devices and the pwm_add_table()
> >>> (the pwm device only becomes available after the pwm-driver has bound to the mfd
> >>> instantiated platform device which happens later).
> >
> > Just to be sure... How is it guaranteed that that happens later?
>
> Ah you are right, it could happen immediately if the driver is builtin and
> has already registered (if the PWM driver is a module, as it is on Fedora,
> then the driver will only bind once the module is loaded).
>
> Regardless there are no ordering guarantees between the probe() function of
> intel_soc_pmic and the consumer of the PWM device, so the consumer must
> be prepared to deal with the lookup not being present yet when its probe()
> function runs (*).

Would be nice to have, but isn't it the issue with all lookup tables
so far, e.g. consumers of GPIO ones are also affected the very same
way?

> *) ATM this is actually an unsolved problem and this works only because the PMIC
> drivers are builtin and i915, which consumes the PWM for backlight control
> is a module. Swapping the order does not impact this.

Even so, I think we can't change order right now because the issue is
much broader.

-- 
With Best Regards,
Andy Shevchenko
