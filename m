Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4E48E968
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiANLq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:46:56 -0500
Received: from smtp2.axis.com ([195.60.68.18]:4161 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237600AbiANLq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642160816;
  x=1673696816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMs+u9nkmpDZ5lxA/fLhYjA5QxFXQFce1TTDfia+q9o=;
  b=prxnNYcOGGmim/hX7bJaOw0U9IHxVljTedagnTFSF7/qctkZakI54WWK
   RlM6AWHnhDj/ULGTxKWnKayKUvqYjLEeaGdTzsQBiVNGOcLEu2hqSrWZI
   vpdH/Bx/jenFQxulF3VtI4OSTXaEZc5Sb86g7IN3BTYVJugQW6GQKkWlx
   nJPuODvDeCGImPG9JuqurCHBYIaA7KTMCBAIvSeY2lQQgKDwmlDc9T8Mj
   q/crapUg10o4os+ZXmQCSk5WGHexbmrCwUCOTIE+QO5+tZBK68ntsIFIY
   ENdJMW4zl0yMtJuu7Xit1OBwLMRKLiSMzlUatAw0HgoUPzvEpa89hPeR1
   g==;
Date:   Fri, 14 Jan 2022 12:46:54 +0100
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
Subject: Re: [PATCH v11 03/19] dyndbg: add write-to-tracefs code
Message-ID: <20220114114654.GA23983@axis.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
 <20220107052942.1349447-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220107052942.1349447-4-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 06:29:26AM +0100, Jim Cromie wrote:
> adds: dynamic_trace()
>  uses trace_console() temporarily to issue printk:console event
>  uses internal-ish __ftrace_trace_stack code:
>       4-context buffer stack, barriers per Steve
> 
> call it from new funcs:
>   dynamic_printk() - print to both syslog/tracefs
>   dynamic_dev_printk() - dev-print to both syslog/tracefs
> 
> These handle both _DPRINTK_FLAGS_PRINTK and _DPRINTK_FLAGS_TRACE
> cases, allowing to vsnprintf the message once and use it for both,
> skipping past the KERN_DEBUG character for tracing.
> 
> Finally, adjust the callers: __dynamic_{pr_debug,{,net,ib}dev_dbg},
> replacing printk and dev_printk with the new funcs above.
> 
> The _DPRINTK_FLAGS_TRACE flag character s 'T', so the following finds
> all callsites enabled for tracing:
> 
>   grep -P =p?T /proc/dynamic_debug/control
> 
> Enabling debug-to-tracefs is 2 steps:
> 
>   # event enable
>   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
>   # callsite enable
>   echo module foo +T > /proc/dynamic_debug/control
> 
> This patch,~1,~2 are based upon:
>   https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/
> 
> .. with simplification of temporarily reusing trace_console() rather
> than adding a new printk:dyndbg event.  Soon, add 2 new events
> capturing the pr_debug & dev_dbg() args.

The example above does not match the code in this patch since the
dyndbg:* events are only added in a later patch.  Perhaps you could
reorder this patch stack so that you don't use trace_console() in this
patch just to replace it with the new events in the next patch?

> 
> CC: vincent.whitchurch@axis.com
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |   1 +
>  lib/dynamic_debug.c                           | 155 +++++++++++++++---
>  2 files changed, 130 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
[...]
> @@ -723,29 +822,33 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  {
>  	struct va_format vaf;
>  	va_list args;
> +	unsigned int flags;
>  
>  	va_start(args, fmt);
>  
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> +	flags = descriptor->flags;
>  
>  	if (ibdev && ibdev->dev.parent) {
>  		char buf[PREFIX_SIZE] = "";
>  
> -		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
> -				"%s%s %s %s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> -				dev_driver_string(ibdev->dev.parent),
> -				dev_name(ibdev->dev.parent),
> -				dev_name(&ibdev->dev),
> -				&vaf);
> +		dynamic_dev_printk(flags, ibdev->dev.parent,
> +				   "%s%s %s %s: %pV",
> +				   dynamic_emit_prefix(descriptor, buf),
> +				   dev_driver_string(ibdev->dev.parent),
> +				   dev_name(ibdev->dev.parent),
> +				   dev_name(&ibdev->dev),
> +				   &vaf);
>  	} else if (ibdev) {
> -		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "%s%s: %pV",
> +			       dev_name(&ibdev->dev), &vaf);
>  	} else {
> -		printk(KERN_DEBUG "(NULL ib_device): %pV", &vaf);
> +		dynamic_printk(flags, KERN_DEBUG "(NULL ip_device): %pV",
> +			       &vaf);
>  	}
>  
> -	va_end(args);
> +va_end(args);

This looks like an unintentional whitespace change?
