Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEA580324
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGYQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGYQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:52:21 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5921D0DB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:52:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i13so8834050qvo.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j0BaZSzqD5eIgwyip/HS4aDnwW9Jp806htc77k2W+9I=;
        b=YrRC8+DcvcJ+j3/daDEZUkXI7wwrYxc1PEjLb5WJCKV4hOP1uHTC/ifMwxGxMiDkfx
         /A82VqK1LTw9pVhvRXWQeyXrrPJ2ZvCuG5iWP7cY8NmWkKUfWofwwTglQWitP4sLRpre
         NB5VpzmQIT0yR8C+q/8SpRe6N4qEXuOmhz9/zyJDdIRw6IQfETk2K2RZNRdauaalnISk
         ecXU6u6eJyO8O/HQW59YX4MJEK3q8L7+iGwgT+B0Xfmvz2s9vSCXiUlMoZjDizM7CmZj
         Pva3rt58bJXcA2sOVprKVekCrokJioAdbUfKQmHTFPMiKttfucAsODDHed2z6c5VspUe
         9oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0BaZSzqD5eIgwyip/HS4aDnwW9Jp806htc77k2W+9I=;
        b=JXo9lJWV3bLta2K2h8Fs6mkkHRfzFC+bqd7MU/QpthROF7uMZw8OLt07TJZ79AZlqB
         mdghoaTx7tMVONou8JqpEl4S0e0y4X182pHYqAFI6zR+M5U4iimr04bTKDWrX6IffyeH
         WEVDp+ViHZHNW1prVqxxwSPLC+5kynyCSB08IRM7kxT55jG+wgVQXb8FV+mx6EwASZYa
         B68we9FCI94ibFxCbXJ2PuJg8fz2vcfCkCKPa3kjr7tggVEHxk+GwGwCm+m+cELgW+gO
         wiwqI1zCVjAvwTFPFOzaNOx6uAtl9FgkcOAsJVpTCXnklVDUrWMrSWumwtSwUY/3Aptl
         sv6w==
X-Gm-Message-State: AJIora/jH0/5b2z59qMJ83De1VCNCHhRRsMgtJLcMA9XHvRXVts0MsI0
        Z3lKyE9A0ztX9DTdTInAp/26Hw==
X-Google-Smtp-Source: AGRyM1uv3LFH6aM79vzCkplcfzTZ3m25YJ7ns1XG6o8aG/GGTPTrtN6PwrSDI9Hn7ptl4H/XTiIloQ==
X-Received: by 2002:ad4:5de4:0:b0:474:2384:a0e9 with SMTP id jn4-20020ad45de4000000b004742384a0e9mr11516834qvb.79.1658767938522;
        Mon, 25 Jul 2022 09:52:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id u20-20020ac858d4000000b00304f3e320f2sm7915678qta.4.2022.07.25.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:52:18 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:52:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <Yt7KQc0nnOypB2b2@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:38PM +0800, Chengming Zhou wrote:
> PSI accounts stalls for each cgroup separately and aggregates it
> at each level of the hierarchy. This may case non-negligible overhead
> for some workloads when under deep level of the hierarchy.
> 
> commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
> make PSI to skip per-cgroup stall accounting, only account system-wide
> to avoid this each level overhead.
> 
> For our use case, we also want leaf cgroup PSI accounted for userspace
> adjustment on that cgroup, apart from only system-wide management.

I hear the overhead argument. But skipping accounting in intermediate
levels is a bit odd and unprecedented in the cgroup interface. Once we
do this, it's conceivable people would like to do the same thing for
other stats and accounting, like for instance memory.stat.

Tejun, what are your thoughts on this?
