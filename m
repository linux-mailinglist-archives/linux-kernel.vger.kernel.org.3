Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413650FEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiDZN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiDZN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:28:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B9F15837
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:25:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF237ED1;
        Tue, 26 Apr 2022 06:25:14 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5BBD3F774;
        Tue, 26 Apr 2022 06:25:13 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:25:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Message-ID: <20220426132511.7zo4w42kauvrq26n@bogus>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220425165946.qb6xilgmjahdh4pa@bogus>
 <SL2PR06MB3082544EFB9C6F518A2EBF04BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426064053.h4rwvcdvmwxj2hmt@bogus>
 <SL2PR06MB3082F1AEE684E638C1B5F226BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082F1AEE684E638C1B5F226BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:52:34AM +0000, 王擎 wrote:
> 
> >> 
> >> >> 
> >> >> >> From: Wang Qing <wangqing@vivo.com>
> >> >> >> 
> >> >> >> cluster sched_domain configured by cpu_topology[].cluster_sibling, 
> >> >> >> which is set by cluster_id, cluster_id can only get from ACPI.
> >> >> >> 
> >> >> >> If the system does not enable ACPI, cluster_id is always -1, even enable
> >> >> >> SCHED_CLUSTER is invalid, this is misleading. 
> >> >> >> 
> >> >> >> So we add SCHED_CLUSTER's dependency on ACPI here.
> >> >> >>
> >> >> >
> >> >> >Any reason why this can't be extended to support DT based systems via
> >> >> >cpu-map in the device tree. IMO we almost have everything w.r.t topology
> >> >> >in DT and no reason to deviate this feature between ACPI and DT.
> >> >> >
> >> >> That's the problem, we parse out "cluster" info according to the
> >> >> description in cpu-map, but do assign it to package_id, which used to
> >> >> configure the MC sched domain, not cluster sched domain.
> >> >>
> >> >
> >> >Right, we haven't updated the code after updating the bindings to match
> >> >ACPI sockets which are the physical package boundaries. Clusters are not
> >> >the physical boundaries and the current topology code is not 100% aligned
> >> >with the bindings after Commit 849b384f92bc ("Documentation: DT: arm: add
> >> >support for sockets defining package boundaries")
> >>
> >> I see, but this commit is a long time ago, why hasn't it been used widely.
> >> Maybe I can help about it if you need.
> >>
> >
> >I assume no one cared or had a requirement for the same.
> 
> It took me a while to find the root cause why enabling SCHED_CLUSTER
> didn't work.
> 
> We should add SCHED_CLUSTER's dependency before implementation.
> Otherwise, everyone who doesn't have ACPI but use SCHED_CLUSTER 
> will have this problem.
> 

I am fine with that or mark it broken for DT, but ideally I wouldn't
want to create unnecessary dependency on ACPI or DT when both supports
the feature.

-- 
Regards,
Sudeep
