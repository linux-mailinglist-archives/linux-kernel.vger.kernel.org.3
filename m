Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26249CEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiAZPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiAZPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:54:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD238C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C7C6B81EFD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E80C340E3;
        Wed, 26 Jan 2022 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643212492;
        bh=IIHhUmLrk+ly/tOHaZfanJN3Jp4qrbBjymc58Is+O+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioVG4xKbhhEryA671lyFldKC1d7fBSzw12HShHDRfoQgKTGLt9H3CiRTzHuzJwKqS
         btHkF2EY/JvZhJd2qpGTtjFe5T3sRlVLWdlmHdrYUD1A962oEz82GC9OK3iI3mbnfA
         7LdzLpF+1NJJGLxg+DZIaJHbmhVaI2+Y4qM6eKh3UOqWfJRY0+4/vD+wxmKh9pbVZu
         +j8mranfOUKpHdO6nHYuLWQY69v+jh62aAS84KI7vwVRzMz/F2nTtbxEmEeKItm9zn
         1T2OdVWnRBq+vYaYMdY7DiY2Y8PuoDvYIAAPrqf+RtnSLI43xnA2yoimw1cbz7TzXi
         dVTTcRD1GbDIw==
Date:   Thu, 27 Jan 2022 00:54:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-Id: <20220127005447.143a840e9b0f67d894b8c54a@kernel.org>
In-Reply-To: <CAEr6+EB+ENLJM1vU1pPgQ4ZcYe6FDSRWwdSpY_dLq0tGqr+tnQ@mail.gmail.com>
References: <20220113013835.503285-1-xiehuan09@gmail.com>
        <20220118232448.891fbf550b50193e0155b59c@kernel.org>
        <CAEr6+EB+ENLJM1vU1pPgQ4ZcYe6FDSRWwdSpY_dLq0tGqr+tnQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, 19 Jan 2022 10:32:49 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> > > Note: when change to use the ftrace_test_recursion_trylock, all the functions
> > > will call the copy_from_kernel_nofault, I don't know where this is the problem now,
> > > maybe should fall back to the usage in v6.
> > >
> > > for example:
> > >
> > > cat-118     [000] ...1.     1.458998: __bio_add_page <-bio_add_page object:0xffff88811a12e9e8 value:0x0
> > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...1.     1.458998: __rcu_read_lock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...2.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...1.     1.458998: __rcu_read_unlock <-xa_load object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault <-trace_object_events_call object:0xffff88811a12e9e8 value:0x1000
> > > cat-118     [000] ...3.     1.458998: copy_from_kernel_nofault_allowed <-copy_from_kernel_nofault object:0xffff88811a12e9e8 value:0x1000
> > > ....
> >
> > Hmm, this is strange, but I got it is the expected behavior, since the
> > ftrace_test_recursion_trylock() accepts one stage recursion for the
> > first event in the interrupt as transition event.

I think you should revert that change and back to your own per-cpu recursion
flag instead of using ftrace_test_recursion_trylock().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
