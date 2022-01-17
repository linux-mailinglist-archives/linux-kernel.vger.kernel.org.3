Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174B1490B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiAQPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:14:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiAQPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:14:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BBCAB80EF1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFD0C36AE7;
        Mon, 17 Jan 2022 15:14:15 +0000 (UTC)
Date:   Mon, 17 Jan 2022 10:14:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: WARNING: modpost:
 vmlinux.o(.text.unlikely+0x2c44): Section mismatch in reference from the
 function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <20220117101413.51edd7fa@rorschach.local.home>
In-Reply-To: <cea7d17b-1994-e2cb-7580-4bd2f287ebdd@intel.com>
References: <202112210114.CFpCHRci-lkp@intel.com>
        <20220110185100.6c4c226c@gandalf.local.home>
        <cea7d17b-1994-e2cb-7580-4bd2f287ebdd@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 16:32:38 +0800
"Chen, Rong A" <rong.a.chen@intel.com> wrote:

> > 
> > Please tell me where initcall_level_names is being referenced?
> > 
> > Either fix the compiler or tell me exactly what the bug is. Otherwise, stop
> > sending me this.
> > 
> > -- Steve  
> 
> Hi Steve,
> 
> I'm not familiar with the code, the warning can be silenced with the 
> below change:
> 
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(trace_define_field);
>          if (ret)                                                        \
>                  return ret;
> 
> -static int trace_define_generic_fields(void)
> +static __init int trace_define_generic_fields(void)
>   {
>          int ret;
> 
> @@ -174,7 +174,7 @@ static int trace_define_generic_fields(void)
>          return ret;
>   }
> 
> -static int trace_define_common_fields(void)
> +static __init int trace_define_common_fields(void)
>   {
>          int ret;
>          struct trace_entry ent;
> 
> If the warning can't be fixed, we'll add the warning to the ignore list.
> 

So the issue is that an __init function calls a static function that
isn't marked as __init?

I guess it can be updated, but seriously, there's nothing bad that can
happen with the above, and it still looks to me as an over aggressive
compiler.

-- Steve
