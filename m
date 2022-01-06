Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAA485D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbiAFAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbiAFAsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:48:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E71C0611FD;
        Wed,  5 Jan 2022 16:48:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9A7619FF;
        Thu,  6 Jan 2022 00:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB35C36AE9;
        Thu,  6 Jan 2022 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641430082;
        bh=/n4TYkRZyJxRZrK+39C7W2Ad7P+ontm5qgFpCwVt6+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HNaWJeaeQV3xCHOCx1Ng7WixW0iROwf5rpxSJmFL1+ZbF75phjNyuOsIFLkV8jnvU
         jnQkklIWEjJobVs6j/XnZsxBefpaWirJmBGb5fbmb7BR1jj7QSnosdwR4Vcb8v73GI
         zy+fF+p+fVAItrB+WlLQQH1NrEEQSdsayiPhpxTd3NYMB0sIYCi1uvZV3k6bH8gyHw
         zr37QpoP08Yq7XXJCgHoDVXw7Ctd6nkAlktRcykBX3ceJKL3wk+lTHcQVrDo5U1Ho7
         pEiAhWHilFu8YnTFtuXgBE4xQiPFrb703lQAKJK76WBwPUY7k2/13WCmg3HwT/ls/e
         Akevck6E2fatg==
Date:   Thu, 6 Jan 2022 09:47:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: remove unneeded initialization in
 __trace_uprobe_create()
Message-Id: <20220106094758.7f6e5b12962639559cf9afb8@kernel.org>
In-Reply-To: <20220105185715.0b40cb3f@gandalf.local.home>
References: <20211227125308.25787-1-lukas.bulwahn@gmail.com>
        <20220105185715.0b40cb3f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 18:57:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami, want to ack this?
> 
> -- Steve
> 
> 
> On Mon, 27 Dec 2021 13:53:08 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > There is no need to initialize ret with 0, as all the early error branches
> > simply return constant values, and the default path always reaches
> > ret = kern_path(filename, LOOKUP_FOLLOW, &path), which will reset ret
> > before the initial value was ever used.
> > 
> > Remove this unneeded initialization and keep the code succinct.

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Regards,

> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  kernel/trace/trace_uprobe.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 5921951a0d5c..9da10c5efdce 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -548,7 +548,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >  	bool is_return = false;
> >  	int i, ret;
> >  
> > -	ret = 0;
> >  	ref_ctr_offset = 0;
> >  
> >  	switch (argv[0][0]) {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
