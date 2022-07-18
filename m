Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F5577A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGRFkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640C13D55
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF6AB80F52
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847DFC341C0;
        Mon, 18 Jul 2022 05:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658122812;
        bh=87LUcZiFjIWe/vzk6Jb1Bq6M7bzKPkdcdYKImIzVThE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HhQ7gQ8TO9WomaOk72iS6hAJH0O7UjiUXcvv/Ozfq/5ABzrc1R5glgvN4AUOcZEU+
         iTqN9+Elmk/Gmjq2S9X+AfY1h0WL5EIWTIhZz4WBVTDVKGT7G18lGjeiTm4U9Bpyf+
         NCqDwZ17uono/ef8SwW2yMSMSdhvikmvJp9wT7j+c55qAqYKnWGQ8x0hm/S7JB8ssd
         dwgS1+Hdg4EqloHLl+7jHls/ob1XEmFjnxd5OaFGiU8CHxWo6P4rqJSeOVahUC0OsE
         cQ2R4si906589X2wK/1ec2VmN40126VPh8P9kv16nzPNe9RJjK8p0hhSADwsiGzpV7
         fZfQAiECpuJcA==
Date:   Mon, 18 Jul 2022 14:40:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: Re: [PATCH] selftests/kprobe: Do not test for GRP/ without event
 failures
Message-Id: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
In-Reply-To: <20220718110853.299c7631f15fd1dfb002ef6c@kernel.org>
References: <20220712161707.6dc08a14@gandalf.local.home>
        <20220718110853.299c7631f15fd1dfb002ef6c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 11:08:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Jul 2022 16:17:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A new feature is added where kprobes (and other probes) do not need to
> > explicitly state the event name when creating a probe. The event name will
> > come from what is being attached.
> > 
> > That is:
> > 
> >   # echo 'p:foo/ vfs_read' > kprobe_events
> > 
> > Will no longer error, but instead create an event:
> > 
> >   # cat kprobe_events
> >  p:foo/p_vfs_read_0 vfs_read
> > 
> > This should not be tested as an error case anymore. Remove it from the
> > selftest as now this feature "breaks" the selftest as it no longer fails
> > as expected.
> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, in this case, NO_EVENT_NAME error should not happen anymore.
> Let me cleanup the code.

Oops, no. There is an error case of NO_EVENT_NAME. 'p: vfs_read' will cause
this error because it expects an event name after ':'. Thus, the correct
fix is just removing "foo/":

check_error 'p:^ vfs_read'		# NO_EVENT_NAME

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
