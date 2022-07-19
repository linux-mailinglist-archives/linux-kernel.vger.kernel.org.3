Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC257A2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiGSPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiGSPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F8564E7;
        Tue, 19 Jul 2022 08:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614196183C;
        Tue, 19 Jul 2022 15:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C198C341C6;
        Tue, 19 Jul 2022 15:24:49 +0000 (UTC)
Date:   Tue, 19 Jul 2022 11:24:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
Message-ID: <20220719112448.4e9915e0@gandalf.local.home>
In-Reply-To: <2893728a294ef13bdeba9e587083b82fb794cc68.camel@mediatek.com>
References: <20220714164256.403842845@goodmis.org>
        <20220714164330.311734558@goodmis.org>
        <1267b234b09280b9b475cfe2bb32580e967e2dac.camel@mediatek.com>
        <20220715173944.386743d8@gandalf.local.home>
        <2893728a294ef13bdeba9e587083b82fb794cc68.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 13:23:06 +0800
Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> > Care to send me a patch, and I'll just include it in my series?  
> Seems no need add another patch, just modify this patch as below:
> 
> diff --git a/drivers/usb/mtu3/mtu3_trace.h
> b/drivers/usb/mtu3/mtu3_trace.h
> index a09deae1146f..03d2a9bac27e 100644
> --- a/drivers/usb/mtu3/mtu3_trace.h
> +++ b/drivers/usb/mtu3/mtu3_trace.h
> @@ -18,18 +18,16 @@
> 
>  #include "mtu3.h"
> 
> -#define MTU3_MSG_MAX   256
> -
>  TRACE_EVENT(mtu3_log,
>         TP_PROTO(struct device *dev, struct va_format *vaf),
>         TP_ARGS(dev, vaf),
>         TP_STRUCT__entry(
>                 __string(name, dev_name(dev))
> -               __dynamic_array(char, msg, MTU3_MSG_MAX)
> +               __vstring(msg, vaf->fmt, vaf->va)
>         ),
>         TP_fast_assign(
>                 __assign_str(name, dev_name(dev));
> -               vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf-
> >va);  
> +               __assign_vstr(msg, vaf->fmt, vaf->va);
>         ),
>         TP_printk("%s: %s", __get_str(name), __get_str(msg))
>  );
> >   
> 
> remove below two lines
> "
> -#define MTU3_MSG_MAX   256
> -

Fine.

Even though I already pushed to linux-next, I did something I seldom do. I
rebased my for-next branch and removed this patch.

I'll send a v2.

-- Steve
