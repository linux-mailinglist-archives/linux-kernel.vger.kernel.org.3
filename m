Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0B4D5757
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiCKB3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiCKB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:29:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E191198EC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:28:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 25so10185154ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dW9ZypqBoCugmw6ZCMV/tiPW76WW4fYGbEuqLLIjSso=;
        b=b26lvnNBl47MpfzrhncI8jFj4I7n4NCEu1IWehFbMVOKTNCirpYiZBDSZfHTSUTwB+
         OSxpFnzfpJlDLl0WOxCGg8dVM/U3mThKvghhRYNkqSssU7F4W3wM6lxZjC0TVC8LTNtL
         rukTZxD9aFsb4zxvo7+gSr/yWV4k16ICvIMSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW9ZypqBoCugmw6ZCMV/tiPW76WW4fYGbEuqLLIjSso=;
        b=omfMqBopf46vKXOESIeuxxtJK0IJ85ZdAZodvIgWYQOn2OtxApVKM4EJgX19ssnc3H
         UlbbUJD22y6GCzTmow6/WycZRUVsIyEgVdBz2qVKoK1S9iU123phpCDOQP+5ShkLRvQm
         6vYTvloSiLE7caIJxXOrm4rKuaYTJPAvgr/VQhE9JADzPEWMWYUcWON0IdkZisnTah/1
         J7H/lpMlLxRrKrr5RLqTo6AMbpa0W3Z9JU5IE6nxAHBzUNU7NaP6LLY1qaOU6G1yUEXR
         BepIxLmEZciHzuEJBb5IGFm1iG0TfnGMWCiLSk1qAirvhspZRmIX2xd09xoubo66zR/A
         3s/A==
X-Gm-Message-State: AOAM53340DyMNctyhTfIAyR423dRfayHgr2lhnt0ByDtDF6nUrWLMTG/
        zYeOhIXX4AcBA7RYphe6NmAwCg/3l2HutkNqNw4=
X-Google-Smtp-Source: ABdhPJzbH8c9ZGI/V1jp9et8LmG4RG9fzTPG7GX9ZtM73H7gQRfzKnq3B+yb/tMMaRujI4dDmYMEoA==
X-Received: by 2002:a2e:a795:0:b0:248:27a5:4798 with SMTP id c21-20020a2ea795000000b0024827a54798mr3465475ljf.446.1646962129167;
        Thu, 10 Mar 2022 17:28:49 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2568d000000b00446985451c3sm1280068lfr.157.2022.03.10.17.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 17:28:48 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n19so12502011lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:28:48 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr4570765lfb.687.1646962127821; Thu, 10
 Mar 2022 17:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20220310174545.68e872fc@gandalf.local.home>
In-Reply-To: <20220310174545.68e872fc@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 17:28:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrhzKn2p6s7WPDGegmcnyOWL4jt5+4By11sGJGAkxG1w@mail.gmail.com>
Message-ID: <CAHk-=wjrhzKn2p6s7WPDGegmcnyOWL4jt5+4By11sGJGAkxG1w@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: minor fixes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
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

On Thu, Mar 10, 2022 at 2:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  - Fix unregistering the same event twice a the user could disable
>    the event osnoise will disable on unregistering.

What? That sounds like a (bad) markov chain text generator made random
commit noises.

I tried to edit that to something that actually makes some sense, but
who knows..

                  Linus
