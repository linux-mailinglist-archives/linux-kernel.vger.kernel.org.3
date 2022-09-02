Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992405AB659
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiIBQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiIBQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:15:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060A117AE6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70F13B82C7D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3679C433D6;
        Fri,  2 Sep 2022 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662135110;
        bh=Z+r+C0wXesNeSLz5e3UJqk59d7HBkCsYfjmU8Ig94Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkQbfUn6XOZBr8nDbP6jSghq2ziGVbFCURz1EP8SImFQb0gGum6nav+0oCXZD7ca4
         BiYWRgLJZyzHWkTYBOiZte3KsKNZWIaY7JHIgPbUTs39A/svAaTh534v3gZNz3dTpU
         qcNBiQKyrHWmUFRJXjg5x06pHGiz0vbgXZLq03Kp8fpdRNRmnY1JlsRjNcipWw8zvC
         ZlboecCfQFKHa5Mo57dBxwMIfOMQb8sbBwobndKOSFII3YyfG4RmjA95dFR3ekTbnC
         ZDAck3yQCQmVYQ1lyvVjRxls+MRvckUZzmxlE5Lo1Iu6oo7fzaAQkCK9gn9I6CLAVJ
         Moit4HTADimIA==
Date:   Fri, 2 Sep 2022 09:11:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/math-emu: Remove -w build flag and fix
 warnings
Message-ID: <YxIrRJz3+fkzogay@dev-arch.thelio-3990X>
References: <a7384eafc6a27aea15bdc9e8f9a12aac593fccb7.1662113301.git.christophe.leroy@csgroup.eu>
 <35c86b7ca823954c6cd593acc3690dc3748da9b1.1662113301.git.christophe.leroy@csgroup.eu>
 <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X>
 <20220902155954.GP25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902155954.GP25951@gate.crashing.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:59:54AM -0500, Segher Boessenkool wrote:
> On Fri, Sep 02, 2022 at 08:37:23AM -0700, Nathan Chancellor wrote:
> > On Fri, Sep 02, 2022 at 12:08:55PM +0200, Christophe Leroy wrote:
> > > This should have been detected by gcc at build time, but due to
> > > '-w' flag it went undetected.
> > > 
> > > Removing that flag leads to many warnings hence errors.
> 
> > Thanks for figuring out what was going on here! I took this patch for a
> > spin with clang and it has a few more errors around
> > -Wimplicit-fallthrough:
> 
> Maybe add -Wno-implicit-fallthrough?  This code is a copy from outside
> the kernel, no one has ever wanted to maintain it, if nothing else (the
> more politically correct formulation is "we cannot as easily pick up
> improvements from upstream if we modify stuff").

Sure, we could do something like this if you preferred:

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 26fef2e5672e..ed775747a2a5 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -16,3 +16,7 @@ obj-$(CONFIG_SPE)		+= math_efp.o
 
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
+
+ifdef CONFIG_CC_IS_CLANG
+ccflags-remove-y := $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+endif

At the same time, I see other modifications to these files that appear
to be for the kernel only so I suspect that this is already in the "we
cannot as easily pick up improvements from upstream" category,
regardless of that diff. No strong opinion from me, although I see
Christophe already included my suggestion in the most recent series:

https://lore.kernel.org/2663961738a46073713786d4efeb53100ca156e7.1662134272.git.christophe.leroy@csgroup.eu/

Cheers,
Nathan
