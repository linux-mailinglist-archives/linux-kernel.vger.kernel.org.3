Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5B487E36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiAGVXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiAGVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:23:52 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78484C061574;
        Fri,  7 Jan 2022 13:23:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id f9so6067803qtk.3;
        Fri, 07 Jan 2022 13:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDIG8hlIPSgos1AEwZopFYwplEZE2Io0p9+mhy5BWpI=;
        b=DlTvOvYQdHxBwp9EYa8ixtLXU+8FnKJVOGqoNFqX9mFTUP5WsDGxZa4dl1VKu27xzD
         dKrbGfqL0Vk4INEoWjqzoCx70v49siHQqHmAPhYXFM5Jp6Ms9gChervONUPnspBn9OzR
         HuOJOEzAvxf/LxQjHVr21ErNt+2iwSDlJK+m6NpP+RRHxNxNE0Aay2DRpPQLVwrNkBav
         ZrtxcIOOgQ6DUsOH/zf9kZOnfnsN53QyPkEbJp0GJrGq/ubX+mdj+v+Ook2MunMgo2TB
         vuDlvzLI7oQHMPvf4/S4ujEpEx2vD3o9YKEmyzDzXR/IZ5fl/R7G+geFvL8xO/cEYnIy
         mBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDIG8hlIPSgos1AEwZopFYwplEZE2Io0p9+mhy5BWpI=;
        b=z5D2TsdoHWRWaITKid0/duamTzIkUgT0pMbDPv5tfv//D85pE7Q7db58FK+KUvDvLZ
         eSfvyqbVPiuTpUG1UotK00DAHtyl76yydLxSPk2NbkQeW8Dov1n5ASPvgZf5zgtz+DsF
         gez0oqOcSQTvhp/NnwYVg8FMELGTIVgUCRrKyJId1p8v5yrDYR+Qv8txKxjIItMRjH4O
         4zPa5kOdRMPziZM1pmqPpKJngZseFeuje1baGw+xxWrvZ2z+O+491QLUuRgGmPXDx5gh
         ZLCZvaNHGIsaQPXKa8ru8DhIrLJ0mDVg4hoiR8V51udJdCiGpcWPucoOSPNXyfwpbNKg
         MYAA==
X-Gm-Message-State: AOAM532ksX+KhGUTcEfhHANQAojLpcPhxCHM7t6TpDpmJuTlyI2euanB
        aQIVwfp/IZlBgCccMsUSR+E=
X-Google-Smtp-Source: ABdhPJyVNaqir9sjtRIE4vGqirwi2DyZw6Ta3kbEyPc0E3zFKWOFjGobWKR13SKYFNgBrdtwx8Ivpg==
X-Received: by 2002:a05:622a:1996:: with SMTP id u22mr57750521qtc.268.1641590631647;
        Fri, 07 Jan 2022 13:23:51 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id c25sm4309221qkp.31.2022.01.07.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:23:51 -0800 (PST)
Date:   Fri, 7 Jan 2022 16:23:49 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdivZYknD2IQ1Wzy@errol.ini.cmu.edu>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
 <20220107170616.2041589-4-gsomlo@gmail.com>
 <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu>
 <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:50:02PM +0200, Andy Shevchenko wrote:
> > > +             .of_match_table = of_match_ptr(litex_match),
> >
> > You said "Wrong usage of of_match_ptr()" here, and all I have to go by
> > is a bunch of other `drivers/mmc/host/*.c` files that use it in a
> > similar way, so can you please clarify and/or provide an example of how
> > to do it properly?
> 
> First of all, you have a dependency to OF, try to remove it and
> compile with OF=n and you will immediately see the issue. You may also
> go for  `git log --no-merges --grep of_match_ptr` and analyze the
> result.

Ah, grepping for "of_match_ptr" was *never* going to show me the
"right way of using of_match_ptr()" :)

OTOH, grepping for "of_match_table" (and of course the commits
returned by your command line) suggests that I simply should *not*
use it at all, and assign its argument directly to .of_match_table.

Got it, fixed it, thanks!

Now, on to the probe ordering issue... :)

Thanks,
--G
