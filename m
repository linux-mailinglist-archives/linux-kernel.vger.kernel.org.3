Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52E487C71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiAGSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiAGSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:49:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB1C061574;
        Fri,  7 Jan 2022 10:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 338DDB8270A;
        Fri,  7 Jan 2022 18:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05491C36AE0;
        Fri,  7 Jan 2022 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641581374;
        bh=HJvDnci5soQ2jCNcWQ/ojyf3bfVjVb4ytDufqixZdvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT8a/9CwoQNKjJR941aCeoORxgbLwZmvEeN326X1HW7zIHqPbJCH9fRFGbQr/ezrS
         qcMq/EsqkjHLFOoOZWSprzN/nhVdL13+Da1IcXC++QiIKsre/dHfj0ry0qcgsgxCuo
         LbQEslTL28KuxnrGWCdaitFK4K6tLdI1OuH/IJF4olUIu42eTgrQKr0yH2n7FdtskF
         u2/L4bpngMyPw/mIQC1u+anp4FyrtZFFxI+JwQgDugdYF6NRMDMih82+vBFm2eb8gy
         HnnSM/nJa61iOvRhQiwPtsZ/q0IEHBaq0JBbHUE4IlJEGmb8QVHNTUKZIr69+lpDCl
         rPgJAjuipo4FA==
Date:   Fri, 7 Jan 2022 11:49:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kbuild: move headers_check.pl to usr/include/
Message-ID: <YdiLO0VstqY66LyP@archlinux-ax161>
References: <20211206023507.447574-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206023507.447574-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, Dec 06, 2021 at 11:35:06AM +0900, Masahiro Yamada wrote:
> This script is only used by usr/include/Makefile. Make it local to
> the directory.
> 
> Update the comment in include/uapi/linux/soundcard.h because
> 'make headers_check' is no longer functional.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>  - Fix the comment in soundcard.sh to point to the new file path
> 
>  include/uapi/linux/soundcard.h            | 2 +-
>  usr/include/Makefile                      | 2 +-
>  {scripts => usr/include}/headers_check.pl | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {scripts => usr/include}/headers_check.pl (100%)
> 
> diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
> index f3b21f989872..ac1318793a86 100644
> --- a/include/uapi/linux/soundcard.h
> +++ b/include/uapi/linux/soundcard.h
> @@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
>   *	the GPL version of OSS-4.x and build against that version
>   *	of the header.
>   *
> - *	We redefine the extern keyword so that make headers_check
> + *	We redefine the extern keyword so that usr/include/headers_check.pl
>   *	does not complain about SEQ_USE_EXTBUF.
>   */
>  #define SEQ_DECLAREBUF()		SEQ_USE_EXTBUF()
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 1c2ae1368079..0e9c3e72f43a 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -99,7 +99,7 @@ quiet_cmd_hdrtest = HDRTEST $<
>        cmd_hdrtest = \
>  		$(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
>  			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
> -		$(PERL) $(srctree)/scripts/headers_check.pl $(obj) $(SRCARCH) $<; \
> +		$(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
>  		touch $@
>  
>  $(obj)/%.hdrtest: $(obj)/%.h FORCE
> diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
> similarity index 100%
> rename from scripts/headers_check.pl
> rename to usr/include/headers_check.pl
> -- 
> 2.32.0
> 
> 

After this patch landed in -next, with a completely clean tree, I see:

$ make clean
  CLEAN   usr/include

$ git status --short
 D usr/include/headers_check.pl

Is something like this needed?

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 0e9c3e72f43a..6e9dfd657e89 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -105,4 +105,4 @@ quiet_cmd_hdrtest = HDRTEST $<
 $(obj)/%.hdrtest: $(obj)/%.h FORCE
 	$(call if_changed_dep,hdrtest)
 
-clean-files += $(filter-out Makefile, $(notdir $(wildcard $(obj)/*)))
+clean-files += $(filter-out headers_check.pl Makefile, $(notdir $(wildcard $(obj)/*)))
