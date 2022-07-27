Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D56583505
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiG0WCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiG0WCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:02:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BC4F650;
        Wed, 27 Jul 2022 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BeBrPOLke6WzMWFWacFZZOXBlwbPMapBMRMcKarqkaM=; b=F2msVEIQ4j5C0MRFgckCahwZVf
        JpfYlCrIDWIKspHdCBCxjCBOf1bpGSMmTaH4HK6bGrVM9Xn6dKgpsteLMulCX1Rcn9INNsPGVnTnh
        LOKAlI1NOF8r7N5kF40HZzVXCOJMl4I6GJevS4FqJJu9cBCh8tm8yXyJObHmeKx0fU5ny/dewcX7F
        7TSimFc41ONT5KnAznUR8LtwmIRw33Bq+j2qg20vG3FXHzfyenBLcQRt9kA4GdnIBlXIh5sXHzBwm
        W9Uxm8ECGDeaGChrsecHgk9KBtt8H9qG8Xdk892vi185o/6UhgH9BdOKfUJKbYQWB4OjRZUDw61L3
        6ZuyH6Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGp61-003Hce-O7; Wed, 27 Jul 2022 22:01:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9209C980403; Thu, 28 Jul 2022 00:01:35 +0200 (CEST)
Date:   Thu, 28 Jul 2022 00:01:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <YuG1vwqs1GgE/twg@worktop.programming.kicks-ass.net>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <20220712125702.yg4eqbaakvj56k6m@wubuntu>
 <Ys2duuPDNq/q+oOz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2duuPDNq/q+oOz@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:13:46AM -1000, Tejun Heo wrote:

> But now we're failing user-initiated operations randomly. I have a hard time
> seeing that as an acceptable solution. 

There (sadly) is precedent for that; grep for "cpu_hotplug_disable".
