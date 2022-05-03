Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007515186A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiECObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiECOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:31:29 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549631DE3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:27:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y19so22229370ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAIaFBddevm5l2FhMvLviBi7kDOvuEBcgoyQi5o6QDE=;
        b=UKobFtvPGLpGii6q96CXxVA3nOqmwhkT9ADQwFcjwROXPESKQFTaUK5lxjcqkf9Tj7
         GVQ02fdHMZJ+N3j97U5ygU1P8F3cOhPCEisR4N7Chvgtysi9YYeWD8F/a9Kz9YtxFLqb
         RoSpMhsb9tPtD0B2vcDvpnou3BhDrHoVZiTg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAIaFBddevm5l2FhMvLviBi7kDOvuEBcgoyQi5o6QDE=;
        b=ZQ3GTEANM3w9YYl5RORPPtlAfG5ycuS/XxYvA3FRY4kddpOuWqoLN/5RElcy1ucrnT
         vn/1BXDAqujCkROn4rqNO1vUY1iReYqOSUhZih5YGPc2A0E3TSmzWNVnfRTSzaNjfj5C
         TOzeQDAnWkMKvbcpeJjMwYwmFQJQuxDa9mPxN+Id0aj95mV5wPyTeZAd1tjbq+CBogby
         GiaiuIP4COs447Wb1RuEhWBjDSYj8QmoWUx+MgJYjumdwQBGENeNgsTjebqiW52Qnvj6
         t7D8rvS8i6/fV97/EXb1E4a0YDZTQVdZRSpsho+/AXa6L5ux7ZNGpgcnUOYtLEDUc0I3
         sfAg==
X-Gm-Message-State: AOAM532K02aeC1gCAzLJtgfrdIYp0j/PZTbdVIYLENychuRv9v9/fwqW
        rYFTnyMgaEsxX19xE2Mm46jON00WGLnABjf7GaNL5A==
X-Google-Smtp-Source: ABdhPJzXMApdMEcaH0qHhb0XSh0yJ4MlGpHyNV62jXxA3eP/N8JMSZdKbljVCVJ4oy5ClEXwSQOC191bM4WEAbQ08ls=
X-Received: by 2002:a2e:9dcc:0:b0:24f:2785:76de with SMTP id
 x12-20020a2e9dcc000000b0024f278576demr10378646ljj.137.1651588074212; Tue, 03
 May 2022 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220429023113.74993-1-sargun@sargun.me> <20220429023113.74993-2-sargun@sargun.me>
 <CACaBj2Z0OO7quYDF6LBaNsh14xTm6cN+rcMJMYtTioXNQNd34g@mail.gmail.com> <20220502160415.GA1289934@ircssh-3.c.rugged-nimbus-611.internal>
In-Reply-To: <20220502160415.GA1289934@ircssh-3.c.rugged-nimbus-611.internal>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Tue, 3 May 2022 16:27:18 +0200
Message-ID: <CACaBj2ba08sQTvJSTuApiXAcsRsC09UMbA3AN744r6FEngBGow@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 6:04 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Mon, May 02, 2022 at 04:15:07PM +0200, Rodrigo Campos wrote:
> > (I couldn't git-am this locally, so maybe I'm injecting this at the
> > wrong parts mentally when looking at the other code for more context.
> > Sorry if that is the case :))
> >
> > Why do we need to complete() only in this error path? As far as I can
> > see this is on the error path where the copy to userspace failed and
> > we want to reset this notification.
> This error path acts as follows
> (Say, S: Supervisor, P: Notifying Process, U: User)
>
> P: 2 <-- Pid
> P: getppid() // Generated notification
> P: Waiting in wait_interruptible state
> S: Calls receive notification, and the codepath gets up to the poin
>    where it's copying the notification to userspace
> U: kill -SIGURG 2 // Send a kill signal to the notifying process
> P: Waiting in the wait_killable state
> S: Kernel fails to copy notification into user memory, and resets
>    the notification and returns an error
>
> If we do not have the reset, the P will never return to wait interruptible.

Ohhh, because we want the wait to be interruptible again! Right, I
forgot we should reset to that state again, until the notification is
indeed handled.

What if we say something along those lines in the comment, then? Like:

// Make the other side go back to wait interruptible, the notification
is not SENT.

Something like that would at least help me in the future :)

> > We _need_ to call complete() in the non error path here so the other
> > side wakes up and switches to a killable wait. As we are not doing
> > this (for the non error path), this will basically not achieve a
> > wait_killable() at all.
> >
> No, because here, we check if we were waiting interruptible, and
> then we switch to wait_killable:

Ohhh, right right right. This is lazily changing to wait killable only
when something already wakes up the process. Sorry, I overlooked that.



Best,
Rodrigo
