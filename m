Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96454E58A9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiCWSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbiCWSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:48:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4E8933E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:47:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so4215401lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OUdDOmT/BscvMZ9xQqItVK3uz90XvUvJhYMHDKCWz4=;
        b=HtYX1Ondm+m9J67VQiXoWqS0eKe3pyOKVWbfnRUOYF7UtHwDt/cBxxIt+P9m5OX9jt
         C4y0ziVguDJsLBVu4TOEJb8tl+MYvBLKNuifQmFPSZYJSL61IpZ5dMkYs8qYfqJmgwG8
         7keP8dxE3UQCxaZAN7UnT0YttTLUWzr+LSlDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OUdDOmT/BscvMZ9xQqItVK3uz90XvUvJhYMHDKCWz4=;
        b=KOSMx2kiP3IKxmRpBEp0NMAsgYDRAhqRGSkqYRmibxWwbBEqg9W0WDgjLFVvR0sf4f
         MUXn5tcnTVIFs5aLfODnyqyjScDR9AYYBMb8s536/TNJZDMPLnNPGpjyOU/+ZOQCMIHu
         rkXqTZqBdoVrPb6zW9erLdlK2o1fPTlZQnp+r6VeVpGDO5ZsQYnoAM9xQgRPvy/HXABt
         TFHCD4vJNGPkEx8hflAPs3Eon3LAI+zb+SyXWnWuz2zQ8rr8l7tKcvNQJqdyCgiy7RIy
         4toVAam+7wY8je0cbbihsg1k1s/QiKebGlRkl0/NNEarRXPTvrgJyuwnl0EezhfDN3aY
         DW4g==
X-Gm-Message-State: AOAM531lz1c/X8KhgEJDT5wcBe1s6uLASxGO21mtve63aE3ZAtdMmc3m
        dAjH07mgWuDCSWOOu+wWdp3mBN/JhSRC8tb6n2g=
X-Google-Smtp-Source: ABdhPJy/vaaTr5lBi/hYJmamzj2gNm/Kd2dPY0Nzt4Z/JwkofFbwlJEI7uqdf2vzUNWsQQitzLzpmA==
X-Received: by 2002:a05:6512:308b:b0:448:9298:4f62 with SMTP id z11-20020a056512308b00b0044892984f62mr921565lfd.123.1648061245988;
        Wed, 23 Mar 2022 11:47:25 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i14-20020a198c4e000000b0044a279d25d2sm61556lfj.244.2022.03.23.11.47.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 11:47:24 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w7so4210855lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:47:24 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr950426lfj.449.1648061243836; Wed, 23 Mar
 2022 11:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105621.3d4a9bc6@gandalf.local.home>
In-Reply-To: <20220321105621.3d4a9bc6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 11:47:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY2iVfuwuOLbaQ1PG2sK2ZGVtCfRH+bjDyei3j5YytLA@mail.gmail.com>
Message-ID: <CAHk-=wiY2iVfuwuOLbaQ1PG2sK2ZGVtCfRH+bjDyei3j5YytLA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 7:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> A restructure of include/trace caused a conflict [..]

Ugh. Disgusting. And in the very same pull request it shows why that
TRACE_CUSTOM_EVENT() thing that caused this all was actually a
horribly bad idea, since it also then DIDN'T WORK due to the kernel
interfaces changing.

So this restructuring seems to have been triggered by something that
was a bad idea to begin with.

But the real problem is here:

> Tracing updates for 5.18:
>
> - New user_events interface. User space can register an event with the kernel
>   describing the format of the event. Then it will receive a byte in a page
>   mapping that it can check against. A privileged task can then enable that
>   event like any other event, which will change the mapped byte to true,
>   telling the user space application to start writing the event to the
>   tracing buffer.

That explanation makes no sense, because it doesn't actually explain *why*.

It explains *what*, but the big issue for new interfaces shoudl always
be why the heck a new interface was needed in the first place.

I've pulled this, but under protest.

              Linus
