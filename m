Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733453BA25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiFBNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:54:41 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFD29C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:54:39 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-2f83983782fso52063337b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/gnu/MxgbP5VgTvT1TuMar0PXEXuliXD6xjk85RxwCg=;
        b=XCfH7LQuMcSvDOBNSg4kIBZE1Po1OS+oB1o7ihv1N3Iy+mHD/WHWTZZJxlRN2G/9iP
         LfgVxtWDPHSyn5FrXIMKitCgigmHY9xwTT8iYlKkZnA+2ZrqSGr5wik2CDEWaVz55lUz
         VmKZTo97qBwd95AfbhOu1cq7lg3zySKKuadZINA4kDh5ANpwNckkQ7WzXcnBEoBC/fnS
         sDOCO3ancPFz5qdek53CsjLviP8ahbk8ZSpBKul6o7LxvoDtJ15tsFkseVde2btMClpA
         T6K/eZW1U6mnMhuC+weBj/RTIp8QCOaqdEXIzez7y5T/8VlKeEPHR9IO7tyc8Ke5G4gL
         gNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/gnu/MxgbP5VgTvT1TuMar0PXEXuliXD6xjk85RxwCg=;
        b=afOWQZopfNi+bGPva9wjiRXM7IGzxsH/IKdCznGDcKEXvkIks5i53dDSG3Vk2YOqFB
         sH+GfgvFVgskfrcjumWEke2JqrcrFJdI86EuuWf1oHeKpZiz+WKQ1njIuGdbGKzj5XL2
         3ZuJZucnJFs7gEqkvo/Sx32XRRAQUas6TYLw3gyR0FaIFz9sYPdOdsmtA40Iv/VSpK2X
         Bzhal6t7HIzWvngPuUZK714nIpBObeGoeYmMRrXaIG7JXRAFr+cROcNYaMyjnDnF4n9M
         M1eG3STTVfvGydZkrrNhQoHu8ChlLdxdwgjl+RjBJiuoWvPAbSBqygeXuDA2hQWzV0ap
         dpPg==
X-Gm-Message-State: AOAM532K/000pYTHVV+mszDUmtSyQFtmzeyPt6OakYLf9sGAyfFbsxtI
        xSTXKnsDAN2IA06umFPxoaDA7FgbqoaGzKCOVg==
X-Google-Smtp-Source: ABdhPJzrtk1BKctgnYFJym34JktGWwB3OjCFFHQl6UJ5ppCPsPn0ipziPzw5Yj8L8mCeXWDFRGmS/bOuVOJElmgJNU4=
X-Received: by 2002:a0d:d9d7:0:b0:30c:2ba5:a151 with SMTP id
 b206-20020a0dd9d7000000b0030c2ba5a151mr5567383ywe.481.1654178078608; Thu, 02
 Jun 2022 06:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220602022404.508144-1-sunliming@kylinos.cn> <20220602082559.795189e1@rorschach.local.home>
In-Reply-To: <20220602082559.795189e1@rorschach.local.home>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Thu, 2 Jun 2022 21:54:27 +0800
Message-ID: <CAJncD7S88TnmoYkLnhiHWEH_8V_PfF56ctLA6Z1_joqHOmDTAg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Simplify conditional compilation code in tracing_set_tracer()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=882=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu,  2 Jun 2022 10:24:04 +0800
> sunliming <sunliming@kylinos.cn> wrote:
>
> > Two conditional compilation directives "#ifdef CONFIG_TRACER_SNAPSHOT"
> > are used consecutively, and no other code in between. Simplify conditio=
nal
> > the compilation code and only use one "#ifdef CONFIG_TRACER_SNAPSHOT".
>
> I think you mean CONFIG_TRACER_MAX_TRACE here.
>
> -- Steve
>
> >
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > ---
> >  kernel/trace/trace.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index f400800bc910..dc959e339512 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6430,9 +6430,7 @@ int tracing_set_tracer(struct trace_array *tr, co=
nst char *buf)
> >               synchronize_rcu();
> >               free_snapshot(tr);
> >       }
> > -#endif
> >
> > -#ifdef CONFIG_TRACER_MAX_TRACE
> >       if (t->use_max_tr && !had_max_tr) {
> >               ret =3D tracing_alloc_snapshot_instance(tr);
> >               if (ret < 0)
>
Yes, you are right. I am sorry about this low-level mistakes.
