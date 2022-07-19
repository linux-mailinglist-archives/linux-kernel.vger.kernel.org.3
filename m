Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A757A0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiGSOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiGSOL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:11:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13FFC564D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:33:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4C2139F;
        Tue, 19 Jul 2022 06:33:45 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E6573F766;
        Tue, 19 Jul 2022 06:33:42 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:33:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Message-ID: <20220719133340.rhrxyrlg3qg6wxnh@bogus>
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com>
 <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
 <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <f68f8bcc-7543-5957-0e17-2cc797898ec0@samsung.com>
 <CAGETcx-=0Lis2Btt7Ski+eO4Dp+Aa+a+eF+Sp=igSOsWvEntww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-=0Lis2Btt7Ski+eO4Dp+Aa+a+eF+Sp=igSOsWvEntww@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:51:29PM -0700, Saravana Kannan wrote:
> On Tue, Jul 12, 2022 at 11:53 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:

[..]

> Longer explanation follows:
> 
> 5a46079a9645 ("PM: domains: Delete usage of
> driver_deferred_probe_check_state()") correctly assumed fw_devlink
> will block calls to __genpd_dev_pm_attach() before the power domain
> has probed or we have given up waiting on suppliers at the driver core
> level. So, __genpd_dev_pm_attach() returning -2 was not a problem
> (well, there are other issues, but we'll pretend they don't exist for
> now).
> 
> Until this amba patch, that was true because really_probe() calls
> device_links_check_suppliers() before you'll get anywhere near
> __genpd_dev_pm_attach().
>

Last time I started looking at this patch, I was suspecting some issue
around __genpd_dev_pm_attach() but your explanation makes sense to me
now and I am more or less convinced this was what happening on Juno.

> But with this amba patch, we try to get power domains before we get to
> really_probe() and that doesn't get the device links check. So,
> amba_match() has to always return -EPROBE_DEFER on any error until we
> optimize out match() calls for devices whose suppliers aren't ready
> yet. I'm considering reverting 5a46079a9645 due to other issues, so I
> think v4 might be okay as is.
>

OK, do I need to check with 5a46079a9645 reverted then ?

-- 
Regards,
Sudeep
