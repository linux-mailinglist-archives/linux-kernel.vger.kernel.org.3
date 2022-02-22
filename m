Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3744C00D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiBVSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiBVSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:02:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193228E18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:01:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z4so17651726pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U2mVWyuJYst2hRT390dDGbBH5nhQBc5hEp3VGAnPbXE=;
        b=oK67h3ro/cLPh6YDhHxDvK9RcO0ANtZY+7h8jrzUBvd6L6z6OziDtsqeEjfGfjlJDz
         RX73wZ8YxxTV6QZLjh2Z4tlZujD69Rb5U4lgUoyshQ9E8t5JmpvLSgBejPUUjspAKLgi
         XOscd8wU56hLDvfBytAWYyfTmHwC7G9kYzsoEVIZMxw8ZQU6TY+wN+8ExOUFJ2sXzzvL
         LLRyIo75QPpCYE9zIhOxbptAz4UmpDc7rAdH6YVq4S4nUsLgWw72Bhz7BbiNOLVVinQl
         my60JvIyU4th6ozHT41Bow6A+TFlKIejVjWq3ljKYybsxj77RD1zOgwQlyaSDOt+Ex/S
         u42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U2mVWyuJYst2hRT390dDGbBH5nhQBc5hEp3VGAnPbXE=;
        b=ntQqYR0KnojORkjnY9gwWQZbqrnYwda0BwV1Vx/CKMke+AF3BVQYD9FoR2wlRuALJD
         8d5QfuPHSdvStupsffrSXWiiBQ/4CusFxt74Gmg4YtmAhocXDTT00ZV57zghaX5iIliP
         FmwSDIhIvruvQ4LZY7HMo5CbQZBzoMxZDVE5FxjdwRE/GpNClNCml916W3dM+bLpxrtZ
         SiEiXSh1ezAds1xcnj3dfQPIN6aVwbph7XLSJduBUVXBii/efqA8LmBPK/Ye8jhz5sCY
         FELm5ykK0T4LUg4YgUCwIm2L6bjQiEPa1Hw5BAhZA0Q3d4kb8K983BSImDDKd5x4BgJ3
         0+7A==
X-Gm-Message-State: AOAM531adNiJEr4ulqXpoJDODIh2ROajfCPk3MAbsSqctdaZA2rl+QgK
        uTARsAtAVTsVGJX00Rk7x7k=
X-Google-Smtp-Source: ABdhPJzQWiv0dTbT4oI+Zqge+/kT/Ahjw97tR7f7fGGexU14GsOuQLZdkQDVYOvqN7+iUYaqxlrVAQ==
X-Received: by 2002:a63:6b02:0:b0:342:e6a3:ef9c with SMTP id g2-20020a636b02000000b00342e6a3ef9cmr20535719pgc.77.1645552913660;
        Tue, 22 Feb 2022 10:01:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d20sm18526639pfu.9.2022.02.22.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:01:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:01:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Minye Zhu <zhuminye@bytedance.com>
Subject: Re: [PATCH v3 1/3] sched/cpuacct: fix charge percpu cpuusage
Message-ID: <YhUlD+NUMYdKB40J@slm.duckdns.org>
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220051426.5274-1-zhouchengming@bytedance.com>
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

On Sun, Feb 20, 2022 at 01:14:24PM +0800, Chengming Zhou wrote:
> The cpuacct_account_field() is always called by the current task
> itself, so it's ok to use __this_cpu_add() to charge the tick time.
> 
> But cpuacct_charge() maybe called by update_curr() in load_balance()
> on a random CPU, different from the CPU on which the task is running.
> So __this_cpu_add() will charge that cputime to a random incorrect CPU.
> 
> Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
> Reported-by: Minye Zhu <zhuminye@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

For all three patches,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
