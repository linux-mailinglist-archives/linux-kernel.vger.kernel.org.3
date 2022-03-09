Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8074D36FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiCIRls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiCIRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:41:46 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4670913
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646847647; x=1678383647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4+HDh+YvwFEs84X6XFiq5TTs7ogzojgyVT3Fsf9PmQ=;
  b=cGwasehqd7zxYS4VsHOj8zbD+E46r5dAuu8OH/8MHe5eQn61wdFTzpPf
   sKeYFg/KKMLD4r4RH1NkM/Az/KC/6YQE3V2HSNRCd6Uhu1NvimzCffJTs
   e/N/GwDU82IPpoJur/Tv/b2QhQ4FfA9W4O+/ydsxXYjWgkRSza540bh77
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Mar 2022 09:40:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 09:40:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 09:40:36 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 9 Mar 2022
 09:40:35 -0800
Date:   Wed, 9 Mar 2022 12:40:33 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Linu Cherian <lcherian@marvell.com>
CC:     <maz@kernel.org>, <tglx@linutronix.de>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when
 reading IAR
Message-ID: <YijmkXp1VG7e8lDx@qian>
References: <20220307143014.22758-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220307143014.22758-1-lcherian@marvell.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:00:14PM +0530, Linu Cherian wrote:
> When a IAR register read races with a GIC interrupt RELEASE event,
> GIC-CPU interface could wrongly return a valid INTID to the CPU
> for an interrupt that is already released(non activated) instead of 0x3ff.
> 
> As a side effect, an interrupt handler could run twice, once with
> interrupt priority and then with idle priority.
> 
> As a workaround, gic_read_iar is updated so that it will return a
> valid interrupt ID only if there is a change in the active priority list
> after the IAR read on all the affected Silicons.
> 
> Since there are silicon variants where both 23154 and 38545 are applicable,
> workaround for erratum 23154 has been extended to address both of them.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>

Reverting this commit from today's linux-next fixed global-out-of-bounds
accesses running CPU hotplug workloads on a non-ThunderX server.

 psci: CPU88 killed (polled 0 ms)
 ==================================================================
 BUG: KASAN: global-out-of-bounds in is_affected_midr_range_list
 Read of size 4 at addr ffffa0ec80ddcc6c by task swapper/88/0

 CPU: 88 PID: 0 Comm: swapper/88 Not tainted 5.17.0-rc7-next-20220309-dirty #25
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  print_report
  kasan_report
  __asan_report_load4_noabort
  is_affected_midr_range_list
  is_midr_in_range_list at ./arch/arm64/include/asm/cputype.h:221
  (inlined by) is_affected_midr_range_list at arch/arm64/kernel/cpu_errata.c:41
  verify_local_cpu_caps
  verify_local_cpu_caps at arch/arm64/kernel/cpufeature.c:2787
  check_local_cpu_capabilities
  verify_local_elf_hwcaps at arch/arm64/kernel/cpufeature.c:2852
  (inlined by) verify_local_cpu_capabilities at arch/arm64/kernel/cpufeature.c:2922
  (inlined by) check_local_cpu_capabilities at arch/arm64/kernel/cpufeature.c:2948
  secondary_start_kernel
  __secondary_switched

 The buggy address belongs to the variable:
  cavium_erratum_23154_cpus

 The buggy address belongs to the virtual mapping at
  [ffffa0ec80dd0000, ffffa0ec82140000) created by:
  map_kernel


