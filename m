Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBF51AF73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378209AbiEDUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378158AbiEDUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:42:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E050049;
        Wed,  4 May 2022 13:39:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x52so2017880pfu.11;
        Wed, 04 May 2022 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iPsQSqw38DosWcjT864uHfOF3XMxzmipGYiJZY97a+Y=;
        b=HeKz8oHH+fsEnc9s5lWFq2PGnWyNSnGkB3GsCOSICh3Cp4xpuN0zvzcUvI23k1GPpH
         nw3mWSQDbM8My5I3049IDKSslQGytio+8Mu1v/GyBvMuMQ4trIchlQB3blQaFDUoWw56
         5MOYSYmdvCw3gVpi1BZNreXBJKLNjQ5H95BZjS/NaV1sI8mkk9qQFg/chvTR0o8j0X77
         gWdUHFVhXgV47R3enUr/M301Ev/8EL3kPPiJ2WjX0OyLFy63ukkqt/cQgyXTSyjZ9Hsk
         XvI0+0qvOAJO6jLRoAnXAXhUuommEQpTTf4YhnLO6lhcIcblnVFKApPdGCMZMpQFDR5B
         3q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPsQSqw38DosWcjT864uHfOF3XMxzmipGYiJZY97a+Y=;
        b=FOw185EkRC2nmhe88VRknzEbWWmvWcRSUd6K55vzttqvEkr+zkgg0SyYFFFpmVq1w6
         xkhqkX9qTFtdQiYCyqGUnVQGRq0BjxchbRQQK0p8QXGDGZEZjwHQ6qXkHQ3ogyqKFXQ1
         jC7YcRA9ghaQIRis8Nn78zhHk5SVtinUxdO+1QIM1uzbNtC2x3eYJlCCP5u9+Sp97Lcb
         Ry4rVLaJBW4vluD+oQAgXij4Da5xztYw3fUfqINwzP8dYES/PeD+XeGubIj/7hielvV3
         1LEr3dwT1BGic1IuMGPJ3CxJiegOwx+3/1EEMPve+3wG/C93Cxk9GyV1i9Bn80nOvp/L
         HchA==
X-Gm-Message-State: AOAM531H+KaWyOdPhnpFf6MvHxGW8P2HRZnLj6SevF+f97buBMbnqMIt
        CN6PkvUf0eZU97qJ4PNMH6fw2uW0YPTamA==
X-Google-Smtp-Source: ABdhPJyT72f6GCu/Hi0foCbtIUf3rGveJmsZaXeGY5CnNpUoYWUQwAfMmEBdDiFZ9ilZNTjq67JcTg==
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id l14-20020a637c4e000000b003808ae9c975mr19713757pgn.25.1651696741592;
        Wed, 04 May 2022 13:39:01 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y11-20020a62b50b000000b0050e0a43712esm3644774pfe.63.2022.05.04.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:39:00 -0700 (PDT)
Date:   Thu, 5 May 2022 05:38:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnLkYjOF2vEOdjOo@antec>
References: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com>
 <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
 <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:10:03PM -0700, Linus Torvalds wrote:
> On Wed, May 4, 2022 at 12:58 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > I have uploaded a diff I created here:
> >   https://gist.github.com/54334556f2907104cd12374872a0597c
> >
> > It shows the same output.
> 
> In hex_to_bin itself it seems to only be a difference due to some
> register allocation (r19 and r3 switched around).
> 
> But then it gets inlined into hex2bin and there changes there seem to
> be about instruction and basic block scheduling, so it's a lot harder
> to see what's going on.
> 
> And a lot of constant changes, which honestly look just like code code
> moved around by 16 bytes and offsets changed due to that.
> 
> So I doubt it's hex_to_bin() that is causing problems, I think it's
> purely code movement. Which explains why adding a nop or a fake printk
> fixes things.
> 
> Some alignment assumption that got broken?

This is what it looks like to me too.  I will have to do a deep dive on what is
going on with this particular build combination as I can't figure out what it is
off the top of my head.

This test is using a gcc 11 compiler, I tried with my gcc 12 toolchain and the
issue cannot be reproduced.

  - musl gcc 11 - https://musl.cc/or1k-linux-musl-cross.tgz
  - openrisc gcc 12 - https://github.com/openrisc/or1k-gcc/releases/tag/or1k-12.0.1-20220210-20220304

But again the difference between the two compiler outputs is a lot of register
allocation and offsets changes.  Its not easy to see anything that stands out.
I checked the change log for the openrisc specific changes from gcc 11 to gcc
12.  Nothing seems to stand out, mcount profiler fix for PIC, a new large binary
link flag.

-Stafford
