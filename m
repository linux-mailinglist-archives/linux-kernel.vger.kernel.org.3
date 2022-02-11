Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB64B232C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbiBKKcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:32:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348921AbiBKKcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:32:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8EFEA9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:32:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB8C5106F;
        Fri, 11 Feb 2022 02:32:15 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACEC3F73B;
        Fri, 11 Feb 2022 02:32:13 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:32:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 40/49] firmware: pcsi: replace cpumask_weight with
 cpumask_weight_eq
Message-ID: <YgY7JRQtWr48PtG2@FVFF77S0Q05N>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-41-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-41-yury.norov@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:24PM -0800, Yury Norov wrote:
> down_and_up_cpus() calls cpumask_weight() to compare the weight of
> cpumask with a given number. We can do it more efficiently with
> cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is (or can't be) met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

With the 'pcsi' typo fixed:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci_checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index 116eb465cdb4..90c9473832a9 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -90,7 +90,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
>  		 * cpu_down() checks the number of online CPUs before the TOS
>  		 * resident CPU.
>  		 */
> -		if (cpumask_weight(offlined_cpus) + 1 == nb_available_cpus) {
> +		if (cpumask_weight_eq(offlined_cpus, nb_available_cpus - 1)) {
>  			if (ret != -EBUSY) {
>  				pr_err("Unexpected return code %d while trying "
>  				       "to power down last online CPU %d\n",
> -- 
> 2.32.0
> 
