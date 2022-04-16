Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D4503566
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiDPI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiDPI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:57:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975A24BF4;
        Sat, 16 Apr 2022 01:55:21 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 18B6060C;
        Sat, 16 Apr 2022 08:55:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 18B6060C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650099321; bh=kyGKxhjj+jW2MN2KpzeSLbx1pVTnpoKfNHzINimjN/8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YhiPHvoYgKWUh9AlA0wGRMxBMlGl9W8RwYA93nc2lwv5uSlBaYBofQEECPqp4bAwP
         sawOCAn63EKkprQOw0D8L5AbmP32Kv8y7bHnDESH8rquBIkizSrBp5fH5hOcQYHoc5
         3sDXW2ioD7uqvkuPP3vggzK7EPIYZOAfTeYKti0JkiI6hFkXvuZ3jrQ7MaQW9XwJxI
         F2SMgjk+h9y2zi6lmo7o6OKa1iE2acSAdkxBK8IKW79pj7aNZT4BoSMcWqoKrVzrSC
         QBxvjQi0qz1azLAJ+LHCUViP4rlip9723xXAk8GC1q5cgdFddrEGMEo1AhJBjv1bWQ
         SgQibI7K9bFqA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] docs/scheduler: fix unit error
In-Reply-To: <20220415033618.15655-1-juitse.huang@gmail.com>
References: <20220415033618.15655-1-juitse.huang@gmail.com>
Date:   Sat, 16 Apr 2022 02:55:16 -0600
Message-ID: <87ilr92yrv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jui-Tse Huang <juitse.huang@gmail.com> writes:

> The unit mentioned in the documentation of scheduler statistics is
> outdated which may mislead the readers.
>
> The unit of statistics that is reported by /proc/schedstat is modified
> to nanosecond, and the unit of statistics that is reported by
> /proc/PID/schedstat is provided as well to make the context consistent.
>
> The rq_cpu_time and the rq_sched_info.run_delay of a run queue, and the
> sched_info.run_delay of a task are all updated based on the clock of the
> run queue, while the se.sum_exec_runtime of a task is updated based on
> the clock_task of the run queue of the task. Both the clock and
> clock_task are relied on the return value of the function sched_clock()
> which is in the unit of nanosecond.
>
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> ---
>  Documentation/scheduler/sched-stats.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Part of this had already been fixed by a previous patch, but git was
able to figure it out...this one's applied as well, thanks.

jon
