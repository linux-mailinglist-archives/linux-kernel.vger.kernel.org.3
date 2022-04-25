Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B550D971
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiDYGcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDYGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:31:51 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C993E5C64F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:28:45 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v139so3951731vsv.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kf/Nrn0xCzvr9Ng1DZxkPHwYxvEut9TFnWqEhFyhu2M=;
        b=mRyvDXCUfrlj5wEpXDOBS/gLBaAS4sUksB23l37WEeuml6s/ldL5+eWJSSxuGWTMuR
         rmefFjSmKEWmn3GimH1MLcGCi0OLtqbV5Y4d5k+jjYRuZf+W7HxV5S20J4W5u8Z6f128
         Ld+NQa3u6ca8iLTwY4yVz2IhFa1JmSLzaSGck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kf/Nrn0xCzvr9Ng1DZxkPHwYxvEut9TFnWqEhFyhu2M=;
        b=1t9Uarmku2UqvXn4uWFJpNgGONXHLB4KR9AdJL1mAzG4c+xjKwqis4PHxPlicIkzn4
         9kPWVHcW3SefusY4RHMaKbqqkQ7GSZNau+fvQ5PN424gkGnX3tSSXB9SjlwyNmWdIoSB
         JutaIGRP0v4Vqw61eK/b1uM5aKdsIRvmPg/X+t3FF87LhJsJqZiW3ErEW0SRmuCWIMbK
         1GhC39QswuDkapCjTVAw7pi1wGVHbHXXQj5brgh9wbRd6+ujYdG2IG7hVMaedjjnFM21
         1gQJWZS4kBGOth3P50hixFsTatkhAu1wCE5wzcU0JRlMjtKmBRhVvaMI8RodPPfFJp2t
         T2lg==
X-Gm-Message-State: AOAM533kJmUDo3od/ei4AhTYMqRAZzfz6BGGcQFZR1VYqCP77CqKoIZr
        GKKswTV1BzhDt4eS0dlmkiWw4SxJyzGPVMR9/Lp+FA==
X-Google-Smtp-Source: ABdhPJxRaBz4nv0YFpX0TE8UKPpZRBcRpetml7bH9I6rAFdGAtWAQGexbcQ/Ll6mJOrXZbY3rGSo4UZP/8pBfS7Wvis=
X-Received: by 2002:a05:6102:7c4:b0:32c:d1f6:1bba with SMTP id
 y4-20020a05610207c400b0032cd1f61bbamr537864vsg.0.1650868124810; Sun, 24 Apr
 2022 23:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220422060025.1436075-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <20220423001311.31e2dff59708ddd3043e55af@kernel.org>
In-Reply-To: <20220423001311.31e2dff59708ddd3043e55af@kernel.org>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Mon, 25 Apr 2022 15:28:32 +0900
Message-ID: <CAEYrHjk3hmP2Vf3d3LqW7w+3GGMxu+hvDQbjaNgcU7oCrrzGsg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix potential double free in create_var_ref()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks for the review!
I'll add the info and resend the patch.

Thanks,
Keita

2022=E5=B9=B44=E6=9C=8823=E6=97=A5(=E5=9C=9F) 0:13 Masami Hiramatsu <mhiram=
at@kernel.org>:
>
> Hi Keita,
>
> On Fri, 22 Apr 2022 06:00:25 +0000
> Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:
>
> > In create_var_ref(), init_var_ref() is called to initialize the fields
> > of variable ref_field, which is allocated in the previous function call
> > to create_hist_field(). Function init_var_ref() allocates the
> > corresponding fields such as ref_field->system, but frees these fields
> > when the function encounters an error. The caller later calls
> > destroy_hist_field() to conduct error handling, which frees the fields
> > and the variable itself. This results in double free of the fields whic=
h
> > are already freed in the previous function.
> >
> > Fix this by storing NULL to the corresponding fields when they are free=
d
> > in init_var_ref().
> >
>
> Good catch! this looks good to me.
>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>
>
> BTW, could you Cc the original code authoer and  if you fix a bug and
> add Fixes: tag? That will help the original author can check the bug and
> help stable kernel maintainers to pick the patch. :)
>
> To find the original commit, you can use the 'git blame'.
>
> $ git blame kernel/trace/trace_events_hist.c -L 2093,2100
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2093)      return er=
r;
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2094)  free:
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2095)      kfree(ref=
_field->system);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2096)      kfree(ref=
_field->event_name);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2097)      kfree(ref=
_field->name);
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2098)
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2099)      goto out;
> 067fe038e70f6 (Tom Zanussi 2018-01-15 20:51:56 -0600 2100) }
>
> Then, git show will tell you the original author.
> $ git show 067fe038e70f6
>
> And get the format of the commit for Fixes tag.
>
> $ git --no-pager show -s --abbrev-commit --abbrev=3D12 --pretty=3Dformat:=
"%h (\"%s\")%n" 067fe038e70f6
> 067fe038e70f ("tracing: Add variable reference handling to hist triggers"=
)
>
> Then you can add lines like:
>
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist tr=
iggers")
> Cc: stable@vger.kernel.org
>
> Thank you,
>
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> >  kernel/trace/trace_events_hist.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_even=
ts_hist.c
> > index 44db5ba9cabb..a0e41906d9ce 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -2093,8 +2093,11 @@ static int init_var_ref(struct hist_field *ref_f=
ield,
> >       return err;
> >   free:
> >       kfree(ref_field->system);
> > +     ref_field->system =3D NULL;
> >       kfree(ref_field->event_name);
> > +     ref_field->event_name =3D NULL;
> >       kfree(ref_field->name);
> > +     ref_field->name =3D NULL;
> >
> >       goto out;
> >  }
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
