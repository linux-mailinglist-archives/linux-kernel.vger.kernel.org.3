Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE873535891
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbiE0ErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiE0ErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:47:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512103FDA7;
        Thu, 26 May 2022 21:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 056D6B82280;
        Fri, 27 May 2022 04:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5021FC385A9;
        Fri, 27 May 2022 04:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653626833;
        bh=YHKq9nwyKVgGkcT0zHCEXoHsZ+seaUJoWfi7kBjvnIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNUEEnRlEEtWrd/bqSusSNb7/aG9zRCxakQxHlf9GS7HzghlBiZjicyZR1hq0sqxd
         rrZB5fUHhAvSmNoh+vuWfnrcPtlRwMvc6YmwQ7KpIsRG/xm9xj9ntMwlMSylM33drm
         K9bPBYZBLjt6tqtKsjSi8Wq4VZo4EOe5BMUFWLJR3wrdoxFrwc3gFMKgtYRIClk6Wx
         BdzGX0V7QThu1ItdDNLy3gKreJOwxncjYHJNW0SxzjK1yjywJ7UMAuOjrOTTyvjWvB
         TwldbYwovR37SgSbZLiNutTWjemkqz4OD6jqdKI90Imy6Y24CjcRnlkz4TWwT7XDyp
         fsiGD+HeuoJWg==
Date:   Thu, 26 May 2022 21:47:11 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220527044711.hrqxx5gz3jghydax@treble>
References: <20220523142431.10ff2f77@canb.auug.org.au>
 <20220523154758.11668628@canb.auug.org.au>
 <20220523162307.45dycvqld7maaj7l@treble>
 <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:19:02AM +0900, Masahiro Yamada wrote:
> [1] original behavior in Josh's commit
> 
> $ git checkout 753da4179d08b625d8df72e97724e22749969fd3
> $ make defconfig
> $ make -j8 kernel/
> $ head -n 1   kernel/.fork.o.cmd
> 
> 
> I do not see the "--linked" parameter in the objtool command.
> 
> 
> 
> 
> [2] behavior in linux-next
> 
> 
> $ git checkout next-20220523
> $ make defconfig
> $ make -j8 kernel/
> $ head -n 1   kernel/.fork.o.cmd
> 
> I see the "--linked" parameter in the objtool command.
> 
> kernel/fork.o  is a direct output from GCC,
> not from linker.

Yes, good catch.  That flag should only be used for linked objects like
vmlinux.o or some_module.o.

Objtool only runs on such objects when CONFIG_LTO_CLANG,
CONFIG_X86_KERNEL_IBT, or CONFIG_NOINSTR_VALIDATION (vmlinux.o-only) is
enabled.

-- 
Josh
