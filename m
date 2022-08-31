Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125035A798B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiHaIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHaIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:54:15 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D1CACA5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:54:03 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11dca1c9c01so22670492fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=kbwQHOUbQlR2/mm4JOyIlKOeCQ9N4lWFC645O8AgNso=;
        b=gWIE9RhdeOCDBJtLJCy1XVNrbAt1QEQNcT07eNtDEH8QP7EiVD9C/KlBVzImYNkXP/
         5NbpegxB/4gnzxWoXRiltGyRH/9CSvUP8yYjYXUodceWmVAgCThud9abMMSJmEStzRPd
         wMSIDWWD35TY8VCadpb9/pARVc7nl+t+jbv7o4Adysz/L4L5HWQaVsdasosTf2KxaSOd
         P54BAtUPm8mSHhim/ZT8JLitAkfZ0gPLjWTw+qU3ygdkz/xaYgAHP1ElLmDe/iw5HViM
         RluvYeTSYb/flZUMNyjn7jwlwUPcAJR5lwC72rMBUoJw8X4de87t8xe3T7IfKR3Ivg0A
         ZepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kbwQHOUbQlR2/mm4JOyIlKOeCQ9N4lWFC645O8AgNso=;
        b=Guiw2l1paJdQXHm5x8qeLDuMRySyc6l/eq3fDpK0KmuFvtJOS4J+L8WGOHLhHgkCY1
         KXtNExr+hULy+62MhN585XdBCh8csYS5HEhzxM2nNz+NDntvPuHvO9UWR0/VZSmO5iwj
         qniJ08eVHzvmfiNELHhdMkSTjfFJzqHb9qUOf7mnfaTxZa/j4F2BDY2leAxofe0TXjrt
         VtiGmF5K16rTXODe7llsWmHiNRj/AmePOyZfhP9YvJWdcaXsHsRG1hp9I68sVFsvO6Ou
         RzZMEkRisnoweHh4stx6zdmcqA7Q3qA+xhT1kTjRsZkEFVVwU1iOYiBtJXem80gM4LX7
         tZ2A==
X-Gm-Message-State: ACgBeo2j2cVlMXA5Z/iB4n4cEqnfvzxb9ec8+GE22MivggkyaeGUP8aX
        GPiKrVqHaSS/ErkbveEGSyo=
X-Google-Smtp-Source: AA6agR5a1ByJW1wvGG66gF57NFjg4g2yXXwvd903j2PM6zbyv5lIeFnwvL+0yibjTq7ehcwtYfUQ1g==
X-Received: by 2002:a05:6808:d4d:b0:344:863a:36fb with SMTP id w13-20020a0568080d4d00b00344863a36fbmr793701oik.235.1661936041628;
        Wed, 31 Aug 2022 01:54:01 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r7-20020acac107000000b003352223a14asm7201510oif.15.2022.08.31.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:54:01 -0700 (PDT)
Date:   Wed, 31 Aug 2022 01:51:49 -0700
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
Message-ID: <Yw8hJS9f6SofG4/6@yury-laptop>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> The compilers provide some builtin expression equivalent to the ffs(),
> __ffs() and ffz() functions of the kernel. The kernel uses optimized
> assembly which produces better code than the builtin
> functions. However, such assembly code can not be folded when used
> with constant expressions.
> 
> This series relies on __builtin_constant_p to select the optimal solution:
> 
>   * use kernel assembly for non constant expressions
> 
>   * use compiler's __builtin function for constant expressions.
> 
> 
> ** Statistics **
> 
> Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> of __ffs() and ffz() calls (details of the calculation in each patch).

Hi Vincent,

Can you please add a test for this? We've recently added a very similar
test_bitmap_const_eval() in lib/test_bitmap.c.

dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
assertions")

Would be nice to have something like this for ffs() and ffz() in
lib/test_bitops.c.

Please keep me in loop in case of new versions.

Thanks,
Yury

