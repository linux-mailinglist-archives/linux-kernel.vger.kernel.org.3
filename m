Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37381543626
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiFHPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiFHPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73146756F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5094E61C3D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0211AC3411D;
        Wed,  8 Jun 2022 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654700441;
        bh=WnSIpYNEp6Zh9omFv6+B795I66G2qY/jt8+Mozk+Nq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaDdxpG9A8R9DpCVtZt/PkExzC1iXt9xhga+IowtsZC44xDosfadcccWldjJnab3M
         9HPXNC7Zo37XBJl7nx0KjaG6eQDwz59yVkpAXp3EVQzzTJoy0hcGC9UI430tUZSrsE
         eI/kol8W5AzdEZUwipWg6KNYfntYIGPOId9BSU0ZLGxGNQZZw+yZgdG/BQ15gwEB2R
         BWmhZRsYH8vXol7I49H7Thfw6pnedzD1db27cWzuPHzc1dMuFJoUpNKVNTNBXsCL3p
         mTjkyG5R/u2pGFeAmPq/+sOcOPghQaBBdC+eFoabJA6GA3Dq+0Oiz+AUOIukAKLp3Z
         rkfKPzTTwDZ8g==
Date:   Wed, 8 Jun 2022 08:00:39 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Joe Damato <jdamato@fastly.com>, "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "bp@suse.de" <bp@suse.de>, "brgerst@gmail.com" <brgerst@gmail.com>
Subject: Re: 5.19-rc1 x86 build failure
Message-ID: <20220608150039.uunijnzx6t4irfrm@treble>
References: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
 <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com>
 <20220608005956.hzvx3fapdmp25oun@treble>
 <b5e11680-9101-24ec-0977-c5d0ff8c98c2@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5e11680-9101-24ec-0977-c5d0ff8c98c2@citrix.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:24:25AM +0000, Andrew Cooper wrote:
> On 08/06/2022 01:59, Josh Poimboeuf wrote:
> > @@ -133,12 +125,16 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
> >  
> >  #endif /* __i386__ */
> >  #endif /* _SETUP */
> > -#else
> > -#define RESERVE_BRK(name,sz)				\
> > -	.pushsection .brk_reservation,"aw",@nobits;	\
> > -.brk.name:						\
> > -1:	.skip sz;					\
> > -	.size .brk.name,.-1b;				\
> > +
> > +#else  /* __ASSEMBLY */
> > +
> > +#define RESERVE_BRK(name, size)				\
> > +	.pushsection .brk_reservation, "aw";		\
> > +__brk_##name:						\
> > +1:	.skip size;					\
> > +	.size __brk_##name, . - 1b;			\
> >  	.popsection
> 
> While I think about it before you write the patch properly, you ought to
> have a .type in here too, seeing as the C side now gets one.

Good point, I'll just use the SYM_DATA_{START,END} macros.

-- 
Josh
