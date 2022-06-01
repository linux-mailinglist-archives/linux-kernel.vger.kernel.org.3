Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98F53A9B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiFAPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348999AbiFAPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:13:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685D6FD09
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC7CBB81BA4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D1C385B8;
        Wed,  1 Jun 2022 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654096415;
        bh=AKied9qL7mPMb5TN8YdwIpBfNWBe+n2m6OCjzvUfk5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FXPtJGDXdKYrZnL/FdYQtJlCyPdwKfdevDysVc8GecPOOM0z79+HAqHKkE9Fn4fv6
         Kuu8Luzckze5LPiZrCfpx503KV63d4cPd8Kkb0qwndrbut94UzcBdw7od7EH0yDubN
         QeGjKM6mxRmQqa+THEqRox8TEyqAFCxyacqI10s2Pzy9OQThSCadGqm/kRvkR9IZjR
         1MtnqgSvDHA+2A3cAUBewOgIosvgb1CoXbXEbHJJNjkD5uQo6sYMMLTzgAJqRrC9ug
         TLbUUtd2fv/+mS4e1AfERgJN4Wl8AIDa2pJtIPB7f5fdNzqeINQCQqjfzSKV2eGsnD
         5Zid04fiNyXnA==
Date:   Thu, 2 Jun 2022 00:13:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] trace/objtrace: Get the value of the object
Message-Id: <20220602001331.fab92b2dcd2c9aaad800ddae@kernel.org>
In-Reply-To: <CAEr6+EAU_FUvCqZqqpp_hC5ichV9WJ+Up+N6ya5KW_CbqbRGFA@mail.gmail.com>
References: <20220512170008.1301613-1-xiehuan09@gmail.com>
        <20220512170008.1301613-3-xiehuan09@gmail.com>
        <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
        <CAEr6+EAU_FUvCqZqqpp_hC5ichV9WJ+Up+N6ya5KW_CbqbRGFA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 15:13:24 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Hi Masami and steve,
> 
> On Sun, May 22, 2022 at 10:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > On Fri, 13 May 2022 01:00:06 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > [...]
> > > @@ -175,9 +271,27 @@ trace_object_trigger(struct event_trigger_data *data,
> > >
> > >       field = obj_data->field;
> > >       memcpy(&obj, rec + field->offset, sizeof(obj));
> > > -     set_trace_object(obj, tr);
> > > +     /* set the offset from the special object and the type size of the value*/
> > > +     set_trace_object(obj, obj_data->obj_offset,
> > > +                     obj_data->obj_value_type_size, tr);
> > >  }
> > >
> > > +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > > +     {"u8", 1},
> > > +     {"s8", 1},
> > > +     {"x8", 1},
> > > +     {"u16", 2},
> > > +     {"s16", 2},
> > > +     {"x16", 2},
> > > +     {"u32", 4},
> > > +     {"s32", 4},
> > > +     {"x32", 4},
> > > +     {"u64", 8},
> > > +     {"s64", 8},
> > > +     {"x64", 8},
> >
> > Hmm, as far as I can see, you don't distinguish the prefix 'u','s','x'.
> > If so, please support only 'x' at this moment. kprobe events supports
> > those types, and it distinguishes the types when printing the logged
> > data. E.g. 's16' shows '-1' for 0xffff, but 'x16' shows '0xffff'.
> > You can add another patch to support such different types afterwards.
> 
> I feel to let the objtrace trigger to distinguish the prefix 'u', 's',
> 'x', It seems a very challenging work ;-)
> I spent a lot of time thinking, I would like to add a callback
> function(print function) in the struct trace_object_entry  for each
> data type.
> Not sure if this is possible or allowed, as I haven't seen any example
> like this to add function in the  struct *_entry  ;-)

Hmm, I don't recommend this, becuase this event record can be exposed
to user space as binary data. So please do not put such a function
pointer which will be used in the ftrace directly.
Instead, add a new event type of the object-trace for each type-prefix,
since each of them has different print-fmt.

Anyway I would like to ask you is to share the next version of the
series without that improvement. You can improve it after merging the
basic feature. No need to stop the series until all possible feature
set are implemented (unless it will change the user-exposed interface
much.)

> 
> The following is part of the code I have prepared. I don't know if you
> can give any suggestions or wait until I submit the next version to
> discuss.

But thanks for sharing the code. This helps me to understand what you
are trying :)

Thank you,



> 
> <snip>
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 2407c45a568c..5f8289e26f91 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -414,6 +414,7 @@ FTRACE_ENTRY(object, trace_object_entry,
>                 __field(        unsigned long,          parent_ip       )
>                 __field(        unsigned long,          object          )
>                 __field(        unsigned long,          value           )
> +               __field(        unsigned long,          print           )
>         ),
> 
> +/* get the type size for the special object */
> +struct objtrace_fetch_type {
> +       char *name;
> +       int type_size;
> +       int is_signed;
> +       print_type_func_t       print;
> +};
> +
> 
>  static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> -       {"x8", 1},
> -       {"x16", 2},
> -       {"x32", 4},
> -       {"x64", 8},
> -       {NULL, 0}
> +       {"u8", 1, 0, PRINT_TYPE_FUNC_NAME(u8)},
> +       {"s8", 1, 1, PRINT_TYPE_FUNC_NAME(s8)},
> +       {"x8", 1, 0, PRINT_TYPE_FUNC_NAME(x8)},
> +       {"u16", 2, 0, PRINT_TYPE_FUNC_NAME(u16)},
> +       {"s16", 2, 1, PRINT_TYPE_FUNC_NAME(s16)},
> +       {"x16", 2, 0, PRINT_TYPE_FUNC_NAME(x16)},
> +       {"u32", 4, 0, PRINT_TYPE_FUNC_NAME(u32)},
> +       {"s32", 4, 1, PRINT_TYPE_FUNC_NAME(s32)},
> +       {"x32", 4, 0, PRINT_TYPE_FUNC_NAME(x32)},
> +       {"u64", 8, 0, PRINT_TYPE_FUNC_NAME(u64)},
> +       {"s64", 8, 1, PRINT_TYPE_FUNC_NAME(s64)},
> +       {"x64", 8, 1, PRINT_TYPE_FUNC_NAME(x64)},
> +       {NULL, 0, 0, NULL}
>  };
> </snip>
> 
> > > +     {}
> >
> > If this array is null terminated, please explictly do that, like
> >
> >         {NULL, 0},
> >
> > for readability.
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks,
> JeffXie


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
