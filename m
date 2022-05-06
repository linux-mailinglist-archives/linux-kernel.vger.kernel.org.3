Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0051E10C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444431AbiEFVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442687AbiEFVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:30:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE0E63BE4
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:26:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so8657555plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6Oz7HOQ3x6czvwnoivav5HCYoCnmrdh+Dm8MPs0jWw=;
        b=SwSsYkfN9KDMSB9pu+/5JgU2+rc3oBkAjfkvyVVfj4lcVjlMSeXz7cn1HFWsS0mdbe
         ZRjWpTVwLSz/9p3vpGcOcbvBkpxNLjdAtOqAHGzkEKp1Kd3d8Q383mYCiHBojVpARBTn
         eEeMZFbq42IX6E84oH9rQEVpC2kuaoCp2yZ9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6Oz7HOQ3x6czvwnoivav5HCYoCnmrdh+Dm8MPs0jWw=;
        b=Fm04NfpAyVnzGKcZ7NBN65FfCSffMOlePB+M2SFRPtLUvlQWb8G3IfaNGX+C+l+tgf
         qgZAS2E1qg/8UhvTLxx67bprHfpYdH6mvraxxfMupwBdPrMcS/N6q/epgxJYu/TR/l9E
         NFnuq4CR2xKSm/TBAxjiQ/kUILna1/RM3MS68aQ7X1pn5UdvGE3T3noL+3lwvRLvE6nz
         OJaNKVhpmEcxSTqEl4mrZF2df3yN97V8kbw3BZaO0qlI47ir4SxUPr9AorAffWDWIa/D
         th+u6Na6hXiFWe/Jl4Ad3+t8L8DUm85ifjJjVgA3dpA/X0mNf4Ev4T/W8rO1/rlbCnM1
         p3wA==
X-Gm-Message-State: AOAM531nVvNWwM8Vsf+aC+UVGzSJxTECwJOxZUhqdzRw4UrsnqSbIOJS
        K127jkdWqo8H6sZ/gkqNLpqskg==
X-Google-Smtp-Source: ABdhPJxqHSDMOut62U5hSxiCpUfOF+RHgmwoJ/cR7WT5zkFNH1CBodbZioDdYdrafVGnTPdDOvN6/g==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr5727111plg.23.1651872397724;
        Fri, 06 May 2022 14:26:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c17-20020a63ef51000000b003c2f9540127sm3713041pgk.93.2022.05.06.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:26:37 -0700 (PDT)
Date:   Fri, 6 May 2022 14:26:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>,
        Kyle Huey <khuey@pernos.co>
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
Message-ID: <202205061348.927E94729E@keescook>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:25:57PM -0500, Eric W. Biederman wrote:
> The states TASK_STOPPED and TASK_TRACE are special in they can not
> handle spurious wake-ups.  This plus actively depending upon and
> changing the value of tsk->__state causes problems for PREEMPT_RT and
> Peter's freezer rewrite.
> 
> There are a lot of details we have to get right to sort out the
> technical challenges and this is my parred back version of the changes
> that contains just those problems I see good solutions to that I believe
> are ready.
> 
> A couple of issues have been pointed but I think this parred back set of
> changes is still on the right track.  The biggest change in v4 is the
> split of "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs" into
> two patches because the dependency I thought exited between two
> different changes did not exist.  The rest of the changes are minor
> tweaks to "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs";
> removing an always true branch, and adding an early  test to see if the
> ptracer had gone, before TASK_TRAPPING was set.
> 
> This set of changes should support Peter's freezer rewrite, and with the
> addition of changing wait_task_inactive(TASK_TRACED) to be
> wait_task_inactive(0) in ptrace_check_attach I don't think there are any
> races or issues to be concerned about from the ptrace side.
> 
> More work is needed to support PREEMPT_RT, but these changes get things
> closer.
> 
> This set of changes continues to look like it will provide a firm
> foundation for solving the PREEMPT_RT and freezer challenges.

One of the more sensitive projects to changes around ptrace is rr
(Robert and Kyle added to CC). I ran rr's selftests before/after this
series and saw no changes. My failures remained the same; I assume
they're due to missing CPU features (pkeys) or build configs (bpf), etc:

99% tests passed, 19 tests failed out of 2777

Total Test time (real) = 773.40 sec

The following tests FAILED:
         42 - bpf_map (Failed)
         43 - bpf_map-no-syscallbuf (Failed)
        414 - netfilter (Failed)
        415 - netfilter-no-syscallbuf (Failed)
        454 - x86/pkeys (Failed)
        455 - x86/pkeys-no-syscallbuf (Failed)
        1152 - ttyname (Failed)
        1153 - ttyname-no-syscallbuf (Failed)
        1430 - bpf_map-32 (Failed)
        1431 - bpf_map-32-no-syscallbuf (Failed)
        1502 - detach_sigkill-32 (Failed)
        1802 - netfilter-32 (Failed)
        1803 - netfilter-32-no-syscallbuf (Failed)
        1842 - x86/pkeys-32 (Failed)
        1843 - x86/pkeys-32-no-syscallbuf (Failed)
        2316 - crash_in_function-32 (Failed)
        2317 - crash_in_function-32-no-syscallbuf (Failed)
        2540 - ttyname-32 (Failed)
        2541 - ttyname-32-no-syscallbuf (Failed)

So, I guess:

Tested-by: Kees Cook <keescook@chromium.org>

:)

-- 
Kees Cook
