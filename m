Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4387948E984
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiANL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:57:21 -0500
Received: from smtp2.axis.com ([195.60.68.18]:46503 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbiANL5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642161440;
  x=1673697440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GxYdK86AwVncAjnPJuoy99CKiKtTmvQPJrbjyinZXo0=;
  b=fuhnfa740wVhRpBmlkOadHSOYsZV1rA7WeI2JrrTonfnC4lu6cT3Zv2Q
   s//sfq9O2U8dmUf7Q8hORFYe+sezgQM4LsiLeuoBZra4HjoplTWPiereE
   0y0f3bL4K3O6nRa/kOAosg3aYIDUxe+lcgKUYPo+aRt60tVWFAruvT7EX
   /EYeRGPwqDL4FrkC8iiM60LUV8Nk8Kg52g1EQlrK3U9PBSyrPHgngg3/z
   DA7HAom2YPzytUv7pOOPGWEwSb7ihMm1c5As0wF4Phdqjf51yTC5OyO7Q
   QqoxzyYnfVqEP3OMnqvHMoshqfWO0fl9frAoTWXxzSpwUDbhj7tsVFBUA
   Q==;
Date:   Fri, 14 Jan 2022 12:57:18 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jim Cromie <jim.cromie@gmail.com>
CC:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>,
        "maz@kernel.org" <maz@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH v11 01/19] dyndbg: add _DPRINTK_FLAGS_ENABLED
Message-ID: <20220114115718.GB23983@axis.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
 <20220107052942.1349447-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220107052942.1349447-2-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 06:29:24AM +0100, Jim Cromie wrote:
>  #ifdef CONFIG_JUMP_LABEL
> -			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
> -				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
> +			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
> +				if (!(modifiers->flags & _DPRINTK_FLAGS_ENABLED))
>  					static_branch_disable(&dp->key.dd_key_true);
> -			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
> +			} else if (modifiers->flags & _DPRINTK_FLAGS_ENABLED)
>  				static_branch_enable(&dp->key.dd_key_true);
>  #endif
>  			dp->flags = newflags;
> -- 
> 2.33.1
> 

I haven't tested it so I could be mistaken, but when
_DPRINTK_FLAGS_ENABLED gets two flags in the next patch, it looks like
this code still has the problem which I mentioned in
https://lore.kernel.org/lkml/20211209150910.GA23668@axis.com/?

| I noticed a bug inside the CONFIG_JUMP_LABEL handling (also present
| in the last version I posted) which should be fixed as part of the
| diff below (I've added a comment).
| [...] 
|  #ifdef CONFIG_JUMP_LABEL
| -			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
| -				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
| +			if (dp->flags & _DPRINTK_FLAGS_ENABLE) {
| +				/*
| +				 * The newflags check is to ensure that the
| +				 * static branch doesn't get disabled in step
| +				 * 3:
| +				 *
| +				 * (1) +pf
| +				 * (2) +x
| +				 * (3) -pf
| +				 */
| +				if (!(modifiers->flags & _DPRINTK_FLAGS_ENABLE) &&
| +				    !(newflags & _DPRINTK_FLAGS_ENABLE)) {
|  					static_branch_disable(&dp->key.dd_key_true);
| -			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
| +				}
| +			} else if (modifiers->flags & _DPRINTK_FLAGS_ENABLE) {
|  				static_branch_enable(&dp->key.dd_key_true);
| +			}
|  #endif
