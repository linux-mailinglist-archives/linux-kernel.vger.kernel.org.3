Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7219D5314E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiEWQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiEWQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9367D3B;
        Mon, 23 May 2022 09:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7420261444;
        Mon, 23 May 2022 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DC0C385AA;
        Mon, 23 May 2022 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653322988;
        bh=22LDqW39hYfZWUrqVa40+JARPQjAVp5JttY1+ru3FPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tftt7dckinwCf4LrLK1Zj2LdoBobYvDT6/NJYF3hjWYboT4k8qXSkCLliOsVHzSi6
         zkE5g71y7KuhZ17OitWK2/pLMJJScqm6CvYvidsL8oO9Pvk39Y9KuWJsvvfyuofxFY
         Ks4tm3GgaQOCtK3VPTXuw5C5GDkVY6QbzRv6lkBx6YvK80Iyt2d3luqSLokBnVthJR
         VfwY06DF3OeTqsgBvc6aGj8BokCC8s2T5dFACtLdte7maMSOcMzC8C/f+zgnbWHLFm
         /Uu/3kKPqpb3qwTA1OQts6WaZ2gSab0vm+fUgr3ipoTMu4Twu+VarBSZCN2f09xiJy
         b/1QMpdX36Ibg==
Date:   Mon, 23 May 2022 09:23:07 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220523162307.45dycvqld7maaj7l@treble>
References: <20220523142431.10ff2f77@canb.auug.org.au>
 <20220523154758.11668628@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220523154758.11668628@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:47:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 23 May 2022 14:24:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tip tree got a conflict in:
> > 
> >   scripts/Makefile.build
> > 
> > between commit:
> > 
> >   0212301af7bb ("kbuild: do not create *.prelink.o for Clang LTO or IBT")
> > 
> > from the kbuild tree and commit:
> > 
> >   753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")
> > 
> > from the tip tree.
> > 
> > I am not sure if I fixed this up correctly, please check the final result
> > when linux-next is released.
> > 
> > I fixed it up (I used the former version) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> 
> That produced may warnings :-(   so I tried the below resolution instead.

Looks good to me.  I guess the confusing bit was that in most cases,
CONFIG_STACK_VALIDATION has been replaced with CONFIG_OBJTOOL.

-- 
Josh
