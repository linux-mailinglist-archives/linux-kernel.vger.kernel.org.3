Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88A2598030
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiHRIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHRIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:36:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF9B029D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q6fIoPbFyzYKNKdjMKH1CBJNejIE1XTrbd73RU1e9sc=; b=r2KCmCMNPaVpKNnzK4I6t/KGCp
        nJAo8/Pe/IaYWeoc676+RE0YIGu+Cq7lB+NS7WemPdKInZJbHVMGiZv5q1EGfVIqONtTLOLnPQfVY
        iWZvKHGfpMxffGOe6rfDcjwiFybGY7qCIaSM9zzVLH2QtKrQY+FgatDj0CwqsfbVbACu3DBeAvSFe
        cbbqX9BgNevjA7xcswwSwPWtygiTvsdyS3ytRVPOQ9/36dmlmpDd00Vv4oTWNfkQUUpcjtHZcHm6k
        rySlB7r5tKsZntzLK6QDZoGKjCMXJxbPEdArhfEVmAvzvcSe1X5iAETqkuyk7JsMsDj+C7n2djaki
        1+yXj7Cg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOb0x-009XA4-Ko; Thu, 18 Aug 2022 08:36:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2969C9801D4; Thu, 18 Aug 2022 10:36:30 +0200 (CEST)
Date:   Thu, 18 Aug 2022 10:36:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, acme@redhat.com, namhyung@kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf/x86/intel/ds: fix precise store latency handling
Message-ID: <Yv36DrUKLz8UWnbX@worktop.programming.kicks-ass.net>
References: <20220818054613.1548130-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818054613.1548130-1-eranian@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:46:13PM -0700, Stephane Eranian wrote:
> With the existing code in store_latency_data(), the memory operation (mem_op)
> returned to the user is always OP_LOAD where in fact, it should be OP_STORE.
> This comes from the fact that the function is simply grabbing the information
> from a data source map which covers only load accesses. Intel 12th gen CPU
> offers precise store sampling that captures both the data source and latency.
> Therefore it can use the data source mapping table but must override the
> memory operation to reflect stores instead of loads.
> 
> Fixes: 61b985e3e775 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")
> Signed-off-by: Stephane Eranian <eranian@google.com>

Thanks
