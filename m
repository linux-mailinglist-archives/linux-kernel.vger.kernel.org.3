Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3125050E3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiDYPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiDYPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C81119EFF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FB96169F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE7C385A7;
        Mon, 25 Apr 2022 14:59:24 +0000 (UTC)
Message-ID: <6a8e2b72f44047985b976423887aa06413503d9a.camel@kernel.org>
Subject: Re: [PATCH] tracing: Fix potential double free in create_var_ref()
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 09:59:22 -0500
In-Reply-To: <20220423001311.31e2dff59708ddd3043e55af@kernel.org>
References: <20220422060025.1436075-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
         <20220423001311.31e2dff59708ddd3043e55af@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 00:13 +0900, Masami Hiramatsu wrote:
> Hi Keita,
> 
> On Fri, 22 Apr 2022 06:00:25 +0000
> Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:
> 
> > In create_var_ref(), init_var_ref() is called to initialize the
> > fields
> > of variable ref_field, which is allocated in the previous function
> > call
> > to create_hist_field(). Function init_var_ref() allocates the
> > corresponding fields such as ref_field->system, but frees these
> > fields
> > when the function encounters an error. The caller later calls
> > destroy_hist_field() to conduct error handling, which frees the
> > fields
> > and the variable itself. This results in double free of the fields
> > which
> > are already freed in the previous function.
> > 
> > Fix this by storing NULL to the corresponding fields when they are
> > freed
> > in init_var_ref().
> > 
> 
> Good catch! this looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>


Looks fine to me too, thanks,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> 
> 
> BTW, could you Cc the original code authoer and  if you fix a bug and
> add Fixes: tag? That will help the original author can check the bug
> and
> help stable kernel maintainers to pick the patch. :)
> 
> To find the original commit, you can use the 'git blame'.
> 
> $ git blame kernel/trace/trace_events_hist.c -L 2093,2100
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600
> 2093)      return err;
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2094)  free:
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600
> 2095)      kfree(ref_field->system);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600
> 2096)      kfree(ref_field->event_name);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600
> 2097)      kfree(ref_field->name);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2098) 
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2099)      goto
> out;
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2100) }
> 
> Then, git show will tell you the original author.
> $ git show 067fe038e70f6
> 
> And get the format of the commit for Fixes tag.
> 
> $ git --no-pager show -s --abbrev-commit --abbrev=12 --
> pretty=format:"%h (\"%s\")%n" 067fe038e70f6
> 067fe038e70f ("tracing: Add variable reference handling to hist
> triggers")
> 
> Then you can add lines like:
> 
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to
> hist triggers")
> Cc: stable@vger.kernel.org
> 
> Thank you,
> 
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> >  kernel/trace/trace_events_hist.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 44db5ba9cabb..a0e41906d9ce 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -2093,8 +2093,11 @@ static int init_var_ref(struct hist_field
> > *ref_field,
> >  	return err;
> >   free:
> >  	kfree(ref_field->system);
> > +	ref_field->system = NULL;
> >  	kfree(ref_field->event_name);
> > +	ref_field->event_name = NULL;
> >  	kfree(ref_field->name);
> > +	ref_field->name = NULL;
> >  
> >  	goto out;
> >  }
> > -- 
> > 2.25.1
> > 
> 
> 

