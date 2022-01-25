Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7986C49BDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiAYVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiAYVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:23:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388AC06173B;
        Tue, 25 Jan 2022 13:23:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 572F9617D6;
        Tue, 25 Jan 2022 21:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A2C340E0;
        Tue, 25 Jan 2022 21:23:28 +0000 (UTC)
Date:   Tue, 25 Jan 2022 16:23:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125162326.3d1ca960@gandalf.local.home>
In-Reply-To: <202201251256.CCCBE9851E@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 12:57:24 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Jan 25, 2022 at 11:31:54PM +0900, Masami Hiramatsu wrote:
> > On Tue, 25 Jan 2022 22:27:32 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > > /*
> > > >  * struct trace_event_data_offsets_<call> {
> > > >  *      u32                             <item1>;
> > > >  *      u32                             <item2>;
> > > >  *      [...]
> > > >  * };
> > > >  *
> > > >  * The __dynamic_array() macro will create each u32 <item>, this is
> > > >  * to keep the offset of each array from the beginning of the event.
> > > >  * The size of an array is also encoded, in the higher 16 bits of
> > > >  * <item>.
> > > >  */
> > > > 
> > > > So, I think -Warray-bounds is refusing to see the destination as
> > > > anything except a u32, but being accessed at 4 (sizeof(u32)) + 8
> > > > (address && 0xffff) (?)  
> > > 
> > > Ah, I got it. Yes, that's right. __data_loc() will access the data
> > > from the __entry, but the __rel_loc() points the same address from
> > > the encoded field ("__rel_loc_foo" in this case) itself.
> > > This is introduced for the user application event, which doesn't
> > > know the actual __entry size because the __entry includes some
> > > kernel internal defined fields.
> > >   
> > > > But if this is true, I would imagine there would be plenty of other
> > > > warnings? I'm currently stumped.  
> > > 
> > > That is because __rel_loc is used only in the sample code in the kernel
> > > for testing. Other use-cases comes from user-space.
> > > Hmm, can we skip this boundary check for this example?  
> > 
> > If the -Warray-bounds determines the destination array size from
> > the type of given pointer, we can just change the macro as below;
> > 
> > #define __get_rel_dynamic_array(field) 
> > 			((void *)__entry +                                 \
> > 			 offsetof(typeof(*__entry), __rel_loc_##field) +   \
> > 			 sizeof(__entry->__rel_loc_##field) +              \
> > 			 (__entry->__rel_loc_##field & 0xffff))
> > 
> > This must works same as __get_dynamic_array() macro.
> > 
> > Could you try this patch?
> > 
> > From 2982ba01367ec1f746a4f128512436e5325a7f9d Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Tue, 25 Jan 2022 23:19:30 +0900
> > Subject: [PATCH] tracing: Avoid -Warray-bounds warning for __rel_loc macro
> > 
> > Since -Warray-bounds checks the destination size from the
> > type of given pointer, __assign_rel_str() macro gets warned
> > because it passes the pointer to the 'u32' field instead of
> > 'trace_event_raw_*' data structure.
> > Pass the data address calculated from the 'trace_event_raw_*'
> > instead of 'u32' __rel_loc field.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  include/trace/trace_events.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index 8c6f7c433518..65d927e059d3 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
> >  #define __get_str(field) ((char *)__get_dynamic_array(field))
> >  
> >  #undef __get_rel_dynamic_array
> > -#define __get_rel_dynamic_array(field)	\
> > -		((void *)(&__entry->__rel_loc_##field) +	\
> > -		 sizeof(__entry->__rel_loc_##field) +		\
> > +#define __get_rel_dynamic_array(field)					\
> > +		((void *)__entry + 					\
> > +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> > +		 sizeof(__entry->__rel_loc_##field) +			\
> >  		 (__entry->__rel_loc_##field & 0xffff))
> >  
> >  #undef __get_rel_dynamic_array_len  
> 
> This patch doesn't silence the warning, but now that I see the shape of
> things more clearly, let me see if I can find the right combo.

Hmm, could the zero size array cause an issues here. That is, does this
help?

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 65d927e059d3..3d29919045af 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -128,7 +128,7 @@ TRACE_MAKE_SYSTEM_STR();
 	struct trace_event_raw_##name {					\
 		struct trace_entry	ent;				\
 		tstruct							\
-		char			__data[0];			\
+		char			__data[];			\
 	};								\
 									\
 	static struct trace_event_class event_class_##name;


-- Steve
