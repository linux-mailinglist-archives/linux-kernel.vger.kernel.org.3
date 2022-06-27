Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9206855D3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiF0SEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiF0SET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:04:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017ED132
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:04:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so14169356edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZqIXiGtlvNVG5JO+e4DPTFXLFGbncUcH+8YC7UZ0eE=;
        b=fRovQTFBLjiZJ/UgRgYBpy18eSOfFsi2Wn9Vo86EP8aFAKyllIkYdp6RIWABQXdeK9
         MBjlsbvZZmze02zGHMsoxhss36Sd3riB2vuDV2ylGzn2bYOSeURdEgcTa26ctlsxGc2Z
         W0n3OJS/i0y2CwBy/6JvGrHQXVOCaudr9ow93dMgv/RWC4n2u0kqTOvg3kdlMJZ95v5z
         n/vzNizq3sNFnB2pKgnfZaT3L14c0gWuYS00C+qOolRsTuWHfuihpof9c0o5lbkRXwUb
         55Nc5HYAh6gt8fb9BSvK4fjQSh5v+L8DsZ7o3swmOPlJQJFllzlqAK0ts3Sw54Gw7YUd
         pyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZqIXiGtlvNVG5JO+e4DPTFXLFGbncUcH+8YC7UZ0eE=;
        b=ztFFWlDRFbtxndJ7+rKSZS5pDZxNTXqmNPpR/NtMlUEiIpYsPXaGUCc9xF8iFsl9c3
         Bpwa4pQnYdixkVHjgAZfemX9w+FnZew6pd6QExUTUamWxu5mY+v0rY4VPH3y7/AEDb18
         zXoZt588r2nb1jlaApiGuXAuf+x0wKud5zY2Xrav8u/Lrdpok2nc70IO2/wmknDyg5Uu
         EmnrwWA36h958AiBEBSn1sYmNIGQ26B8xtq0WkKx3AA0iK5Xo2l6w6qubfD6QyXzwYDm
         7yLU3moyq/LpmIZBVtW0hxee91ftNsmARdZu20Gvz7lY84pJCXj9sGbz7JGMejUQ0Apq
         6+cQ==
X-Gm-Message-State: AJIora9pEKAoT8LcZwMw96Ke2xD3Mk/suTMviEu6GzOFwDOJ3p4YXBDC
        IzbqM4tTXt/Yqm6tAvfUFt0r
X-Google-Smtp-Source: AGRyM1uI6pP3ME/0GVXkreC6KY78qNLDELqR2VPQLgaMNRDgBB2wXyNbohLnPJGT+cHQna48KQRJeQ==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr17948679edr.158.1656353056845;
        Mon, 27 Jun 2022 11:04:16 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id t17-20020a1709067c1100b00711d5baae0esm5334711ejo.145.2022.06.27.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:04:16 -0700 (PDT)
Date:   Mon, 27 Jun 2022 18:04:12 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <YrnxHBoi6sO0vqV0@google.com>
References: <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
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

On Mon, Jun 27, 2022 at 05:11:36PM +0900, Tejun Heo wrote:
> Yeah, I have a hard time imagining this happening in C but maybe we'll
> get pretty good closure support through rust-in-kernel if that works
> out. That'd be pretty sweet even though we might not be able to use it
> everywhere.

While Rust does support closures and it would work just fine here, I
think in this case its type system allows for better ergonomics and
flexibility without them, for example:

  // the pr_info! part is a closure for the body of the thread. Could
  // also be replaced with a function.
  let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;

  // Do whatever initialisation one wants to do using new_thread. Only
  // functions that _can_ be used on a new kthread would be available
  // (e.g., wake_up_process() wouldn't).

  new_thread.start();

  // new_thread isn't accessible anymore. The compiler fails compilation
  // if one attempts to use it again, for example, to call start()
  // again.

The type returned by task::new_paused() wouldn't be copyable, so we can
guarantee that start() is called at most once.

It would have a Drop implemention (destructor) that puts the task, which
means that we could use the question mark operator for error handling
between new_paused() & start() (or really any kind of early-return
technique) and all error paths would properly clean the new task up
without any goto mess. It also means that if one forgets to call
start(), not only will the thread never start, it will also be freed
(i.e., no leaks).

If the caller wants to keep a reference to the task, they would do
something like the following (instead of calling new_thread.start()):

    let task = new_thread.start_and_get();

Then `task` could be used as any task. For example, wake_up() would be
available, but not wake_up_new_task(). It also has automatic handling of
refcounting such that we are garanteed to never have a dangling pointer
to the task.

Lastly, all the checks I mentioned above happen at compile time, so
there is absolutely zero cost at runtime.

Anyway, sorry for the digression. I thought this would be a good
opportunity to talk about some of the possibilities in API design and
enforcement that Rust affords us since this kind of design was the topic
in discussion and Rust was brought up by someone else :)

Cheers,
-Wedson
