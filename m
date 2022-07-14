Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46E57526A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiGNQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiGNQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:05:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900F5143A;
        Thu, 14 Jul 2022 09:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1517DB82730;
        Thu, 14 Jul 2022 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705AC34114;
        Thu, 14 Jul 2022 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657814745;
        bh=u1PzRpfvIioRbL5vI4/uG1dc+4gqO2bAsTU0TqTxIPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT5yUYctDZH0qrlGCxQAuMOPhME+eSBJ6C/DdjprmCXeGu8g64qYnz24aLVyk7OeL
         JUc/T82SG0qPzcncprQ2CNCgskGbbduSDjkU3DlyyaS6/46A9zAbQE44WPQP0QVq/+
         EMItdC36oS3MuGW8wG6n92hoXMSXrTu8wyIm/tFLMzxb1rg5fdDQwJg9xFSf6IMWKf
         JEzhwySCauX+dN8stFawkDD8p7uycHt0rplKPdKm5ie5+5GqAbpoJa8OYYy1oSVLqY
         rBTwM3Kc8GBFAVuCXRmQWkzkAOdDDgIx0fhhQtF/XJQLfXWpb/O3YC7vwWrMzgXJ4n
         6CBsDgZnqZXuQ==
Date:   Thu, 14 Jul 2022 09:05:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Jul 14
Message-ID: <YtA+127QgRifnRBZ@dev-arch.thelio-3990X>
References: <20220714185514.7d1a2ac9@canb.auug.org.au>
 <Ys/42uMzQy+CFTGI@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/42uMzQy+CFTGI@debian>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi Stephen,
> 
> On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20220713:
> 
> Build failures on next-20220714:

<snip>

> x86_64 allmodconfig with clang fails with:
> 
> drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
>         gpu_cc_parent,
>         ^~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
>         gpu_cc_parent,
>         ^~~~~~~~~~~~~

I sent https://lore.kernel.org/20220711174004.3047516-1-nathan@kernel.org/
for this a few days ago, it just needs to be picked up.

> arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
> DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
>                     ^
> ./arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
> extern u64 x86_spec_ctrl_current;

This is now fixed in -tip so it should be fixed in -next tomorrorow:

https://git.kernel.org/tip/db866d3352ec85e821e730e191481cba3a2bfa6e

In the future, consider CC'ing our mailing list (llvm@lists.linux.dev)
for any clang related issues so that we can get them taken care of ASAP,
we have a MAINTAINERS entry for a reason :) thank you for testing with
clang; the more people that use it, hopefully the easier it will be to
get things unbroken.

Cheers,
Nathan
