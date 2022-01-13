Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6548E0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiAMXCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiAMXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:02:20 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:02:20 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w7so5217501ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5pDJzk1dQsu0Qk8opYITEZv6dz4zcJdUZeTWjVZhptE=;
        b=i7ChxMb5M3oaC8H54OCxVrXkfUa7WLgJX+ltnKBKDBkjz66N9TQzyDZinEbP79ixk3
         tjxIfvWEOm33MpTaaKvOx4EL+geVEPBg41GOv1jJcsOf82ZVYdqOCCMbuTEYc63fpvWM
         Fa5uXRS0je7t11ma8khJr08jVW6zsrFZPFOlVJy2ygnz1T9ihu4jgB6FGN0sRF5G6yCi
         fd2qj4c8tGnOxXO3bE7g56BWoJt0S9gFYxFLez/ONgOdsBCLZlZ4/yxZSx7FztJNAFH/
         QMQJIUw/J5MakijV5N5CuCnnJiT803PyaWh1w/qzi76wpuAMLwvKkYffhOfO/RUxjjJB
         1kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5pDJzk1dQsu0Qk8opYITEZv6dz4zcJdUZeTWjVZhptE=;
        b=32R01vwuXIfrf+fB5tZIuoLwBKyTJ+0Iy6G8DYYV0TmRC8XbzAvwo5o9TVOHEB0+FP
         aEtXchRZs8vHlw0T0mt724jOFCUMny9+EIZ6ogCiHNfEiX7CUNVib1jew02gXpQ6uso5
         sng6AR5KGdkGMDgpJHkalAaL+n3eqreqL2tVy/nqm7lCojlt4yzh4fcAQyBmKLW6aH/U
         IrpEgoM7gXcPz/+5WUQ60VoMgsnrSXyffhlta5OqPLESBlVQGosczd5D0PMG9/6S5WOz
         7o6dAHSYEP1cy5O5ZjRUONVhhbIU2WyOWm8r9LO+roiB201MbiHEHFTuEDxyqLKLVKWW
         TZ2Q==
X-Gm-Message-State: AOAM531qVXuxh/01RXn9zx3qspgCr6owDuftALmS+ehkzuek+XJk8CKe
        jxdWZgwmSumU+TnhbpkhqNbTTA==
X-Google-Smtp-Source: ABdhPJzMMAQXbahgizkqdtfjZ2i9Fvd2grW2x1BACOTg5wkyiMKd17pDOdTjWFpfP/ndoI6nBLGJew==
X-Received: by 2002:a02:a982:: with SMTP id q2mr3158600jam.220.1642114939372;
        Thu, 13 Jan 2022 15:02:19 -0800 (PST)
Received: from google.com ([2620:15c:183:200:2ee3:2c3c:a8c8:b1bf])
        by smtp.gmail.com with ESMTPSA id i20sm3830279iov.43.2022.01.13.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 15:02:18 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:02:15 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
Message-ID: <YeCvd4UBPy27SYGZ@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <87a6g0nczg.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6g0nczg.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 04:01:31PM +0530, Aneesh Kumar K.V wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
> 
> 
> Got the below lockdep warning while using the above kill/enable switch
> 
> 
> [   84.252952] ======================================================
> [   84.253012] WARNING: possible circular locking dependency detected
> [   84.253074] 5.16.0-rc8-16204-g1cdcf1120b31 #511 Not tainted
> [   84.253135] ------------------------------------------------------
> [   84.253194] bash/2862 is trying to acquire lock:
> [   84.253243] c0000000021ff740 (cgroup_mutex){+.+.}-{3:3}, at: store_enable+0x80/0x1510
> [   84.253340]
>                but task is already holding lock:
> [   84.253410] c000000002221348 (mem_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x30/0x50
> [   84.253503]
>                which lock already depends on the new lock.
> 
> [   84.255933] Chain exists of:
>                  cgroup_mutex --> cpu_hotplug_lock --> mem_hotplug_lock

Thanks. Will reverse the order between mem_hotplug_lock and
cgroup_mutex in the next spin.
