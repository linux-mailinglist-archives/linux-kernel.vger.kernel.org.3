Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE348779F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiAGMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAGMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:32:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0437C061245;
        Fri,  7 Jan 2022 04:32:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h1so4767899pls.11;
        Fri, 07 Jan 2022 04:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aX15vcXEfaENKROZ/2of0+4S5a/GCCCjcMiAL2bj5pI=;
        b=njkBeIobxW6KB+Q6BlkJ1uXIYPRHhtIHmo69a0G5LngTBikhFI/KR/nP1YQcUBm8bg
         jMkIrWHjl5X/hzEQMvfClaiO6A8xPnoWd2edU8kjXnS/kJMZZxA+jmjC4W+vCz+Injpu
         NMGxDJWltE/N28HNkrMh0jsCUM8JYZOr8Uo36L/GoAEOvR9VnT2vqUvQETX50q8hQaTf
         MjxIOr5PR3/Q/GSuU+kzSAbOl+qmsBWpeMFD0/2l8r10bF0+T37hKRdpDaqQS6w4LCoS
         WvCGjoIIeS2BMKgDKrzNCQ6ln/XOWzXPf6YCubkXnfXKE4U+H6RhavvA4l/nJ8ggl15M
         zGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aX15vcXEfaENKROZ/2of0+4S5a/GCCCjcMiAL2bj5pI=;
        b=oiX+n2mhBg1KsLB/TVh1x8OnKXQXKyWZAM3NbXlTPGZvCzdgbdojf1nNx89DFTVbf9
         PULP0xjiloHdhTVvrsOqrle2xTmMlPipaPYDJipkNu+HJfz3GMFudFdJyIZqXphobKRA
         8jnLQiAtrhHipsZ5Mz4g3a2LmNd9scHvcwTtWWK8NPOpkoLdhssNpUJAkLSVdhHFl35i
         ogXU3LjbOQ4ek/E7K2WweFJOf5syaDHdSCi6cgkfQ5fZaNSdZgUwsVJ5dTHfq9aA9Aln
         58D/g2koDBEQA/m+VOKCqUd8rvsLM3N8o/TrLZzQ5MeC4tUJ0irQYSF/G7UqgTgX4ZxX
         QCsA==
X-Gm-Message-State: AOAM530METK7oc1WJWoKdNuqOsU01yCduzTt49m/LMdhvvy5E+H2DXkN
        JNb2801zzBNesFdxhfBNg0M=
X-Google-Smtp-Source: ABdhPJwYdHiMRO98i2rLiFl9Ft0Ya+T45NVrvwXwIMql0uKuhSCsZaTxgRSImDtnMnRi9h1gyG/JBw==
X-Received: by 2002:a17:90a:c68a:: with SMTP id n10mr1876007pjt.144.1641558741157;
        Fri, 07 Jan 2022 04:32:21 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t126sm4595721pgc.61.2022.01.07.04.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:32:20 -0800 (PST)
Date:   Fri, 7 Jan 2022 21:32:18 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ydgy0mCMJFkZqWAb@antec>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
 <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
 <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec>
 <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:24:23PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 7, 2022 at 12:12 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> 
> ...
> 
> > > Many (most?) blurbs do mention the module name.
> >
> > I was doubting this as well, but I searched and its true.  The text 'module will
> > be called' shows up many times, there is also different text.
> >
> >  $ grep -r 'module will be called' drivers/ | wc
> >    1347    9023   9086
> >
> >  $ grep -r 'tristate \"' drivers/ | wc
> >    7169   47486  521795
> 
> Just a side note: `git grep ...` is much faster in the Git trees.

Yes, it is quite a lot faster, I always wondered why one would use it rather
than just grep.  Thanks for the tip.

    < shorne@antec ~/work/linux > time grep -r 'module will be called' drivers/ >/dev/null

    real    0m0.338s
    user    0m0.220s
    sys     0m0.113s

    < shorne@antec ~/work/linux > time git grep 'module will be called' -- drivers/ >/dev/null

    real    0m0.153s
    user    0m0.205s
    sys     0m0.659s


> And for this particular case I dare to advertise a script I wrote [1]
> to help with recursive searches.
> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/gl4func.sh

Neat script.

> > So maybe >10% have module name in the blurb.  Example:
> >
> >           To compile this driver as a module, choose M here: the
> >           module will be called tifm_sd.
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
