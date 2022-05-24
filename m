Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE255325A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiEXIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiEXIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:52:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7130469B40
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:52:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB2A1FB;
        Tue, 24 May 2022 01:52:06 -0700 (PDT)
Received: from bogus (unknown [10.57.66.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B4E3F73D;
        Tue, 24 May 2022 01:52:04 -0700 (PDT)
Date:   Tue, 24 May 2022 09:51:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rafael@kernel.org, Jonathan.Cameron@huawei.com, drjones@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arch_topology: Limit threads to one specific cluster
Message-ID: <20220524085157.o3ie6hjy3tg5of5y@bogus>
References: <20220524081212.1363105-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524081212.1363105-1-gshan@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:12:12PM +0800, Gavin Shan wrote:
> The sibling information for one particular CPU is updated after ACPI
> PPTT table is parsed. struct cpu_topology::thread_sibling tracks the
> the CPUs in same core. However, cluster isn't considered when it's
> populated. In this case, multiple threads belonging to different
> clusters can be put together through the sibling information. It
> eventually leads to unexpected warning from sched subsystem.
> 
> For example, the following warning is observed in a VM where we have
> 2 sockets, 4 clusters, 8 cores and 16 threads and the CPU topology
> is populated as below.
> 
>    CPU  Socket-ID  Cluster-ID  Core-ID  Thread-ID
>    ----------------------------------------------
>     0      0          0          0        0
>     1      0          0          0        1
>     2      0          0          1        0
>     3      0          0          1        1
>     4      0          1          0        0
>     5      0          1          0        1
>     6      0          1          1        0
>     7      0          1          1        1
>     8      1          0          0        0
>     9      1          0          0        1
>    10      1          0          1        0
>    11      1          0          1        1
>    12      1          1          0        0
>    13      1          1          0        1
>    14      1          1          1        0
>    15      1          1          1        1
> 
>   [    0.592181] CPU: All CPU(s) started at EL1
>   [    0.593766] alternatives: patching kernel code
>   [    0.595890] BUG: arch topology borken
>   [    0.597210]      the SMT domain not a subset of the CLS domain
>   [    0.599286]      child=0-1,4-5    sd=0-3
> 
>   # cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
>   0-3
>   # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
>   0-1,4-5
>
> This fixes the issue by limiting threads to one specific cluster.
> With this applied, the unexpected warning disappears in the VM.
>

I have similar fix but as part of bigger series[1] to get DT support in
line with ACPI.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20220518093325.2070336-3-sudeep.holla@arm.com
