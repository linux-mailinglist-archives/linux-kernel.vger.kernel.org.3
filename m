Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F5487F9E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAGXwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiAGXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:52:07 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF7C061574;
        Fri,  7 Jan 2022 15:52:07 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so7107799qtx.10;
        Fri, 07 Jan 2022 15:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aU8/5mVKlEMT/Qttq5O3DrV9RFJs3vfNMkN1OVYl94g=;
        b=T4+XCh3ftAIzbtt6LmDGuXNGec6C43LntQC5i7/C8HYKmZwGU4u7r24REaDJeSEtA/
         zR3ebKwPeraqdH4kX28aYgydtUbXPLe4W+7F7I1+KX5EhGyLX1WOt5c6HDgaRNzEXQZ3
         B5BOx+wOgekab4gN5/tQrRjVKUfRA3mk4SDwbuPpSFBr17DfkCivQfbIuCehRQD3uPfs
         mldbt//G5L6ADXvSYeDQfCMjnmFoTLzcHVL69TVir+Uw1LNlW38+51udxrZ+nB3kA0Ae
         xduGQX5iqtsLr4/y5XrblwVQw1psd0C/oextHRYqE0k7bS0GhK2WV5eqiasQZlHSoG1q
         El1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aU8/5mVKlEMT/Qttq5O3DrV9RFJs3vfNMkN1OVYl94g=;
        b=XGx6aQRQPBDG7Hde2iuguFipXz8X5hzA9Te23QgdDT+P7hkN6FsBZuSZIgWgm+n1uN
         l3FFUiNHwNxE4lY+lREfuXfSDsE+rC1JKH+8epYe6InsG23aj5hGSZlpgd8/2j1ddrWR
         DUjaosJcCZgIev8bIF+JXm35UqX+4vU1qdyMACp46Ij6D7yxgQJc937CR1hgua3fuV/l
         n8tfwBIXbuUf2IX6NjD6NLxQZnrdmGyXsiHY2NeIk7mzVrO42gE6JCe5NMb+TVshCbej
         9S26Y6iESpmgKoqhmJAkhnVMBo7TWj8cDjlVvXAUypohdJNjchlkKMvMVtBJi1Jgstx6
         EpGw==
X-Gm-Message-State: AOAM533zktX+u48kvWbHOumaZxWBqleWeYWQ3VnnhtNLDbwFabXhmBut
        ROPgQeb6zS+aO66YytDDiaM=
X-Google-Smtp-Source: ABdhPJzVrNtO+yZnVgnRKPZ02xfBJ44/6rIzZC/wm4x6y67anqWEKcF9mt4dRk2NK9iOVHJEVPvm+Q==
X-Received: by 2002:ac8:5942:: with SMTP id 2mr55955504qtz.239.1641599526268;
        Fri, 07 Jan 2022 15:52:06 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id m20sm93186qkp.112.2022.01.07.15.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:52:05 -0800 (PST)
Date:   Fri, 7 Jan 2022 18:52:03 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdjSI1R9qdnYHFNB@errol.ini.cmu.edu>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
 <20220107170616.2041589-4-gsomlo@gmail.com>
 <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu>
 <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
 <YdivZYknD2IQ1Wzy@errol.ini.cmu.edu>
 <CAHp75VfMJyeF4dpz63TqZv9UCMBWmQu0U622SOV7wLmn7Qm0mQ@mail.gmail.com>
 <CAHp75Vfo=uJ3eY0GtjdjTk32KkaQfOFYw6kF5oZqQLb38AnhbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfo=uJ3eY0GtjdjTk32KkaQfOFYw6kF5oZqQLb38AnhbA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 01:40:06AM +0200, Andy Shevchenko wrote:
> 
> 
> On Saturday, January 8, 2022, Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
> 
> 
> 
>     On Friday, January 7, 2022, Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> 
>         On Fri, Jan 07, 2022 at 10:50:02PM +0200, Andy Shevchenko wrote:
>         > > > +             .of_match_table = of_match_ptr(litex_match),
>         > >
>         > > You said "Wrong usage of of_match_ptr()" here, and all I have to go
>         by
>         > > is a bunch of other `drivers/mmc/host/*.c` files that use it in a
>         > > similar way, so can you please clarify and/or provide an example of
>         how
>         > > to do it properly?
>         >
>         > First of all, you have a dependency to OF, try to remove it and
>         > compile with OF=n and you will immediately see the issue. You may
>         also
>         > go for  `git log --no-merges --grep of_match_ptr` and analyze the
>         > result.
> 
>         Ah, grepping for "of_match_ptr" was *never* going to show me the
>         "right way of using of_match_ptr()" :)
> 
> 
> 
>     Hmm... this is strange. The above command is grepping in the commit
>     messages, and not in the code.
>      
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=
> grep&q=of_match_ptr
> 
> Shows a lot of the commits that I referred to.
> 

Right. I was originally looking at *code* for current usage examples.

I get that you were referring to grepping through *commits*, which
seems to be the new way of figuring out what's canonical (as a lot of
the existing code seems to be in need of update :)

Thanks,
--Gabriel
  
> 
> 
>         OTOH, grepping for "of_match_table" (and of course the commits
>         returned by your command line) suggests that I simply should *not*
>         use it at all, and assign its argument directly to .of_match_table.
> 
>         Got it, fixed it, thanks!
> 
>         Now, on to the probe ordering issue... :)
> 
>         Thanks,
>         --G
> 
> 
> 
>     --
>     With Best Regards,
>     Andy Shevchenko
> 
> 
> 
> 
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 
