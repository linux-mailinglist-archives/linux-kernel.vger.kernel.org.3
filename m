Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0E553E40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355055AbiFUWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354420AbiFUWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:03:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2231DF5A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:03:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s21so14073143lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/nAALPTQk2jOf7mwjFbXYskfwmpL/i3xmmIwWAqGBk=;
        b=X6t1vTBA6W1iUMu8Qz7eID+6FJWgZfWRA7zdkDckW4hNHGuZ2/QO03KT1VsPZyHWee
         l5itrIal+AwrzrdgdDBYCLYGHKvti9IRVUl0kfq/3ggZQowxaWsXOe9ydphnuFteIlrw
         azUnNJcBMdBCdXdOF1dC1gVFKaQpW/HSgcYxvKQ0JSfcjVpbircgdMBlH9mSCsLxGvXH
         +zrl2ydovOhve4QTBNVZpydzIu3e9eBY3AwDYzqjvoM4Hgs3VZLd0mOl/kBL6127eHWw
         7dq/f6yo0dJ+piy8A+8OgfdCaAO6g8SgJna27hwhay32dLt3T9sDLNKXKIW+D763FHBp
         OVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/nAALPTQk2jOf7mwjFbXYskfwmpL/i3xmmIwWAqGBk=;
        b=28L7uJW7d+vQDppXVbcuk0T9+oSTmduNVXcurfrKbzdqGPJzyivcjQ2/HRXE6RSWCU
         QiEzhX2v9A22C0TKHtos7nbrKFhvlnqRbqOnoXft+UXgwXFxfVh5lPhJ81pKHMz7c9k4
         Vv8y7k5EThjMaATU1ByhDKYmjwq/rKsqHq7DMQTOMe0rd0EasqnKPKL6jgcUxKBqvPYi
         jCk11K9zx6MA24njOJosne8kUMpGyLw0/eyRrASZVKlAB96Q7DYo3a0dtDnYbHNsi+PF
         30FdD6QlDs0WpuJ1XuLeZDgmWrrw7nIctAqUvXpCH1PtVPf00JL8CxuO0XqTMGjdDPKz
         t64Q==
X-Gm-Message-State: AJIora/wUJdoJS0uUWu9BhiSZTOY2xhm7Xh7CKO4qJSuBdmsYuBIYqbM
        0YeRzIj1DiVcJBLsK9BBzRj7ObKGzVW5WXYv0skzyw==
X-Google-Smtp-Source: AGRyM1twzM6PZQGBn/eKAhODKzD6PMg5gKTbscJydFS2KHZpqXK16I02j71nfGu5QWAT6I2VTcEoEJ2YRPhl89Ab2oc=
X-Received: by 2002:a05:6512:10cb:b0:479:682e:7f0c with SMTP id
 k11-20020a05651210cb00b00479682e7f0cmr224941lfg.626.1655848980268; Tue, 21
 Jun 2022 15:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org> <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
In-Reply-To: <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 15:02:49 -0700
Message-ID: <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
Subject: Re: plumbers session on profiling?
To:     Ruud van der Pas <ruud.vanderpas@oracle.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 4:46 AM Ruud van der Pas
<ruud.vanderpas@oracle.com> wrote:
>
> Hi Jose,
>
> Thanks. I indeed plan to attend LPC 2022 and am very interested
> to participate in such a discussion.

Hi Ruud,
If you're still considering attending Linux Plumbers conf, please
submit a proposal:
https://lpc.events/event/16/abstracts/
Please make sure to select "Toolchains Track" as the "Track" after
clicking on "Submit new abstract."

>
> Kind regards, Ruud
>
> > On 24 May 2022, at 12:24, Jose E. Marchesi <jemarch@gnu.org> wrote:
> >
> >
> > I am adding Ruud van der Pas in CC.  He works in gprofng and would be
> > willing to participate in a discussion on kernel profiling.
> >
> >> (Re-sending with Vladamir's email addr fixed; sorry for the noise)
> >>
> >> On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
> >> <ndesaulniers@google.com> wrote:
> >>>
> >>> Hi Sami, Bill, Jose, and Vladamir,
> >>> Jose and I are currently in the planning process to put together a
> >>> Kernel+Toolchain microconference track at Linux Plumbers Conference
> >>> this year (Sept 12-14) in Dublin, Ireland.
> >>>
> >>> Would you all be interested in leading a session discussing various
> >>> profiling related topics such as:
> >>> * gprofng
> >>> * PGO
> >>> * AutoFDO
> >>>
> >>> Would others find such a discussion useful?
> >>> --
> >>> Thanks,
> >>> ~Nick Desaulniers
>


-- 
Thanks,
~Nick Desaulniers
