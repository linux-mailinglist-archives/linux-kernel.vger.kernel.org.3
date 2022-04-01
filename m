Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB364EF8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349761AbiDARXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242911AbiDARW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A4C6802;
        Fri,  1 Apr 2022 10:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09BD61CC0;
        Fri,  1 Apr 2022 17:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF3CC2BBE4;
        Fri,  1 Apr 2022 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648833668;
        bh=rSx8N99cHtG8lzV8XmCZYT1IK82L3z6RhBojDkyGxI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2nlMqIqkJIVjKFws5I/zu2WMBz400kfRUc2GTdP3zUZHl+fWtMocpeRLa6uLWl7E
         BBeY22ZJpWNwMh8GK5PfmVTMwHjO3mmygexiqmEWE9MWAei/4knEA92EkUXQBsf/TA
         Yh7F4+SBpCJ1iKW1yFlEvMUr/z3r5K5dxLIwzpTapvZzhZf7Xw7Zx8Q47Yfi/6QXHB
         /QdqgVKsuJtAQJVxORJFBvnfy1ZsTBmPEXDrAqGNujMok/jeXEByHzWaVlk48R4VmX
         Vxi9HaW7mmLrg76dnnWG+pcUxhQx4JxmE52zsL2Kw7TIno0vRspbE0dB4fOV0NwPg7
         JXtA0QTe+EhtQ==
Date:   Fri, 1 Apr 2022 10:21:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     FraSharp <f.duca00@gmail.com>
Cc:     FraSharp <s23265@iisve.it>, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: use hostname -s along uname to obtain
 LINUX_COMPILE_HOST
Message-ID: <Ykc0ge8SPt/x8IHc@thelio-3990X>
References: <20220330182329.52310-1-s23265@iisve.it>
 <20220401151706.30697-1-s23265@iisve.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401151706.30697-1-s23265@iisve.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Fri, Apr 01, 2022 at 05:17:06PM +0200, FraSharp wrote:
> * On some systems (e.g. macOS, Debian, Fedora), using commands like 'uname -n' or
>   'hostname' will print something similar to "hostname.domain"
>   ("Francescos-Air.fritz.box" for example), which is very annoying.
>   What works instead is 'hostname -s', which will only write hostname
>   without the domain ("Francescos-Air" for example),
>   but also keep 'uname -n', as some systems as Arch Linux does not have
>   'hostname' as command.
> 
> * This commit is complementary to
>   1e66d50ad3a1dbf0169b14d502be59a4b1213149
>   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
> 
> Signed-off-by: Francesco Duca <s23265@iisve.it>
> ---
>  scripts/mkcompile_h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index ca40a5258..3eefbafe5 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -34,7 +34,7 @@ else
>  	LINUX_COMPILE_BY=$KBUILD_BUILD_USER
>  fi
>  if test -z "$KBUILD_BUILD_HOST"; then
> -	LINUX_COMPILE_HOST=`uname -n`
> +	LINUX_COMPILE_HOST=$(hostname -s 2>/dev/null || uname -n)
>  else
>  	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
>  fi
> -- 
> 2.32.0 (Apple Git-132)
> 

I personally think this is going to output something objectively worse
for my use case. I use containers for my main workflow, which have a
hostname of "container name" and domain name of "host's hostname".

For example:

$ uname -n
thelio-3990X

$ distrobox enter dev-arch

$ uname -n
dev-arch.thelio-3990X

With the move to 'hostname -s' by default, I lose the information about
the main host machine, so I am unable to tell exactly which container
built the image:

$ hostname -s
dev-arch

While moving to containers is supposed to help eliminate the need to
know about a particular machine because it should be the same
environment, it is still relevant because I build certain tools on some
machines and not others and I am not necessarily updating each container
on the same timeline, so it is still useful to have this information
included in the kernel image for tracking purposes.

Given this is a purely a subjective/cosmetic issue, why can you not just
add something like

export KBUILD_BUILD_HOST=$(hostname -s)

in your shell's start up file, so that the hostname is in the format
that you desire?

Cheers,
Nathan
