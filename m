Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9784E3F12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiCVNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiCVNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:03:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E485974;
        Tue, 22 Mar 2022 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=prF9czoDtl9GAA4LHPQoYGhsJJ4PrlX0+rNnCZcAsR4=; b=SpVe8SEYVv4YB7KKDtRtugDGa8
        ucWnhCYUjaw5wsBv3zqqPJY5OJHHV6JgAN+6h6iCabNZo1FUj1gk5ggpESdJbL82UJ1eE7MZqspHV
        oPPgV20vxRM3DawwBZNVf/XNwt9Y6/nXnmo6ZT9BzBROLWfsSioHixPXSB1bHJU7VxkwPN0//21s6
        hT/RMQxUSDRoOEg8bSUzw66zrBFjvHfsvq3Hv4koikeOO95YB+NjJiVsAijtxftbskXcq+QWWXV+N
        dPOxa09OMFYICMps4JcX6YfCQf85wbA+lSSuSfvRIK9vDgU2O/Z7POp46T1fwEph785Gnaz8illn/
        yXcm1MJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWe9A-003T3J-2n; Tue, 22 Mar 2022 13:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B324C30020B;
        Tue, 22 Mar 2022 14:01:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A26AE2019FD09; Tue, 22 Mar 2022 14:01:59 +0100 (CET)
Date:   Tue, 22 Mar 2022 14:01:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 3/6] perf/core: Don't pass task around when ctx sched
 in
Message-ID: <YjnIx5x6/sTeua4H@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-4-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:31PM +0800, Chengming Zhou wrote:
> The current code pass task around for ctx_sched_in(), only
> to get perf_cgroup of the task, then update the timestamp
> of it and its ancestors and set them to active.
> 
> But we can use cpuctx->cgrp to get active perf_cgroup and
> its ancestors since cpuctx->cgrp has been set before
> ctx_sched_in().
> 
> This patch remove the task argument in ctx_sched_in()
> and cleanup related code.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Yeah, this looks reasonable I suppose...
