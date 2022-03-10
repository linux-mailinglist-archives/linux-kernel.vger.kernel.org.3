Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF34D42E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiCJIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiCJIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:55:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E53137584
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2oGu8FQ5/9r0UV/0NCGt/L5DZqE4AtMMTx7LTMP7U6s=; b=VtsSmo3TV36022J8PPW/BtHeYs
        z58gQdYZFXHFgrWM8VmpRVrSPVm3H0PHBcN5O1RJoELD8Swtoxqoc9pWb1OyD8/8WgzYs8TzAHOWv
        0PaquqlfTYRF5hST0VrNMdD2awZ1A+XaU+aN6ee0bAP4j0UAQO5d1ZynEt+jO0ELBgIAfiRM5PPlK
        GDuVbtGkJ/Azc2hh2LjIIGzxpOsAoBcDgYL3lAwwSOczrrmuErTFo7QMMmywi5ScPlGGtlX8FMKxJ
        eUQPqg3q3cOVqv7qpvA87/E0okrCNABpV0kJ6yBGBv0AuWRSC69V3yHPTn/mhLWYJgHXdxGjd5wMg
        +F8qZDfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSEYY-00H4Bs-FH; Thu, 10 Mar 2022 08:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40F3D3000E6;
        Thu, 10 Mar 2022 09:53:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0FBB264E62B5; Thu, 10 Mar 2022 09:53:56 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:53:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel
 headers
Message-ID: <Yim8pJPBLOPtSTw+@hirez.programming.kicks-ass.net>
References: <20220202145954.458370-1-frederic@kernel.org>
 <87mtj9nn3q.mognet@arm.com>
 <20220217111240.GA742892@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217111240.GA742892@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:12:40PM +0100, Frederic Weisbecker wrote:

> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 2 Feb 2022 15:59:54 +0100
> Subject: [PATCH] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers
> 
> Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
> can be misleading for anybody involved in remote debugging because it
> is then not guaranteed that there is an actual preemption behaviour. It
> depends on default Kconfig or boot defined choices.
> 
> Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
> the search for the actual preemption behaviour to browsing dmesg.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Hurmph.. if you all think this matters I suppose.

Let me go queue it.

> ---
>  init/Makefile       |  3 ++-
>  scripts/mkcompile_h | 17 ++++++++++++-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/init/Makefile b/init/Makefile
> index 06326e304384..d82623d7fc8e 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -31,7 +31,8 @@ quiet_cmd_compile.h = CHK     $@
>        cmd_compile.h = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
>  	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
> -	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
> +	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
> +	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
>  
>  include/generated/compile.h: FORCE
>  	$(call cmd,compile.h)
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index 6a2a04d92f42..ca40a5258c87 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -5,9 +5,10 @@ TARGET=$1
>  ARCH=$2
>  SMP=$3
>  PREEMPT=$4
> -PREEMPT_RT=$5
> -CC_VERSION="$6"
> -LD=$7
> +PREEMPT_DYNAMIC=$5
> +PREEMPT_RT=$6
> +CC_VERSION="$7"
> +LD=$8
>  
>  # Do not expand names
>  set -f
> @@ -41,8 +42,14 @@ fi
>  UTS_VERSION="#$VERSION"
>  CONFIG_FLAGS=""
>  if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
> -if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
> -if [ -n "$PREEMPT_RT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"; fi
> +
> +if [ -n "$PREEMPT_RT" ] ; then
> +	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"
> +elif [ -n "$PREEMPT_DYNAMIC" ] ; then
> +	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC"
> +elif [ -n "$PREEMPT" ] ; then
> +	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
> +fi
>  
>  # Truncate to maximum length
>  UTS_LEN=64
> -- 
> 2.25.1
> 
