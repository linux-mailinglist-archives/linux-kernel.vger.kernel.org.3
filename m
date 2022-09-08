Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB545B1A18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIHKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIHKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:36:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063909E2F7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:36:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E3FB33AB1;
        Thu,  8 Sep 2022 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662633395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVGiQFzdoGT4mUBJX9AgoACfWUpyb70+cZGif8ZAb7M=;
        b=P/VXCM/l1S1C6XLk6JnvhP1EBAw11TtgP8z2eK5dPfshXkXBO9ZDYVRItLhd9ohIZ8pawp
        zdVtPUJIZ5VDqJ7D1nV8UihyyIJd2QbZ3Jp9pw++hCZEhFxCLAkNtaJcApRUsRJJbyFQRL
        20sYKR5gXnQ63yu/T3c0PL/W3QLiLPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662633395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVGiQFzdoGT4mUBJX9AgoACfWUpyb70+cZGif8ZAb7M=;
        b=xJtlVypap21E6s6oh47rgNyELpnn4ldteXfZ04vTd3cLMJpQRs5WlXL/N7PAQwGX7FZ+0J
        /YQdJxOd8dxPxmBA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 347A02C143;
        Thu,  8 Sep 2022 10:36:34 +0000 (UTC)
Date:   Thu, 8 Sep 2022 11:36:32 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rohit Jain <rohit.k.jain@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix misuse of available_idle_cpu()
Message-ID: <20220908103632.yzm5boxrr3nmvhpm@suse.de>
References: <20220908080702.58938-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220908080702.58938-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 04:07:02PM +0800, Abel Wu wrote:
> The function available_idle_cpu() was introduced to distinguish
> between the code paths that cares if the vCPU is preempted and
> the ones don't care. In general, available_idle_cpu() is used in
> selecting cpus for immediate use, e.g. ttwu. While idle_cpu() is
> used in the paths that only cares about the cpu is idle or not,
> and __update_idle_core() is one of them.
> 
> Use idle_cpu() instead in the idle path to make has_idle_core
> a better hint.
> 
> Fixes: 943d355d7fee (sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu())
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Seems fair. As vCPU preemption is specific to virtualisation, it is very
unlikely that SMT is exposed to the guest so the impact of the patch is
minimal but I still think it's right so;

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
