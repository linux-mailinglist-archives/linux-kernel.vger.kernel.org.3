Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07349585F92
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiGaPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGaPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:43:45 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C6EE31;
        Sun, 31 Jul 2022 08:43:45 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b7so5460624qvq.2;
        Sun, 31 Jul 2022 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=O5fzJKCKvnX543t55GLgI6tA3O4NIA7ad+898Ffse3w=;
        b=Etnt1m5zuKR7W4Ju2lEurqp8fzpduFBeky7nqg+H8/w99ulQw9mPGAZ88rMEYpUtvb
         DsG0wi5u/PVmZdn9ThPe6VK1eHEW/hLFuSNvnrJuw5ZR/Z8VH8U5V34UaxFwuUoJSbjq
         5ot5k1jShAufGKZn255i7BVZXCHmnGNlfbC4GzO0kOkEyQkXLLVKK840QbSB833fH0+B
         JmpfOjY/w4k4dAe6n43y4gNc7pqipGhNRS1a6N9EWyknRMRVMB9nFJ1gbskQ7WzNkR+8
         HJSg6zJy3/t7WBtS84D/VLLXp2CYZcg+KWhFKwn0XG2wmwYA0DdgXWGohm37kWU/Oem2
         PZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=O5fzJKCKvnX543t55GLgI6tA3O4NIA7ad+898Ffse3w=;
        b=yjmY1xs3UpOiMbtWVVCpB6drG37AKpf4JphExPJwregTW1xUzzNH0LIZSs1zTKUF17
         INcmnQMnttIbez2MyLjWctRjpCnYJfxBCHxF0uyJaH0sbS2WKz4YtJHkXoW1ei4Q/Lyr
         X7SuPnNcDuLgI3eURKpSNce+beLLev1CKmRg/ulYnOikB1Vvj+PHrkayHiVC/bruX2JS
         x6LJhY8IBHOjozXveJlTmUI3Ic9cxYW5mANa14A0m/qg51I5t0aewKJA1YXW+vqWCN8H
         oJc89K58ZBr0QlyxHJ9Qe3B9wMPR7bX1HGQA0VGeRf3lqw1+5qmzk/L1jS+DbRoCFLg8
         RLdA==
X-Gm-Message-State: ACgBeo2LzVPEqJxa5hOi8bIPdoeD9MlvR0YICn2BXifNUdC8RMPz+dIT
        EFWGDWAn+40RId5ZK/y3v3uZ1X/bOgM=
X-Google-Smtp-Source: AA6agR7nm+uPqXgj2bad1CM22NDQbm1CSaTYIGyvrjFVHd9F581P1hgO8deF0JcPA9ncVixpciPiKw==
X-Received: by 2002:ad4:5be6:0:b0:473:9831:541a with SMTP id k6-20020ad45be6000000b004739831541amr10912305qvc.118.1659282224233;
        Sun, 31 Jul 2022 08:43:44 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:ac7a:fe76:f4fe:fa32])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a0d9600b006b872b606b1sm5050082qkl.128.2022.07.31.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 08:43:43 -0700 (PDT)
Date:   Sun, 31 Jul 2022 08:43:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 06/10] lib/cpumask: move trivial wrappers around find_bit
 to the header
Message-ID: <YuajMOuaGYBihRaK@yury-laptop>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
 <20220706174253.4175492-7-yury.norov@gmail.com>
 <9383b9b62a15ba6f91af5adb0b0b1dd90ac1a3df.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9383b9b62a15ba6f91af5adb0b0b1dd90ac1a3df.camel@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 11:42:52AM +0200, Sander Vanheule wrote:
> Hi Yury,
> 
> On Wed, 2022-07-06 at 10:42 -0700, Yury Norov wrote:
> > To avoid circular dependencies, cpumask keeps simple (almost) one-line
> > wrappers around find_bit() in a c-file.
> > 
> > Commit 47d8c15615c0a2 ("include: move find.h from asm_generic to linux")
> > moved find.h header out of asm_generic include path, and it helped to fix
> > many circular dependencies, including some in cpumask.h.
> > 
> > This patch moves those one-liners to header files.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/cpumask.h | 57 ++++++++++++++++++++++++++++++++++++++---
> >  lib/cpumask.c           | 55 ---------------------------------------
> >  2 files changed, 54 insertions(+), 58 deletions(-)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 760022bcb925..ea3de2c2c180 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -241,7 +241,21 @@ static inline unsigned int cpumask_last(const struct
> > cpumask *srcp)
> >         return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
> >  }
> >  
> > -unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
> > +/**
> > + * cpumask_next - get the next cpu in a cpumask
> > + * @n: the cpu prior to the place to search (ie. return will be > @n)
> > + * @srcp: the cpumask pointer
> > + *
> > + * Returns >= nr_cpu_ids if no further cpus set.
> > + */
> > +static inline
> > +unsigned int cpumask_next(int n, const struct cpumask *srcp)
> 
> This also drops the __pure speficier for these functions. Since I have a patch
> that does the opposite for cpumask_next_wrap() [1], I was wondering what your
> reasoning behind this is.
> 
> Since a cpumask like cpu_online_mask may change between subsequent calls, I'm
> considering to drop my patch adding __pure, and to follow the changes you've
> made here.
> 
> [1]
> https://lore.kernel.org/all/06eebdc46cfb21eb437755a2a5a56d55c41400f5.1659077534.git.sander@svanheule.net/
 
__pure is a promise to the compiler that the function will not modify
system state (i.e. will not write into the memory). Now that the
cpumask_next etc. became static inline, there's no reason for the hint
because the compiler inlines the code, and there's no a real function.

Maybe then it's worth to propagate the __pure to find_bit() helpers...

Would be great to get comments form compiler people. Rasmus?

Thanks,
Yury

