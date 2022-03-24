Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BE4E6ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355422AbiCXWfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355409AbiCXWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816205C355
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B54E615BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E774C340EC;
        Thu, 24 Mar 2022 22:33:22 +0000 (UTC)
Date:   Thu, 24 Mar 2022 18:33:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] ftrace: Make ftrace_graph_is_dead() static inline
Message-ID: <20220324183320.000d7088@gandalf.local.home>
In-Reply-To: <529ece004e0901ca04ea0e07d6bf8476612e2294.1648116004.git.christophe.leroy@csgroup.eu>
References: <529ece004e0901ca04ea0e07d6bf8476612e2294.1648116004.git.christophe.leroy@csgroup.eu>
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

On Thu, 24 Mar 2022 11:01:45 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> @@ -1006,7 +1006,20 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  extern int register_ftrace_graph(struct fgraph_ops *ops);
>  extern void unregister_ftrace_graph(struct fgraph_ops *ops);
>  
> -extern bool ftrace_graph_is_dead(void);
> +/**
> + * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
> + *
> + * ftrace_graph_stop() is called when a severe error is detected in
> + * the function graph tracing. This function is called by the critical
> + * paths of function graph to keep those paths from doing any more harm.
> + */
> +extern bool kill_ftrace_graph;
> +
> +static inline bool ftrace_graph_is_dead(void)
> +{
> +	return kill_ftrace_graph;
> +}
> +
>  extern void ftrace_graph_stop(void);

The reason I did not expose that variable, is because I didn't want it to
be touched outside of the kernel/trace directory. Or the ftrace.c file for
that matter (although, I could put it in fgraph.c :-/)

What would be better, is to make it a static branch.

extern struct static_key fgraph_dead;

static inline bool ftrace_graph_is_dead(void)
{
	if (static_key_false(&fgraph_dead))
		return true;
	return false;
}

That way we even get rid of the conditional branch.

Yeah, the fgraph_dead is still exposed for anyone to touch, but it still
requires a function to modify it, so I'm not as worried it will be touched
as easily.

-- Steve
