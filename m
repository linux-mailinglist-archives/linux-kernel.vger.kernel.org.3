Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5F58F840
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiHKHVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKHVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:21:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B5088DE3;
        Thu, 11 Aug 2022 00:21:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31f445bd486so164182757b3.13;
        Thu, 11 Aug 2022 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7pkrbhvnV/QbSUWqoz2X/keBi7uCVIq8rknW2hVQjeo=;
        b=a4hJM03D6vxEEiIgVmwB20CYnvppjjbkLhxpLaY50J6vOflarnIZTzn/ox6wwKTJM8
         f4ccdbI6uHhUeFLJowhbgzMddnByGuDD782jDA6pCdyRHWmz8VzYlrL0JIQezjiCVdLg
         q8MsoVeq6VnJcurjILgIzT2pXw6e7t+esGTfZGIxm7XgOBJCM/2d9X41r0b1XEwjkaob
         jsczyD3TSyVQ/SX1keN3eH9ghN9VD9ZOcVqKNzLBhRAEMMuvK+zdwtzcQeN5m8RgWZTa
         0uoi/tpgib2b2R8rnvhFOfYjr9xOVeo54sLLUwRi/5QOhgiaWpOvRtPka4JLTb6gTwq3
         g+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7pkrbhvnV/QbSUWqoz2X/keBi7uCVIq8rknW2hVQjeo=;
        b=BFvQIYGheZKOZlpu/93636CxdYYaYQgfE9czb5F9rVjzNwIBWGUqhFuTU+82UhkynV
         ODcz+Nw14dPaBOJmJLAB/BSQDgWM/qLQwRL/PS9iLIgN1mz0nwF5oPZR4WH3si5TRZRA
         NdPtvhUv3eXzgOp21YqDKxekmaVwZDLqJJnLUABY13iAIKdQU3yophcSqQr2QuOxnORQ
         gc8+QALhE7lrYZCgzYVjA2IU3wvRlaNx9JOKDZyv9UscpOGXRLDow4WypIJQjzoK1oXC
         K+MbhRDVrYmp9Jj7rd4ZvA4A/8mA/w1++9vClrWE80IPG3K3QSrEmcjfqWcWxAGwgDld
         mXKQ==
X-Gm-Message-State: ACgBeo0GyzVypUmeIn8oK8ONHM5cAzOqbjyii9gyr0W7SNz3MJu4Fbbj
        jnlbA3pBimu2w5TZhFF0ytKm2qBJ/lE9DeItJRc=
X-Google-Smtp-Source: AA6agR7YkeUW6mHWPGyI0rEF4Q6qVH5UaJZye+cchoREuruzAl4pfP2vRvTme3wdSXcmzkdBIpkmYtOq3y/eeY/gEDc=
X-Received: by 2002:a81:8345:0:b0:323:9a15:7fd6 with SMTP id
 t66-20020a818345000000b003239a157fd6mr28519265ywf.104.1660202463545; Thu, 11
 Aug 2022 00:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220810150921.8858-1-lukas.bulwahn@gmail.com> <e6839a7e-d1f4-7d9f-68f4-f99c216f647f@quicinc.com>
In-Reply-To: <e6839a7e-d1f4-7d9f-68f4-f99c216f647f@quicinc.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 11 Aug 2022 09:20:52 +0200
Message-ID: <CAKXUXMxkLZXvJbkKNG9f_9Jog5f4azgjr2XpEgJx1j2A-2OgjQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: react to error return from traceprobe_parse_event_name()
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 1:29 AM Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
> hi Lukas,
>
> On 8/10/2022 11:09 PM, Lukas Bulwahn wrote:
> > The function traceprobe_parse_event_name() may set the first two function
> > arguments to a non-null value and still return -EINVAL to indicate an
> > unsuccessful completion of the function. Hence, it is not sufficient to
> > just check the result of the two function arguments for being not null,
> > but the return value also needs to be checked.
> >
> > Commit 95c104c378dc ("tracing: Auto generate event name when creating a
> > group of events") changed the error-return-value checking of the second
> > traceprobe_parse_event_name() invocation in __trace_eprobe_create() and
> > removed checking the return value to jump to the error handling case.
> >
> > Reinstate using the return value in the error-return-value checking.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >   kernel/trace/trace_eprobe.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 4a0e9d927443..460d3ec8a256 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -883,7 +883,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >       trace_probe_log_set_index(1);
> >       sys_event = argv[1];
> >       ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
> > -     if (!sys_event || !sys_name) {
> > +     if (!ret || !sys_event || !sys_name) {
>
> that's right, miss case sys_event and sys_name are not null, but invalid.
>
> it should be  if (ret || ...)  ?
>

Linyu, you are right. The visual symmetry tricked me into believing
the line above was right, but it is clearly wrong if you think about
it and look at the other invocation.

I send out a corrected patch v2:

https://lore.kernel.org/all/20220811071734.20700-1-lukas.bulwahn@gmail.com/

Please review, ack and pick the patch v2. Thanks.

Lukas
