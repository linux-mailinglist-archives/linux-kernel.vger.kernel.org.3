Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB184AE193
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385551AbiBHS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiBHS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:56:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD3C0613CB;
        Tue,  8 Feb 2022 10:56:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so2625213pjm.2;
        Tue, 08 Feb 2022 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yeJo/5hRrRCyM2Jlw/wQyb6VESGf89gzXf+99lk7a3A=;
        b=FgXOB2hB2inJYKtI8UTi1vhmT/jH47kpKuzq3ZMCZb5yW1Yur9p0av+LCMiF0KmOCm
         8uj8z+CeQrwdAXzc99xk9QOR43b/6OV4H9IDViFxOF9JIpk67dSU3t+67ax9WJcZeIvb
         Cnu4pChuxVQ+IkuMOUdlP6g0nfsG/Y7CZbroTNarO5AZMV/pUkua1pULsJpmRjFJrzDb
         Jdy49h0K2QW5qQNM7joc55BAMkbWWIfdvZZftvLPG2Z1pNbl9qRXeR5W8hly0TZbZwlJ
         QwjqmeubH6D8bZkLrwXMf7t9ShWiajbusghkt0ayHmnDnnG/bNaspO0S4LAM2fqZZObb
         Toiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yeJo/5hRrRCyM2Jlw/wQyb6VESGf89gzXf+99lk7a3A=;
        b=yf+RaRC0AHB+WsNI2IPajlXpbwOTAU6HDX8d0dUbCAshdwPtsiZGc4y0D+UQDPunGd
         F1X/TWABYf0j1fJno+uNkKm6nqxpAIYAZMNdu6yt37sCAWIeDpzNmu0vXTZTN663q70b
         S55mjfZ1G48pgDH2BbVMmMJlT6Q+C+5uI1gntm6pbvZup/bmbwQa4KrGZqCrGiVSGK5F
         FabLLmJmDj0J+QQ2haGA1QWwt41Afbml2wl5oxS+JoU/OK+Hf0ixx8NPwgwdxolMHRfm
         hB4fIugn1UuqipZvjW0MUDjD5W/wyROo1cL/IRHk7bZgCQLt7qJ8egB1WS9fTugeQEMv
         VszQ==
X-Gm-Message-State: AOAM5327Hvbw0+Iama/2Vfdre4K65egLscVCI/C5K9ZsiEbucM6yqkbr
        MUv0xuAxnrqN6CmNptwAimOKJu4/NV8=
X-Google-Smtp-Source: ABdhPJzNZbZrbclkhIGMjgr6jnTBCIGd7035cZq8xL4tSAq9c/zh578nWHZgv101gyl1ot5pbnemMg==
X-Received: by 2002:a17:90a:8e84:: with SMTP id f4mr2828258pjo.215.1644346582712;
        Tue, 08 Feb 2022 10:56:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z13sm17177810pfj.23.2022.02.08.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:56:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 08:56:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Message-ID: <YgK81N+w/zsW12N9@slm.duckdns.org>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
 <20220204225507.4193113-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204225507.4193113-3-paulmck@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
> Although it is usually safe to invoke synchronize_rcu_expedited() from a
> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> invoke a workqueue handler will hang due to RCU waiting on a CPU that
> the scheduler is not paying attention to.  This commit therefore expands
> use of the existing workqueue-independent synchronize_rcu_expedited()
> from early boot to also include CPUs that are being hotplugged.
> 
> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
