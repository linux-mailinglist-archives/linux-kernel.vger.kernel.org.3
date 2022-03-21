Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD174E262B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiCUMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCUMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:17:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B48FA1587AA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:16:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582371042;
        Mon, 21 Mar 2022 05:16:13 -0700 (PDT)
Received: from wubuntu (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F204D3F66F;
        Mon, 21 Mar 2022 05:16:12 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:16:11 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Paul Bone <pbone@mozilla.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scheduling for heterogeneous computers
Message-ID: <20220321121611.ssa7o2npy3ahdofk@wubuntu>
References: <20220308092141.GF748856@aluminium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308092141.GF748856@aluminium>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On 03/08/22 20:21, Paul Bone wrote:
> 
> Are there plans for power-aware scheduling on heterogeneous computers that
> processes & threads can opt-in to?
> 
> Several mainstream devices now offer power-aware heterogeneous scheduling:
> 
>  * Lots of ARM (and therefore android) devices offer big.LITTLE cores.
>  * Apple's M1 CPU has "gold" and "silver" cores.  The gold cores are faster
>    and have more cache.  I think there are other microarchitectual
>    differences.
>  * Intel's Alder Lake CPUs have P and E cores.  I'm told that the E cores
>    don't save power though since each core type still gets the same work
>    done per Watt, it's just that the P cores are bigger and faster.
>  * Multicore CPUs that offer frequency scaling could get some power savings
>    by switching off turbo boost and similar features.  They wonThe work/watt
>    improves at the cost of throughput & responsiveness.
> 
> I'm aware that Linux does some Energy Aware Scheduling
> https://docs.kernel.org/scheduler/sched-energy.html, however what I'm
> looking for is an API that processes (but ideally threads) can opt in-to
> (and out-of (unlike nice)) to say that the work they're currently doing is
> bulk work.  It needs to get done but it doesn't have a deadline and
> therefore can be done on a smaller / more power efficient core.  The idea is
> that the same work gets done eventually, but for a background task (eg
> Garbage Collection) it can be done in a greener or more
> battery-charge-extending way.
> 
> MacOS has added an API for this as:
>     pthread_set_qos_class_self_np()
>     https://developer.apple.com/documentation/apple-silicon/tuning-your-code-s-performance-for-apple-silicon?preferredLanguage=occ
> 
> Windows has:
>     ThreadPowerThrottling
>     https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-setthreadinformation
> 
> I'm not aware of anything for Linux and I've been unable to find anything.
> Are there any plans to implement this?  

We do actually have a feature called util clamp (uclamp for short) that allows
you to do that.

There's a new field in sched_setattr() to set UCLAMP_MIN and UCLAMP_MAX.

UCLAMP_MIN hints towards performance. Ie: tell the system this task needs at
least this performance level as a minimum. Which will be translated into task
placement and frequency selection by the scheduler when this task is running.

UCLAMP_MAX hints towards efficiency. Ie: tell the system this task does not
need to operate above this performance level. Like UCLAMP_MIN, this will impact
task placement and frequency selection when this task is running.

There's a tool called uclampset in util-linux v2.37.2 that allows you to play
with this. See this commit message for an example:

	https://lore.kernel.org/lkml/20211216225320.2957053-2-qais.yousef@arm.com/

There are some issues that you might need to be aware of though.

	1. UCLAMP_MAX effectiveness issues when there are multiple tasks with
	   different demands running on the same CPU.

	   This LPC talk will explain the problem:
	   https://www.youtube.com/watch?v=i5BdYn6SNQc&t=680s

	2. fits_capacity() is not uclamp aware yet, and this means the task
	   placement bias will not work as well as it should be.

I am working on both these issues and kernel documentation to help better
explain the feature. There's a cgroup interface in the cpu controller
(cpu.uclamp.min/max).

You need to use schedutil cpufreq governor.

There was a LWN article on the feature that might help with more background:

	https://lwn.net/Articles/762043/

HTH.

Cheers

--
Qais Yousef
