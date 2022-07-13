Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80A35735B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiGMLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGMLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:40:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFAF7894;
        Wed, 13 Jul 2022 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vOHzc0iNAJAyWdjUKS1wA/+wU9ZskbRu8pEYBEJ/SIw=; b=SzcYxdnGL7pR91/ks+09wj9cTy
        1uKLqgNzuodQeTHkWqZ2sYqsTCYyU7HFzvbwdTmvA6xfCfbPypc+yqHI4M8hM1vFHj/aL0FQm4FfE
        xFlTlizvOXXa8/Rqe9I97iKEKTqGYuMYV/PblZuqeEJQ2th+d1NfOGBeY7h1D5pzXkZ8QT9/5KvE9
        m0ROYzNoMm07LnOq980QooeQoyx9EXu6WIPggS2eOKvjmS02RXyWASx+b7tqpybQOY48axg5g4GUD
        vqfkHm42DjseEIcQ456aMWvF2G3BYK9TFrfN1T57DQAGHow8gD2zoTIHnXMK8IaBPL98szIStGOFI
        fisg2pAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBaiK-003Xye-M8; Wed, 13 Jul 2022 11:39:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEA17300238;
        Wed, 13 Jul 2022 13:39:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FBF3201DA175; Wed, 13 Jul 2022 13:39:31 +0200 (CEST)
Date:   Wed, 13 Jul 2022 13:39:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Borislav Petkov <bp@suse.de>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <Ys6u88DqQdgmkWWf@hirez.programming.kicks-ass.net>
References: <20220713203409.559c5464@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713203409.559c5464@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:34:09PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rust tree got a conflict in:
> 
>   arch/x86/Makefile
> 
> between commit:
> 
>   f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
> 
> from Linus' tree and commit:
> 
>   0ea4b9a1bece ("Kbuild: add Rust support")
> 
> from the rust tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/x86/Makefile
> index 1f40dad30d50,5ac9b324751d..000000000000
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@@ -21,12 -21,8 +21,13 @@@ ifdef CONFIG_CC_IS_CLAN
>   RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
>   RETPOLINE_VDSO_CFLAGS	:= -mretpoline
>   endif
> + RETPOLINE_RUSTFLAGS	:= -Ctarget-feature=+retpoline-external-thunk
>   
>  +ifdef CONFIG_RETHUNK
>  +RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
>  +RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
>  +endif

Does Rust have the equivalent of -mfunction-return=thunk-extern ?

Related, how does Rust deal with all the various CC_HAS_ Kconfig stuff?
What if C has the relevant option but Rust does not; then we must not
have the feature enabled or there will be a mis-match.

Do we now have to litter everythign with RUSTC_HAS_ ?

