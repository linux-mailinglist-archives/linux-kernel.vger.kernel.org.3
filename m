Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5BB4CAD99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiCBSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiCBSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:33:10 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35384109B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:32:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso5565029pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qd42BnpR52D+AhX5aeRfQ73Nc9hYkmpHfd4TTWN+uII=;
        b=GWLUbfHqPqiWSHV5g19FOhTfakpd0jWDELj9DJzgQUDt0ztsNuPbwPjvGFqDqQuMEK
         yxz54xIFb3JDWxlkH4lwbXxhu6rmN+J2a+rexf9+LCzeaTx0w2JwqEgMi/9enfRqeZlC
         Z+C18SN/xIqaY9YFlLNcwTvQfYt7tTTEXxWsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qd42BnpR52D+AhX5aeRfQ73Nc9hYkmpHfd4TTWN+uII=;
        b=RR+75YC22WYieMZhMpXnbZe/ZBBrbXfFCtxOTUndjY4ipb9dT8Xtt0IimqGnIJ/vEk
         mOFhyxiMQCAIpp9Xp9z38AVzfJKyr07aGQMyYxM/13RkIUUcg+DFoxNBzeJSWIcRQC8i
         NVQ0yZfAINiPQADeaOGRh8hWUwjVwyB6EGMyoIUFxk7SyjSb36/n3d7WI4gah/LGsMoh
         NNBSCqs9lKqLXpk4Faac14EWT3Yr4T7+6pokks0VxnMG79Ndy1F8VAH55xJC+/XRahSp
         QpVjGf4SdflTZI3iKOq6F3suKEYRFGdxf+QBe50TufjzJDHxlXfexOrKMIptbKcK58Uo
         xFew==
X-Gm-Message-State: AOAM5305UAFP9Et3dkbI9Cc6lpc3uDzfIjb9uOfg01oMM3LwOJTR53sL
        wR9Nq35ddB4oe44ju9zN1i6xAA==
X-Google-Smtp-Source: ABdhPJzk/lxhMnPk1kXAbBKUchI/3RHE2hqeXkIEmq3usIg0PZJsC/S4HcjvYCzeAWEZSV2Xyb5VhA==
X-Received: by 2002:a17:902:6b0a:b0:14d:8ee9:3298 with SMTP id o10-20020a1709026b0a00b0014d8ee93298mr32019886plk.125.1646245944666;
        Wed, 02 Mar 2022 10:32:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1-20020a056a00130100b004df82ad0498sm21679139pfu.82.2022.03.02.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:32:24 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:32:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <202203021030.EEEF58C2@keescook>
References: <20220302043451.2441320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:34:32AM +0000, Matthew Wilcox (Oracle) wrote:
> I thought I'd choose one of the more core parts of the kernel to
> demonstrate the value of -Wshadow.  It found two places where there are
> shadowed variables that are at least confusing.  For all I know they're
> buggy and my resolution of these warnings is wrong.
> 
> The first 12 patches just untangle the unclean uses of __ret in wait.h
> & friends.  Then 4 patches to fix problems in headers that are noticed
> by kernel/sched.  Two patches fix the two places in kernel/sched/
> with shadowed variables and the final patch adds -Wshadow=local to
> the Makefile.

You are my hero. I was pulling my hair out trying to figure out how
to deal with this a few months ago, and the use of UNIQUE_ID was the
key. Yay!

> I'm quite certain this patch series isn't going in as-is.  But maybe
> it'll inspire some patches that can go in.

I think it's pretty darn close. One thing that can be done to test the
results for the first 12 patches is to do a binary comparison -- these
changes _should_ have no impact on the final machine code. (It'll
totally change the debug sections, etc, but the machine code should be
the same.)

-- 
Kees Cook
