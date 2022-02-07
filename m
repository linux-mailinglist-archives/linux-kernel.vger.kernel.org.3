Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3509A4AC807
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiBGRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiBGRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:49:17 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8CC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:49:16 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id k4so11959757qvt.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJucW2FhnAmOVXK6ttAIBgemWe7fm9oO1NBHaN+SpLo=;
        b=7t3DM3VcFauVZOBlngQ9606Z9gD+sKLDq4AgAEevZr3ZavsH+WJjWgzundrmQ8j/fH
         hCffawc1iSxT+eaqadAZ1tqlVNTDb+A8KjFDmVKplNkHqDhpdrPs8wFr6OC0CiykGHfz
         AAKSENzVQE2vrUQ/ZlKTDOUsfDlVmSnj8w3uUXoD6Bbh5yOayLCi6VyiOjsv2oE4naa5
         MzMyXm98/uP0z8aA1/Qe3tZBOtjj8qSrjwkLFmZTgROZ7VSP+wkCsFASes3w87WNcxdo
         jYbbZnyI+uLZXYUYlcOT73zPchwbG85kEXuSM8Hr9RZ6VbhoEm2EuodTvRrGz/h2HdJ4
         n6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJucW2FhnAmOVXK6ttAIBgemWe7fm9oO1NBHaN+SpLo=;
        b=MHfvvAEjJEOq9PBEATNoqa7h69OAxHVIRPB3cup41g0kAQpGV+Q/5vRiVpsKPe7LK5
         xuWj8IC0HRNx4P6UYwjoloLTZNPzGRc1DkjoZyEzBSIuC0+XZw4hczU2uPvxkrUyk7CD
         Wwy0PCp4Y8AcTeEnHn8ki+oNMLtNq6PvZx5iA41ByZjma/f1oMpcThuyz0NM/TWB9XOb
         E+7TVjxTVrK4PAx/qywTGlRUn6pGaT7MUACRai/9WUfvEaSX4x/G3oQG24YqgeOfQuCS
         /gU2/eyWaTJN2At3l/A93pgljDntgLz+Kf/NMQvhv5Ri4BzdqfqL2jWPjzgihhqvsJzT
         shuQ==
X-Gm-Message-State: AOAM5327ob7YWEzuEgwGjJVl99DXjI4JxnmjBtxuFIAPI0xD4Bc5SA9A
        PyCIyFHDYfm2Z/XmZAKZ2GVTGA==
X-Google-Smtp-Source: ABdhPJyfrQtt982KQJ8YVomy4l18OH5G1tRs6T70oQ9tcGHf4td1lFkXstlwrfw1W6P49W2p7bCKGw==
X-Received: by 2002:a05:6214:29e2:: with SMTP id jv2mr600877qvb.4.1644256156176;
        Mon, 07 Feb 2022 09:49:16 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s28sm5387928qkm.53.2022.02.07.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:49:15 -0800 (PST)
Date:   Mon, 7 Feb 2022 12:49:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V11 3/3] memory tiering: skip to scan fast memory
Message-ID: <YgFbmxRR4QC7CJKb@cmpxchg.org>
References: <20220128082751.593478-1-ying.huang@intel.com>
 <20220128082751.593478-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128082751.593478-4-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:27:51PM +0800, Huang Ying wrote:
> If the NUMA balancing isn't used to optimize the page placement among
> sockets but only among memory types, the hot pages in the fast memory
> node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
> to scan the pages in the fast memory node via changing their PTE/PMD
> mapping to be PROT_NONE.  So that the page faults could be avoided
> too.
> 
> In the test, if only the memory tiering NUMA balancing mode is enabled, the
> number of the NUMA balancing hint faults for the DRAM node is reduced to
> almost 0 with the patch.  While the benchmark score doesn't change
> visibly.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
