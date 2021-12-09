Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EC46F695
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhLIWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLIWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:18:09 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9EC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:14:35 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 133so6316188pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NlQS1DLc0GD3dGjiBZJnpRs1mX8oUcH7EYNmoPIbPs=;
        b=fbR1Sv3unwIBPttjXFCIyzE6Txx3+KOGF7jGuO1uw7JId3N+p566xes5kK3dfUxUDG
         DGRKnwmmrQMnRJApYw69w2sgBR/i/S75V/8f69p7hM3ObiERrLlB/RwyWjd4Tk/blB4a
         MBBQaj/Qnc5v/cHuJddIqmrFD5mePBEfBGjjAA06cDHAR3PFd8qdJL0rYi8WidIm9G/q
         nWhcfvzUkWCZmZF4LTt0pEFQxdXWxLV58ASkH123PMMrMiR5lINUStL/IvpWw1QhSxHX
         EJCA2PMpTBmSimHaWzDt6BrWtunMgfREBl6AkP4lA/W3RrtCrGE9UiIDQbM6GocJbQxG
         8vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5NlQS1DLc0GD3dGjiBZJnpRs1mX8oUcH7EYNmoPIbPs=;
        b=0DT2dt8Eo7E0XjqplrShqOXDD9wCRlcClrW41beo6FZL9q7P5K91kK0lox8JOW7RxD
         2u8I72tiAnN8R85/BIqAOIVeV3ySsT6Bp9d2/euMqzCCA6ePA17ueKKCz9I9zhT8jg5I
         c45ayAiNo11iyLrCWAr1qBhTaq6MeJ7ZqnjC63jDESCqrZ9MKCMflIOXhRGJ+t6rqrlj
         gXs+ZR4IG491ZDYsyWlfnpPjBGZSOQ5PmoTao4p5qVe++sT2TyNVu4mIEB50GD1nlhjr
         nIzDCL1IW4dMYHzPrXSmAF1DloAp0wwieM+zju7QAf6qWvcHX07IJz/I/7Pzvtzbq/jK
         1H5g==
X-Gm-Message-State: AOAM53318OCZk9RKgXNE9f4wQI/Dlp34aKiCjHo8o7QB52QX4Ap9RGHA
        MI0Y7sk2oC47f3wp8TGaT6q1xCcGe3c=
X-Google-Smtp-Source: ABdhPJxD4Geh3QLbjHFknd15BmYmvSvKnCUwp+7tO2emAjeMJT9lfvP6B+9G5UnrGbbbvWJFmdhNTw==
X-Received: by 2002:a62:7952:0:b0:4ac:9a13:5563 with SMTP id u79-20020a627952000000b004ac9a135563mr14512231pfc.17.1639088075340;
        Thu, 09 Dec 2021 14:14:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g18sm662035pfb.103.2021.12.09.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:14:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Dec 2021 12:14:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [RFC PATCH 7/7] workqueue: Replace pool lock with preemption
 disabling in wq_worker_sleeping()
Message-ID: <YbJ/yR6KMjhv9EfS@slm.duckdns.org>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
 <20211207073543.61092-8-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207073543.61092-8-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 07, 2021 at 03:35:43PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Once upon a time,  wq_worker_sleeping() was called with rq lock held,
> so wq_worker_sleeping() can not use pool lock.  Instead it used "X:"
> protection: preemption disabled on local cpu and wq_worker_sleeping()
> didn't depend on rq lock to work even with it held.
> 
> Now, wq_worker_sleeping() isn't called with rq lock held and is using
> pool lock.  But the functionality of "X:" protection isn't removed and
> wq_worker_running() is still using it.
> 
> So we can also use "X:" protection in wq_worker_sleeping() and avoid
> locking the pool lock.
> 
> This patch also documents that only idle_list.next is under "X:"
> protection, not the whole idle_list because destroy_worker() in idle
> timer can remove non-first idle workers.  Idle timer can be possible
> strayed in different CPU, or even in the same CPU, it can interrupt
> preemption disabled context.

It's nice to go back to not needing to grab pool lock in the worker sleeping
path but I'm not sure it actually matters. This isn't in a red-hot path and
we're touching a bunch of stuff in the pool anyway, so the overhead of
grabbing a lock which likely isn't too contended shouldn't matter all that
much. So, maybe it'd be better to just keep things simple?

Thanks.

-- 
tejun
