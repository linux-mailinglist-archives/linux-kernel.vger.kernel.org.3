Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3051F26C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiEIBb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiEIALS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1565594
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C9160F13
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74CC385AC;
        Mon,  9 May 2022 00:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652054844;
        bh=bHmScepPN7hiopWGp4Kksweb2MJZ9UmfSD6aznw0bIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWziOI/mxznBq6oexsLOCR4AhVWh+JvIbO7TsfylwMPxv6ZNycNSqGW8E5XfuvAB3
         8mjOvyNDBEPnA52h1dSX1sJWZfsNugYJomO+bov+1M5CSsPlug8KU5cyUAo4DPPupM
         D47fkVLkscKkMJk5ZOgKKLPX0xOoheg/wPo0WM6u917gHYtizntQsyTa3ESY3aA7ES
         XELPW3DvXI3Y+Id/EdxhJZSdfU9kJMoIGad69ni47JHQ3phPwDyspF8FSr3LEBK3fY
         7R1H7YhcwtFg6VvxenzWvQKavKDz+vj2xSuHnosmirIBhxYE6MYjaCT0j8Ee8mtUGY
         nnaHkrTI7lHjQ==
Date:   Sun, 8 May 2022 17:07:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Rossi <issor.oruam@gmail.com>
Cc:     luto@kernel.org, Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
Message-ID: <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X>
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X>
 <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 02:19:00PM +0200, Mauro Rossi wrote:
> > > Alternatively, you could apply the hack that Nick inserted into Android
> > > for this issue if upgrading your toolchain or turning off the integrated
> > > assembler is not possible:
> > >
> > > https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
> > >
> > > I really do not mean to sound dismissive or rude, I apologize if it
> > > comes off that way, but we have worked quite hard to avoid inserting
> > > unnecessary workarounds, as they are ultimately technical debt that can
> > > be hard to manage over the long term.
> > >
> > > Cheers,
> > > Nathan
> >
> > Thanks a lot Nathan
> >
> > It is definitely the clang version 11.0.x which is not updated in aosp
> > Android 11 production tags
> >
> > I will use Nick's workaround which works since only lsl %rax, %rax is
> > currently happening
> >
> > Many thanks, problem solved
> 
> Hello,
> I'm back again because I was assuming that Nick's workaround was working ok,
> but I have found that ARCH=x86_64 i.e. 64bit built kernel is causing
> an immediate hard reboot at initrd execution,
> just after hitting [ENTER] at grub/efi menu.

It looks like there was a follow up fix for that workaround, maybe that
resolves this issue as well?

https://android.googlesource.com/kernel/common/+/cc7f7a84191f5defc2ea4633eeea4acb4486b549

> ARCh=x86 i.e. 32bit kernel binary is not affected, but is Nick's
> workaround targeting 32 bit kernel builds?

No, the file that the build error originates from (entry_64.S) is only
built on x86_64.

> How do aosp android-mailine kernels avoid this instantaneous hard reboot issue?

That hack was reverted once the toolchain was upgraded:

https://android.googlesource.com/kernel/common/+/ff0216d09fd31802537f2d1702ec2f3e9be73aa3
https://android.googlesource.com/kernel/common/+/3c2c8d8f7f2639e319212d10cb8df5bd13098dae

Cheers,
Nathan
