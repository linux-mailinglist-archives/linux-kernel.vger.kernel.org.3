Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AB4AC58C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbiBGQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388673AbiBGQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:18:07 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62507C0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:18:06 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m25so11315231qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IY0dceDT9dYbKD+xsO5uBuadIdWxFI7kmNxQxA0NqII=;
        b=MUHve6+77XYiq1E/DYvBhzenbkXs+FFQQk8DazktiXiFmtxcmKKZfeaBXwb/d5/pEI
         1v2sFMowrQLpqo2HU3dpAZIOYjoyrFaXz3zOzW3kkzupOT87jbkiL8B7NTCw8tLHdwSA
         HXPiCOEbXekgCM7f++IIHSI+9ngBpjpoj4VDX9SbAnX5sJ/xhlozDIxTJH4tq0rfEAtx
         0a5d+7Nw/7ZaGsjRECF11gjJuBeLlyfK42YsJDHvHSET5iWxOSGpt48A1nINzH9NMo1f
         bg2TkqCrM7cTvVtHBeCGiW0uaCd9dstWI0puNh1HXrJtaQEMHWctYbwqWOrZ6vtCGb20
         qfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IY0dceDT9dYbKD+xsO5uBuadIdWxFI7kmNxQxA0NqII=;
        b=L/CY/s2ZjH5k8Y0Qd4zRWFGJGhO4k/49PwU7iIkJP1mCRrKgVh8gV8WfnXd/rjSKS/
         U4h/dllN4yCyD0FX7E+sn1puVGM/YbqrXYa1uQdTiakPxgyf+VAN3Camn1EKFsCLaS9h
         vTuHK0zsIQkCScLwWM2bKBu9fVi7hHP0F5ThspOmYZ4P5CrrMzwHGkGYwGrPeP26639e
         lzWXC32VGTyiagykKxakuyNZ8Am4IKpXsxnx8+UASvgMUGzIUrJmsGX7q8Xf9iBoxHYJ
         S6PU4ZQ07UcJ9i7rH4VjyGsyOTjFwGHOJlt22MmbEzbllbN+zrrLsYMY3VS9G10AQZs8
         S25Q==
X-Gm-Message-State: AOAM533nt5/WRy+wiUWc456mhFH7AdKp8j2PHvDoavxYN6bQWLzGqi1t
        EuZC0TktN4jDfmd1YNV0UFfYdQ==
X-Google-Smtp-Source: ABdhPJwMJ8IhbFQ21vOuTbBXoJvRIp+3/JiRZMP+aPAe8rgWv6GrpwemKSjP4/jjTkjQCTaBu3Dcxw==
X-Received: by 2002:a37:b445:: with SMTP id d66mr343666qkf.144.1644250685600;
        Mon, 07 Feb 2022 08:18:05 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id k190sm5520250qkf.59.2022.02.07.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:18:05 -0800 (PST)
Date:   Mon, 7 Feb 2022 11:18:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH -V11 1/3] NUMA Balancing: add page promotion counter
Message-ID: <YgFGPMCfWb8CK5mn@cmpxchg.org>
References: <20220128082751.593478-1-ying.huang@intel.com>
 <20220128082751.593478-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128082751.593478-2-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:27:49PM +0800, Huang Ying wrote:
> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
> and DRAM in one socket will be put in one NUMA node as before, while
> the PMEM will be put in another NUMA node as described in the
> description of the commit c221c0b0308f ("device-dax: "Hotplug"
> persistent memory for use like normal RAM").  So, the NUMA balancing
> mechanism will identify all PMEM accesses as remote access and try to
> promote the PMEM pages to DRAM.
> 
> To distinguish the number of the inter-type promoted pages from that
> of the inter-socket migrated pages.  A new vmstat count is added.  The
> counter is per-node (count in the target node).  So this can be used
> to identify promotion imbalance among the NUMA nodes.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
