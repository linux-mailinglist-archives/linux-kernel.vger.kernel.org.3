Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5146D55D477
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiF0WyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiF0WyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:54:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660FC7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:54:07 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v185so9701296ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8p2fOgowjsf8oZFxqGZOg/EZjm2/fdInQfV8uj3Tg4=;
        b=lmyYiyM2j12gO44/NHgBsznv8Acdn7rsGx9LOa1DMDnJsxBloM50R+jyM8b/1ZxvBk
         kytYIdVlUB7GUDhGXKTKOwKLAP8msdy5HycKv3A/EKbsr9VrkED/V3e2H0VeZ2ijTPXe
         ArJWK5/1Mg/g5ali4c83gq4U+77uA0AxgOnSIzD9fZTcwBjolJEzwLy1KlwvZO/ZAf0e
         1K+s+qpynni/dm0cIaKOOqyxlKefWZZB0/x+dSnqT0EKkVv3F7NP3ToftLzeRymoeHUX
         evOLbjOieo2GWJsVWTqJPQvzeHFSltOb3FcG4S7SjIhVGMZnPKgXIdUpnTc1jIuHF0jZ
         9/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8p2fOgowjsf8oZFxqGZOg/EZjm2/fdInQfV8uj3Tg4=;
        b=PafNqLiJlHHG+2JJ1/v+68Ymy8qI8zVYyQVLA0zg/sfKb1gALQwKMH2ztKgMkmtja9
         dQV3JYa5+q3PHQe5nOow8lL1QAUnh9e9M9RRrn0jw2mkvZtQhCsQh03DRLmIGMnQA+bz
         w+pwe0rIH+r/RBTt88bK7rK/EHzWKY75MfH6eBSr6WNloDOi3ZcnsKLeY0US9KBqlh8e
         /6bt4m5qNjT3WwxVysyY1DiXxSxdHuSzSUPoXZJrjRdbBOnZSf7VOUhAWw6kft4LcixT
         I65TtQN00LgjfsxrcrwwP3AX7X+aIkXw7f0dgewq8HFFw5+Tts7nzibMozuNnZnq3uvh
         tcGQ==
X-Gm-Message-State: AJIora8Ecfu8TC/I4MoFRWPcBQB1gIrxLIN2afZcXIaws8LsawN2cQEl
        MKWfOdgt5amIec2pM+61Dhpkm5CmmzqZGWxO0RKAag==
X-Google-Smtp-Source: AGRyM1s42lhxj12Q3mI+P6ty59Fb5YUktvgmrfrML6+zuATUXyyKPodhemJYMQuODu8sdf7u6NokoMrKcyg1CZqlcx0=
X-Received: by 2002:a5b:a04:0:b0:668:dd55:1ca8 with SMTP id
 k4-20020a5b0a04000000b00668dd551ca8mr16521779ybq.281.1656370446631; Mon, 27
 Jun 2022 15:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com> <20220619120451.95251-2-wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-2-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 15:53:55 -0700
Message-ID: <CABk29NtfVjXQZORGB1owmBS6C9LZJn8ci15gv4nQm+2DNLEPBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] sched/fair: default to false in test_idle_cores
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> It's uncertain whether idle cores exist or not if shared sched-domains
> are not ready, so returning "no idle cores" usually makes sense.
>
> While __update_idle_core() is an exception, it checks status of this
> core and set to shared sched-domain if necessary. So the whole logic
> depends on the existence of shared domain, and can bail out early if
> it isn't available. Modern compilers seems capable of handling such
> cases, so remove the tricky self-defined default return value.

I don't think the compiler will be able to bail out of the smt
iteration early, since it'll have to do another rcu dereference for
the sd_llc in set(). But I also don't think this case needs
optimization, since it should be transient while the domain isn't
ready.

Reviewed-by: Josh Don <joshdon@google.com>
