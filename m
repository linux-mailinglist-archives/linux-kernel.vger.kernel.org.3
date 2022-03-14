Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF79D4D8B77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiCNSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbiCNSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:12:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97453F89C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:11:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECDC1474;
        Mon, 14 Mar 2022 11:11:00 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E383F66F;
        Mon, 14 Mar 2022 11:11:00 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:10:58 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Message-ID: <Yi+FMrG9NyBnMX0i@arm.com>
References: <20220313055512.248571-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313055512.248571-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sunday 13 Mar 2022 at 13:55:09 (+0800), Leo Yan wrote:
> This patch set is to address issues for CPU capacity scaling.
> 
> "capacity-dmips-mhz" property might be absent in all CPU nodes, and in
> another situation, DT might have inconsistent binding issue, e.g. some
> CPU nodes have "capacity-dmips-mhz" property and some nodes miss the
> property.  Current code mixes these two cases and always rollback to CPU
> capacity 1024 for these two cases.
> 
> Patches 01 and 02 in this set are used to distinguish the two different
> DT binding cases, and for the inconsistent binding issue, it rolls back
> to 1024 without CPU capacity scaling.
> 
> Patch 03 is to handle the case for absenting "capacity-dmips-mhz"
> property in CPU nodes, the patch proceeds to do CPU capacity scaling based
> on CPU maximum capacity.  Thus it can reflect the correct CPU capacity for
> Arm platforms with "fast" and "slow" clusters (CPUs in two clusters have
> the same raw capacity but with different maximum frequencies).
> 

In my opinion it's difficult to handle absent "capacity-dmips-mhz"
properties, as they can be a result of 3 scenarios: potential..
 1. bug in DT
 2. unwillingness to fill this information in DT
 3. suggestion that we're dealing with CPUs with same u-arch
    (same capacity-dmips-mhz)

I'm not sure it's up to us to interpret suggestions in the code so I
believe treating missing information as error is the right choice, which
is how we're handling this now.

For 3. (and patch 03), isn't it easier to populate capacity-dmips-mhz to
the same value (say 1024) in DT? That is a clear message that we're
dealing with CPUs with the same u-arch.

Thanks,
Ionela.


> This patch set is applied on the mainline kernel with the latest commit
> 68453767131a ("ARM: Spectre-BHB: provide empty stub for non-config").
> And tested on Arm64 Hikey960 platform (with a bit hacking to emulate
> fast and slow clusters).
> 
> 
> Leo Yan (3):
>   arch_topology: Correct semantics for 'cap_parsing_failed'
>   arch_topology: Handle inconsistent binding of CPU raw capacity
>   arch_topology: Scale CPU capacity if without CPU raw capacity
> 
>  drivers/base/arch_topology.c | 42 +++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
