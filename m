Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956050C68A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiDWC1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiDWC1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:27:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F61B5302;
        Fri, 22 Apr 2022 19:24:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y20so19569047eju.7;
        Fri, 22 Apr 2022 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqZdE0u9CYPlQ6MQcqOeN4oZEKzgzl5ZlEVKxJ+FAHk=;
        b=OE7s3CPe37nMb1dGmVaIey7JbUtRJ7f6vav2gncQroL5ziOpNrqKAczdsVbRdftZTp
         lvDGoua7DfR0a3ih2mXvBGp/pr8YIwFWvJ7rYtm1KItJ7lzb7bsnCbr0XO6Al/bLSqmY
         wShQ3Q4PeDbaGhthAQmvyUaYMWSIREyHdWzLfIHLlO4xqjeROrsWMsY/13vozvUovkD1
         TOAKaEV8j7EP/9ImivPEP7f9+9yBUR0jy0QdxfQqm1cDoP57+Iq+yV30nc+nepkuJNn4
         1e6bTF9LZV27/+Lsu7KDZ5aSI6QmdhEq2BG3Q9STkKqaymG9HXWUrXc+hO38EBpNkLCd
         yQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqZdE0u9CYPlQ6MQcqOeN4oZEKzgzl5ZlEVKxJ+FAHk=;
        b=J6Pp8w0xhTdRSm1ODUYS0bBxI8ISFH88psRrVam2XqS+LkPWGfpXKHd5K2dFAdKd2v
         7we1UD+5/mB0Y0CnDS8toO21KkSkeAf1KWLA+r0ydF+7j0I6jV/fkOU1xcAohKxUOLR8
         CPLrtNCvLQd2j25PZGF7ueoPm6o0rLNbMaMetKeAjp/O12zgyEnXVDCCdbRIavjSbjyH
         jE+XTazQlpY5zj4mjOByNFBwJNYyZbWNQBTURnGNi1WqnHnBnKqndcwHXGNN881Jxws6
         EmFnKY1rr1cl3vIf7wPqGKodaQlVEekxhjdT8rgKJoh5V00l8z0+egYIfgVP9e6gbxzP
         nYRQ==
X-Gm-Message-State: AOAM530UQbATXHrDDldaYNK8a5OgaaijVwJIaNMuZsFY6LL7IOOZCxpU
        nbBTIZR01ISWvkCk5lfDMXY8P9mtN4C48XyWud0=
X-Google-Smtp-Source: ABdhPJzcIFiqsw8tqvA51BF/kojpRX8faca/GR9O0BKNi3Ttrspe1sgBeJ1OHPMIBfTzzBlAO8IBPBsJXGKx+2s4Z5Y=
X-Received: by 2002:a17:906:d108:b0:6e8:7765:a70b with SMTP id
 b8-20020a170906d10800b006e87765a70bmr6585155ejz.436.1650680660905; Fri, 22
 Apr 2022 19:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-12-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-12-Jason@zx2c4.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sat, 23 Apr 2022 10:24:07 +0800
Message-ID: <CACXcFmksd3cw+xa-c2gEdd4=96PO8GCCMF6q2d6JHnJum2LjiA@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] random: insist on random_get_entropy() existing
 in order to simplify
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
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

On Sat, Apr 23, 2022 at 6:37 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> All platforms are now guaranteed to provide some value for
> random_get_entropy(). In case some bug leads to this not being so, we
> print a warning, ...

Would it make sense to test at compile time? If there is no hardware
RNG nor a cycle counter, then the kernel should be compiled with
the gcc latent entropy plugin. Generate a warning suggesting that,
or even an error insisting on it.
