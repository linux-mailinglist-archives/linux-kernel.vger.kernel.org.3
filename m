Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692665232D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiEKMR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiEKMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:17:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEA4EF41;
        Wed, 11 May 2022 05:17:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso4785687pjb.1;
        Wed, 11 May 2022 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jloxkDrIBx1FQXB3WO3Zmzcd3Q83JGcMWSxebzbF80=;
        b=oU7QGwSElhyci8ZR/OTe9HHc5yH5oBDGLYBqdFuGP0A+UntWW+o126T+puwM3gGQaa
         s8eH+vRmefjW0g9a2Ld4jCTmsADSpVHsyopJw+86eX97RIJVO3ucW+e+tLOJJmhDdZTW
         RV+FZFJAbM0gbfYxUpn86RCEy/gt5mq0YZBclMJGrwklm7ecn0L4M2eLm0WRZQnZSILt
         HmrRTUfFcgUueejhcV96JGCweuRkh4YtPylbiTUDPezsvbnL9MH3jHvL7x9upNuWPH5x
         GTxrVTheyp2VgmmZy5FhNOWBP0e1+5Be8X2g9poc544EzW8f900YlCQk1RKHeJokUzDw
         Ij4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jloxkDrIBx1FQXB3WO3Zmzcd3Q83JGcMWSxebzbF80=;
        b=L3+7q9/bX7qiAG5UsKRHhSrbd6X4+KAegtT2P9F0DOrfLkovjKk8MOHp7DkseDJn/w
         05bCtkhl3xuQ8VdRV8BaFhoeIc0LOaU+42gEA9S+TCdO6IbHmElsw5GZZukIJEvUT+Jo
         +71JEk7P4ddxhe+vbClekaIXXLsHoe45JC3FEdhAv+SloPHDfdAtMqxdblmbajxt5ooC
         m317e4o8iFQL5fkAhDJ+EyOl/wjIE9hrcitYCNMQQCdC4KfoGT2Ra5T3V3A/FOjJtfHy
         c3QPXI8oqN6zJjnmOYrK8tVjufQyZ7vD6EbdYvjNiXnYY+b4hI+UPKqHcXEmgcw1NSl9
         UeEg==
X-Gm-Message-State: AOAM532Wvr+S1BRqYt5FPhLwFtiImqpM7vE/Bb5GgnvBwfD0tFyOvEEj
        b17EIFjNQoAGxWOhheLhbn8=
X-Google-Smtp-Source: ABdhPJxPUIzteam2t9wDpHP6nr06rCewsN5+gC9SkiHTFRp8pdZVPv3cYpJfFGaF/VpS85E2BKIFXA==
X-Received: by 2002:a17:902:9349:b0:158:a6f7:e280 with SMTP id g9-20020a170902934900b00158a6f7e280mr24853463plp.155.1652271461237;
        Wed, 11 May 2022 05:17:41 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015e8d4eb272sm1676730plg.188.2022.05.11.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:17:40 -0700 (PDT)
Date:   Wed, 11 May 2022 21:17:38 +0900
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
Message-ID: <YnupYin9knBu6c91@antec>
References: <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com>
 <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
 <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
 <YnLkYjOF2vEOdjOo@antec>
 <YncQxl1shpH5TpbK@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YncQxl1shpH5TpbK@antec>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 09:37:26AM +0900, Stafford Horne wrote:
> On Thu, May 05, 2022 at 05:38:58AM +0900, Stafford Horne wrote:
> > On Wed, May 04, 2022 at 01:10:03PM -0700, Linus Torvalds wrote:
> > > On Wed, May 4, 2022 at 12:58 PM Stafford Horne <shorne@gmail.com> wrote:
> > > >
> > > > I have uploaded a diff I created here:
> > > >   https://gist.github.com/54334556f2907104cd12374872a0597c
> > > >
> > > > It shows the same output.
> > > 
> > > In hex_to_bin itself it seems to only be a difference due to some
> > > register allocation (r19 and r3 switched around).
> > > 
> > > But then it gets inlined into hex2bin and there changes there seem to
> > > be about instruction and basic block scheduling, so it's a lot harder
> > > to see what's going on.
> > > 
> > > And a lot of constant changes, which honestly look just like code code
> > > moved around by 16 bytes and offsets changed due to that.
> > > 
> > > So I doubt it's hex_to_bin() that is causing problems, I think it's
> > > purely code movement. Which explains why adding a nop or a fake printk
> > > fixes things.
> > > 
> > > Some alignment assumption that got broken?
> > 
> > This is what it looks like to me too.  I will have to do a deep dive on what is
> > going on with this particular build combination as I can't figure out what it is
> > off the top of my head.
> > 
> > This test is using a gcc 11 compiler, I tried with my gcc 12 toolchain and the
> > issue cannot be reproduced.
> > 
> >   - musl gcc 11 - https://musl.cc/or1k-linux-musl-cross.tgz
> >   - openrisc gcc 12 - https://github.com/openrisc/or1k-gcc/releases/tag/or1k-12.0.1-20220210-20220304
> > 
> > But again the difference between the two compiler outputs is a lot of register
> > allocation and offsets changes.  Its not easy to see anything that stands out.
> > I checked the change log for the openrisc specific changes from gcc 11 to gcc
> > 12.  Nothing seems to stand out, mcount profiler fix for PIC, a new large binary
> > link flag.
> 
> Hello,
> 
> Just an update on this.  The issue so far has been traced to the alignment of
> the crypto multiplication function fe_mul_impl in lib/crypto/curve25519-fiat32.c.
> 
> This patch e5be15767e7e ("hex2bin: make the function hex_to_bin constant-time")
> allowed for the alignment to be just right to cause the failure.  Without
> this patch and forcing the alignment we can reproduce the issue.  So though the
> bisect is correct, this patch is not the root cause of the issue.
> 
> Using some l.nop sliding techniques and some strategically placed .align
> statements I have been able to reproduce the issue on:
> 
>   - gcc 11 and gcc 12
>   - preempt and non-preempt kernels
> 
> I have not been able to reproduce this on my FPGA, so far only QEMU.  My
> hunch now is that since the fe_mul_impl function contains some rather long basic
> blocks it appears that timer interrupts that interrupt qemu mid basic block
> execution somehow is causing this.  The hypothesis is it may be basic block
> resuming behavior in qemu that causes incosistent behavior.
> 
> It will take a bit more time to trace this.  Since I maintain OpenRISC QEMU the
> issue is on me.
> 
> Again, It's safe to say that patch e5be15767e7e ("hex2bin: make the function
> hex_to_bin constant-time") is not an issue.

This issue has been fixed.  I sent a patch to QEMU for it:

 - https://lore.kernel.org/qemu-devel/20220511120541.2242797-1-shorne@gmail.com/T/#u

The issue was a bug in the OpenRISC emulation in QEMU which was triggered when
receiving a TICK TIMER interrupt, in a delay slot, on a page boundary.

The fix was simple enough, but investigation took quite some work.

Thanks,

-Stafford
