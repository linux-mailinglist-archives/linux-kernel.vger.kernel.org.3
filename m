Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA24E2EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiCUREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbiCUREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:04:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790918A3EB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:02:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u22so4611161pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oR8TpfJy/owZGjRiMkMLvaSbKucV9ygSIAzUybCGM0g=;
        b=X8rtbZDcFpq7GTNvVZ4f1ABlNxmYNlyWQyOJNO3igQYD801sxxQ3cga8MdGPzCwYCU
         SmDB20QNkm7U27If0MzcZJ+pQRtVXMA523+rdOYeKO9/baqYAxl05HW8Fctnxjaqm6ou
         ZUQtt6e2M565YAC61OUKgjGLZ3tQkfgl13OWXGG/Vhz1UxIQwU64AMI7NAmY4Mh+tnX+
         TqxXXVCSmolW+IU6F1sZF1jsv7pexwK80DTBSI2nKKLSfivMArOaUWZ/fCaL6ZxupSjY
         VmX3RH/gnfySnTTlgn/jz5nL7zc0b6uFqjyP8Tzuz77kGxeLcIMXg3gNOTxr3UjzrD4x
         IrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oR8TpfJy/owZGjRiMkMLvaSbKucV9ygSIAzUybCGM0g=;
        b=clStM83Xr2zonBEDR9AWz3wxD9HcVivWZ+/D6ftkEVf9P4FLlCxQ3oDnsHqpxhTZpi
         cYTLx5ZE+bR0lLnjpagtyIi22th09WdUQI2Js4kHt0ADFFDkG9R4p6IkalbRX/n8VfSL
         hND0uLG8uj5Doge9HIVJoE8laYbMCX2X3Fb3wlgDO3JMyTL8s59Rqg4joQQ3susX17Ei
         A5mMu4ozgaT78jyQ7jOGevQlHCxVVhzmeCZNXXVOK5s+bsjhuBg6dUsje9u1QIKepQgC
         HSLR2/xo8H6ffH04JoTy91mBgjzcEaeRHOHQ3P2bmWEDIrtxSSfRXFMyG96akkcmx3oy
         cqWw==
X-Gm-Message-State: AOAM531sE0spfcASe2kiCAgdoIrDcWE+IxHzDI6QcdCssXkgCnXiKwD+
        uwagAbahk73t8kIXXl4aAno=
X-Google-Smtp-Source: ABdhPJxRJwXUg8B6ygpcXV2aBPI8EZYrTZtdrID7PAuRsR5j7KvSLI2vBkH3UIQqINtCUyvq13q82g==
X-Received: by 2002:a05:6a00:134c:b0:4f7:65a6:88b with SMTP id k12-20020a056a00134c00b004f765a6088bmr25363966pfu.79.1647882167312;
        Mon, 21 Mar 2022 10:02:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f741eb11d0sm21051133pfi.149.2022.03.21.10.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 10:02:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 07:02:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Message-ID: <YjivtdkpY+reW0Gt@slm.duckdns.org>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
 <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
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

On Sun, Mar 20, 2022 at 03:06:30PM +0900, Tetsuo Handa wrote:
...
> What alternative are you expecting? We already have alternatives.
> This change (replacing system_wq with module's local workqueue as
> an example) is a matter of doing
> 
>   (1) add
> 
>         some_workqueue_for_that_module = alloc_workqueue("some_name", 0, 0);
> 
>       into module's __init function.
> 
>   (2) add
> 
>         destroy_workqueue(some_workqueue_for_that_module);
> 
>       into module's __exit function.
> 
>   (3) replace
> 
>         schedule_work(some_work);
> 
>       with
> 
>         queue_work(some_workqueue_for_that_module, some_work);
> 
>       throughout that module.
> 
>   (4) replace
> 
>         flush_scheduled_work();
> 
>       with
> 
>         flush_workqueue(some_workqueue_for_that_module);
> 
>       throughout that module.
> 
> if flush_scheduled_work() cannot be avoided.

I'm willing to bet that the majority of the use cases can be converted to
use flush_work() and that'd be the preference. We need a separate workqueue
iff the flush requrement is complex (e.g. there are multiple dynamic work
items in flight which need to be flushed together) or the work items needs
some special attributes (such as MEM_RECLAIM or HIGHPRI) which don't apply
to the system_wq users in the first place.

Thanks.

-- 
tejun
