Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7949B521
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386963AbiAYNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576989AbiAYN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:27:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1EC06176C;
        Tue, 25 Jan 2022 05:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3434B81809;
        Tue, 25 Jan 2022 13:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C58C340E0;
        Tue, 25 Jan 2022 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643117256;
        bh=93EA8nZNnOBIqZcFg5IYLq0NTFEbXXxEC8zsYAcHrz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lz08uuv8FV0AGzdaWXz7c2VSw6PGWgLqrvd9hKgIvdslhBTHfqKg+tkShkzQ/cSt4
         fAfwqIrfDU8ifzECM4JST5adNgv6ZGLXZbmvtk7bVLuBPx8GtIw2+A1bJWqmm0sCer
         cyuSXIk+yeeNgRhpc8zQiAcMbT3sv+2ZAoWlIp1cyzgdReac6scIS6mMHRkey22tA8
         r/pXftowJKV6FC+m8JdyO+ZDKn3MeS0WDDGFtmJRHIPH4AwGO3oyMGS11alM1vUOOR
         nnC9qnwZ6rgO08vHvmAl+vpc1FqEN23w5EykYmwlaSel9svXPfQo6hl5xBz+4n79/s
         fFYjtHyk5fFBQ==
Date:   Tue, 25 Jan 2022 22:27:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-Id: <20220125222732.98ce2e445726e773f40e122e@kernel.org>
In-Reply-To: <202201242230.C54A6BCDFE@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, 24 Jan 2022 23:44:05 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Jan 25, 2022 at 02:50:06PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the kspp tree, today's linux-next build (powerpc
> > allmodconfig) failed like this:
> > 
> > In file included from include/linux/string.h:253,
> >                  from include/linux/bitmap.h:11,
> >                  from include/linux/cpumask.h:12,
> >                  from include/linux/mm_types_task.h:14,
> >                  from include/linux/mm_types.h:5,
> >                  from include/linux/buildid.h:5,
> >                  from include/linux/module.h:14,
> >                  from samples/trace_events/trace-events-sample.c:2:
> > In function '__fortify_strcpy',
> >     inlined from 'perf_trace_foo_rel_loc' at samples/trace_events/./trace-events-sample.h:519:1:
> > include/linux/fortify-string.h:47:33: error: '__builtin_strcpy' offset 12 is out of the bounds [0, 4] [-Werror=array-bounds]
> 
> -Warray-bounds thinks something is trying to get at offset 12 of an
> object it thinks is only 4 bytes in size.
> 
> >    47 | #define __underlying_strcpy     __builtin_strcpy
> >       |                                 ^
> > include/linux/fortify-string.h:445:24: note: in expansion of macro '__underlying_strcpy'
> >   445 |                 return __underlying_strcpy(p, q);
> >       |                        ^~~~~~~~~~~~~~~~~~~
> > 
> > Exposed by (probably) commit
> > 
> >   602670289b69 ("fortify: Detect struct member overflows in memcpy() at compile-time")
> > 
> > Introduced by commit
> > 
> >   b466b1332164 ("samples/trace_event: Add '__rel_loc' using sample event")
> > 
> > I have reverted that latter commit for today.
> 
> Digging through the macros, I end up reconstructing this:
> 
> 	strcpy( (char *)((void *)(&__entry->__rel_loc_foo) +
> 				  sizeof(__entry->__rel_loc_foo) +
> 				  (__entry->__rel_loc_foo & 0xffff)),
> 		foo ? (const char *)(foo) : "(null)");
> 
> I couldn't figure out how __entry is being allocated, but it seemed
> maybe related to this note:

The __entry is the trace-event entry on the trace ring_buffer. This
reserved an entry (area) on the ring_buffer and fills it with
given traced data. "__rel_loc_foo" is the a field on the entry,
which type is u32. This should be something like this.

struct {
  ...
  u32 __rel_loc_foo;
  ...
} *__entry;

> 
> /*
>  * struct trace_event_data_offsets_<call> {
>  *      u32                             <item1>;
>  *      u32                             <item2>;
>  *      [...]
>  * };
>  *
>  * The __dynamic_array() macro will create each u32 <item>, this is
>  * to keep the offset of each array from the beginning of the event.
>  * The size of an array is also encoded, in the higher 16 bits of
>  * <item>.
>  */
> 
> So, I think -Warray-bounds is refusing to see the destination as
> anything except a u32, but being accessed at 4 (sizeof(u32)) + 8
> (address && 0xffff) (?)

Ah, I got it. Yes, that's right. __data_loc() will access the data
from the __entry, but the __rel_loc() points the same address from
the encoded field ("__rel_loc_foo" in this case) itself.
This is introduced for the user application event, which doesn't
know the actual __entry size because the __entry includes some
kernel internal defined fields.

> But if this is true, I would imagine there would be plenty of other
> warnings? I'm currently stumped.

That is because __rel_loc is used only in the sample code in the kernel
for testing. Other use-cases comes from user-space.
Hmm, can we skip this boundary check for this example?

Thank you,

> 
> Reading 55de2c0b5610 ("tracing: Add '__rel_loc' using trace event
> macros") did not help me. ;)
> 
> -Kees
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
