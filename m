Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883E149C031
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiAZAfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiAZAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:35:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF20C06161C;
        Tue, 25 Jan 2022 16:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB2E614D6;
        Wed, 26 Jan 2022 00:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB6AC340E0;
        Wed, 26 Jan 2022 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643157342;
        bh=tQVezuZkX3J4Tsw6a5hn1BLIry1tdM+HWG/m/i0/4ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X3+GbHtJWxnk9bfaHzQpsjadL7uwNfL/+yo1C2e8o7psvHKI1guL7u1naLeWoDgrU
         UOk1vfzN37N9SsT7+g3YyQKePgw9u6EdZGB8cX5eV9EAS0NlziUlGWZ5e/aJ0k1yzP
         nnhDOeguna8Nr3WEf2fAyyxbp6JKVbzvwyUqYu3/MRtq/OH6NVMx5Foy2S7TyUCBM6
         5gci5sVqDMc8sUqRyyk0QTj15QGHpU3fa1vD93dXyPU+cUmkbGwZQFXFNgUSWbLZuN
         QpMhY+NhXsQGPiEc91EAak7/lIo6B8rWVaOEfU8MDmcUGGwdAwTRXwqsDiq5qbtXNK
         dyBtV+Ua9KMZg==
Date:   Wed, 26 Jan 2022 09:35:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-Id: <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
In-Reply-To: <20220125172114.6807ed8f@gandalf.local.home>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
        <20220125172114.6807ed8f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
(Ccing Beau)

On Tue, 25 Jan 2022 17:21:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 25 Jan 2022 14:07:14 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > The tstruct is the TP_STRUCT__entry() and for each __rel_dynamic_array() or
> > > __dynamic_array(), the __data_size gets updated and saved into the
> > > __data_offsets that holds where each item is.
> > > 
> > > The rel versions sets the offset from its location to the data, where as
> > > the non rel versions sets the offset from the beginning of the event to the
> > > data.  
> > 
> > Could this just be
> > 
> > #define __get_rel_dynamic_array(field) \
> > 	((void *)(&__entry->data[__entry->__rel_loc_##field & 0xffff])
> > 
> > ?
> 
> This is currently user space defined. But since the only user of the rel_*
> version hasn't been upstreamed yet, we could change it. But it also
> requires changing libtraceevent as it depends on this code too.

I think Kees' idea seems better. If you and Beau are good, I will update
the macros for __rel_loc. (This requires to change some user-space
application which Beau is making too.)

> 
> I'm surprised that it doesn't break with the __get_dynamic_array()
> versions, or is that because it's based off of __entry?

I think so. Gcc seems to check the size of the data structure where the
original base address points.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
