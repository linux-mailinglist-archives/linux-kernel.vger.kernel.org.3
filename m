Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517C25A8C12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiIADvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIADvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:51:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1BD162161
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:51:39 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eab59db71so24932349fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FMeFb1DKNrRW4XTw+2AUilPkuq6lPd1YD7bO8dxWl6s=;
        b=ByOcugM+LZVu3LuzIKRmYBcj8KWgL4G7ve6wG4Vn0qoJvpyjNqGF0cyV+0oQVj7j58
         WuNe3l77T9LEvgoTH+w7H1pVPIyGRZAaOiV1cWXfChXXsm1LZtefpsIDIE7RvVLSHA4f
         Wwwtd1IJ+y9eB1DG61eaolq0kyWrCQv+OjXE96DdxLqMuGv+MTUo7sGPj2UM53rtrPNS
         swQqutm5fJ2lxDJEiVMUsXVk4UPO0w2tb57hyw/N5GafGbIsLS1fSXSIkj0D9QWiPh1D
         ESk93IMou7GCvFIDeupXNfI16QVMICInA28JP8OLxS4wdsluU5KnQDK0kBPi3XZxl4Zj
         wCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FMeFb1DKNrRW4XTw+2AUilPkuq6lPd1YD7bO8dxWl6s=;
        b=hU64d3bmvBH59hu4VyC2c/Add065FTFwLunzJ3Cpm98CzQ9rDdU6qUdz5NjrbjkOX4
         V7uVAl4Xyva4t7dpNaW+hsH+rZDAP6FUYoRdWaByjYnW9iOJfsunkVsab+w7EbwdD++x
         opXogJVR2uwH6r/xgYt1f3qn2qhTnCQRSxFO3BsLfTq0QE0MHaxr15VjQ+kwGbrt+e2J
         Dxgr0By+Ka4ElyI6pcPYZeJ0TgeBMrNPXt8+LCni0Xa8UJ3S+8a8VFhX6u5AOW8iHRvW
         OJtchm+/FIQa1kLeZONYl+hZlmKP/IFSTCrtYqEk+3ecuE1pR3XreWsaHJnS1hTKNKWn
         03ZQ==
X-Gm-Message-State: ACgBeo1jLp5QRtEZsHjmz/qSLSRj5sC57/vuifYN/5aeym0te4Ar/KBK
        M7FLq0pHAPJiBsdSpb1fd+k=
X-Google-Smtp-Source: AA6agR4p7F4GBqihoJuFKRYYOZ0Wb+JZLdStHGZEH7IwD5hH4fmexnWwUavQ8c9sZGSy6l7Zmza78A==
X-Received: by 2002:a05:6870:3127:b0:11c:8c2c:9015 with SMTP id v39-20020a056870312700b0011c8c2c9015mr2880965oaa.31.1662004298634;
        Wed, 31 Aug 2022 20:51:38 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id p5-20020a4a95c5000000b00448985f1f17sm9033176ooi.9.2022.08.31.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 20:51:37 -0700 (PDT)
Date:   Wed, 31 Aug 2022 20:49:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
Message-ID: <YxArx4UGoSQXljQd@yury-laptop>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
 <Yw8hJS9f6SofG4/6@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw8hJS9f6SofG4/6@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 01:54:01AM -0700, Yury Norov wrote:
> On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> > The compilers provide some builtin expression equivalent to the ffs(),
> > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > assembly which produces better code than the builtin
> > functions. However, such assembly code can not be folded when used
> > with constant expressions.
> > 
> > This series relies on __builtin_constant_p to select the optimal solution:
> > 
> >   * use kernel assembly for non constant expressions
> > 
> >   * use compiler's __builtin function for constant expressions.
> > 
> > 
> > ** Statistics **
> > 
> > Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> > of __ffs() and ffz() calls (details of the calculation in each patch).
> 
> Hi Vincent,
> 
> Can you please add a test for this? We've recently added a very similar
> test_bitmap_const_eval() in lib/test_bitmap.c.
> 
> dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
> assertions")
> 
> Would be nice to have something like this for ffs() and ffz() in
> lib/test_bitops.c.
> 
> Please keep me in loop in case of new versions.

Also, what about fls? Is there any difference with ffs/ffz wrt compile
time optimizations? If not, would be great if the series will take
care of it too.

Thanks,
Yury
