Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31955C343
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbiF0Wpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiF0Wph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:45:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45668186E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:45:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e2so15121010edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wps7evmCfHkwOKf0HCagt5ucdNhzuooTyX4knSwh9/4=;
        b=gu3ogRGERj7DP4D05Z2mB9N6H/fxqIidBv28teu7FDXQmPmgYdy3Q+9lUnGvB2Tggj
         ytlvQc7hsYvhbHdpzT7aJSUjFIaG8MkjDbTKgY6YeGmYZLthEyCd3pmFMw7uHIWob3lV
         esbzEBjijOD0FErbIsyXGBEW+YLeXXCg3hf281nB8fFKUPjUI2Fbm6pgvRxUic6LvirC
         xd97ycZdhz51wIzmPN4bTBYoOwxcshbIGD8npNFjZbQQXwpC+L1ci/xwHYiiUF+Z+Kbn
         kh7jQCfzfvcUBQXYrVDkKFvjj6UmXh/qynqg35ZTZ4RU4Sb3vxAH+Q1HNrYf5T1jz1tv
         J1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wps7evmCfHkwOKf0HCagt5ucdNhzuooTyX4knSwh9/4=;
        b=kHLhC/DgpdB93H1IaVkWnvrmOBAg9ZD6TuRXuJqSgbjYbNN3itcbtpDpTtZNRqU9WO
         qghEff/HS3mmJyGberVnqvyXwUywOMvZ1SYNAQIPGb190/GugdMwUb4+O92YOGfwt79/
         oDtukWRFmbzYFnW2Ip8UF0hyi2kYtHYq393fnDFG50+aLM9QB/1W0BJz04hedixB3xtQ
         ABYVLgo70/O+fNJqYoNlCbJVnfXloibd0vLYt4/fNXDUfTvxxj8lhUxRK69/ST0zWIID
         cQjVtvRJO/KuWMa4pwofvKJCpRVVGddX1ujiVSlSyHJmuq314pOLcREjfJQztUkoThyH
         rd5w==
X-Gm-Message-State: AJIora8lxHjLCKnAQymNDUxrM4LvVDawNsftQoTnO7Gohz4WA4IcEQre
        agJCO8Vn8Fc4YWpOwqB5oxl8
X-Google-Smtp-Source: AGRyM1srBhqjFZa3i4vSnqfua1hA7Orwh1Ynfw5ddL1/6Z4Zg8WFuZzTD/R167EhNpXqaPS6ExpXAA==
X-Received: by 2002:a05:6402:104a:b0:435:c7cd:11dc with SMTP id e10-20020a056402104a00b00435c7cd11dcmr19550173edu.335.1656369934707;
        Mon, 27 Jun 2022 15:45:34 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7c2ce000000b0042dc9aafbfbsm8258272edp.39.2022.06.27.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:45:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 22:45:29 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>,
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
Message-ID: <YrozCRfBRMCi88Yr@google.com>
References: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
 <YrnxHBoi6sO0vqV0@google.com>
 <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
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

On Tue, Jun 28, 2022 at 12:06:29AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 06:04:12PM +0000, Wedson Almeida Filho wrote:
> 
> >   let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;
> 
> I'm still having a really hard time with this Rust stuff, the above
> looks like a syntax error and random characters to me :/

Fair enough, there are a few things going on there. The code above could
be expanded to the following:

  fn thread_func() {
    pr_info!("Hello world\n");
  }

  let retval = task::new_paused(thread_func);
  if retval.is_err() {
      return retval.unwrap_err();
  }

  let new_thread = retval.unwrap();

I hope the above is clearer. The question-mark operator is just
syntax-sugar for the error handling above, the pipes indicate a closure,
the full syntax is: |args| -> ret_type { statement1; statement2; etc. }
-- the line you quote has the compiler infer the type (so it's omitted),
there are no args (so the nothing between the pipes), and when there's a
single statement that is an expression whose type matches the return
type, the curly braces can thus be omitted, so we end up with "|| x" as
the closure.

I'm confident people can get used to this. It's in the rare cases when
one has to think about say subtyping, invariance, covariance, and
contravriance that things may get hairy (or exciting for the more
math-inclined).
