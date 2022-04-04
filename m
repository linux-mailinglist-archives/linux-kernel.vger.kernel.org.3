Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96AE4F0DBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377014AbiDDDb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiDDDb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:31:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1E32EC8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:30:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e16so14763224lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d7Lm3Nfq8vbKY5cOsivkRl3TUfMD96ByCU0pXJf8Rg=;
        b=dVZOYMCNYVbZdQUv/6fck2MjgKW2NHEUS9guds8X9XRmxc3M1zMZyeINasWP1GmkTf
         gl6x/9vMdkaftthvtkQwNT1ScXDNdpfXfDkSzZ2H+JOPlgh3TpluJB4HDfrafwuzErG9
         OcSbpw/Nn6NdEIe3jcAXzn947O6Qo2gAtiV2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d7Lm3Nfq8vbKY5cOsivkRl3TUfMD96ByCU0pXJf8Rg=;
        b=1nNvXoZB7QfKI4SJzCXQxx+DZzCdGjUtu7yHQD/j/y7aKEWpPC6DVXJ6K4bGx0eA+C
         qtRj2JopKD7bD5xwe2yk3e7xOBKZBsyWvf+/yXbrMtza3R3nwscBSP+Bwc8JTkfCpWZJ
         2i78pbTxAJB3IXJ+uhrX2GV9G5Izl6j4R+V5gXWrI5U7fY0DusNUV3MgyqrCkT5Pd2xA
         8qxlHRdm1UweZtFNj9HlddFXy74SueKMaePZ9XNh1IgVkTs1Cr4BwI2tUG0iVQX/iTH4
         v2WArhkxtvq/7+mp7ddKYpJlLV2wBHzxQY8vG8sVKdSsp74arp/blxga2Eg0MZjMwLa9
         fjeg==
X-Gm-Message-State: AOAM533zw5/imD1VAx8wRiL5cjetAwKMWxN4tU4B0/yNqo3qBr324eCR
        aTFRORbo8nnSlPRxcDEPmAVyABj/10rCav4t
X-Google-Smtp-Source: ABdhPJzQ2+XytKRCE7U74XBBL/QMLUzMqOGas0SNLpopUtoXsJO0hknbejyS5Or88GoksGJ0taWeVg==
X-Received: by 2002:a05:6512:b19:b0:44a:b7c4:3d94 with SMTP id w25-20020a0565120b1900b0044ab7c43d94mr18064165lfu.358.1649043000587;
        Sun, 03 Apr 2022 20:30:00 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0044b075cfe89sm192962lfs.148.2022.04.03.20.29.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 20:29:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bu29so14924916lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 20:29:58 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr18280486lfu.449.1649042997395; Sun, 03
 Apr 2022 20:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
In-Reply-To: <20220404022239.GA1186352@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Apr 2022 20:29:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
Message-ID: <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
Subject: Re: Linux 5.18-rc1
To:     Guenter Roeck <linux@roeck-us.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 3, 2022 at 7:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> In function '__nat25_add_pppoe_tag',
>     inlined from 'nat25_db_handle' at drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
> arch/alpha/include/asm/string.h:22:16: error: '__builtin_memcpy' forming offset [40, 2051] is out of the bounds [0, 40] of object 'tag_buf' with type 'unsigned char[40]'
>
> Exposed by commit e6148767825c ("Makefile: Enable -Warray-bounds").
> Fix at https://lore.kernel.org/lkml/20220403123628.3113382-1-linux@roeck-us.net/

Funky. Apparently nobody else does that pppoe_tag thing, and this
driver does it wrong on little-endian, which is the common thing to
test.

Your email that you point to is a bit confused, though, in how it says
"when building the driver on a big endian system such as alpha".

Alpha is little-endian, not big-endian.

Now, why it apparently only warns on alpha, I have absolutely no idea.
It should warn on other things too afaik, since that

        tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);

should be visible not just on alpha.

Weird. But your patch looks correct.

> Building arm:allmodconfig ... failed
> Building csky:allmodconfig ... failed
> Building i386:allyesconfig ... failed
> Building mips:allmodconfig ... failed
> Building parisc:allmodconfig ... failed
> Building powerpc:ppc32_allmodconfig ... failed
> Building xtensa:allmodconfig ... failed
> --------------
> Error log:
> drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
> drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>
> Fix at https://lore.kernel.org/lkml/20220401151450.3414694-1-linux@roeck-us.net/

Gaah - both of those "(u64)" look pointless.

Either the thing is a pointer, in which case that (uinptr_t) - or just
(unsigned long) - is the right thing to do, or it's already an integer
type, in which case castring it to (u64) just do do that

        phys_pg_pack->pages[i] =  ...

assignment seems entirely pointless.

So I think the patch should also remove those pointless (u64) casts.

Yes, yes, the pages[] array in 'struct hl_vm_phys_pg_pack' 'pages[]'
is of u64's, but casting integers like that is just silly.

> Error log:
> drivers/tty/serial/mpc52xx_uart.c:967:23: error: initialization of 'unsigned int (*)(struct uart_port *)' from incompatible pointer type 'int (*)(struct uart_port *)' [-Werror=incompatible-pointer-types]
>   967 |         .raw_rx_rdy = mpc5125_psc_raw_rx_rdy,
>
> and many similar errors.
>
> Caused by commit 18662a1d8f35 ("tty: serial: mpc52xx_uart: make rx/tx
> hooks return unsigned"). Reported at
> https://lore.kernel.org/lkml/20220403153607.GA3644508@roeck-us.net/

Jiri - apparently you didn't convert the cases under CONFIG_PPC_MPC512x.

Please, people, let's get these silly problems fixed asap, and not
have people unaware of them and fixes pending until much later in the
rc series? It was painful  last release, let's not repeat that
mistake.

               Linus
