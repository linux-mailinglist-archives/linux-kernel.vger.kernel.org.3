Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0C49BE65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiAYWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:21:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33614 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiAYWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:21:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFCF617DA;
        Tue, 25 Jan 2022 22:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAFC340E0;
        Tue, 25 Jan 2022 22:21:15 +0000 (UTC)
Date:   Tue, 25 Jan 2022 17:21:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125172114.6807ed8f@gandalf.local.home>
In-Reply-To: <202201251402.0FB08DB@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 14:07:14 -0800
Kees Cook <keescook@chromium.org> wrote:

> > The tstruct is the TP_STRUCT__entry() and for each __rel_dynamic_array() or
> > __dynamic_array(), the __data_size gets updated and saved into the
> > __data_offsets that holds where each item is.
> > 
> > The rel versions sets the offset from its location to the data, where as
> > the non rel versions sets the offset from the beginning of the event to the
> > data.  
> 
> Could this just be
> 
> #define __get_rel_dynamic_array(field) \
> 	((void *)(&__entry->data[__entry->__rel_loc_##field & 0xffff])
> 
> ?

This is currently user space defined. But since the only user of the rel_*
version hasn't been upstreamed yet, we could change it. But it also
requires changing libtraceevent as it depends on this code too.

I'm surprised that it doesn't break with the __get_dynamic_array()
versions, or is that because it's based off of __entry?

-- Steve
