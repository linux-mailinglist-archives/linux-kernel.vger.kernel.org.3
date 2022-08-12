Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD75916CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiHLVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiHLVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:43:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DEB07E2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:43:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 17so1833679pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=HsCUQ8j36I4b68/toXmGXuF2hsPiyYP9smjWccI2rQk=;
        b=T8edxcRXD18BsL1RTMjGrj5n5dQsaZ4ojGAmMwVXKsYJdht7fJ7wztz/lJ1kLjnRrU
         6Q7c32Y6LN1DE3ooBXiX1OUl6mf/pVEtG+KgbRHbR6NKEp0cSOrtaM+jq500rZ+KzukA
         mc/wTkGgq4u9MKsQT0i919rJABVE6il55R8QLPNON59KLiyPH0abZHeRnsixJqjlZz74
         P1pnhPNaFVgWLAU+ZB+dW7vmVM7yHyVBv3Z4Ldo9oUzYBcC34Z8ZXJTo29AtuInBURZU
         nEx3PPBKtG0g1ceLACYgAXiP6itMQ9oIL1UEEjnecWNcY+pVJiNV/pMKYRyNMh++rqv+
         CmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=HsCUQ8j36I4b68/toXmGXuF2hsPiyYP9smjWccI2rQk=;
        b=56dTKwI4rBtqpmwmwioXb9W9QxyXQALAtiy8vCopIJwNYHKCVi6syI83Z18/Q8sgS6
         8mPWpUgia8BSnCBqoK1/aJfw1CRtMD/3qoswikKuHsSezo3LOAWsybUFWioTCWLbMLyj
         CY67hyOk39LHICliEk6hNMxFVwbi3VAmOxPay4p/jOJDBCSESV0hNDfbraLfdC0CBGqc
         QtnhvzLmPps2/+eXDw8VZ6x5YXB08SzHjRIHRjhBxtqNrZZNcDA7WXcuHCA6MW4V4xwv
         BJspG1J0757vcHNU0NnwbotenowMNBsY4fOtRw1tlSk7F7lxqBBSGuANsS7wPfi1jWol
         G5hQ==
X-Gm-Message-State: ACgBeo2H4O5ytQ4R4D9fYjhDfm5TzEFo3vGfl2pF1sBL11k1T1+vDCI4
        jIPJUBk7X7FWyWx78fLzQDknFxn6OI8=
X-Google-Smtp-Source: AA6agR4Fgetd/4HyBb1xn64ltu8RG1s/lBb7ckWrb3o9x7Qa3INFkzW5TI9HPOMXY2FYziGwhUfswQ==
X-Received: by 2002:a17:90a:d70f:b0:1f3:290b:c8f6 with SMTP id y15-20020a17090ad70f00b001f3290bc8f6mr15857826pju.190.1660340589426;
        Fri, 12 Aug 2022 14:43:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:aae])
        by smtp.gmail.com with ESMTPSA id g23-20020a63e617000000b0041cd2417c66sm1762561pgh.18.2022.08.12.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:43:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 12 Aug 2022 11:43:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
Subject: Re: Selecting CPUs for queuing work on
Message-ID: <YvbJa/6UvSswf8ve@slm.duckdns.org>
References: <82233e68-106f-39e9-b20d-7794eb7a8933@amd.com>
 <Yva4g3V2jAP0NKcY@slm.duckdns.org>
 <5256fc4b-437b-f7fb-55b6-abab091e0182@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5256fc4b-437b-f7fb-55b6-abab091e0182@amd.com>
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

Hello,

On Fri, Aug 12, 2022 at 04:54:04PM -0400, Felix Kuehling wrote:
> In principle, I think IRQ routing to CPUs can change dynamically with
> irqbalance.

I wonder whether this is something which should be exposed to userland
rather than trying to do dynamically in the kernel and let irqbalance or
whatever deal with it. People use irq affinity to steer these handlings to
specfic CPUs and the usual expectation is that the bottom half handling is
gonna take place on the same cpu usually through softirq. It's kinda awkard
to have this secondary assignment happening implicitly.

> What we need is kind of the opposite of WQ_UNBOUND. As I understand it,
> WQ_UNBOUND can schedule anywhere to maximize concurrency. What we need is to
> schedule to very specific, predictable CPUs. We only have one work item per
> GPU that processes all the interrupts in order, so we don't need the
> concurrency of WQ_UNBOUND.

Each WQ_UNBOUND workqueue has a cpumask associated with it and the cpumask
can be changed dynamically, so it can be used for sth like this, but I'm not
yet convinced that's the right thing to do.

Thanks.

-- 
tejun
