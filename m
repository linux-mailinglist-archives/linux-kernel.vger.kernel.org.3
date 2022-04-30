Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2975160D6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiD3Wr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3Wr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:47:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8078845057;
        Sat, 30 Apr 2022 15:44:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o69so8577679pjo.3;
        Sat, 30 Apr 2022 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WX4CoTxj5/IZiX1L7qzvMLL4JHsZq3pvrgPiSDDmODg=;
        b=pn7kEkvBO2ikIdQXc9JP6FAWHDEViF116WVUTLu3IY6Afo1axbWMGXPRYEKTmjtls9
         BFE7ItYK2HLWdLursc7I8nxbe+GmGATN0QbN7ZB7QO0KizOb7K+c5+jt35v5ogDuubrk
         FdJ8NnttNXBFDCjKxfUUm7XNzWYvsjN1Fgn7sCKeH9NsVw+0D3G54TDSYBS2AezeWJ/D
         P8I+GW3FCJrp/dDheT+4Eqa3BDYHI00QEBw6auUASlzF26ZJQImVQJIplqUirUsmRviY
         uJkl+9UMvXjJZMocMtdkWqp5IhtUssS1/ZS3rKyiyufcisVAzvdUuaHqoTmywN2QT61+
         LOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WX4CoTxj5/IZiX1L7qzvMLL4JHsZq3pvrgPiSDDmODg=;
        b=k8+38PBpOFBeMv/Qj/Ut0SV7ZWDfWbhNLOES2FR8hhJR3ni3GazpRZViLQcAZ4wSHh
         SA8EdMmnKnP+cNHEerZZY7c8lfuf7iiUiwrMwiA4CtmPiHaC7Y285fNtLAA2xYaSU2Q6
         YFnkfZF24xQovi91p/Y6qrF94O7saaOqmXOKWQaj6U5yXx6w3sHNcyUlBw0Vcl5A3zbh
         j9cdnQVgLHgRe3iMCGb13n3XlzQ8Z/kvXdGdkczmwG7cjVlngkq/sh4FGOP0dI5dnyDM
         Nu2jas+jvdX4bSSdHiF6d/6t00a9GzUnxBy96QiCf1FW3oTUPaZgncvRwHnKqxTORNRa
         ULvQ==
X-Gm-Message-State: AOAM53207e5ZUuxHiOfZBCaUzr2MO2ZokIqrn73Qk/2xU4/XGT08UJLJ
        I0LJw/yVGACcm3g7zHfjUQBXA/d90Mo2pA==
X-Google-Smtp-Source: ABdhPJxXTIuoT2HiQVUJ1+hIJNM/ChvjLWl/VuTPbA4l2eJrvQ+IiH4A5GP24qciN65wUETHpAANVA==
X-Received: by 2002:a17:902:cecb:b0:15e:8bff:1495 with SMTP id d11-20020a170902cecb00b0015e8bff1495mr5422288plg.131.1651358642941;
        Sat, 30 Apr 2022 15:44:02 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id e7-20020a6558c7000000b003c1bf4c064fsm3223698pgu.72.2022.04.30.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:44:02 -0700 (PDT)
Date:   Sun, 1 May 2022 07:44:00 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 11/17] openrisc: account for 0 starting value in
 random_get_entropy()
Message-ID: <Ym27sFdFZEt5QV0i@antec>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
 <20220429001648.1671472-1-Jason@zx2c4.com>
 <YmyOh/YbgGJ3DK79@antec>
 <YmyRATzJBQX+wnIP@zx2c4.com>
 <Ym20Ga3VsJRzXppd@antec>
 <Ym25Wn1PtpNgkKyR@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym25Wn1PtpNgkKyR@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 12:34:02AM +0200, Jason A. Donenfeld wrote:
> Hi Stafford,
> 
> On Sun, May 01, 2022 at 07:11:37AM +0900, Stafford Horne wrote:
>  
> > I was thinking about this, the reason the tick timer is returing 0 is because
> > the timer is not started.  It's getting initialized right after the random
> > number generator.
> > 
> > A patch like this helps to startup the timer during intial startup, but I am not
> > sure its the best thing:
> > 
> > diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> > index 15f1b38dfe03..a9b3b5614e13 100644
> > --- a/arch/openrisc/kernel/head.S
> > +++ b/arch/openrisc/kernel/head.S
> > @@ -521,6 +521,9 @@ _start:
> >         l.ori   r3,r0,0x1
> >         l.mtspr r0,r3,SPR_SR
> >  
> > +       l.movhi r3,hi(SPR_TTMR_CR)
> > +       l.mtspr r0,r3,SPR_TTMR
> > +
> >         CLEAR_GPR(r1)
> >         CLEAR_GPR(r2)
> >         CLEAR_GPR(r3)
> 
> Yea, great, I was thinking about doing it in assembly earlier in boot
> too, but didn't know how you'd feel about that. I like this better.
> 
> The reason I think this is a good approach is that it means the cycle
> counter includes some information about how long startup takes from the
> earliest stages -- which could involve probing various devices or
> strange things. So enabling the timer in head.S seems good to me.
> 
> > But I wonder:
> >  - Why don't any other architectures have similar issues.
> >  - Is there any more correct place to do an early timer kick off.
> 
> I think most other archs (like, say, x86) have their cycle counter
> enabled by default at boot time. I was surprised to see that the or1k
> risc cycle counter comes disabled by default actually.
> 
> I'll send a v9 incorporating your suggested assembly change.

Thanks!

-Stafford
