Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A04F1BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381903AbiDDVYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380472AbiDDUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:15:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993846140
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:13:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w18so6221693edi.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3ub90YIQCH3gVrlC+XZhiwoGcv8qRMkkwg5XV6TGpo=;
        b=H8bLkWFNt5QHQ76VwX26EiXKepq0WEvr0SAsN5VcU6JoU2U22Jvh1dCkBgEZ+teAZk
         +D6lIkRKH3VV/XRKQCdelK4pPgvqM2wheT6odsr7hMaTQH8zYx6knH1OY6lJjYkTNbd1
         u7qldbMjS0MWp8b2+sb0oR+qEwuEYIrEHSHfF2fGq78+I820yKFRFdZfVJATm2lIuaGt
         Yuqh86WPFLtTS8V8vg9qrUL6gYCuUp82urNfzo7EUsSNkRczA5DKgSshbbhdfDw7hEg7
         u4DX6v3j6OIKy9eAtaltaRyw4jleQqcwHm1/GxWk6m+P/od6CD6c7JgOEQ7S127KKGR1
         lpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3ub90YIQCH3gVrlC+XZhiwoGcv8qRMkkwg5XV6TGpo=;
        b=ZkMuNjSl4lu5pZtilM8Sig0KmllpwsE5XEMrefwP3L2MhmuEEeOnvjR4tmmD4yD9ua
         5JdEK9rS/GTT0N+TXWVmegrVZj+fM4EsUB/hs05g6PFQtXfoGyT6/Xd7ZbA1PmS4eU+c
         nTq6SkvZP2rFOV9h7pqyY8OoVkaCjoZf5QoXw38j2f2G5TCfHriUI/0g4sIFH/f9BuQQ
         SRu44ET0teR9ti56ZcUJlT6x8TK2WacZfbLrg90nTHPV6bxHCHgLiNK4BOue2BSlxlL0
         uZHzAD+SMp5MfbI4RmbGJCPfWReNuE1x8vo1jHS/NcLodXIuPGg3KoX6dR1H8o2YEQNH
         qNIw==
X-Gm-Message-State: AOAM531Hc+eC2ODGZe/4RD7NlGlx1U7FtXeUINceF/yTRi7zzkRXdOyW
        YoZSQi0MxZ8PvJqFynZ/LofuZiXAri/iIRSq0rVWmA==
X-Google-Smtp-Source: ABdhPJyjaZPLJ2IAcUnO0PWdbzDgVf1qeADw4rh2FnfnjirXie9zljRk+Niv/kP5VX3HBauIFJFTem64EluRa1ybc3o=
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id
 ck30-20020a0564021c1e00b004165b93eacfmr1998410edb.302.1649103213975; Mon, 04
 Apr 2022 13:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318092159.6f275782@gandalf.local.home>
In-Reply-To: <20220318092159.6f275782@gandalf.local.home>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 16:13:22 -0400
Message-ID: <CAFd5g461Poh37o=3m6EXppdX7oS0D5vZxvFAEtzJMwtBD1VJEw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Muckle <smuckle@google.com>
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

On Fri, Mar 18, 2022 at 9:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 18 Mar 2022 10:13:12 +0800
> David Gow <davidgow@google.com> wrote:
>
> > Does either (or both) of these features sound useful, and is this
> > sort-of API the right model? (Personally, I think there's a reasonable
> > scope for both.) Is anything obviously missing or wrong? Do the names,
> > descriptions etc. make any sense?
>
> Obviously I'm biased toward the ftrace solution ;-)

Personally, I like providing both - as long as we can keep the
interface the same.

Ftrace is less visually invasive, but it is also less flexible in
capabilities, and requires substantial work to support on new
architectures.
