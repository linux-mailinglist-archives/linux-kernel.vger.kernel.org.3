Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399E157CE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiGUOzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGUOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A913E3B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5252B82472
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07CDC3411E;
        Thu, 21 Jul 2022 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658415344;
        bh=PzmXzO0OGI8+AukQJZUMy/PSmU3hi9+I1oGnrrJOq5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tJuFU0CPMVa9GI4+tbmHMFcn1ZCvjrj45fYFY8+cS5dDT1Vqa8FBT2Qmj5/qogfAx
         wV74R3bSi+jqkP1d4q5a15us1/55k6gLuEySxyacgKwPzb4dkJNh1nc2M9NhQsmMAe
         xYFdkM/bSimMkO2Tep+lLnxKJhy8n9T1gbpn1qsFAQajLln1pL65WOYHjL2dQbbS3j
         f16bGKVQQUtr+ghG+ZS/59xV7hmQ6W5KlDb1VgwarjiCDVncqX6BHtu02wYIsBzgld
         Q/TQqnjfBguSUpWu/0BisWL6mcLticzyz6F3UrvEeDOvRO9vKbVcJTThte+5jsjJA2
         lRAuJo6lXeXrg==
Date:   Thu, 21 Jul 2022 23:55:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/kprobe: Update test for no event name syntax
 error
Message-Id: <20220721235540.a9e068f9dbb442aa44c117c9@kernel.org>
In-Reply-To: <1c530e9b-3184-0113-d8ef-47548d7ab173@quicinc.com>
References: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
        <165812790993.1377963.9762767354560397298.stgit@devnote2>
        <1c530e9b-3184-0113-d8ef-47548d7ab173@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 17:36:43 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> hi Masami,
> 
> On 7/18/2022 3:05 PM, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > The commit 208003254c32 ("selftests/kprobe: Do not test for GRP/
> > without event failures") removed a syntax which is no more cause
> > a syntax error (NO_EVENT_NAME error with GRP/).
> > However, there are another case (NO_EVENT_NAME error without GRP/)
> > which causes a same error. This adds a test for that case.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > index 7c02509c71d0..9e85d3019ff0 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > @@ -21,6 +21,7 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
> >   check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
> >   
> >   check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
> > +check_error 'p:^ vfs_read'		# NO_EVENT_NAME
> 
> i think you fix the issue which exist from start, right ?

Yes, this is not a new bug but the error case which still
exists.

> 
> is there better comment than NO_EVENT_NAME  ?

These comments are corresponding to the error name, so that we can
find the logging code easily. (Not for users)

Thank you,

> 
> >   check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
> >   check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
> >   
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
