Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538464F7CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiDGKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDGKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:32:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35295BC11
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:30:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA39523A;
        Thu,  7 Apr 2022 03:30:25 -0700 (PDT)
Received: from bogus (unknown [10.57.43.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE073F5A1;
        Thu,  7 Apr 2022 03:30:24 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:30:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangqing <11112896@bbktel.com>
Subject: Re: [PATCH] arch_topology: support parsing cache topology from DT
Message-ID: <20220407103022.fim3cvpnzfngyzkt@bogus>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
 <20220406110655.iimv6s4godvgfwoq@bogus>
 <SL2PR06MB3082F70F1F4CE661288103C1BDE69@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082F70F1F4CE661288103C1BDE69@SL2PR06MB3082.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:11:51AM +0000, 王擎 wrote:
> 
> >> From: wangqing <11112896@bbktel.com>
> >> 
> >> When ACPI is not enabled, we can parse cache topolopy from DT:
> >> *             cpu0: cpu@000 {
> >> *                     next-level-cache = <&L2_1>;
> >> *                     L2_1: l2-cache {
> >> *                              compatible = "cache";
> >> *                             next-level-cache = <&L3_1>;
> >> *                      };
> >> *                     L3_1: l3-cache {
> >> *                              compatible = "cache";
> >> *                      };
> >> *             };
> >> *
> >> *             cpu1: cpu@001 {
> >> *                     next-level-cache = <&L2_1>;
> >> *             };
> >> *             cpu2: cpu@002 {
> >> *                     L2_2: l2-cache {
> >> *                              compatible = "cache";
> >> *                             next-level-cache = <&L3_1>;
> >> *                     };
> >> *             };
> >> *
> >> *             cpu3: cpu@003 {
> >> *                     next-level-cache = <&L2_2>;
> >> *             };
> >> cache_topology hold the pointer describing "next-level-cache", 
> >> it can describe the cache topology of every level.
> >> 
> >> Expand the use of llc_sibling when ACPI is not enabled.
> >>
> >
> >You seem to have posted this patch as part of the series first. One patch
> >was rejected and then you post this without any history. It confuses if you
> >don't provide all the background/history.
>
> Yes, the series contains several parts, the sched_domain part was rejected
> temporary. But it has nothing to do with this patch, that's why I took it apart.

That's not correct if you plan to use it there. Currently no users so no need
to add.

> The background doesn't matter, let's focus on this patch itself.
>

It depends, some people might find it useful, so better to provide it.
One can ignore if that is not needed or if they are already aware.

> >
> >Having said that, NACK for this patch as it stands. We have
> >drivers/base/cacheinfo.c which has all the parsing of cache information.
> >IIRC we already consider LLC but highlight if anything is particularly
> >missing. I am unable to follow/understand with you commit message. 
> 
> cacheinfo.c just describes the properties of the cache, It can't describe
> the cache topology, some like cpuinfo and cpu topology.
> 

Not 100% correct. We do have info about sharing there.

> llc_sibling is not used at all if ACPI is not enabled, because llc_id
> always be -1, and cpu_coregroup_mask() always return the core_sibling.
>

You can use of_find_last_level_cache or something similar and remove load
of duplicated code you have in this patch.

> Why not get the cache topology from DT if the arch support GENERIC_ARCH_TOPOLOGY.
>

Sure but if the intended use is for scheduler, please include relevant people
as there are quite a few threads around the topic recently and disintegrating
and throwing patches at random with different set of people is not going to
help make progress. If this is intended for Arm64 platforms, I suggest to
keep these 2 in the loop as they are following few other threads and gives
them full picture of intended use-case.

Vincent Guittot <vincent.guittot@linaro.org>
Dietmar Eggemann <dietmar.eggemann@arm.com>

--
Regards,
Sudeep
