Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE7538BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiEaHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiEaHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:13:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149A2AC5A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:13:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x17so8284427wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpJXD4uWmZk0N+tXI9zTVOKV/51RZ9LSRoM3wkb91iQ=;
        b=VfQb/SAzTYskOxUvNYLCKPFqjCFKzcYWhzgZpZ6pq7GdpAMBxZn5a90aWMRdAzsm3+
         4V4YNQh1HAjrLTlgay2ujDoZBtNRdkMQST4kadNvaBeFHauvhWDEvP/LZIaTkDll9uHO
         Nm7j9xrVrwIjpmKuygLLXnOL5xcxSkb8hxcHZDJKvt+qvXyi+3AL92H9vV9jRf+szLt5
         fMcmH5sB6oXHhbJQ1ra8by5lEllDrIkaBVyruEo4kkXmuD4dJg6dIFMvhZ9VcLI493/o
         WNLg08cTpv4JDaoiTnYL6hWkKoZpmRdk05GNhOTHlqfKBPcQoUqzxSPSuLZ49nLCtU32
         JqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpJXD4uWmZk0N+tXI9zTVOKV/51RZ9LSRoM3wkb91iQ=;
        b=KpT1uPMADBT56bynM20MdlAMhmbEg1V/vVPUrCCPds4f7GcmMmOIC3tDGNcyuu5LBv
         sI9YFr1/22UlkRTA9yBllUodwUXkd2ElHVquZ8V3m3Hg56wW4zeQZi5ephc2c/N6KfOJ
         FxhB21Dfgdn69sq1kmzlpqH+m8RjSFGC2v6zpMzK52P02sLSlAcoii0+hKH1VXo/82tB
         i/vnmx7D1PwXuV+4eO9SBjvwnvl28Xn3J368hi5J8IGLbuzcByZOpiJnBhOBffCx3uOv
         eznQe9pFhQPsg3zkZ+fzzpV2/mLTiI/K2U9OzwGYfa9n9/gxWjJABtf6gLSWDs/hP9tB
         MjzQ==
X-Gm-Message-State: AOAM5321X78roLyv71dIBsgng/plBCIEIOxboMzF8iLi5JYFBmFldnzN
        U102bk9jFGBaQOlQWfJC8yFrGw9Z7M5GvU2xMx5NUfWhXp0=
X-Google-Smtp-Source: ABdhPJwO3f3UUsNyWqrqdELliF94hlgYLBXaZYE9Ur7xStNyChRvc+OILJ07/u8p0E7flMcjZGJDvj4C2BSr4QdsHHM=
X-Received: by 2002:a05:6000:1788:b0:20c:a43c:10fa with SMTP id
 e8-20020a056000178800b0020ca43c10famr48558569wrg.511.1653981216503; Tue, 31
 May 2022 00:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-1-xiehuan09@gmail.com> <20220512170008.1301613-3-xiehuan09@gmail.com>
 <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
In-Reply-To: <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 31 May 2022 15:13:24 +0800
Message-ID: <CAEr6+EAU_FUvCqZqqpp_hC5ichV9WJ+Up+N6ya5KW_CbqbRGFA@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] trace/objtrace: Get the value of the object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami and steve,

On Sun, May 22, 2022 at 10:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Fri, 13 May 2022 01:00:06 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> [...]
> > @@ -175,9 +271,27 @@ trace_object_trigger(struct event_trigger_data *data,
> >
> >       field = obj_data->field;
> >       memcpy(&obj, rec + field->offset, sizeof(obj));
> > -     set_trace_object(obj, tr);
> > +     /* set the offset from the special object and the type size of the value*/
> > +     set_trace_object(obj, obj_data->obj_offset,
> > +                     obj_data->obj_value_type_size, tr);
> >  }
> >
> > +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > +     {"u8", 1},
> > +     {"s8", 1},
> > +     {"x8", 1},
> > +     {"u16", 2},
> > +     {"s16", 2},
> > +     {"x16", 2},
> > +     {"u32", 4},
> > +     {"s32", 4},
> > +     {"x32", 4},
> > +     {"u64", 8},
> > +     {"s64", 8},
> > +     {"x64", 8},
>
> Hmm, as far as I can see, you don't distinguish the prefix 'u','s','x'.
> If so, please support only 'x' at this moment. kprobe events supports
> those types, and it distinguishes the types when printing the logged
> data. E.g. 's16' shows '-1' for 0xffff, but 'x16' shows '0xffff'.
> You can add another patch to support such different types afterwards.

I feel to let the objtrace trigger to distinguish the prefix 'u', 's',
'x', It seems a very challenging work ;-)
I spent a lot of time thinking, I would like to add a callback
function(print function) in the struct trace_object_entry  for each
data type.
Not sure if this is possible or allowed, as I haven't seen any example
like this to add function in the  struct *_entry  ;-)

The following is part of the code I have prepared. I don't know if you
can give any suggestions or wait until I submit the next version to
discuss.

<snip>
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 2407c45a568c..5f8289e26f91 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -414,6 +414,7 @@ FTRACE_ENTRY(object, trace_object_entry,
                __field(        unsigned long,          parent_ip       )
                __field(        unsigned long,          object          )
                __field(        unsigned long,          value           )
+               __field(        unsigned long,          print           )
        ),

+/* get the type size for the special object */
+struct objtrace_fetch_type {
+       char *name;
+       int type_size;
+       int is_signed;
+       print_type_func_t       print;
+};
+

 static const struct objtrace_fetch_type objtrace_fetch_types[] = {
-       {"x8", 1},
-       {"x16", 2},
-       {"x32", 4},
-       {"x64", 8},
-       {NULL, 0}
+       {"u8", 1, 0, PRINT_TYPE_FUNC_NAME(u8)},
+       {"s8", 1, 1, PRINT_TYPE_FUNC_NAME(s8)},
+       {"x8", 1, 0, PRINT_TYPE_FUNC_NAME(x8)},
+       {"u16", 2, 0, PRINT_TYPE_FUNC_NAME(u16)},
+       {"s16", 2, 1, PRINT_TYPE_FUNC_NAME(s16)},
+       {"x16", 2, 0, PRINT_TYPE_FUNC_NAME(x16)},
+       {"u32", 4, 0, PRINT_TYPE_FUNC_NAME(u32)},
+       {"s32", 4, 1, PRINT_TYPE_FUNC_NAME(s32)},
+       {"x32", 4, 0, PRINT_TYPE_FUNC_NAME(x32)},
+       {"u64", 8, 0, PRINT_TYPE_FUNC_NAME(u64)},
+       {"s64", 8, 1, PRINT_TYPE_FUNC_NAME(s64)},
+       {"x64", 8, 1, PRINT_TYPE_FUNC_NAME(x64)},
+       {NULL, 0, 0, NULL}
 };
</snip>

> > +     {}
>
> If this array is null terminated, please explictly do that, like
>
>         {NULL, 0},
>
> for readability.
>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
