Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50134E44E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiCVRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiCVRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:21:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9B275F9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:20:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so23388393wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klmvLMjbhecm1dnOMFwYg5TFnV3WErf04K5GrMiLkZg=;
        b=SWuScJCronuoC7Z3TBASO5IIOKWKgRonLFJmfKKtsjkjM1UFU/0a2h0IpH0oNgO61X
         TKF7993iliLo8MhWH2Pt+lYiVDMnB9hVp/vhHmxA9M/d9kyH8mYyUxpoksfGhekvpVi/
         AzRR6dbjFmaqSXrSsAfqbQPKfJADZ/EW8aKHPfhAj2YivkFGwX40OxVn/8F1JpQKM7EV
         140iatXNYUzSgHCLiUEqpPw/wxzoWUgGk0cWHCG6QSti9CGJX07yCVU7rdRtFKrxgc/+
         DUuylRykw/81EktBzgaDX9d+XzOEGA9XXZOwJQtm7Jnp1ho8afXItg8qIpbBg+Rhdacy
         oHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klmvLMjbhecm1dnOMFwYg5TFnV3WErf04K5GrMiLkZg=;
        b=MWoEYbsvk91gpEJSevp+GAfKMoN8Vy93bz8kEnYCswP7rT8fuBD5Xeke6gN/svI8z1
         cbWhRUpWJmG8Fyb3KDdw0YRejooMKogolx0V8E6wEXlRhz9tDj13eepOO9CfvLSevw7s
         LcNBUSRfIILAr5X/0ckC1heGL3KKITctU+nOoBWowRLU07GLKgznFa34O8IjwCo1Jk9h
         7NmQ/Lbiomm8Nh6ZMvMLYQ2c9EFJErFCoKordPLd4Yuw2H8GUNqbRFQrf9V7Fwf/i7Fz
         UYmCc+UgPo5GqUWeapoEuA+fXxkzb+M7MIE3EbQlr964wXZTjEEV7APQaCH74k4qswD6
         cGnA==
X-Gm-Message-State: AOAM531727voY/WP7km/dUgPAMvYfkeGgmfCdiFJnnSEmSIRgdOupYXx
        kuCPFme8i3ZZpXTvONe0pf6wZFfyMloLPMmYicCKH/t1TAg=
X-Google-Smtp-Source: ABdhPJx/nKEZcJDd/ekvcHdFdncpRSjxaY99nDV82un0XYkxYcgzXA4TsvD4QNobTQevQ91j9X+TyWVj3rJF3EQtbms=
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id
 d2-20020a056000186200b00204e4179cf8mr3707264wri.593.1647969626263; Tue, 22
 Mar 2022 10:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220204035644.734878-1-xiehuan09@gmail.com> <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
 <20220208104806.5272f2ea@gandalf.local.home> <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
 <20220228110822.4b906204@gandalf.local.home>
In-Reply-To: <20220228110822.4b906204@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 23 Mar 2022 01:20:14 +0800
Message-ID: <CAEr6+EAJqM6py_8xtVyH3BZ9U+vODVecSUkLdZkKu3FN2ZkRtw@mail.gmail.com>
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

Hi steve,

On Tue, Mar 1, 2022 at 12:08 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 27 Feb 2022 00:01:06 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Congratulations on joining google.  Just check out this series when
> > you are free.
> >
> > Please don't get me wrong, I'm not pushing anyone.
> > It just doesn't feel good that I haven't responded to emails for a long time ;-)
>
> And keep responding ;-) I want to look at this series, and your emails do
> remind me (it's still in my patchwork queue, so it wont be forgotten, but
> it is getting crowded in that queue of "todo"s).
>
> Yeah, I'm hoping to start being able to do more upstream, but I'm still a
> bit in the flux of figuring out what I'm suppose to be doing at work ;-)
>
> -- Steve

Hope this series is less crowded in your todo queue ;-)
---
JeffXie
