Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40801577989
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGRCJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGRCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:09:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90210559
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8A4AB80EFF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18758C3411E;
        Mon, 18 Jul 2022 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658110137;
        bh=b9NvY9iu91PN+nbkdFil7z6UnA+30tNfJQaKaf1Zn10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=beEwHQISvatVEaFlarkpSupiipxJaHpyjCVF9621I+QVIcUP5h55jqstJR+0qWl87
         6UFkb/CYJ1mWl8iRmfQzXq5zwwsu12YzUGKePog1NbBMkc/oE+TmnDP97W3UGJV4GG
         woWfCTI0rK9ciHRgbeOkx+YG4EuFmfIgM9lSM49d0XWm/3NBQvoyhehYSly8u2Qs1X
         vZxCW0bsUtwStKWtouHpulwyAq8lgkMQNVm8ZykqYhPORTDvZrQd2Ee/8AhYOd4bOv
         BcHmx7rhkusdr2BG1vOLVaXG2hgfzQJhVr5c03cbHTVCZG62//jbSHiBPZh9ipRrIx
         NeWcAD5swec3Q==
Date:   Mon, 18 Jul 2022 11:08:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: Re: [PATCH] selftests/kprobe: Do not test for GRP/ without event
 failures
Message-Id: <20220718110853.299c7631f15fd1dfb002ef6c@kernel.org>
In-Reply-To: <20220712161707.6dc08a14@gandalf.local.home>
References: <20220712161707.6dc08a14@gandalf.local.home>
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

On Tue, 12 Jul 2022 16:17:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new feature is added where kprobes (and other probes) do not need to
> explicitly state the event name when creating a probe. The event name will
> come from what is being attached.
> 
> That is:
> 
>   # echo 'p:foo/ vfs_read' > kprobe_events
> 
> Will no longer error, but instead create an event:
> 
>   # cat kprobe_events
>  p:foo/p_vfs_read_0 vfs_read
> 
> This should not be tested as an error case anymore. Remove it from the
> selftest as now this feature "breaks" the selftest as it no longer fails
> as expected.

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, in this case, NO_EVENT_NAME error should not happen anymore.
Let me cleanup the code.

Thank you,

> 
> Link: https://lore.kernel.org/all/1656296348-16111-1-git-send-email-quic_linyyuan@quicinc.com/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc       | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index fa928b431555..7c02509c71d0 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -21,7 +21,6 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
>  check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
>  
>  check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
> -check_error 'p:foo/^ vfs_read'		# NO_EVENT_NAME
>  check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
>  check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
