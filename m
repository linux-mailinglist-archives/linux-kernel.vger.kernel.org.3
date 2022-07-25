Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B485802AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiGYQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGYQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:28:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702641C93D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:28:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x8so6985139qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D9jayUJ70LH8CbIWJGpGOTA1AeV4fof3pzfT+UJy1Rk=;
        b=U4/ItNyNQNuRxXWqGEzyZ7n0ybqvDu/aedYL4Xh8lPayVkbetD172/WLCe6ohgzBG8
         ArIndK45c4NbVGzvhVyG2P8K2fPJzDwlJrTJrKWt2HMCrcXCPDq7IP62V7T4nxSU8r8B
         hZE9dTyCS0Qhk8XmCJ7OlqGH7BLbBHSHRHb6ekjoMZFBhGu3z693T2qhoi9L3pMoBhoN
         BToZQZKvRA9WB82ra5KvCz1vjCKOXkcZ0yDCF1OGPe2EbxGoOBcIx1sFiexxzpcIiXEu
         MbN3wmzKSTpHmN/cj8ldR4/0EbLSjUzEjS+ULTJCdVL3S6HbZrXCYNu8XkRKparUn66y
         ZyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9jayUJ70LH8CbIWJGpGOTA1AeV4fof3pzfT+UJy1Rk=;
        b=peNmVLGsq+53KKQMzyU3sOVj7iEjfqGRF78WhT89+nZ+gU9bvpO1+ENSpskbmM2blA
         I/Cbeg9fWNEoI7Rz9tqiP6yB+2+srgIE/hK2ZVQHT9E+HuasjDUkC/aeokN5Xr2wTbhi
         2kufqX06x7SIUN0JJD7F1cOSsdCv/sShqPhbuHADFrnufgxpE1gheSNUUhUj5iToOHxS
         aXo/+/QTXlX0AmevPa92CGCUMDlPnBoDowXh5psdoqeemRe2Ia/YvRLhJolFN5jpV9DR
         lh870eBJ9SIeHsAnYQ6tGoNaD4Yu1dEguQw69JVWrL+vu30pJoOpjsuM5PYvoCNo5H4A
         iZIw==
X-Gm-Message-State: AJIora9x58HC8VN8887m0EldMxqz61TJ4XxW0vjwiwa2M2jCrsdT0gWB
        FpmnlqkRIdM80BHcnFg2C0agd/+tniw=
X-Google-Smtp-Source: AGRyM1vw9DdU6tiZc6B7msB2VfNWpClP3iavSCiPsNVBrZ/DFZU6H5B0Ur4PHoGGozEWeTqqQKn7hQ==
X-Received: by 2002:a05:6214:e69:b0:474:77:1fe5 with SMTP id jz9-20020a0562140e6900b0047400771fe5mr10951464qvb.27.1658766531421;
        Mon, 25 Jul 2022 09:28:51 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:2e4b:4ce0:4ade:bf5e])
        by smtp.gmail.com with ESMTPSA id y11-20020a05622a004b00b003051f450049sm8131847qtw.8.2022.07.25.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:28:51 -0700 (PDT)
Date:   Mon, 25 Jul 2022 09:28:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
Message-ID: <Yt7Ewi2vu49fW1ZJ@yury-laptop>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
 <8735epd204.fsf@mpe.ellerman.id.au>
 <87wnc1bcwa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnc1bcwa.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:22:13PM +1000, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Yury Norov <yury.norov@gmail.com> writes:
> >> archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
> >> circular header dependency, if generic nodemask.h  includes random.h:
> >>
> >> In file included from include/linux/cred.h:16,
> >>                  from include/linux/seq_file.h:13,
> >>                  from arch/powerpc/include/asm/machdep.h:6,
> >>                  from arch/powerpc/include/asm/archrandom.h:5,
> >>                  from include/linux/random.h:109,
> >>                  from include/linux/nodemask.h:97,
> >>                  from include/linux/list_lru.h:12,
> >>                  from include/linux/fs.h:13,
> >>                  from include/linux/compat.h:17,
> >>                  from arch/powerpc/kernel/asm-offsets.c:12:
> >> include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
> >>  1203 |         nodemask_t                      mems_allowed;
> >>       |         ^~~~~~~~~~
> >>
> >> Fix it by removing <asm/machdep.h> dependency from archrandom.h
> >>
> >> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >> ---
> >>  arch/powerpc/include/asm/archrandom.h |  9 +--------
> >>  arch/powerpc/kernel/setup-common.c    | 11 +++++++++++
> >>  2 files changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> >> index 9a53e29680f4..21def59ef1a6 100644
> >> --- a/arch/powerpc/include/asm/archrandom.h
> >> +++ b/arch/powerpc/include/asm/archrandom.h
> >> @@ -4,7 +4,7 @@
> >>  
> >>  #ifdef CONFIG_ARCH_RANDOM
> >>  
> >> -#include <asm/machdep.h>
> >> +bool __must_check arch_get_random_seed_long(unsigned long *v);
> >>  
> >>  static inline bool __must_check arch_get_random_long(unsigned long *v)
> >>  {
> >> @@ -16,13 +16,6 @@ static inline bool __must_check arch_get_random_int(unsigned int *v)
> >>  	return false;
> >>  }
> >>  
> >> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> >> -{
> >> -	if (ppc_md.get_random_seed)
> >> -		return ppc_md.get_random_seed(v);
> >> -
> >> -	return false;
> >> -}
> >
> > I'd rather we didn't have to force this out of line.
> >
> > I think I see a different way to fix it, I'll just do some more build
> > tests.
> 
> Of course my idea didn't work :}
> 
> So I'll just ack your patch for now, and maybe I can get the headers
> cleaned up in future to allow it to be out-of-line again.

I understand that it looks like a tradeoff - we inline a couple of small
functions with the cost of uninlining an almost innocent victim. 

The complete solution would be probably a splitting ppc_md declaration
out of asm/machdep.h. I wanted to do that, but I'm not a PPC guy, and
just don't know how to split the header correctly.

Anyways, thanks for the ack. Applied on bitmap-for-next.

Thanks,
Yury
