Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C284E53F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiCWOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiCWOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:07:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC47EB10;
        Wed, 23 Mar 2022 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKhKVi5fr2eBNbfU4f/0JBSibQlWyP+cFs6PqFc8qm0=; b=SYOS9MKLR7UfPrQs2XV/TuRHnZ
        P6N6DZr+Sfp9andljnhVuB9WeNOPJO1iLTXrkoNMzQGJvSKuAc7PFuFme0Cr+GePu24CcxrWdpVf6
        tu2CtRbWfPziqVEmS6yP4clVx7ASMxPLE3xMAfhwGGqJydfbCyTcO81Z3btUMxue06n5A1qpANo89
        GvhmaB9vg/pmjTEVh/uy7r/TuibLaEcvxzkwuifnHFgfoSV+Sj+tdRhDt2pz8CAnK8uxMgz/1B+IP
        8heBXrDOMFSSTlzHPheULdPf+Ukl/4IgX9iSO4jysNm7tJ9hrzrYTdYPZGCwkvZNN7ntgCALvy1h6
        RKs0BJpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX1cK-003mZh-Kx; Wed, 23 Mar 2022 14:05:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 271F630007E;
        Wed, 23 Mar 2022 15:05:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02AEF265BB5E2; Wed, 23 Mar 2022 15:05:37 +0100 (CET)
Date:   Wed, 23 Mar 2022 15:05:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Message-ID: <YjspMR6gJ5AWjE8Q@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <20220323125116.GX8939@worktop.programming.kicks-ass.net>
 <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
 <20220323131744.GY8939@worktop.programming.kicks-ass.net>
 <c4fea458-b0e1-9842-91ea-5a1c6f7e8387@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fea458-b0e1-9842-91ea-5a1c6f7e8387@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:37:16PM +0800, Chengming Zhou wrote:

> But you are right, having cpuctx->cgrp and cpu_perf_cgroup make things confused..
> maybe we can delete cpuctx->cgrp, change to use percpu cpu_perf_cgroup?

I'm hoping to soon (*finally*!) have some time for this again:

  https://lkml.kernel.org/r/20220113134743.1292-1-ravi.bangoria@amd.com

That should get us a single cpuctx.
