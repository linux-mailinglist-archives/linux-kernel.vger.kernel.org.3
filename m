Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656765A17CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiHYRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiHYRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:16:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0163B978
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:16:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kk26so11146547ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3kaoHrknD8P9F02t3vtvA1BMAXsONZRXU6MvhQ9cGm0=;
        b=Kx3Dht7p+xMwF8txIAf16o45Jbd5BarQhl+hTLnStlK+dnLu8CQHK2RcIzo9QNnbV0
         c4gNp7qmdE6YOchm2Gy+iMBaiQVOUufrpkH6vQ/g5W8LOb06aqEzTPQqYRVpm9jkNh1Q
         pKL1ofb86P3CBoNgi9kLOEAga5m+GZYCXEisz54+F706FD11ImkP96ot3klNK/RKOwDP
         g1Rp3pJ8PohBavZvYluu6a6WR2jA0Heg8yn0gy44KXBhLY5RlMCoFZxdnKx3/6Tgi3QF
         I52eXYKkogKjti2J+zLJZSiwMpBbRBET5warOvEzaVmiiMqQqz8dUTwQejSwcp+Pu6ji
         Z+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3kaoHrknD8P9F02t3vtvA1BMAXsONZRXU6MvhQ9cGm0=;
        b=basL5DheifT0LvXRgNhtytnHvdeb5AYAZdr9moYWunEJUrm2Xh+tLjVWjbBjn3HvGM
         a6E7b1a0sSe6vmf5CSD8A5ALMeUe+p/Sb9VnDm9ydHuj114otObSLC7uOvBXNrBUgKyg
         OmssnIzaPsYgTGGUElQQ6KM57I1o1UGLxFai8YypxikqEzprRTmSEKVgJ0y8gJWGb2iD
         iPrs8ZWVae/DDr4JoAjG92Nxg7XKD72YqfyNu/LAB/xSBnrzb8TXcmWvX08H0BudX+td
         3WJ3XWVHslRwJQ+l5+LOY9QcTvkpEMltVt67oh3uqCGv8okacuWaIMd47wzhBmWF8tZS
         tslQ==
X-Gm-Message-State: ACgBeo2khI4b/ybpO+WmHk1T0S5pJ68pqI9EilazGh6R3/xS2p0WitOG
        y56g9+u2Th6k9NwfD2H1cSkquQ==
X-Google-Smtp-Source: AA6agR7fz7MWmgqV3LHa4xD9Of7hPclEKmCl9zwQ1fZUtUga5upe1qXXPjZgXPBFV945Y5pwHN5Ozw==
X-Received: by 2002:a17:907:72cf:b0:73d:d007:e249 with SMTP id du15-20020a17090772cf00b0073dd007e249mr2803387ejc.500.1661447768985;
        Thu, 25 Aug 2022 10:16:08 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id i15-20020a0564020f0f00b0043cab10f702sm5199485eda.90.2022.08.25.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:16:08 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:16:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v4 05/10] sched/psi: optimize task switch inside shared
 cgroups again
Message-ID: <YweuV/+G0DGn3ECV@cmpxchg.org>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
 <20220825164111.29534-6-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164111.29534-6-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:41:06AM +0800, Chengming Zhou wrote:
> Way back when PSI_MEM_FULL was accounted from the timer tick, task
> switching could simply iterate next and prev to the common ancestor to
> update TSK_ONCPU and be done.
> 
> Then memstall ticks were replaced with checking curr->in_memstall
> directly in psi_group_change(). That meant that now if the task switch
> was between a memstall and a !memstall task, we had to iterate through
> the common ancestors at least ONCE to fix up their state_masks.
> 
> We added the identical_state filter to make sure the common ancestor
> elimination was skipped in that case. It seems that was always a
> little too eager, because it caused us to walk the common ancestors
> *twice* instead of the required once: the iteration for next could
> have stopped at the common ancestor; prev could have updated TSK_ONCPU
> up to the common ancestor, then finish to the root without changing
> any flags, just to get the new curr->in_memstall into the state_masks.
> 
> This patch recognizes this and makes it so that we walk to the root
> exactly once if state_mask needs updating, which is simply catching up
> on a missed optimization that could have been done in commit 7fae6c8171d2
> ("psi: Use ONCPU state tracking machinery to detect reclaim") directly.
> 
> Apart from this, it's also necessary for the next patch "sched/psi: remove
> NR_ONCPU task accounting". Suppose we walk the common ancestors twice:
> 
> (1) psi_group_change(.clear = 0, .set = TSK_ONCPU)
> (2) psi_group_change(.clear = TSK_ONCPU, .set = 0)
> 
> We previously used tasks[NR_ONCPU] to record TSK_ONCPU, tasks[NR_ONCPU]++
> in (1) then tasks[NR_ONCPU]-- in (2), so tasks[NR_ONCPU] still be correct.
> 
> The next patch change to use one bit in state mask to record TSK_ONCPU,
> PSI_ONCPU bit will be set in (1), but then be cleared in (2), which cause
> the psi_group_cpu has task running on CPU but without PSI_ONCPU bit set!
> 
> With this patch, we will never walk the common ancestors twice, so won't
> have above problem.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
