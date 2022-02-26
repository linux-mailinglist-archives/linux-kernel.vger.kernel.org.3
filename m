Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951064C56C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiBZQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiBZQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:01:52 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5CB1795C3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 08:01:17 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id j24so9923168oii.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peIyakp4rpyaMIT7dkZzhM+KDY5rX6A1L6WCTTlQTi8=;
        b=W/nckU8SWSeeJmQpnaPFmRJhlh6oFZ5ha2cvBLO6MAU8vduuMeQ7GAEc4XRPf7EVd/
         /fVfUQIRk8FuStkOrYex+BfsGjm0yoeglw4PVWdy93G10E1vT17sHklyzQUf3Di8Dpfe
         +WjXlTCA9WL6XQVwOu07pt+eM+JAsOvuat3aAdnIFkD2XubXMbWTTRhUMV8nfXcSbhdq
         9Tx1igFaO7JHi6ypqXY7R0o3oKvHDU38xW6l79T9OyeXlsnZ61oRf34huWD58lZlQCdN
         C5211H94F1drYg4A40mu50HfnAhuIwBErN2AzpGGB19b1jBiMnVsGGotwaYlpGFoe3KS
         kxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peIyakp4rpyaMIT7dkZzhM+KDY5rX6A1L6WCTTlQTi8=;
        b=7QTfWxK/KLLnYf0BCCARDx/eFaYmNcDmf9sm4Kpv6G+lM7sqOgO9f2hf2NtmWB5Mjm
         dfnHNBZCTZC2XgqczBfSD0vYxZe8n9Cr9mzCkkaWu4ijJYdl760liEVeU/ak7mPAZo3N
         0seM0Wzjl0NfnCJoj61YDzBSciXfDUWOmPxL8uXp9bbS3E+jlrBo08yBtFRcz/NEZJyA
         +u+XpO9ZGunc2Y7WfZOuFNUTFKPFy5VOZYzbq0pPp+ZCnB7iaTYv6edEwmoHu//srsgR
         UxkfXzvh8G6rithWugDF/G8WDPyLxaTBTD6wWG1v3K39uvlXZ3DbYZQXFxVDsy8vqo6U
         20pA==
X-Gm-Message-State: AOAM533B9qCiLcZRRh7+kvklB4aTshpZVXSadUVFHvCbyWGuvUWGSNkz
        OC2rXTAQPmXVHAYbmi4GWXNQeshvrpNIon2RugnnKLPbktg=
X-Google-Smtp-Source: ABdhPJzzYDzLgwHmLqji8UsdckXWckFDgUjSIv67rb8y+BVxcpur+bq/MF5zI74j6lewIDoCXSShcuBRwjDNAnYVRdM=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id
 j13-20020a056808118d00b002d4be7e6748mr3111956oil.123.1645891277390; Sat, 26
 Feb 2022 08:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20220204035644.734878-1-xiehuan09@gmail.com> <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
 <20220208104806.5272f2ea@gandalf.local.home>
In-Reply-To: <20220208104806.5272f2ea@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 27 Feb 2022 00:01:06 +0800
Message-ID: <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
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

Hi Steve and Masami,

On Tue, Feb 8, 2022 at 11:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 8 Feb 2022 23:08:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Thanks for updating the series. I've tested the patches and confirmed
> > the objtrace is working :)
> >
> > Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > for the series.

Thanks, It's very difficult to get your double "by" and I'm very excited ;-)

>
> Thanks. Just to give you an update on my own workload.
>
> I'm finishing my last week of on-boarding, and hopefully, I'll have more
> time next week to look at more things upstream. And hopefully, I'll be able
> to get to looking at this series then.
>

Congratulations on joining google.  Just check out this series when
you are free.

Please don't get me wrong, I'm not pushing anyone.
It just doesn't feel good that I haven't responded to emails for a long time ;-)

> Cheers,
>
> -- Steve
---
JeffXie
