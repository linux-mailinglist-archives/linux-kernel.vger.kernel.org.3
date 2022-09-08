Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2CE5B1B86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiIHLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIHLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E2CEB2C;
        Thu,  8 Sep 2022 04:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33DCE619F2;
        Thu,  8 Sep 2022 11:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04909C433D6;
        Thu,  8 Sep 2022 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662636814;
        bh=fAv0H5mhmBOeV+oGdvgzNzv3ieu8oKLrIj4T6iX1Njg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqsT+crZcE1Xz1oKUhzrLrQvGV+aUsn4Q5WOMlSKuT1swBFdAs/RBfAEaurpJnDXJ
         pyZLwcVsz037q4SEMwGULQ61oM8fM0Sr3jZ6khWW3FIpcRVAiMzA82QGA9DHw55J8w
         hC3HRB9p3Cz5r2KFZpiJStQWL/crzRbbPhQExtG8=
Date:   Thu, 8 Sep 2022 13:33:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] usb: chipidea: make configs for glue drivers visible
 with EXPERT
Message-ID: <YxnTI927V0hGs+kz@kroah.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-5-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908104337.11940-5-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:43:35PM +0200, Lukas Bulwahn wrote:
> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> and just gives that intent a much better name. That has been clearly a good
> and long overdue renaming, and it is clearly an improvement to the kernel
> build configuration that has shown to help managing the kernel build
> configuration in the last decade.
> 
> However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
> this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
> open for future contributors to implement that intended semantics:
> 
>     A new CONFIG_EMBEDDED option is added that automatically selects
>     CONFIG_EXPERT when enabled and can be used in the future to isolate
>     options that should only be considered for embedded systems (RISC
>     architectures, SLOB, etc).
> 
> Since then, this CONFIG_EMBEDDED implicitly had two purposes:
> 
>   - It can make even more options visible beyond what CONFIG_EXPERT makes
>     visible. In other words, it may introduce another level of enabling the
>     visibility of configuration options: always visible, visible with
>     CONFIG_EXPERT and visible with CONFIG_EMBEDDED.
> 
>   - Set certain default values of some configurations differently,
>     following the assumption that configuring a kernel build for an
>     embedded system generally starts with a different set of default values
>     compared to kernel builds for all other kind of systems.
> 
> Considering the first purpose, at the point in time where CONFIG_EMBEDDED
> was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
> become visible throughout all different menus for the kernel configuration.
> Over the last decade, this has gradually increased, so that currently, with
> CONFIG_EXPERT, roughly 170 more options become visible throughout all
> different menus for the kernel configuration. In comparison, currently with
> CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
> one in arm, and five for the ChipIdea Highspeed Dual Role Controller.
> 
> As the numbers suggest, these two levels of enabling the visibility of even
> more configuration options---beyond what CONFIG_EXPERT enables---never
> evolved to a good solution in the last decade. In other words, this
> additional level of visibility of configuration option with CONFIG_EMBEDDED
> compared to CONFIG_EXPERT has since its introduction never become really
> valuable. It requires quite some investigation to actually understand what
> is additionally visible and it does not differ significantly in complexity
> compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
> other config to show more detailed options beyond CONFIG_EXPERT---is
> unlikely to be valuable unless somebody puts significant effort in
> identifying how such visibility options can be properly split and creating
> clear criteria, when some config option is visible with CONFIG_EXPERT and
> when some config option is visible only with some further option enabled
> beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, it
> is much more reasonable to simply make those additional seven options that
> visible with CONFIG_EMBEDDED, visible with CONFIG_EXPERT, and then remove
> CONFIG_EMBEDDED. If anyone spends significant effort in structuring the
> visibility of config options, they may re-introduce suitable new config
> options simply as they see fit.
> 
> Make the configs for usb chipidea glue drivers visible when CONFIG_EXPERT
> is enabled.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/usb/chipidea/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Now queued up in my USB tree, thanks.

greg k-h
