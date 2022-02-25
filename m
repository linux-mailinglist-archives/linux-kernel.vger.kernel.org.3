Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57AF4C5139
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiBYWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiBYWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:08:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C03D14088
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193FB61880
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D0C340E7;
        Fri, 25 Feb 2022 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645826892;
        bh=8p7WkXuGAypZbBNf4T87PSxeCyirSi+UTVXXW12vVOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gv0D6s3pQeR8kgih9xJOwkPz/IXt3SA4RHJWwfcBzul6s3CvcQxQcT21MHTzIBgsE
         rid2yMfryrFqLMVwoxt2jBd6fXXpghzy8IVpfsuEtxXAIlb6b3RKKbVsGsXDBCyCS3
         wsKuXAcIS0QQplx5/rADmquYj70UJHk+cgc2VTt7wihnJhDPUBa1bqXMdSjohcNb99
         WbLduf8p2G58Dwf81dcAf83zyN+J66hr/9wqug08G2m8fGnlnrF/7EUibbsdhtO4q4
         gZL0QjDYeY1UhEaB4xbueXioxDH6msnhMpHRvRx9+B6laJJ9KtVcUjZeduc1DDceN2
         Jjl62N03qt/0A==
Date:   Fri, 25 Feb 2022 15:08:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook>
 <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:46:59PM -0700, Nathan Chancellor wrote:
> On Thu, Feb 24, 2022 at 04:35:51PM -0800, Kees Cook wrote:
> > On Thu, Feb 24, 2022 at 03:51:43PM +0100, Peter Zijlstra wrote:
> > > Add Kconfig, Makefile and basic instruction support for x86 IBT.
> > > 
> > > XXX clang is not playing ball, probably lld being 'funny', I'm having
> > > problems with .plt entries appearing all over after linking.
> > 
> > I'll try to look into this; I know you've been chatting with Nathan
> > about it. Is there an open bug for it? (And any kind of reproducer
> > smaller than a 39 patch series we can show the linker folks?) :)
> 
> I should be able to create a reproducer with cvise and file a bug on
> GitHub around this tomorrow, I should have done it after Peter's
> comments on IRC.

https://github.com/ClangBuiltLinux/linux/issues/1606

Cheers,
Nathan
