Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1825F4F92CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiDHKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDHKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:23:17 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A97140DC5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:21:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z7so10089822iom.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiDN7k6aC8ZwYDiFSJSV9wrBF+tzi9VGwTXl8N4IGsA=;
        b=xe6Sx6YnpT8qRY77m0yznqYAK7saEHhq+hJLli+HkXPONxuO4flT1bUYpsx0oSPEVg
         XWWoaTTaK7OmZUyXdVqg6bVaddQpNTFyYu+wYlfYEml4uytnsN5qXispMHUC/vqynwKa
         bW6YQcY8XUnsrva+TGmfOW9o/Gm1IYjw9ZdqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiDN7k6aC8ZwYDiFSJSV9wrBF+tzi9VGwTXl8N4IGsA=;
        b=hxlAzehSuQcX/DY1zBWR78QaOFtXeNy8nIwcq9ZSDfHpdMgpTbS4TQJh4il7whqPj2
         VwmH2r7lL/iTANpsMvI0JIcmzfmXFP0TYbJfzblkwl6r8Gcu3J/14fClwkVoKp1tUPGA
         Ve8jsBK3i85HUcXmtcfhYhuJnuYaAc9MEdYQ81PLEEmPKVCtw5QjoebWAVF63pbgagCX
         QzBmnd5GmK0URplxIme8n2cARsX8W5QNYu1iKPdKjVYoFooigXew1syo7an/gdsZ2KcW
         39MgztZQZ+Nu6TEsMpE8DtX5aTeQCPNhN/VgyOyoSVa8b0Ru57tBrbokgpCJmVJf0L5y
         o1EA==
X-Gm-Message-State: AOAM533Ilt56L/9R4giQt9wYQR3EqzvR9z2Ux5WwyAJzJkpkT+TKCssT
        6oo9Ig8e6DEbo8C1mbXr5kxqHgEY/TZ3RiAzdJUYHA==
X-Google-Smtp-Source: ABdhPJzCKUtlciLHhXB49c82badUbJaguTQiw22dcg/5qKqwQVnRmiOYZEtGtZ0v0BQCKXuRFjjhOxRw4N9RZ0lonGQ=
X-Received: by 2002:a05:6638:130d:b0:323:8fba:8a15 with SMTP id
 r13-20020a056638130d00b003238fba8a15mr9476118jad.270.1649413274312; Fri, 08
 Apr 2022 03:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
In-Reply-To: <20220408045734.1158817-1-kaleshsingh@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 06:21:03 -0400
Message-ID: <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
[..]
> +config RCU_EXP_KTHREAD
> +       bool "Perform RCU expedited work in a real-time kthread"
> +       depends on RCU_BOOST && RCU_EXPERT

Doesn't this disable the fix if a system is not RCU_EXPERT ?  Please
see the definition of RCU_EXPERT:
"This option needs to be enabled if you wish to make expert-level
adjustments to RCU configuration."

I don't think a bug fix counts as an expert-level adjustment.

> +       default !PREEMPT_RT && NR_CPUS <= 32

What is the benefit of turning it off on PREEMPT_RT, even if
PREEMPT_RT does not use expedited GPs much post-boot? I would think in
the future if PREEMPT_RT ever uses expedited GPs, they would want this
feature even more. I'd rather be future-proof now as I don't see any
advantages of disabling it on !PREEMPT_RT (And a drawback that the fix
won't apply to those systems). Also will keep the config simple.

> +       help
> +         Use this option to further reduce the latencies of expedited
> +         grace periods at the expense of being more disruptive.
> +
> +         Accept the default if unsure.
> +
>  config RCU_NOCB_CPU
>         bool "Offload RCU callback processing from boot-selected CPUs"
>         depends on TREE_RCU
[...]

Thanks,

 - Joel
