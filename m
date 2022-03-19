Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1764DE7A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbiCSLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiCSLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:39:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899E72E15
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:37:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d10so21422875eje.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9BRdTXptPn9nAkqk8VJH8CbSa79VcrhNAZrsTgKEeY=;
        b=FqjoPvj27E+ko4rKADi6ZlHlM49M4sHIiLFaU3IxZkil52Ht+3ayk72E+zaAIt314q
         ggfqm7yzmGfL1Sa/syHrwX/AxeHkxd7VkHSUtfXt521idDme/jjR32ZoqziokyfXndnQ
         gjj2p8LiGEYjpNKBHQTLVmx+cB+/hb5h6ZRv40+2WbiLR0POQUTVoi9CvqnqzaoV1Am4
         SVNA2r2IsShba/IKx6rP8QlJtwJetbszJKwwfdtHXXRRToMsv+2vv4wUHOkxGZ8n46fk
         npSB8C16MMuwV/zgdMQ3J8237NxKfyfYaJ/x/23y8zsmWiyHuUTFtspPByXJ+FBkRvYc
         EyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9BRdTXptPn9nAkqk8VJH8CbSa79VcrhNAZrsTgKEeY=;
        b=202GXkx3FzcOF55zBBC0RTRQpatE1JmhR4XWLoDzsMMHX+Ycz/btD+k6UqHYMR9CE8
         ThmgzZFrGyP6bcavjbGxHDpcbjmak/fBjJj23KrOcx4jjLutBgV5xsRGk+SerXD9pwme
         kWS7FD6NxxUTgm01IX4gGAlns+GVUD6Zo54Fju1EziPQa5kJaQEZVzuGk3ARgAbiiYA8
         G1gHEbD2rOmfep047jZv2ZtC4pHNVF/smtqx8DAmpMSSONxbhMDzDlJWUapiur0/Z9Ou
         kmcCRsikD6d0S5cqZB0IjyxSktc5fzUFT3qwhYvMcm0cCrJ2FnH6baYAitokGgW2fOG2
         4f5w==
X-Gm-Message-State: AOAM530xpRibhSSZEKAkcBjNSEN3p+OwOvthD4OdWmqgS7irhzabx5RD
        zPsWsxlusUEbwKHFWNpommP8TW3yLPGddyqA6Lc=
X-Google-Smtp-Source: ABdhPJzIqn+r1GhTb2EP6E7uj2RA39/apGSu0U/R63O4hzfdexCWcoeQqcj+LPr7SRvoreJXWECKPXj/ZkqWTaZ0uRQ=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr12721701ejt.639.1647689861322; Sat, 19
 Mar 2022 04:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
 <20220308151119.48412-4-andriy.shevchenko@linux.intel.com> <CANiq72mVnHWi-tZmT4g+2Y96eYu=Hm=oMKn6RkwpXWh7ARATAA@mail.gmail.com>
In-Reply-To: <CANiq72mVnHWi-tZmT4g+2Y96eYu=Hm=oMKn6RkwpXWh7ARATAA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 19 Mar 2022 13:37:05 +0200
Message-ID: <CAHp75VfMHWObRFs=-fOQnkV=KkAKWuqRF=JLUfzqruTa2U9XjQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Mar 19, 2022 at 6:46 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, Mar 8, 2022 at 4:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Currently the reading of the onstack array is confusing since two
> > out of three members are of different types. Let it be more clear
> > by explicitly set the array size, so everybody will understand that
> > parameters are cast to the type of the array.
>
> I am not sure what you mean by this, could you please elaborate why is
> it more clear if the size is given?

With [] and parameters not being bytes by type one needs an additional
processing step to figure that out. When I see u8 ...[3] I immediately
understand that there are 3 _bytes_. Moreover, [] is error prone when
one may add something to the buffer with the expectation that it will
work somehow (for example, with an old device you need 3, with new
device revision you need 4 bytes and passing 4 bytes breaks the old
device). Of course most of that quite likely won't happen.

If you think this change is not worth it, please, drop.


--
With Best Regards,
Andy Shevchenko
