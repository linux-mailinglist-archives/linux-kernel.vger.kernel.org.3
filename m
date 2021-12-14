Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C384740FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhLNLAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:00:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233336AbhLNLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:00:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E0C2106F;
        Tue, 14 Dec 2021 03:00:01 -0800 (PST)
Received: from [10.57.84.72] (unknown [10.57.84.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048533F5A1;
        Tue, 14 Dec 2021 02:59:59 -0800 (PST)
Message-ID: <38b167f2-d055-9618-62b7-c65363d06d29@arm.com>
Date:   Tue, 14 Dec 2021 10:59:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/4] coresight: etm: Correct PID tracing for non-root
 namespace
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211213121323.1887180-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211213121323.1887180-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 12:13, Leo Yan wrote:
> If a profiling program runs in a non-root PID namespace, if CoreSight
> driver enables PID tracing (with contextID), it can lead to mismatching
> issue between the context ID traced in hardware (from the root
> namespace) and the PIDs gathered by profiling tool (e.g. perf) in its
> non-root namespace.
> 
> CoreSight driver has tried to address this issue for the contextID
> related interfaces under sysfs, but it misses to prevent user to set
> VMID (virtual contextID) for kernel runs in EL2 with VHE; furthermore,
> it misses to handle the case when the profiling tool runs in the
> non-root PID namespace.
> 
> For this reason, this patch series is to correct contextID tracing for
> non-root namespace.  After applied this patchset, patch 02 doesn't
> permit users to access virtual contextID via sysfs nodes in the non-root
> PID namespace, patch 03 and 04 stop to trace PID packet for non-root PID
> namespace.
> 
> This patch is dependent on the patchset "pid: Introduce helper
> task_is_in_root_ns()" [1].
> 
> [1] https://lore.kernel.org/lkml/20211208083320.472503-1-leo.yan@linaro.org/
> 
> 
> Leo Yan (4):
>    coresight: etm4x: Add lock for reading virtual context ID comparator
>    coresight: etm4x: Don't use virtual contextID for non-root PID
>      namespace
>    coresight: etm4x: Don't trace PID for non-root PID namespace
>    coresight: etm3x: Don't trace PID for non-root PID namespace
> 

For the series,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
