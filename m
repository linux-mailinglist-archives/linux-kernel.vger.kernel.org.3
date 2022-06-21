Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A876255353F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352226AbiFUPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351813AbiFUPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:09:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0521838F;
        Tue, 21 Jun 2022 08:09:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8638A6601688;
        Tue, 21 Jun 2022 16:09:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655824150;
        bh=yKy10fDX54YCxEXJXL79y5iJPRtvTIKAxsv4we0n0gM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jhlSZIQwj7YbqFfDJecLZBGilYxdq01bn1UglhX+ppksvvE2oCGLoyDEV+26Spq8I
         LA9bzGLWEmIz/sIfdrkH9pRj5uq3H3rQ3gT8hu5eAkFBtUEq525YDwtPu5tr77yQPN
         dps2l2p7DkF5xz3g6T5Ot+HSskVGcCSmy+gDnqKIZI6oaN3uVNPmq5Mmt/aPFKoypS
         gy+4TWKA5Rq1Mq/QNYcE6tIxTFT9OLqCWGHiiEvZJ9+J9+HyUW6NvzqRE5oVE/mlSc
         DIeUxz3n0M4Q2F9J+Uz324cHOBEb0EJsX84dURVAwdJ2W1nVt2D2s5GnK7aGnHl2PR
         CEgLzJz5I/duw==
Message-ID: <da2f1552-6896-5ae8-4837-28f31f3031a9@collabora.com>
Date:   Tue, 21 Jun 2022 18:09:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 02/31] OPP: Add dev_pm_opp_set_config() and friends
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <9c4b2bfe628bf7a583a96cee7cc3539e2e66245e.1653564321.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <9c4b2bfe628bf7a583a96cee7cc3539e2e66245e.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/22 14:42, Viresh Kumar wrote:
> +/**
> + * dev_pm_opp_clear_config() - Releases resources blocked for OPP configuration.
> + * @opp_table: OPP table returned from dev_pm_opp_set_config().
> + *
> + * This allows all device OPP configurations to be cleared at once. This must be
> + * called once for each call made to dev_pm_opp_set_config(), in order to free
> + * the OPPs properly.
> + *
> + * Currently the first call itself ends up freeing all the OPP configurations,
> + * while the later ones only drop the OPP table reference. This works well for
> + * now as we would never want to use an half initialized OPP table and want to
> + * remove the configurations together.
> + */
> +void dev_pm_opp_clear_config(struct opp_table *opp_table)
> +{
> +	if (opp_table->genpd_virt_devs)
> +		dev_pm_opp_detach_genpd(opp_table);
> +
> +	if (opp_table->regulators)
> +		dev_pm_opp_put_regulators(opp_table);
> +
> +	if (opp_table->supported_hw)
> +		dev_pm_opp_put_supported_hw(opp_table);
> +
> +	if (opp_table->set_opp)
> +		dev_pm_opp_unregister_set_opp_helper(opp_table);
> +
> +	if (opp_table->prop_name)
> +		dev_pm_opp_put_prop_name(opp_table);
> +
> +	if (opp_table->clk_configured)
> +		dev_pm_opp_put_clkname(opp_table);
> +
> +	dev_pm_opp_put_opp_table(opp_table);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_clear_config);

1. I started to look at the Tegra regressions caused by these OPP
patches and this one looks wrong to me because dev_pm_opp_set_config()
could be invoked multiple times by different drivers for the same device
and then you're putting table not in accordance to the config that was
used by a particular driver.

For example, if parent tegra-cpufreq driver sets supported_hw for
cpu_dev and then cpufreq-dt also does dev_pm_opp_set_config(cpu_dev),
then dev_pm_opp_clear_config(cpu_dev) of cpufreq-dt will put
supported_hw(cpu_dev) of tegra-cpufreq. Hence this
dev_pm_opp_set/clear_config() approach isn't viable, unless I'm missing
something.

2. Patches aren't bisectable, please make sure that all patches compile
individually and without warnings.

3. There is a new NULL dereference in the recent linux-next on Tegra in
_set_opp() of the gpu/host1x driver. I'll take a closer look at this
crash a bit later.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
[00000000] *pgd=00000000
Internal error: Oops: 80000005 [#1] SMP ARM
Modules linked in:
CPU: 3 PID: 38 Comm: kworker/u8:1 Not tainted
5.19.0-rc3-next-20220621-00013-g0f8bc1c418c4-dirty #18
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
PC is at 0x0
LR is at _set_opp+0x15c/0x414
pc : [<00000000>]    lr : [<c0afa928>]    psr: 20000013
sp : df989b60  ip : df989b60  fp : df989ba4
r10: 00000000  r9 : c21e4b40  r8 : c2861e34
r7 : c21b3010  r6 : c28a5080  r5 : c2861e00  r4 : 00000000
r3 : 00000000  r2 : c28a5080  r1 : c2861e00  r0 : c21b3010
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8000404a  DAC: 00000051
Register r0 information: slab kmalloc-1k start c21b3000 pointer offset
16 size 1024
Register r1 information: slab kmalloc-512 start c2861e00 pointer offset
0 size 512
Register r2 information: slab kmalloc-128 start c28a5080 pointer offset
0 size 128
Register r3 information: NULL pointer
Register r4 information: NULL pointer
Register r5 information: slab kmalloc-512 start c2861e00 pointer offset
0 size 512
Register r6 information: slab kmalloc-128 start c28a5080 pointer offset
0 size 128
Register r7 information: slab kmalloc-1k start c21b3000 pointer offset
16 size 1024
Register r8 information: slab kmalloc-512 start c2861e00 pointer offset
52 size 512
Register r9 information: slab task_struct start c21e4b40 pointer offset 0
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdf988000
allocated at kernel_clone+0x64/0x43c
Register r12 information: 2-page vmalloc region starting at 0xdf988000
allocated at kernel_clone+0x64/0x43c
Process kworker/u8:1 (pid: 38, stack limit = 0x(ptrval))
Stack: (0xdf989b60 to 0xdf98a000)
...
Backtrace:
_set_opp from dev_pm_opp_set_opp+0x70/0xd8
r10:00000001 r9:000f4240 r8:c2848440 r7:c2848440 r6:c28a5080 r5:c21b3010
r4:c2861e00
dev_pm_opp_set_opp from tegra_pmc_core_pd_set_performance_state+0x50/0xb8
r6:c2848440 r5:c1807654 r4:c28a5080
tegra_pmc_core_pd_set_performance_state from
_genpd_set_performance_state+0x1fc/0x288
r6:c2848690 r5:c2848680 r4:000f4240
_genpd_set_performance_state from _genpd_set_performance_state+0xb8/0x288
r10:00000001 r9:000f4240 r8:c284a000 r7:c2848440 r6:c284a250 r5:c28a7180
r4:000f4240
_genpd_set_performance_state from genpd_set_performance_state+0xb8/0xd4
r10:c0185b00 r9:c28a7580 r8:00000000 r7:00000000 r6:c284a000 r5:00000000
r4:c28a7580
genpd_set_performance_state from genpd_runtime_resume+0x228/0x29c
r5:c21b3810 r4:c284a1d0
genpd_runtime_resume from __rpm_callback+0x68/0x1a0
r10:c0185b00 r9:00000004 r8:00000000 r7:c08dd55c r6:c2173800 r5:c08dd55c
r4:c21b3810
__rpm_callback from rpm_callback+0x60/0x64
r9:00000004 r8:c21b3894 r7:c08dd55c r6:c2173800 r5:c21e4b40 r4:c21b3810
rpm_callback from rpm_resume+0x608/0x83c
r7:c08dd55c r6:c2173800 r5:c21e4b40 r4:c21b3810
rpm_resume from __pm_runtime_resume+0x58/0xb4
r10:c21e4b40 r9:c21b3810 r8:c21b3800 r7:00000000 r6:c21b3894 r5:60000013
r4:c21b3810
__pm_runtime_resume from host1x_probe+0x48c/0x700
r7:00000000 r6:c2862504 r5:00000000 r4:c2862440
host1x_probe from platform_probe+0x6c/0xcc
r10:c202c00d r9:c21e4b40 r8:00000001 r7:00000000 r6:c1812420 r5:c21b3810
r4:00000000
platform_probe from really_probe+0xd8/0x300
r7:00000000 r6:c1812420 r5:00000000 r4:c21b3810
really_probe from __driver_probe_device+0x94/0xf4
r7:0000000b r6:c21b3810 r5:c1812420 r4:c21b3810
__driver_probe_device from driver_probe_device+0x40/0x114
r5:df989e84 r4:c1901580
driver_probe_device from __device_attach_driver+0xc4/0x108
r9:c21e4b40 r8:00000001 r7:c08c0fb4 r6:c21b3810 r5:df989e84 r4:c1812420
__device_attach_driver from bus_for_each_drv+0x8c/0xd0
r7:c08c0fb4 r6:c21e4b40 r5:df989e84 r4:00000000
bus_for_each_drv from __device_attach+0xb8/0x1e8
r7:c21b3854 r6:c21e4b40 r5:c21b3810 r4:c21b3810
__device_attach from device_initial_probe+0x1c/0x20
r8:c1882620 r7:00000000 r6:c1814e90 r5:c21b3810 r4:c21b3810
device_initial_probe from bus_probe_device+0x94/0x9c
bus_probe_device from deferred_probe_work_func+0x88/0xb4
r7:00000000 r6:c1814c00 r5:c1814bec r4:c21b3810
deferred_probe_work_func from process_one_work+0x21c/0x548
r7:c202c000 r6:c2006a00 r5:c23e8380 r4:c1814c14
process_one_work from worker_thread+0x27c/0x5ac
r10:00000088 r9:c2006a00 r8:c1703d40 r7:c2006a1c r6:c23e8398 r5:c2006a00
r4:c23e8380
worker_thread from kthread+0x100/0x120
r10:00000000 r9:df831e7c r8:c23ed0c0 r7:c23e8380 r6:c014bcfc r5:c23ed000
r4:c21e4b40
kthread from ret_from_fork+0x14/0x2c
Exception stack(0xdf989fb0 to 0xdf989ff8)
9fa0:                                     00000000 00000000 00000000
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01539f4 r4:c23ed000
Code: bad PC value
---[ end trace 0000000000000000 ]---


-- 
Best regards,
Dmitry
