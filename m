Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414B59682D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiHQE2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQE2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:28:52 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47713ED49;
        Tue, 16 Aug 2022 21:28:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32a17d3bba2so202164647b3.9;
        Tue, 16 Aug 2022 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Fd64ZTYpBZ+RIWsrdcx55o1cFYfsxNqJQSrJeLxKjSQ=;
        b=Ad99UETspLmbHH9gsu+1FAFTvXlfJoLpaNP0OL9t4xxoVylZiSsMLzp4nPYGIA1UFH
         IOKL84hR+P6bSU7poN6ScvoslZBqCCZJ+q/m/a3E+GfVFccj2tMmQaejOqlhVckdRP2K
         5/9xgAqY2UHzw7qhAf13K6clzbiIjuZIaU9rLdrg2XKbT27K6Kn7nQXLXk6No6K9C0q0
         3d/ppwe3m4L4fPgoXWluWqPvm1Y7d2cz6MIvl/hxiWZkTiTtseK7FvlK4sQobx0QkTNJ
         3X89MouRVjqTxcepKwydY0yX7qth747/NNwCTIg0LL55+5UtSw6tC3MfVpOTZXRRo7al
         TUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fd64ZTYpBZ+RIWsrdcx55o1cFYfsxNqJQSrJeLxKjSQ=;
        b=wHzCIo/8XqRcHdoL2HaPXJwd1sG5qFOxcIAIF6aNctQURvqm653AfZqkms6XGbL0+1
         4KBaHC4usPnpEAY5JvjEzwCbI5+LoSiCiwE2PSPZmy20B8qd1MkqImVhD5UG7XL//Mlq
         JgAU6KJe6RQifr8Tuga8LWR0A5nCa8INbR3KcqTmkYy+6pkQlmLN7vyrYsOr8kHsQmoo
         OspdT3QetlfRSGO/iBufPB6QhO/rLosnx/YVun4yD+ie3LGk9U4vWpcPV9Gu/nQ3/vW+
         1ZNFKO8KHSQXLwAaHcijxVZEqG2IjQtxQ2ZJAgnCzC7yew4h2GcMVWrNL7eQGA5B4loO
         vBbA==
X-Gm-Message-State: ACgBeo1HhuVeoDyMwkgip+dvyeDwEuIDRLF66s3iaLOPQj7Thsgb5zZx
        acDsmgJZc9Ld1E+PxCZViB4onvZVCeq3U4ajAwI=
X-Google-Smtp-Source: AA6agR7r3Vz1IkV8JjjkI722lpR7xQMTMFPwTM97y2R48sSD8HSCg6dN1OoUe4zjtP1cNX3v/pKyZCb6n0V55d2IfQo=
X-Received: by 2002:a25:6885:0:b0:68b:b381:facf with SMTP id
 d127-20020a256885000000b0068bb381facfmr7872999ybc.318.1660710529892; Tue, 16
 Aug 2022 21:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
 <20220810050712.9539-2-lukas.bulwahn@gmail.com> <d8930edf-d138-6ef2-81c3-ff4d9003066b@suse.com>
In-Reply-To: <d8930edf-d138-6ef2-81c3-ff4d9003066b@suse.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 17 Aug 2022 06:28:39 +0200
Message-ID: <CAKXUXMx2HvR5SYxpvH3=LSzv_v6S65n-F4FyUSD=STpAgSYcOw@mail.gmail.com>
Subject: Re: [PATCH 1/4] xen: x86: set the config XEN_512GB after config change
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
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

On Wed, Aug 10, 2022 at 9:07 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> On 10.08.2022 07:07, Lukas Bulwahn wrote:
> > --- a/arch/x86/configs/xen.config
> > +++ b/arch/x86/configs/xen.config
> > @@ -14,7 +14,7 @@ CONFIG_CPU_FREQ=y
> >
> >  # x86 xen specific config options
> >  CONFIG_XEN_PVH=y
> > -CONFIG_XEN_MAX_DOMAIN_MEMORY=500
> > +CONFIG_XEN_512GB=y
>
> Does this actually need setting here? The option's default is y, so
> it ought to be turned on "automatically". Hence I think it's only
> the stale line which wants deleting.
>

Jan, that makes sense. I will send a patch v2 to do so.

Lukas
