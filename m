Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5836850E65D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbiDYRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiDYRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:02:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28CF1132C3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:59:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A571C1FB;
        Mon, 25 Apr 2022 09:59:53 -0700 (PDT)
Received: from bogus (unknown [10.57.11.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F210B3F5A1;
        Mon, 25 Apr 2022 09:59:51 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:59:46 +0100
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
Message-ID: <20220425165946.qb6xilgmjahdh4pa@bogus>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:18:21AM +0000, 王擎 wrote:
> 
> >> From: Wang Qing <wangqing@vivo.com>
> >> 
> >> cluster sched_domain configured by cpu_topology[].cluster_sibling, 
> >> which is set by cluster_id, cluster_id can only get from ACPI.
> >> 
> >> If the system does not enable ACPI, cluster_id is always -1, even enable
> >> SCHED_CLUSTER is invalid, this is misleading. 
> >> 
> >> So we add SCHED_CLUSTER's dependency on ACPI here.
> >>
> >
> >Any reason why this can't be extended to support DT based systems via
> >cpu-map in the device tree. IMO we almost have everything w.r.t topology
> >in DT and no reason to deviate this feature between ACPI and DT.
> >
> That's the problem, we parse out "cluster" info according to the
> description in cpu-map, but do assign it to package_id, which used to
> configure the MC sched domain, not cluster sched domain.
>

Right, we haven't updated the code after updating the bindings to match
ACPI sockets which are the physical package boundaries. Clusters are not
the physical boundaries and the current topology code is not 100% aligned
with the bindings after Commit 849b384f92bc ("Documentation: DT: arm: add
support for sockets defining package boundaries")

> That is to say, "cluster" in cpu-map is used to describe the package_id.
> We can't get cluster_id from DT.
>

That is wrong, we have "socket" to describe the package_id now.

--
Regards,
Sudeep
