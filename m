Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92055ABA8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiFYRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFYRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:01:49 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6F15829
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:01:48 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-f2a4c51c45so7796109fac.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSHAh+p153CfcTnoVcsWDcEHZUwVwm5dYG5CL+ikasQ=;
        b=CvQXJrzh22pIHrAHrbCaUm6gv8l7Ok4pX5jS29hyMuoTAfcUJFNM9A7DmMjP/VVoAe
         skUV5ZEgzBFSUACwhpSkMUDIDGw3nEraAjIPJsqDzFMzG1nPJo/u90sglFpbU6QEn5ol
         mt7tpE7TWXcOLjPW8CAzCvOLnoFk6JGnoB3SvXJR/d8meOwRY49jhHQjDbiy6adc0cnD
         fOZ0xY+JwJ0snJX4IX4JKmVVaM8iE0IWXfuAzCDmST1a7ws+Lf2mz35uVL3iJqLFqtoX
         PLxa5T+rY0JwKDvbZld9LVjuMkF+FIpmNwcM04bXQWClm6LiFc4ZqZv1UUxaf6zFN9bc
         GPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSHAh+p153CfcTnoVcsWDcEHZUwVwm5dYG5CL+ikasQ=;
        b=bDgA+XB5cvh1SHsQwOU6OGmE0IDmdMtm/Iz4+VFNmzisKznpqhOlLpuUc4z+qiUJ4r
         gJHXzW7KxoHXVUoEHRnf1jFKfXOuOSsPk6+H0vQfmfk4SUSiygX+OD7/AVF1oQ6Ik492
         shV8oI6d/RIlN4jRjcDC50jyupS64LyROD4Bk5wnyaQXLlAjLu955OuANAHqipPc9ByU
         Y1J7udhzIg4JlBkmQYds2hAlFsdcPsstGIhTUY7F4dr8u3EK5SkvyxhiaMULffrvZyQj
         g88Lv/lsYYvSWoZvK4dGLZosNJcENESvs9ig0qZDOXlzBSJYU8NEfd12MlSVxXntfl95
         uBCg==
X-Gm-Message-State: AJIora/H3NK7R2+oPYFYjEZq2qwXUUMLKbbfVou4cXj1OogVDNfSqHiE
        GaGjq5mQLFaFDa+MrnrXgl0Qz5lT7YxeYmKCsoE=
X-Google-Smtp-Source: AGRyM1uUzEtvjXKPXe5qgCIlAgss3CLjQgdVe8pG5eekvszZDXriCctjyt4obif7SljdNYmIiAnvYQzUhC1KudkC+BY=
X-Received: by 2002:a05:6870:e95:b0:106:a8fe:1dc5 with SMTP id
 mm21-20020a0568700e9500b00106a8fe1dc5mr5585667oab.217.1656176506964; Sat, 25
 Jun 2022 10:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220606160943.663180-1-xiehuan09@gmail.com> <20220606160943.663180-3-xiehuan09@gmail.com>
 <20220626005824.cabbfe7d77baf3aa64ca7669@kernel.org>
In-Reply-To: <20220626005824.cabbfe7d77baf3aa64ca7669@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 26 Jun 2022 01:01:34 +0800
Message-ID: <CAEr6+EDSq9TmAAy4WZ_+K52CwO-NUBUDh+mt-ZPYju_PO4Rowg@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] trace/objtrace: Get the value of the object
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

On Sat, Jun 25, 2022 at 11:58 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> On Tue,  7 Jun 2022 00:09:41 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > @@ -176,9 +275,27 @@ trace_object_trigger(struct event_trigger_data *data,
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
> > +     {NULL, 0},
> > +};
>
> As I said before, please use only 'uX' types at this moment,
> since the objtrace event doesn't show the value with sign.
> This means it only supports 'uX'.

Thanks, I will remove the 's' type in the next version.

> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
