Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0131E56573F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiGDNcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiGDNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:32:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9711C03
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 565CFCE16AE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67378C3411E;
        Mon,  4 Jul 2022 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656941347;
        bh=LxOgaJ9LSgEjVEuMAJUhVF/q8JAFuDeLHwegeV8kA+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNI+7QkpC3aLbGataolyMpLPtKEu8CKuclbUHURo1BxSe9EZvBggWafe9cc7MntHS
         EMXFp45e3B0esnlKzSsBiW3ed0jhCGDmo3KCthIzh61k9EzvgMF0OAu3TBirp9WDzv
         qKmmMeyZzkMcPqWemgD4B+BO3qIKEt7fKKtPENF+zmLJhQG4oGayeg93wrcaylA8Px
         1s3SsNTho80QD/W9+MGqts9ub7DIDaBszIxuTfzX2IUDAKP3sRq6EzHdUwopwLOh7W
         HxtreIXlyRUprjsnBINdTS60JYEuFsXqpSybaqjCWyRVvTCba314q8tTWzLy4hES8w
         ZticA7DiamrvA==
Received: by pali.im (Postfix)
        id BBEE46E8; Mon,  4 Jul 2022 15:29:04 +0200 (CEST)
Date:   Mon, 4 Jul 2022 15:29:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220704132904.irvs4xefu4esgw6c@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au>
 <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
 <20220704131358.fy3z7tjcmk2m6pfh@pali>
 <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 July 2022 15:22:03 Arnd Bergmann wrote:
> On Mon, Jul 4, 2022 at 3:13 PM Pali Rohár <pali@kernel.org> wrote:
> > On Monday 04 July 2022 14:07:10 Arnd Bergmann wrote:
> 
> > > CFLAGS_CPU-$(CONFIG_PPC_BOOK3S_32) := -mcpu=powerpc
> > > CFLAGS_CPU-$(CONFIG_PPC_85xx) := -mcpu=8540
> > > CFLAGS_CPU-$(CONFIG_PPC8xx) := -mcpu=860
> > > CFLAGS_CPU-$(CONFIG_PPC44x) := -mcpu=440
> > > CFLAGS_CPU-$(CONFIG_PPC40x) := -mcpu=405
> > > ifdef CONFIG_CPU_LITTLE_ENDIAN
> > > CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power8
> > > else
> > > CFLAGS_CPU-$(CONFIG_BOOK3S_64) := -mcpu=power5
> > > endif
> > > CFLAGS_CPU-$(CONFIG_BOOK3E_64) := -mcpu=powerpc64
> >
> > Yes, this is something I would expect that in Makefile should be.
> >
> > But what to do with fallback value?
> 
> Most of the fallback values can just be removed because we don't support
> building with gcc versions older than 5.1.0 any more. The only one
> that I think still needs a fallback is mtune=power9, which requires gcc-6.1
> or higher. CONFIG_POWER9_CPU could similarly use a
> "depends on GCC_VERSION > 60100".
> 
>         Arnd

And still what to do with 4bf4f42a2feb ("powerpc/kbuild: Set default
generic machine type for 32-bit compile")? I'm somehow lost there...
