Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA964C46EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiBYNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBYNxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:53:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3316313859B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:52:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41BB106F;
        Fri, 25 Feb 2022 05:52:29 -0800 (PST)
Received: from [10.57.90.208] (unknown [10.57.90.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2AC33F5A1;
        Fri, 25 Feb 2022 05:52:28 -0800 (PST)
Message-ID: <5f56c04f-f132-a200-4acc-7b151f7abce1@arm.com>
Date:   Fri, 25 Feb 2022 13:52:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 RESEND 0/4] coresight: etm: Correct PID tracing for
 non-root namespace
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220204152403.71775-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220204152403.71775-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 15:23, Leo Yan wrote:
> If a profiling program runs in a non-root PID namespace and CoreSight
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
> This patch series has been rebased on the mainline kernel and applied
> cleanly on latest commit dcb85f85fa6f ("gcc-plugins/stackleak: Use
> noinstr in favor of notrace").
> 
> 
> Leo Yan (4):
>    coresight: etm4x: Add lock for reading virtual context ID comparator
>    coresight: etm4x: Don't use virtual contextID for non-root PID
>      namespace
>    coresight: etm4x: Don't trace PID for non-root PID namespace
>    coresight: etm3x: Don't trace PID for non-root PID namespace
> 
>   .../coresight/coresight-etm3x-core.c          |  4 +++
>   .../coresight/coresight-etm4x-core.c          | 10 +++++--
>   .../coresight/coresight-etm4x-sysfs.c         | 30 +++++++++++++++++++
>   3 files changed, 42 insertions(+), 2 deletions(-)
> 

I have queued the series to coresight/next.

Kind regards
Suzuki

