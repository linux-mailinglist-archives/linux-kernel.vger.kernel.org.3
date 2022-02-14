Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915E4B5781
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356745AbiBNQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:57:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBNQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:57:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001AA48892
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C30CB811EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33F8C340EE;
        Mon, 14 Feb 2022 16:57:05 +0000 (UTC)
Date:   Mon, 14 Feb 2022 11:57:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 12/13]
 include/linux/fortify-string.h:47:30: error: '__builtin_strncat' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <20220214115703.31a1af37@gandalf.local.home>
In-Reply-To: <202202140628.fj6e4w4v-lkp@intel.com>
References: <202202140628.fj6e4w4v-lkp@intel.com>
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

On Mon, 14 Feb 2022 06:42:59 +0800
kernel test robot <lkp@intel.com> wrote:

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:253,
>                     from arch/x86/include/asm/page_32.h:22,
>                     from arch/x86/include/asm/page.h:14,
>                     from arch/x86/include/asm/processor.h:19,
>                     from arch/x86/include/asm/timex.h:5,
>                     from include/linux/timex.h:65,
>                     from include/linux/time32.h:13,
>                     from include/linux/time.h:60,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from kernel/trace/trace_events_hist.c:8:
>    In function 'strncat',
>        inlined from 'last_cmd_set' at
> kernel/trace/trace_events_hist.c:759:2:
> >> include/linux/fortify-string.h:47:30: error: '__builtin_strncat'
> >> output truncated before terminating nul copying as many bytes from a
> >> string as its length [-Werror=stringop-truncation]  
>       47 | #define __underlying_strncat __builtin_strncat
>          |                              ^
>    include/linux/fortify-string.h:191:10: note: in expansion of macro
> '__underlying_strncat' 191 |   return __underlying_strncat(p, q, count);
>          |          ^~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_events_hist.c: In function 'last_cmd_set':
>    include/linux/fortify-string.h:46:29: note: length computed here
>       46 | #define __underlying_strlen __builtin_strlen
>          |                             ^
>    include/linux/fortify-string.h:102:10: note: in expansion of macro
> '__underlying_strlen' 102 |   return __underlying_strlen(p);
>          |          ^~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

I have no idea what the above riddle is saying. But looking at the code, I
can figure out a few issues with it.

> static void last_cmd_set(struct trace_event_file *file, char *str)
> {
> 	const char *system = NULL, *name = NULL;
> 	struct trace_event_call *call;
> 	int len = 0;
> 
> 	if (!str)
> 		return;
> 
> 	len += sizeof(HIST_PREFIX) + strlen(str) + 1;

Nit, I have no idea why len has += and is initialized to zero. Looks like
it could have just been:

	len = sizeof(HIST_PREFIX) + strlen(str) + 1;

> 	kfree(last_cmd);
> 	last_cmd = kzalloc(len, GFP_KERNEL);
> 	if (!last_cmd)
> 		return;
> 
> 	strcpy(last_cmd, HIST_PREFIX);
> 	strncat(last_cmd, str, len - sizeof(HIST_PREFIX));

OK, I think the issue here is that "len" contains the "+1" for the nul
byte. According to the man page for strncat(), it states that "dest" needs
to be at least strlen(dest)+n+1. And since len has + 1 in it already, it
can't have it in the strncat().

Perhaps we need to change this to:

	len -= sizeof(HIST_PREFIX) + 1;
	strncat(last_cmd, str, len);

-- Steve


> 
> 	if (file) {
> 		call = file->event_call;
> 		system = call->class->system;
> 		if (system) {
> 			name = trace_event_name(call);
> 			if (!name)
> 				system = NULL;
> 		}
> 	}
> 
> 	if (system)
> 		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, HIST_PREFIX "%s:%s", system, name); }
