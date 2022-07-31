Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341858611C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiGaTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:49:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EF9590;
        Sun, 31 Jul 2022 12:49:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p5so11348435edi.12;
        Sun, 31 Jul 2022 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N/fgYXwtU9ATVuR/a6UTkauiOwtD5IjK7Z7No2h6JmY=;
        b=XUJi5S2pt4s6/mXFpJrDtt09UnCecXOA3G62a9Po7x9bgx2dAOdiMJ0UjWmIQmBf8X
         q/hb4guqpEOuoReC/TaDbPkngYM/7wkgfGn/sZCWQzqmHb/8x/fjfoGcoTtjfaka23y5
         NMIj8DkR/s4i2gUXDQQKfbL1CNHQu+l3HVkmTZNa5S3ue0iTY0goaCzVHnO/GzQuYb3X
         AjVzCkJLiMIaG5ZlPPzevM66Hp1+pKpoOZWoAQ8ZENwgIyR2R/F5gFhyyy7qXaeZl+CV
         g9wGyODUWWbmV7giWTmEtZjVj13wRzN07VKLoxwcIInPYablalUZ0qzzO7Wp/euHMziO
         3LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N/fgYXwtU9ATVuR/a6UTkauiOwtD5IjK7Z7No2h6JmY=;
        b=SNxdskB5tP/Iz8IVb/rzvAzdq/vYIHrc3Lsaffd9RoFtj523X7RsLrp2aI8ZdmVEA3
         xTI+Ndeiltq8FKoMK6xlE3AWlmrRw/Pk1Sd3bwpwT5gdklXMb5I+rt2acowmrpH6HH9I
         aOpUnfrcXEiPrSVFPLXITSoPLJHTRDQDpZhiDocK0gWUOCim6idu1JdmEdbTPS/cXsK0
         1mU0sdjz8nPm0vTs9CpoJBJ7rNx7niaomNXnPTAytj17/o3e4hH6qD4zg50LCGC/kRuJ
         DBHNPbOlRqZwfNsYDXYDAM/qGIaMzszL/5Dk4jb7a7Rb5ai79wYzUNT9olB2DI/rvZuk
         /vaA==
X-Gm-Message-State: AJIora/jenyODseuenB9bklBZqAH8ZYokp8YNi0sxcc8e76oFFiFCpBI
        H7zxyyLyeeqyD+c9kkdn8xRos6kJQm6XzMYJx+c=
X-Google-Smtp-Source: AGRyM1tdF/IXXgLemI/0Vwlxn4hxsB/HhIZp3GYv+/dvfHBNiTvBJOFNpdSVFaUVpfgGpioOHcP2+VCM+J/gA7mYF2o=
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id
 b10-20020a056402084a00b00426262d967emr12209415edz.286.1659296988720; Sun, 31
 Jul 2022 12:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <7c3918d7cce9643414697cef02ef636f05efb003.1659266359.git.christophe.jaillet@wanadoo.fr>
 <CAHp75VfHBvpy-u766n7A8HYEcWBZGrqsyi2mOnh96oPTSOuVdw@mail.gmail.com>
In-Reply-To: <CAHp75VfHBvpy-u766n7A8HYEcWBZGrqsyi2mOnh96oPTSOuVdw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Jul 2022 21:49:11 +0200
Message-ID: <CAHp75VfwOEyFENgj8C+nPpgYmCw39s5Sg1jrLaCV-RHob0EVPQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic: Fix an error handling path in intel_soc_pmic_i2c_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Shobhit Kumar <shobhit.kumar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
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

On Sun, Jul 31, 2022 at 9:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Jul 31, 2022 at 1:19 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > The commit in Fixes: has added a pwm_add_table() call in the probe() and
> > a pwm_remove_table() call in the remove(), but forget to update the error
> > handling path of the probe.
> >
> > Add the missing pwm_remove_table() call.
>
> ...
>
> I guess it should be rebased on top of [1] which I assume will go into v5.20...
>
> [1]: https://lore.kernel.org/lkml/20220718122328.8287-1-andriy.shevchenko@linux.intel.com/

...And now I realize that I have sent some BS there, heh...
I need to send a v2, so I will take your patch as a precursor.


-- 
With Best Regards,
Andy Shevchenko
