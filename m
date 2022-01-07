Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E42487E11
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiAGVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:14:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6797C061574;
        Fri,  7 Jan 2022 13:14:23 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t66so7241489qkb.4;
        Fri, 07 Jan 2022 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=86bmCUO4/U0a6rfe/ONoJYDT8UB9ddOMRY07QyBxd1o=;
        b=GCOwZzZ5W5BcbBib85Vqi1ujWWtcLE27iRT9Z8cnGyPMWqFnLHljYYSZUgeo1JFxeb
         eNJmKJrWjdGcokG+SOoq+HZ8J2XRJ1ZtssqdjUyT1FphndgWYCSA0n0iJ3sy3ax5Oyth
         IHQ6iUz4LjxD7+l28sGBRxFbBQdtAtwuYA33Pq1QyMO+UBSWMgmAeSMTjyV0v50n4vtj
         l3E31iBUyriNNLalaLv9tzIwyC/hDsVwVmGKGmQ+Fr+ilsJ82fzJLkB6ARW1RD4+N99f
         bA8cL28Jargge43xh8U/ufeVzYtO9H37Fb67Z4dBPRv9ljPzX8HSYGUGD8gp8UDVzpJ7
         PjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86bmCUO4/U0a6rfe/ONoJYDT8UB9ddOMRY07QyBxd1o=;
        b=kG12YE7FcHwBl5o26vBm3CekyE0S70culeZuiUDry1EOsY6D8YD4N7n+pV8GQqHQVe
         +NG1NJ6n2w5AXyoGRd3ozSOfZNS4I8I/nPPUb8eEIaXyAJMhFFp18BSwoWgeQsS0FsiC
         wNYX6spoR8GtpgIWsf7JIi5DPcLam70oDJvgbYKj5MYsNCZvwXAr3tZFkKpwvRXMjoqD
         vOSA5fWM9HayXK9eFMyPNa/t8s6WdlfkEGFTwBbA1WO9NRbNVhw4dmhtAYWfQI2Ukkzh
         HYW5LOZZYjxIR4X60BfF2/cZnvfWuEDWrQruQiuW+B2Sxk9FZN6SPeliOZtBYKqlkWeX
         liUw==
X-Gm-Message-State: AOAM5327QCiUAMuS9cUciiEh2rw91jE6hPX5Fna0yx4W2LstDZKicRS7
        ZX58v7+5loa4UdinwtgilwU=
X-Google-Smtp-Source: ABdhPJxzmpCCj8uBAD4V5Nc9xbRrIiVMpXkV/b1Xv5womCk1laqHpqgz34wR9fupkQM+rf23/11QNg==
X-Received: by 2002:a05:620a:430e:: with SMTP id u14mr46230836qko.286.1641590062961;
        Fri, 07 Jan 2022 13:14:22 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id s9sm4219123qki.99.2022.01.07.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:14:22 -0800 (PST)
Date:   Fri, 7 Jan 2022 16:14:20 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YditLMRpj0BaG9O0@errol.ini.cmu.edu>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
 <20220107170616.2041589-4-gsomlo@gmail.com>
 <CAHp75VfBUomALtdhRXN-Z12RDAvLUiNHzazK0Mit6ExzRUTtRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfBUomALtdhRXN-Z12RDAvLUiNHzazK0Mit6ExzRUTtRw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:54:12PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 7, 2022 at 7:06 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> 
> ...
> 
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LiteX LiteSDCard driver
> > + *
> > + * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
> > + * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
> > + * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
> > + * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
> > + * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>
> 
> > + *
> 
> I guess I have commented on this and there was no discussion about the
> necessity of this blank line. I dunno what else has been ignored, so I
> will wait either for the continuation of the discussion (as per v6) or
> amending code in v8.

Yeah, not sure how that got lost, it "should have" been in v7 already,
but will definitely be in v8... :)
 
BTW, I also added the `bit.h` include per your explanation, and removed
all the `Cc:` lines from the commit blurb (not sure when it's actually
appropriate to put those in vs. just cc-ing people from `git send-email`,
but I have no strong feelings about it of my own :)

> > + */
> 
> ...
> 
> On top of that it might still be the ordering issues in the error path
> of ->probe() and in ->remove(). I believe we will likely see v8.

I'll need to follow your bread crumbs on ordering and `of_match_table`
(also in some of the other emails you've sent in this thread),
and will send out v8 once I've made some sense of it all...

Thanks much,
--Gabriel
