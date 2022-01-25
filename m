Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B7C49BDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiAYV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiAYV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21325C06173B;
        Tue, 25 Jan 2022 13:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B78617D9;
        Tue, 25 Jan 2022 21:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA81C340E0;
        Tue, 25 Jan 2022 21:29:00 +0000 (UTC)
Date:   Tue, 25 Jan 2022 16:28:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125162859.2b3cc8a0@gandalf.local.home>
In-Reply-To: <20220125162326.3d1ca960@gandalf.local.home>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 16:23:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >  #undef __get_rel_dynamic_array
> > > -#define __get_rel_dynamic_array(field)	\
> > > -		((void *)(&__entry->__rel_loc_##field) +	\
> > > -		 sizeof(__entry->__rel_loc_##field) +		\
> > > +#define __get_rel_dynamic_array(field)					\
> > > +		((void *)__entry + 					\
> > > +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> > > +		 sizeof(__entry->__rel_loc_##field) +			\
> > >  		 (__entry->__rel_loc_##field & 0xffff))
> > >  
> > >  #undef __get_rel_dynamic_array_len    
> > 

I also do not like the the inconsistency between
sizeof(__entry->__rel_loc_##field) and sizeof(u32) that is used in the
calculation part:


#define __rel_dynamic_array(type, item, len)				\
	__item_length = (len) * sizeof(type);				\
	__data_offsets->item = __data_size +				\
			       offsetof(typeof(*entry), __data) -	\
			       offsetof(typeof(*entry), __rel_loc_##item) -	\
			       sizeof(u32);				\
	__data_offsets->item |= __item_length << 16;			\
	__data_size += __item_length;

Why is one using sizeof(u32) and the other using the size of the field?

Just to let you know what is happening. As dynamic elements of the trace
event needs to be appended at the end of the event, the above macros are
defined and then run through the TRACE_EVENT() macro, where the
TP_STRUCT__entry() is parsed to calculate where each item will be for that
event.

static inline notrace int trace_event_get_offsets_##call(		\
	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
{									\
	int __data_size = 0;						\
	int __maybe_unused __item_length;				\
	struct trace_event_raw_##call __maybe_unused *entry;		\
									\
	tstruct;							\
									\
	return __data_size;						\
}


The tstruct is the TP_STRUCT__entry() and for each __rel_dynamic_array() or
__dynamic_array(), the __data_size gets updated and saved into the
__data_offsets that holds where each item is.

The rel versions sets the offset from its location to the data, where as
the non rel versions sets the offset from the beginning of the event to the
data.

-- Steve
