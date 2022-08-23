Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F459EA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiHWSEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiHWSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B8C2776
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A026163B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756FEC433D6;
        Tue, 23 Aug 2022 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661271072;
        bh=I2wMQlQE2ea0W3N6RNflFgDwWIvO1yrAEOonIAJwWe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSNdmwjbSdgzxxiy2Qzow0e270Hch77B2bpGjSSvCsBEq0D2lu1fyHza6fmFyevSY
         I651tP7J8TQq8OWHcF3ddOmM58Q232mMCNLsju4WTWaGp1jQdjx9JpupezRSO216s2
         Gi+4M0GDMeNwY8EB83YKlpOnJeOoR4A0zBRIjE5TflYDFKivDoABAY4GrAD60t7vqJ
         WF4oASrfMmg6VsYGrsvEZNqwHqVNYBRDFaIKO5gPs5UamkOflYkkBJUcCqXGpX07wh
         5kBgJU/plegFl8P78+jzUovFOnAnyZvJEEFkpIVukrEMDVT5YZ70FbtqUvOfCKQgr5
         KG7LbnvSYLkEA==
Date:   Tue, 23 Aug 2022 09:11:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        llvm@lists.linux.dev,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: Fix clang
 -Wbitfield-constant-conversion
Message-ID: <YwT8HYefLbFaOdJz@dev-arch.thelio-3990X>
References: <20220810010809.2024482-1-nathan@kernel.org>
 <166058059542.769843.4941839393289864947.b4-ty@kernel.org>
 <YwT0oUjo/lzBDRdH@dev-arch.thelio-3990X>
 <YwT6bmqeBeoYcRi7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwT6bmqeBeoYcRi7@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:03:58PM +0100, Mark Brown wrote:
> On Tue, Aug 23, 2022 at 08:39:13AM -0700, Nathan Chancellor wrote:
> 
> > I noticed that this was applied to for-6.1. I know you do not rebase or
> > change your trees so this request might be rejected based on that alone
> > but would it be possible to cherry-pick this to for-6.0 so that it can
> > be applied to Linus's tree quicker? We have had to apply this change to
> > our CI to keep our builds green in mainline, -tip, and 5.19/5.15 stable
> > with clang-16 due to -Werror. If not, no worries, I should have made it
> > clearer that is what I was looking for with the subject prefix.
> 
> Hrm, OK - it's a bit surprising that this didn't get fixed in -next
> before the clang change made it to mainline TBH, it looked like
> something that had just hit -next.

Right, sorry for not making that more clear in the commit message. The
change in clang was made only a few hours before this patch so I did fix
it quickly but we do not usually get any heads up on new warnings. They
just appear then we fix them and move on. I'll make it clearer where I
want the patch to go in the future, thanks for accommodating this one
time.

Cheers,
Nathan
