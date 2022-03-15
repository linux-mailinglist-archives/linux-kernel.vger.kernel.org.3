Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099D4DA102
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350514AbiCORUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiCORUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:20:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D29E42ED3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:19:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B8D01474;
        Tue, 15 Mar 2022 10:19:21 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2273F73D;
        Tue, 15 Mar 2022 10:19:17 -0700 (PDT)
Message-ID: <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
Date:   Tue, 15 Mar 2022 18:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched: dynamic config sd_flags if described in DT
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 08:58, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>

(1) Can you share more information about your CPU topology?

I guess it is a single DSU (DynamIQ Shared Unit) ARMv9 system with 8
CPUs? So L3 spans over [CPU0..CPU7].

You also mentioned complexes. Am I right in assuming that [CPU0..CPU3]
are Cortex-A510 cores where each 2 CPUs share a complex?

What kind of uarch are the CPUs in [CPU4..CPU7]? Are they Cortex-A510's
as well? I'm not sure after reading your email:

https://lkml.kernel.org/r/SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com

You might run into the issue that individual CPUs of your system see a
different SD hierarchy in case that [CPU4..CPU7] aren't Cortex-A510's,
i.e. CPUs not sharing complexes.

(2) Related to your MC Sched Domain (SD) layer:

If you have a single DSU ARMv9 system, then in Linux kernel mainline you
shouldn't have sub-clustering of [CPU0..CPU3] and [CPU4...CPU7].

I.e. the cpu-map entry in your dts file should only list cores, not
clusters.

I know that in Android the cluster entries are used to sub-group
different uarch CPUs in an asymmetric CPU capacity system (a.k.a. Arm
DynamIQ and Phantom domains) but this is eclipsing the true L3 (LLC)
information and is not "supported" (in the sense of "used") in mainline.

But I have a hard time to see what [CPU0..CPU3] or [CPU4..CPU7] are
shareing in your system.

(3) Why do you want this different SD hierarchy?

I assume in mainline your system will have a single SD which is MC (w/o
the Phantom domain approach from Android).

You mentioned cpus_share_cache(). Or is it the extra SD level which
changes the behaviour of CFS load-balancing? I'm just wondering since
EAS wouldn't be affected here. I'm sure I can understand this better
once we know more about your CPU topology.

[...]
