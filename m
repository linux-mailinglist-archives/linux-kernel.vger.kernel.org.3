Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4BC4A9DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbiBDRoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiBDRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:44:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC551C061714;
        Fri,  4 Feb 2022 09:44:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C08CCE23C8;
        Fri,  4 Feb 2022 17:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D48C004E1;
        Fri,  4 Feb 2022 17:44:27 +0000 (UTC)
Date:   Fri, 4 Feb 2022 12:44:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 4/4] rtla/osnoise: Fix segmentation fault when failing
 to enable -t
Message-ID: <20220204124426.54d82ce2@gandalf.local.home>
In-Reply-To: <264ff7941b7551ec0b6e5862e40cf3dd593d0ff0.1643990447.git.bristot@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
        <264ff7941b7551ec0b6e5862e40cf3dd593d0ff0.1643990447.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2022 17:24:05 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -750,6 +750,9 @@ void osnoise_put_context(struct osnoise_context *context)
>   */
>  void osnoise_destroy_tool(struct osnoise_tool *top)
>  {
> +	if (!top)
> +		return;
> +
>  	trace_instance_destroy(&top->trace);
>  
>  	if (top->context)

Um, don't you still need to initialize everything to NULL?

i.e.

nt osnoise_top_main(int argc, char **argv)
{
        struct osnoise_top_params *params;
        struct trace_instance *trace;
        struct osnoise_tool *record;
        struct osnoise_tool *tool;
        int return_value = 1;
        int retval;



Does not guarantee that record and tool will be initialized to NULL.

-- Steve
