Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CC4951D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376781AbiATPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiATPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:54:53 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:54:52 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id p9so6189164qkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3imv5N5fxywtvSvcA2lQJudUo3fZTOe6sHyrTTAExJM=;
        b=M1lffiwB1KLYq1J8nAT8JMcPgGsU1FzGHHWsTq/K9IshZRpLxrNhWmd6QP1GKfUxBA
         76O/l8kWD+mTeEzqyt8BVi/KLfTidOI3ObbhdFhQ7HJJqoWxY+xk0JohOp+jz8ogimnF
         4VcDUXDdCgEyFQMp5xyxyppINhHLU5i7nIitnLJfJvMwqyc6gna3wktp0CTGu+vCGibC
         ZBJ7z1+5M9bGooXjUGG2JyUKJR0+qiiP4mK77u9Xx9DuWvavFKEWrTI6IPX8geSXs0qN
         EWJxGcDHHl/lryEyhQrj1vyLblQllLSPGI0REIHU3nqxW/3NxCaJYJctv1HjGRUHux3v
         KArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3imv5N5fxywtvSvcA2lQJudUo3fZTOe6sHyrTTAExJM=;
        b=utkFpjZvwT27SkhcOMkSlyQYGzDEXf961dmecSzT5RzSto2y3AOZx/DWsIsv4jAfHP
         Taj7XR4f9h9Nb2D3szGvQTlsgVFjeauHIii7f7NEO8XhR2+yXZtVbELrMq+zEVXDzFx/
         6qPXaTIA8HYWkbEXjCMfMx7gnvVXx95TY3SN+ObtmOZVpKyYXa3ZpQtp7lFUFnnIG8t/
         k5oit/pYOaTtY3JCx1sSAxZTw2vc5Got2UAvLAyOQyCRkTL7NAyN6vT7pmyeZljj5YUN
         DEpBy37h9qgXabTAd8kCwZzSVxp9Lo9G755Fe+cfwO4Zvl4XhfIZl+ChD4d9bzr2DFPZ
         5GoQ==
X-Gm-Message-State: AOAM531qLxadWUYxXYoVM64zBlkWv8SElCDRVP00gUoI4rkTjZz79fbc
        +ulseuUp8x3MSMmLIkF6Gg+GDA==
X-Google-Smtp-Source: ABdhPJy8Eyfg4/k+3lg4PinOuMHDcU903HioGbTVEy2SNs/dfAxM73fcSY50ZYRcg4rrzXZ+fF7mbA==
X-Received: by 2002:a05:620a:4707:: with SMTP id bs7mr17590848qkb.69.1642694091949;
        Thu, 20 Jan 2022 07:54:51 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id p64sm1610570qkf.38.2022.01.20.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:54:51 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:54:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, ebiggers@kernel.org,
        tj@kernel.org, willy@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] psi: Fix "defined but not used" warnings when
 CONFIG_PROC_FS=n
Message-ID: <YemFypC3TKwpuUvm@cmpxchg.org>
References: <20220119223940.787748-1-surenb@google.com>
 <20220119223940.787748-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119223940.787748-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:39:40PM -0800, Suren Baghdasaryan wrote:
> When CONFIG_PROC_FS is disabled psi code generates the following warnings:
> 
> kernel/sched/psi.c:1364:30: warning: 'psi_cpu_proc_ops' defined but not used [-Wunused-const-variable=]
>     1364 | static const struct proc_ops psi_cpu_proc_ops = {
>          |                              ^~~~~~~~~~~~~~~~
> kernel/sched/psi.c:1355:30: warning: 'psi_memory_proc_ops' defined but not used [-Wunused-const-variable=]
>     1355 | static const struct proc_ops psi_memory_proc_ops = {
>          |                              ^~~~~~~~~~~~~~~~~~~
> kernel/sched/psi.c:1346:30: warning: 'psi_io_proc_ops' defined but not used [-Wunused-const-variable=]
>     1346 | static const struct proc_ops psi_io_proc_ops = {
>          |                              ^~~~~~~~~~~~~~~
> 
> Make definitions of these structures and related functions conditional on
> CONFIG_PROC_FS config.
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
