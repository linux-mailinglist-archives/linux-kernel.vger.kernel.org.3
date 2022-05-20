Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B677252EFBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiETPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245558AbiETPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08315FE05;
        Fri, 20 May 2022 08:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 579FD61DCD;
        Fri, 20 May 2022 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44945C34100;
        Fri, 20 May 2022 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653061967;
        bh=B8GCMZ/0ZW3rQLq4mGs9IzvLjmN3mvUZf37rxd5zXSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaJE6IRJE7sZeLyrGSUXmPauj4ZdilaexT3ltgp57a36nW0Yb+9BM5VZoDUGIGnhR
         y53lJ83MwmR/KQBwZ+EULRP0PuZnzZjRFusrPBJ/tN5Ba/uc3ERLTzNwh4Gzd8j6vA
         u8Rx7zQSWboHegq+8zTFScGHESWSjFAn7qSu82sM+4i8wXy6FfLJEt/yw946JSmvab
         4x8NuVHBFHo57pMsV0sYqmFeOXaD0/a4sNuRp/+MuYm29+HlRjvveByGYpJgthss4z
         /bm2h5Tmu9CVwdnt3Gx8r5NR9VLFWXNWZuwu7drJ6hcwbIUWLOXS3p8w6avekBR1Jm
         fy9UqjhVpV7Tw==
Date:   Fri, 20 May 2022 08:52:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: Re: arch/mips/include/asm/checksum.h:195:9: error: unsupported
 inline asm: input with type 'unsigned long' matching output with type
 '__wsum' (aka 'unsigned int')
Message-ID: <Yoe5TafDskZ9JDSW@dev-arch.thelio-3990X>
References: <202205200128.layu7VXF-lkp@intel.com>
 <OB55CR.QAT1J8A48BK21@crapouillou.net>
 <alpine.DEB.2.21.2205200510350.52080@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2205200510350.52080@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:08:02PM +0100, Maciej W. Rozycki wrote:
> On Thu, 19 May 2022, Paul Cercueil wrote:
> 
> > About the real issue: Maybe the last "addu" in csum_tcpudp_nofold() should be
> > a "daddu"?
> 
>  It doesn't matter whether there is ADDU or DADDU anymore, given that 
> commit 198688edbf77 ("MIPS: Fix inline asm input/output type mismatch in 
> checksum.h used with Clang") has added a redundant 32-bit sign-extension 
> operation right afterwards, regressing size/performance by an extra 
> instruction in this performance-critical code as a workaround for a stupid 
> compiler.

Shouldn't this concern have been addressed by Tiezhu's follow up?

https://lore.kernel.org/1617359240-16609-1-git-send-email-yangtiezhu@loongson.cn/

I guess it never got picked up?

Cheers,
Nathan
