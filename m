Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0351D4E3B49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiCVI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCVI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:57:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8E2B1;
        Tue, 22 Mar 2022 01:56:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j15so20628183eje.9;
        Tue, 22 Mar 2022 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESu1ATyCblde608Tp0DuuPKc9a1X1gmR6Fzw+AgUrmk=;
        b=qQrDeaja8bl0oisj01EGLO5y1cDJOtOGbLyYG0cq48n5xUVqw1R7+mirNxJTHjsw/q
         Sr/vezKjQ8oB6iAzW+V0BSX1HoPU/A1RE57JXbftIlWnBbborx2QruBSq1vAAFuz9PI0
         hAYEUc/afZI0qXPp8gHw4xvbjj/+wWxqYKSqqm3R5GLTASEOTpnu96W7NoDFKVD41tmJ
         8olgV+n5DuEtGugaljoGwlS7au3AqLmoG0/4oWk2m736xDvvsrCCIqdvTQz5BgM8QIHq
         5vupNtufNUN91zl4O8njzaq1LLIr6M3tbrJ6LBQrJmN/CcV9HAiofiHzvySaP6PkN02W
         MPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESu1ATyCblde608Tp0DuuPKc9a1X1gmR6Fzw+AgUrmk=;
        b=gjvuMOnzRujRBrijXmQ0f6xfi+QxREoXUnHdr/DxLTcziMCz7i1rdIGYdGpCWkR4KA
         iYYqJEIU11krg93IqGTeLPHCkM4WaMVo1//XbsWkl7QAJ+JquyHalgNNlDUJ/KmFuFHw
         BxUnMnXhVV3hjotvshdILRzI4S8MFCyGCheXgOH3qSegxxqk0IrZtwZKHsKKb0l48IkK
         eA2nwThWMIAXZ/P1zBh9JLGVp06BbfxAUdUUwu8hxCH0sNcRMAGSQ2bweld1gji/BMDA
         QKfbjGp61L7Yv6a5HfYrCCQ6lt94vTpU/k+Md3knBFXYEJMEkdGGa4gjL2onFay5vrQM
         20oA==
X-Gm-Message-State: AOAM5333SNOsOmcsMiAvxx8O7962CoyIqJ0yNGmdFDrVUY6SL/eLVAIx
        bs35nKcMRPsUtr+zLjow37x5+cCKIrKytcm7hF0OQIPUb4M=
X-Google-Smtp-Source: ABdhPJyE6x4vJmfYjVgKX9TWQhbzL5tJaJehalE0oDO2n4RWxskOJzVs1C+Z6TEW5+iUk6hzcROzeF26gahQv2K7eM8=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr24237516ejc.636.1647939363493; Tue, 22
 Mar 2022 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-4-jagathjog1996@gmail.com> <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
 <20220321222117.GD10058@jagath-PC>
In-Reply-To: <20220321222117.GD10058@jagath-PC>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 10:54:53 +0200
Message-ID: <CAHp75Vdp12bm+CHWun36b36Sui73zh0_wtY5YhEqVdNy4rUxVA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Tue, Mar 22, 2022 at 12:21 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> On Mon, Mar 21, 2022 at 10:39:22AM +0200, Andy Shevchenko wrote:
> > On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:

First of all, you left many uncommented comments. I assume you agree
with my comments and are going to address them. If it's not the case,
please elaborate.

...

> > > +out:
>
> Just to skip the below "if()" if error occurs in previous regmap read,
> I used this label.
>        if (status & BMA400_INT_DRDY_MSK)
>              iio_trigger_poll_chained(data->trig);
>
> I will remove the label in next patch

Just return directly.

...

> > A useless label. Moreover this raises a question: why is it okay to
> > always mark IRQ as handled?
> >
> > > +       return IRQ_HANDLED;
>
> Since I was not using top-half of the interrupt so I marked IRQ as handled
> even for error case in the handler.

Yes, but why? Isn't it an erroneous state? Does it mean spurious
interrupt? Does it mean interrupt is unserviced?

-- 
With Best Regards,
Andy Shevchenko
