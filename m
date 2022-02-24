Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E284C3010
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiBXPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiBXPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:42:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881811A3D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:41:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9895A6166E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA92C340E9;
        Thu, 24 Feb 2022 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645717295;
        bh=i1VbX+3UHp78QF22K/i1FXekm2wijy/n94jgRTzywT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gE4y7mnXWB9mJwph9MNVnivBonLk66Rrr2RS8QVCfdqngOmY65GSLZyIwPF2DcOSF
         N1AB6gGbLkGyAM3aAySMasgKe3YUoWDNFYcD1u1SyiDQoTXlc4iOpFxR1c0vJOfxmj
         gUsIKztrxJXcrwq+3d3HAzEhH4k9t/8/yXcJfzYQBVnnr+og4qaqy7bLDkNX12X/kg
         IoRG2FFGd4Wu5j/sKdVpzIXvKt54WfbPedffMs7ODoObMg6dZATWpmk2YuXj1GLrQU
         sWk/b6rcjYmmKKsOf66VUAFtJdQmcp+tahXzZX07P5NTTcg4zURtP++uLIJXFyrQz1
         TJJRo3xw7a4OA==
Message-ID: <d38804da61e219e617b056a176cf8755c74c90d5.camel@kernel.org>
Subject: Re: [PATCH] tracing: Dump stacktrace trigger to the corresponding
 instance
From:   Tom Zanussi <zanussi@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Date:   Thu, 24 Feb 2022 09:41:33 -0600
In-Reply-To: <afbb0b4f18ba92c276865bc97204d438473f4ebc.1645396236.git.bristot@kernel.org>
References: <afbb0b4f18ba92c276865bc97204d438473f4ebc.1645396236.git.bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, 2022-02-20 at 23:49 +0100, Daniel Bristot de Oliveira wrote:
> The stacktrace event trigger is dumping the stacktrace to the
> instance
> where it was enabled, but to the global "instance."
> 
> Use the private_data, pointing to the trigger file, to figure out the
> corresponding trace instance, and use it in the trigger action, like
> snapshot_trigger does.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_events_trigger.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c
> b/kernel/trace/trace_events_trigger.c
> index d00fee705f9c..e0d50c9577f3 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1540,7 +1540,12 @@ stacktrace_trigger(struct event_trigger_data
> *data,
>  		   struct trace_buffer *buffer,  void *rec,
>  		   struct ring_buffer_event *event)
>  {
> -	trace_dump_stack(STACK_SKIP);
> +	struct trace_event_file *file = data->private_data;
> +
> +	if (file)
> +		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
> +	else
> +		trace_dump_stack(STACK_SKIP);
>  }
>  
>  static void


Looks good to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom




