Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1FC4A77D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiBBSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:24:18 -0500
Received: from foss.arm.com ([217.140.110.172]:47344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbiBBSYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:24:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBDC7113E;
        Wed,  2 Feb 2022 10:24:15 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366AE3F40C;
        Wed,  2 Feb 2022 10:24:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers
In-Reply-To: <20220202145954.458370-1-frederic@kernel.org>
References: <20220202145954.458370-1-frederic@kernel.org>
Date:   Wed, 02 Feb 2022 18:24:09 +0000
Message-ID: <87mtj9nn3q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 15:59, Frederic Weisbecker wrote:
> Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
> can be misleading for anybody involved in remote debugging because it
> is then not guaranteed that there is an actual preemption behaviour. It
> depends on default Kconfig or boot defined choices.
>
> Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
> the search for the actual preemption behaviour to browsing dmesg.
>

Looks sensible. One small further cleanup nit below, otherwise:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  init/Makefile       |  3 ++-
>  scripts/mkcompile_h | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/init/Makefile b/init/Makefile
> index 06326e304384..d82623d7fc8e 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -31,7 +31,8 @@ quiet_cmd_compile.h = CHK     $@
>        cmd_compile.h = \
>       $(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
>       "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
> -	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
> +	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
> +	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
>
>  include/generated/compile.h: FORCE
>       $(call cmd,compile.h)
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index 6a2a04d92f42..f4d6ca3c6fd7 100755
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
> @@ -41,7 +42,13 @@ fi
>  UTS_VERSION="#$VERSION"
>  CONFIG_FLAGS=""
>  if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
> -if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
> +if [ -n "$PREEMPT" ] ; then
> +	if [ -n "$PREEMPT_DYNAMIC" ] ; then
> +		CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC";
> +	else
> +		CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT";
> +	fi
> +fi
>  if [ -n "$PREEMPT_RT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"; fi
>

I got suspicious of that PREEMPT_RT line, but it works because
PREEMPT_BUILD and PREEMPT_RT are mutually exclusive. Nevertheless, could we
clear out the ambiguity and make that into:

if   [ -n "$PREEMPT_RT" ] ;      then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT";
elif [ -n "$PREEMPT_DYNAMIC" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC";
elif [ -n "$PREEMPT" ] ;         then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT";
fi


>  # Truncate to maximum length
> --
> 2.25.1
