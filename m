Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980274C19F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbiBWRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiBWRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:40:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5236B48;
        Wed, 23 Feb 2022 09:39:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A4C61484;
        Wed, 23 Feb 2022 17:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F2DC340E7;
        Wed, 23 Feb 2022 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645637982;
        bh=UB/fdzNnOIHMXBBBmk61V4+OoYvesbVZ2l0elnEufzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf3D2LPejolRCxzzwXBAjLaXRzKYJp3PVnWiPo6fUoWNajRrzf0DJpnrbGS310o+b
         d5Wp8WWyMsyHMqh1H4aXG7CkNqkqxv4nhSAXKmxgG0Wi4NmyoI0VJTpvgAse7fDhqh
         IEWoXVixG3N+TSSAF24zW1hB0F9jxPdSQghzIwFhmQqihwyNKVgQvCn5z5dfmBNCs9
         ynAGTrmCV1hFtBbw+754CjyRqQN4nDhp5+vTuDH098HsUtx/ZeikW8QnO3DspbBz89
         7KSa29WNpvX4IFs+d+kut4AytrYJVsnDTmBX/9nQDNosRbphm1Fr657UDS/CNoBrXU
         yp1WsX2CJWy7Q==
Date:   Wed, 23 Feb 2022 10:39:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
Message-ID: <YhZxVwoshSwwJkJO@dev-arch.archlinux-ax161>
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161>
 <69d351c6-a69d-6ebb-53bc-b46dfe4da08a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d351c6-a69d-6ebb-53bc-b46dfe4da08a@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 12:50:21AM -0800, Dan Li wrote:
> 
> 
> On 2/22/22 08:16, Nathan Chancellor wrote:
> > On Tue, Feb 22, 2022 at 01:57:36AM -0800, Dan Li wrote:
> > > Shadow call stack is available in GCC > 11.2.0, this patch makes
> > > the corresponding kernel configuration available when compiling
> > > the kernel with gcc.
> > >   config SHADOW_CALL_STACK
> > > -	bool "Clang Shadow Call Stack"
> > > -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
> > > +	bool "Shadow Call Stack"
> > > +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > >   	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> > >   	help
> > > -	  This option enables Clang's Shadow Call Stack, which uses a
> > > +	  This option enables Clang/GCC's Shadow Call Stack, which uses a
> > 
> > I wonder if we want to just ditch the mention of the compiler if both
> > support it?
> > 
> 
> My intention is to remind users that this is a compiler feature.
> But since there is also a hint in CC_HAVE_SHADOW_CALL_STACK:
> +# Supported by clang >= 7.0 or GCC ...
> 
> Removing the specific compiler here also looks fine to me.
> Would this look better?
> 
> "This option enables Shadow Call Stack, which uses a ..."
> 
> or maybe:
> 
> "This option enables compiler's Shadow Call Stack, which uses a ..."

I do not honestly have a strong opinion around removing mention of the
compiler so either looks fine to me (might be better to say "the
compiler's Shadow ..." in the second one).

> > >   	  shadow stack to protect function return addresses from being
> > >   	  overwritten by an attacker. More information can be found in
> > >   	  Clang's documentation:
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 09b885cc4db5..a48a604301aa 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
> > >   config ARCH_HAS_FILTER_PGPROT
> > >   	def_bool y
> > > -# Supported by clang >= 7.0
> > > +# Supported by clang >= 7.0 or GCC > 11.2.0
> > 
> > Same thing here, although eventually there may be a minimum GCC version
> > bump to something newer than 11.2.0, which would allow us to just drop
> > CONFIG_CC_HAVE_SHADOW_CALL_STACK altogether. No strong opinion.
> > 
> 
> As Guenter said, I thought maybe we could mark the minimum available
> version for users :)

Yes, that is what I was getting at with the "minimum version" comment.
It should remain around.

Cheers,
Nathan
