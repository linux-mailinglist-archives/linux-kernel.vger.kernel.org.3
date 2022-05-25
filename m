Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9A5340C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiEYPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbiEYPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17D35DD7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224966155B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8540C34113;
        Wed, 25 May 2022 15:51:43 +0000 (UTC)
Date:   Wed, 25 May 2022 11:51:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     slm <kelulanainsley@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        sunliming@kylinos.cn, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: fix comments of
 event_trigger_separate_filter()
Message-ID: <20220525115142.279298c1@gandalf.local.home>
In-Reply-To: <20220523075123.1068763-1-sunliming@kylinos.cn>
References: <20220523075123.1068763-1-sunliming@kylinos.cn>
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

On Mon, 23 May 2022 15:51:23 +0800
slm <kelulanainsley@gmail.com> wrote:

> The parameter name in comments of event_trigger_separate_filter()
> is inconsistent with actual parameter name, fix it.
> 
> Signed-off-by: slm <sunliming@kylinos.cn>

Signed off by must have your full name. I doubt "slm" is your full name.

> ---
>  kernel/trace/trace_events_trigger.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 21592bed2e89..c364dc729339 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -738,27 +738,28 @@ bool event_trigger_empty_param(const char *param)
>  
>  /**
>   * event_trigger_separate_filter - separate an event trigger from a filter
> - * @param: The param string containing trigger and possibly filter
> - * @trigger: outparam, will be filled with a pointer to the trigger
> + * @param_and_filter: The param_and_filter string containing trigger
> + * and possibly filter

The parameter description should be contained to a single line. No need to
say "The param_and_filter".


> + * @param: outparam, will be filled with a pointer to the trigger
>   * @filter: outparam, will be filled with a pointer to the filter
>   * @param_required: Specifies whether or not the param string is required
>   *
>   * Given a param string of the form '[trigger] [if filter]', this
>   * function separates the filter from the trigger and returns the
> - * trigger in *trigger and the filter in *filter.  Either the *trigger
> + * trigger in *param and the filter in *filter.  Either the *param

If you are updating this, then it should be:

    trigger in @param and the filter in @filter.

As they are referencing parameters which need the "@" notation.

>   * or the *filter may be set to NULL by this function - if not set to

And that includes the above as well.

>   * NULL, they will contain strings corresponding to the trigger and
>   * filter.
>   *
>   * There are two cases that need to be handled with respect to the
> - * passed-in param: either the param is required, or it is not
> - * required.  If @param_required is set, and there's no param, it will
> - * return -EINVAL.  If @param_required is not set and there's a param
> - * that starts with a number, that corresponds to the case of a
> - * trigger with :n (n = number of times the trigger should fire) and
> - * the parsing continues normally; otherwise the function just returns
> - * and assumes param just contains a filter and there's nothing else
> - * to do.
> + * passed-in param_and_filter: either the param is required, or

As "param" did not have a "@" in front of it, that means it did not
represent the parameter.

> + * it is not required.  If @param_required is set, and there's no
> + * param, it will return -EINVAL.  If @param_required is not set
> + * and there's a param_and_filter that starts with a number, that
> + * corresponds to the case of a trigger with :n (n = number of times
> + * the trigger should fire) and the parsing continues normally;
> + * otherwise the function just returns and assumes param_and_filter
> + * just contains a filter and there's nothing else to do.

And there's still more space to use, as the biggest line is only 70
characters and we allow 80.

-- Steve

>   *
>   * Return: 0 on success, errno otherwise
>   */

