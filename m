Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8951EAB9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350464AbiEHAlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbiEHAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:41:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FEB2B;
        Sat,  7 May 2022 17:37:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q4so7914137plr.11;
        Sat, 07 May 2022 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=arUH2MRVxEf8vhAeq3i8+iP+btufOwV/ehc3jq4WcgU=;
        b=p11ukt8Ydp2k3YtnsohJUeCg3245UiJ/gHETAXz21sVatEaeSLC7j3QFTHQBscVBUp
         fgCd7feTwCVK3V4p2D0W4grttv6jIRhz514Y8rPOfg1ygMKm9opOmMjwmmKd+vBwSN7F
         bIMzqgY9p9Q2SrJfVjRuhHbOY0Vb0W/YTNVxlb7CvNla1+xXLKB2pwBT345GuVALoPjD
         btUTaGbkMFdpsXWAb55rXJVoIj2lMZvyFc6YeXSD0ZYe5SCUHBfqQ2ogErpf5xf/36+4
         1ufegU1gvlSIuKkXA3qIetAxQ7WrZ9CGoTyTPGI+ORMiBfvOjEnBArunp7KhgiHgiK87
         Pg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arUH2MRVxEf8vhAeq3i8+iP+btufOwV/ehc3jq4WcgU=;
        b=I9KR5VwSVNUQ5glfYJ1z+mH8tBP94e8siymm4tPg5moBFEq+9nyfKiwvfmuivpB4/0
         KDvHVnL3u1YoeKB0QAvvIPfA3vytLW5ozf7pKRv0DUj96LMy8ArhIEwSOijfSueEllNf
         inY3JGLZusZ9gnfOvUNEdRCVabH14ULL/euv6N2KerZ+yJGGiBScDsjxjLA47YoBP19x
         8paRtM1Ck4VuUKmj2wJVXRkcV3TPtConNE8ILzVMgl8sgecZjE245EpPfcHhtjxeketD
         CdbyIOXh7OSBqAihJK+UMYYoTxIzhD9lrwe+c1heK9/HBpyiagNJNKdYf4XyLBoYU+gF
         bSPg==
X-Gm-Message-State: AOAM531qPttFkjKFPRugsOOf/LQagHZ10qVLBDx9ZukKHHIW1xesm3nA
        e0Ri6PhQZun59ErqmmH9fR4=
X-Google-Smtp-Source: ABdhPJwLlAmDIofQb7jE/g+VMSVHar3owskWZ/EMG0HUf496uiLDgk4O2m3XYmugmFA8Z827riK8VA==
X-Received: by 2002:a17:902:f68d:b0:15e:bd3c:43da with SMTP id l13-20020a170902f68d00b0015ebd3c43damr9894794plg.164.1651970248880;
        Sat, 07 May 2022 17:37:28 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b0015e8d4eb222sm3341599pln.108.2022.05.07.17.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 17:37:27 -0700 (PDT)
Date:   Sun, 8 May 2022 09:37:26 +0900
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
Message-ID: <YncQxl1shpH5TpbK@antec>
References: <YnI7hE4cIfjsdKSF@antec>
 <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com>
 <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
 <CAHk-=wjLRo-6PbhbvMUDojbMo=L+2jc5VpCYTyF-LGxZPhUngA@mail.gmail.com>
 <YnLkYjOF2vEOdjOo@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnLkYjOF2vEOdjOo@antec>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:38:58AM +0900, Stafford Horne wrote:
> On Wed, May 04, 2022 at 01:10:03PM -0700, Linus Torvalds wrote:
> > On Wed, May 4, 2022 at 12:58 PM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > I have uploaded a diff I created here:
> > >   https://gist.github.com/54334556f2907104cd12374872a0597c
> > >
> > > It shows the same output.
> > 
> > In hex_to_bin itself it seems to only be a difference due to some
> > register allocation (r19 and r3 switched around).
> > 
> > But then it gets inlined into hex2bin and there changes there seem to
> > be about instruction and basic block scheduling, so it's a lot harder
> > to see what's going on.
> > 
> > And a lot of constant changes, which honestly look just like code code
> > moved around by 16 bytes and offsets changed due to that.
> > 
> > So I doubt it's hex_to_bin() that is causing problems, I think it's
> > purely code movement. Which explains why adding a nop or a fake printk
> > fixes things.
> > 
> > Some alignment assumption that got broken?
> 
> This is what it looks like to me too.  I will have to do a deep dive on what is
> going on with this particular build combination as I can't figure out what it is
> off the top of my head.
> 
> This test is using a gcc 11 compiler, I tried with my gcc 12 toolchain and the
> issue cannot be reproduced.
> 
>   - musl gcc 11 - https://musl.cc/or1k-linux-musl-cross.tgz
>   - openrisc gcc 12 - https://github.com/openrisc/or1k-gcc/releases/tag/or1k-12.0.1-20220210-20220304
> 
> But again the difference between the two compiler outputs is a lot of register
> allocation and offsets changes.  Its not easy to see anything that stands out.
> I checked the change log for the openrisc specific changes from gcc 11 to gcc
> 12.  Nothing seems to stand out, mcount profiler fix for PIC, a new large binary
> link flag.

Hello,

Just an update on this.  The issue so far has been traced to the alignment of
the crypto multiplication function fe_mul_impl in lib/crypto/curve25519-fiat32.c.

This patch e5be15767e7e ("hex2bin: make the function hex_to_bin constant-time")
allowed for the alignment to be just right to cause the failure.  Without
this patch and forcing the alignment we can reproduce the issue.  So though the
bisect is correct, this patch is not the root cause of the issue.

Using some l.nop sliding techniques and some strategically placed .align
statements I have been able to reproduce the issue on:

  - gcc 11 and gcc 12
  - preempt and non-preempt kernels

I have not been able to reproduce this on my FPGA, so far only QEMU.  My
hunch now is that since the fe_mul_impl function contains some rather long basic
blocks it appears that timer interrupts that interrupt qemu mid basic block
execution somehow is causing this.  The hypothesis is it may be basic block
resuming behavior in qemu that causes incosistent behavior.

It will take a bit more time to trace this.  Since I maintain OpenRISC QEMU the
issue is on me.

Again, It's safe to say that patch e5be15767e7e ("hex2bin: make the function
hex_to_bin constant-time") is not an issue.

-Stafford
