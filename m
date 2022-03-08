Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1334D1BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbiCHPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347891AbiCHPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:37:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165E94E3B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6692615EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FFC340EB;
        Tue,  8 Mar 2022 15:37:00 +0000 (UTC)
Date:   Tue, 8 Mar 2022 10:36:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 33/41]
 include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <20220308103658.05c88722@gandalf.local.home>
In-Reply-To: <202203082112.Iu7tvFl4-lkp@intel.com>
References: <202203082112.Iu7tvFl4-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 21:15:29 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:253,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:22,
>                     from arch/x86/include/asm/timex.h:5,
>                     from include/linux/timex.h:65,
>                     from include/linux/time32.h:13,
>                     from include/linux/time.h:60,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from kernel/trace/trace_events_hist.c:8:
>    In function 'strncat',
>        inlined from 'last_cmd_set' at kernel/trace/trace_events_hist.c:760:2,
>        inlined from 'event_hist_trigger_parse' at kernel/trace/trace_events_hist.c:6191:3:
> >> include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]  
>       47 | #define __underlying_strncat __builtin_strncat
>          |                              ^
>    include/linux/fortify-string.h:191:10: note: in expansion of macro '__underlying_strncat'
>      191 |   return __underlying_strncat(p, q, count);
>          |          ^~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_events_hist.c: In function 'event_hist_trigger_parse':
>    include/linux/fortify-string.h:46:29: note: length computed here
>       46 | #define __underlying_strlen __builtin_strlen
>          |                             ^
>    include/linux/fortify-string.h:102:10: note: in expansion of macro '__underlying_strlen'
>      102 |   return __underlying_strlen(p);
>          |          ^~~~~~~~~~~~~~~~~~~

I see my mistake. The code it's talking about is this:

	len = sizeof(HIST_PREFIX) + strlen(str) + 1;
	kfree(last_cmd);
	last_cmd = kzalloc(len, GFP_KERNEL);
	if (!last_cmd)
		return;

	strcpy(last_cmd, HIST_PREFIX);
	len -= sizeof(HIST_PREFIX) + 1;
	strncat(last_cmd, str, len);


Where according to the man page of strncat:

     If src contains n or more bytes, strncat() writes n+1 bytes to dest (n
     from src plus the terminating null byte).  Therefore, the size of dest
     must be at least strlen(dest)+n+1.

The above did: len -= sizeof(HIST_PREFIX) + 1; when it meant to do:

  len -= strlen(HIST_PREFX) + 1

Or it could just do:

  len -= sizeof(HIST_PREFIX)

as sizeof(HIST_PREFIX) contains the nul byte.

Heck, the allocation could be:

	len = sizeof(HIST_PREFIX) + strlen(str);

As the sizeof already contains the nul byte.

Will fix.

Thanks,

-- Steve
