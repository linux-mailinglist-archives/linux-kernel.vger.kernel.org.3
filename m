Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49155530706
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiEWBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiEWBNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:13:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08742377F9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:13:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r23so19186267wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H6FksuJpMo8QoRJSVxkZdGNLFn7WEdBNMVPknI1zCc=;
        b=JUt8T6fbl6Th7kEeKaLn2/2ArJK5fVw0y9pO5ErspjNKXfJihcYko5H+uxiBaxBOEj
         oWz5fZY2L+4+1EIDvUerBD26qp4SDlP+LP7PXib6LUclpa5BQ0ZUKppKAN9qlfupfmjw
         +JTamby7bQYKRJKOtENFP+Su+AEFsjd03oRuBaGkYmSf4eyZZ1+ZxQgglSh2+H57x3AZ
         gEiqdTaXwq2b6RAsWCG5woNaNJto8kcasufK+Oq3lFCDmC6LkAlBr97WS5PuXLXdjOtw
         WSx8F17m2/2/DUx5UPuJXhh640klT1zkVKZSUQvNIqAsGEQq9G5ty6IZjMB2Yhw0uRpA
         pWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H6FksuJpMo8QoRJSVxkZdGNLFn7WEdBNMVPknI1zCc=;
        b=uyczi9xsL9Y8M7j6bJa59atidYIFnz4WCcrh+ALXzjYz6Y2lyQVELYDtX65ZxNOEgm
         p1FtLhQh6HGpYZVQdM3fObMUeboLZYam+1Kq32BHYh3UfOiO0kk24EJx/FDw+bDA7rbu
         6yknMEscK3odutlbGAKQI4B5vXMHqVXc9qdR6BobgzvgFHjg/6AeH8Dh13ZGpn8tQvZm
         Qe70sFwWamas2ULghQg8t6jd28Gv/UeXUw5Bwf7iEut8E2Cso70i1/qGxxJc1Ea3loAW
         5yg4mnV2AKQSwNlVrDVAj2KWpBmBBlXH9gM4FD8asBpCBxIOtMS/TlNDzzllgssG4zP1
         x+gg==
X-Gm-Message-State: AOAM530aaVANTsEyzT2Nh7IYuf7V+sG5MkmK2VJToFdm8YizxuILcuKm
        28MEMcwhnloHA2r5kTHGukiWQMFMEIytl5ZAtN0=
X-Google-Smtp-Source: ABdhPJwK/bhjXxNJEgSZV8LZfkfgLinCiFQdF/bzYTOp45Pz/r2/JOudOoBdnLt5nKBQvpO0C4Omhej8mXtuSfuOcrY=
X-Received: by 2002:a5d:480c:0:b0:20e:6133:132 with SMTP id
 l12-20020a5d480c000000b0020e61330132mr17287906wrq.593.1653268382219; Sun, 22
 May 2022 18:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-1-xiehuan09@gmail.com> <20220512170008.1301613-3-xiehuan09@gmail.com>
 <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
In-Reply-To: <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 23 May 2022 09:12:50 +0800
Message-ID: <CAEr6+EAdrLg8ye=px4J30Kx6Rf_c43nrosyNJYWSNVdanCPRZw@mail.gmail.com>
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

Hi Masami,

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

Thanks, I will add another patch to support it .

> > +     {}
>
> If this array is null terminated, please explictly do that, like
>
>         {NULL, 0},
>
> for readability.

Thank you for your reminder.

> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
