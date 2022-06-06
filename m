Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669153E1E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiFFHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFFHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:12:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD07BF4F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:12:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-310061f47faso73063027b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FAsSBSY7Wsisoy3/WyKLJttYBWhLnj7t3o8A0ZUkcJM=;
        b=QQuWsZ1j/7tV4jRVtGGyXr+t5u71dCwAmHzKBGeywSe6u/moa/zY+SsWHXCX214nOB
         BhprH0ZrUtlDeEM3an2Okonvg/C3LdAnmPA2XXqCaSh2rBpc4gMjTOi4XR/4lCl+v0ln
         sOp3Szo27ICJjD7zo17IrUK/LLpSPJtno97jFu68WSpmsnY/Ct4Pr8iae4A6KjS8Vfnk
         28tYF6gjA89yMONWjyzGZ8CoSLyIGNbXo6gYxb7Mu0KsNLPMaz7MbnjLYEzUZ4nf8lFw
         x8GXfmj9OXcVihgZ9aAia/DyrA9DAmX4J4HacTUGc6EvLgwOXQPtC7eRFQSil95i+Kdo
         T1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FAsSBSY7Wsisoy3/WyKLJttYBWhLnj7t3o8A0ZUkcJM=;
        b=WjXIO6JUMDo7kJR9isvazzXx4R4Q/yS/ov5TuRWrQ2EPUABdQpJWR0mowb4+ydus+p
         p0Uvxha0mPAb1SpTBcASTh1LRUCryswcXHMQ7X3DB5snQ/41a5b3pOtwLDfb7nlnIsWE
         gEz2Yl/YJt+BfD7j7uwzXsz9R5oQ7cI78erutPdCNrilOmJeawmZecU0s49hqfGOB6sf
         tAPNL66yaUvuwOQZ7TIgeIe6PAnYmUHIVsi2UdGkTvcLbbnxW9YsvMHGc9sn4yo2/ulm
         Ay138ywlaIs8o2NoleWWx1n0zSTFntSfh+m1bq7Os1kKxBc7M2H1JZb7gXWTiwGUQeUv
         p+KQ==
X-Gm-Message-State: AOAM533pk1VtqLKoSxbtmI5csUra6A1mGMofbmI1GdIseHi1bD/lswkv
        kKozSIczhYZKb2HY5dxxXGrmOM5L1oOjpQ==
X-Google-Smtp-Source: ABdhPJxIKHGhLv9rUMq9S3FTBeIeO30cLZ2298g4lAGzXyFm/ocwFPtsLRuVN4At8OR7eYZgs9nwNDNwz35IdQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:250:0:b0:65c:84a1:2db7 with SMTP id
 77-20020a250250000000b0065c84a12db7mr24177287ybc.296.1654499521408; Mon, 06
 Jun 2022 00:12:01 -0700 (PDT)
Date:   Mon, 6 Jun 2022 07:11:57 +0000
In-Reply-To: <20220604082209.55174-1-zhengqi.arch@bytedance.com>
Message-Id: <20220606071157.vcx4ykadvlbpqlib@google.com>
Mime-Version: 1.0
References: <20220604082209.55174-1-zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
From:   Shakeel Butt <shakeelb@google.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, mhocko@kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 04:22:09PM +0800, Qi Zheng wrote:
> There are already statistics of {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct of memcg event here, but now only the
> sum of the two is displayed in memory.stat of cgroup v2.
> 
> In order to obtain more accurate information during monitoring
> and debugging, and to align with the display in /proc/vmstat,
> it better to display {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct separately.
> 
> Also, for forward compatibility, we still display pgscan and
> pgsteal items so that it won't break existing applications.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
