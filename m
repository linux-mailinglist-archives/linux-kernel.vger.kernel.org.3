Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0274951CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbiATPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376638AbiATPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:53:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:53:18 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 193so6140026qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vIDf24aJ0cbXE8wQbF+MHqykuuV1NF48uju8rCjVcag=;
        b=Py3yRrevtex8paU2jskEALhXdOnvfddm4Ge28P5rWLqYwCYHq3HNP/duqsBcxq72OR
         Gw9O6lupllJ/8ItMXGAbUn6TzwWzJnl9l+wYjXa7QtZhY1HI4u2o9mI/+kXJdG0V5un3
         zIhZO+IqMuEQvwbST7QVJj3QV7iP90Jg5kZ4SOKIrjrmWBaKxZJM1VJZBh47yFzUC9pT
         eFGwsj/Jp4wTHCemLaOF8KT7Rtd0hPtTlmnzivYtAx8VDUcbAmmx7GXqCpdqMMvR2A9D
         2ic0PUOD2tdHdC9/9ndA15ond4JtAQA3p39mXCA0++Jl06jH/pBIjzbsXNCoscTbfXxx
         QyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIDf24aJ0cbXE8wQbF+MHqykuuV1NF48uju8rCjVcag=;
        b=Hbfo3twzJXWpwdSB8iIN14k3MuXkAFteZFKJBR6tcnQwEZNdD7tvQ1atLzw1PhRSHS
         F0OWUXm8VV3mxeZZjAwveOIrQ7+EqKh8YftxOrEQ/TlCtvk0gUpkmFBbDZVixrDixHJE
         UoiIh2BgNEo5TVOFGFMtFN0McnQlzfH1OJeWDmR5EoSHF5rnIIr19gD+0T27KYXiIUVc
         qfSJp2SKQxTyd25W6oQvi/go4oAIvoW+nuzQfLFPFsukphZDi8vwCQhZG+zn1beaSi5E
         UgYReZ9doF7pubMqpcwcz2knHy5SVcQmIU1TdyMtPebK3H6i5Ik8vAfyTJbXTxT1Sihw
         qrnQ==
X-Gm-Message-State: AOAM530U0j/I5NlSV9AXq4kUs0rIYCExk/srGOgsGybzQzicm5YTVw2+
        YJidYc7S8hV0QfqdfkMRMrLVBA==
X-Google-Smtp-Source: ABdhPJzlzw1msMwdUO0DxapxnYMhLH+k6S8kHBZuc9rSeXENY8u1kGiC+aUCE4lNSNTl2oBJR31Yqg==
X-Received: by 2002:a05:620a:c4f:: with SMTP id u15mr24796384qki.565.1642693997046;
        Thu, 20 Jan 2022 07:53:17 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id o20sm1542705qtv.69.2022.01.20.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:53:16 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:53:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, ebiggers@kernel.org,
        tj@kernel.org, willy@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] psi: Fix "no previous prototype" warnings when
 CONFIG_CGROUPS=n
Message-ID: <YemFa5ouZXEnR/D+@cmpxchg.org>
References: <20220119223940.787748-1-surenb@google.com>
 <20220119223940.787748-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119223940.787748-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:39:39PM -0800, Suren Baghdasaryan wrote:
> When CONFIG_CGROUPS is disabled psi code generates the following warnings:
> 
> kernel/sched/psi.c:1112:21: warning: no previous prototype for 'psi_trigger_create' [-Wmissing-prototypes]
>     1112 | struct psi_trigger *psi_trigger_create(struct psi_group *group,
>          |                     ^~~~~~~~~~~~~~~~~~
> kernel/sched/psi.c:1182:6: warning: no previous prototype for 'psi_trigger_destroy' [-Wmissing-prototypes]
>     1182 | void psi_trigger_destroy(struct psi_trigger *t)
>          |      ^~~~~~~~~~~~~~~~~~~
> kernel/sched/psi.c:1249:10: warning: no previous prototype for 'psi_trigger_poll' [-Wmissing-prototypes]
>     1249 | __poll_t psi_trigger_poll(void **trigger_ptr,
>          |          ^~~~~~~~~~~~~~~~
> 
> Change declarations of these functions in the header to provide the
> prototypes even when they are unused.
>
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

For a second I was confused by the "unused" in the changelog. The
functions themselves are used unconditionally: by the internal
/proc/pressure/* implementation. But I suppose that usage wouldn't
need the prototypes - hence unused prototypes.
