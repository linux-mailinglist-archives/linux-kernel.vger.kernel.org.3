Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B856AC04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiGGToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiGGToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:44:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2742B61F;
        Thu,  7 Jul 2022 12:44:05 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8C8666019C3;
        Thu,  7 Jul 2022 20:44:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657223044;
        bh=s9q09bnLdROpMqyLMBUQhz0ijZlXdUM75kjg46rBmj0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BAMNb3hntq6N1YVAjYdQILoHglcKsMGJ4YA0mWQQxERAplRBE0k4Vxl03rjeB8BJF
         SG1siIM+tVhWqAkEMtG8/INZusv1xXwAHmcm1YueWr78NVCtv/GbKWC8BIUfVZ7w/g
         rxhuHUTrNuOLIXzpd89kZyGwy9UbgCOERVk/rlD+Au7VOSIw+gFiXzA3wadr6/WI2t
         enzYcVhkpnc7uRlUKvvB1xfGO/xyJeBmQWVGbFUrcUbJxj/KrCjoXnxaAmbXJ2EedE
         P+P+apJpW9WIrNRSKJLkz8feDH/F9WuM5/wkVegaSeOhMYo1huyPHbjb2y6XTZJ68i
         nz7CaB0OKpCuA==
Message-ID: <d557bbd0-2afb-12dc-1287-1aeb44ef55f5@collabora.com>
Date:   Thu, 7 Jul 2022 22:43:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
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

On 7/5/22 10:00, Viresh Kumar wrote:
> Hello,
> 
> This patchset adds support for devices with multiple clocks. None of the clocks
> is considered primary in this case and all are handled equally.
> 
> The drivers, for multiple clock case, are expected to call dev_pm_opp_set_opp()
> to set the specific OPP. Though how they find the target OPP is left for the
> users to handle. For some, we may have another unique OPP property, like level,
> which can be used to find the OPP. While in case of others, we may want to
> implement freq-based OPP finder APIs for multiple clock rates. I have decided
> not to implement them in advance, and add them only someone wants to use them.
> 
> This is rebased over a lot of other OPP changes and is pushed here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> 
> V1->V2:
> 
> - Fix broken git bisect for:
>   OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
> 
> - Include binding changes written by Krzysztof earlier.
> 
> - Check config_clks before calling it, it isn't always set.
> 
> - Add config_clks for Tegra30's devfreq to handle its corner case.
> 
> - _opp_compare_key() supports multi-clk case now, earlier it skipped freq
>   comparison for such a case.
> 
> - New patch to compare all bandwidth values as well in _opp_compare_key().
> 
> - New patch to remove *_noclk() interface.
> 
> - Various other minor fixes.
> 
> --
> Viresh
> 
> Krzysztof Kozlowski (1):
>   dt-bindings: opp: accept array of frequencies
> 
> Viresh Kumar (12):
>   OPP: Use consistent names for OPP table instances
>   OPP: Remove rate_not_available parameter to _opp_add()
>   OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
>   OPP: Make dev_pm_opp_set_opp() independent of frequency
>   OPP: Allow multiple clocks for a device
>   OPP: Compare bandwidths for all paths in _opp_compare_key()
>   OPP: Add key specific assert() method to key finding helpers
>   OPP: Assert clk_count == 1 for single clk helpers
>   OPP: Provide a simple implementation to configure multiple clocks
>   OPP: Allow config_clks helper for single clk case
>   PM / devfreq: tegra30: Register config_clks helper

Hello Viresh,

This patch breaks Tegra again, please take a look:

   OPP: Remove dev{m}_pm_opp_of_add_table_noclk()

 8<--- cut here ---
 Unable to handle kernel paging request at virtual address ffffffff
 [ffffffff] *pgd=9effd861, *pte=00000000, *ppte=00000000
 Internal error: Oops: 37 [#1] PREEMPT SMP ARM
 Modules linked in:
 CPU: 3 PID: 8 Comm: kworker/u8:0 Not tainted
5.19.0-rc1-00040-g30b62d123f4f #82
 Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
 Workqueue: events_unbound deferred_probe_work_func
 PC is at _opp_compare_key+0x40/0xc4
 LR is at 0xfffffffb
 pc : [<c0b91b54>]    lr : [<fffffffb>]    psr: 20000113
 sp : df831b08  ip : c33cd4d0  fp : df831b24
 r10: c2586078  r9 : c258606c  r8 : 00000000
 r7 : 00000000  r6 : 00000001  r5 : c33cd480  r4 : c2586000
 r3 : 00000000  r2 : c33cd480  r1 : c258606c  r0 : c2586000
 Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
 Control: 10c5387d  Table: 8000404a  DAC: 00000051
...
 Backtrace:
  _opp_compare_key from _set_opp+0x80/0x408
  r7:00000000 r6:c27c0010 r5:c33cd480 r4:c2586000
  _set_opp from dev_pm_opp_set_opp+0x74/0xdc
  r10:00000001 r9:000f4240 r8:c33b6840 r7:c33b6840 r6:c33cd480 r5:c27c0010
  r4:c2586000
  dev_pm_opp_set_opp from tegra_pmc_core_pd_set_performance_state+0x54/0xbc
  r6:c33b6840 r5:c1a21760 r4:c33cd480
  tegra_pmc_core_pd_set_performance_state from
_genpd_set_performance_state+0x1f0/0x280
  r6:c33b6b58 r5:c33b6b48 r4:000f4240
  _genpd_set_performance_state from _genpd_set_performance_state+0xb4/0x280
  r10:00000001 r9:000f4240 r8:c33b9800 r7:c33b6840 r6:c33b9b18 r5:c33d0040
  r4:000f4240
  _genpd_set_performance_state from genpd_set_performance_state+0xb8/0xd4
  r10:c33b9a98 r9:c33d0400 r8:00000000 r7:00000000 r6:c33b9800 r5:00000000
  r4:c33d0400
  genpd_set_performance_state from genpd_runtime_resume+0x22c/0x240
  r5:00000000 r4:c27c0810
  genpd_runtime_resume from __rpm_callback+0x4c/0x1ac
  r10:c27ba8bc r9:00000000 r8:c27c0960 r7:c27c08cc r6:c27ba800 r5:c09611b8
  r4:c27c0810
  __rpm_callback from rpm_callback+0x60/0x64
  r9:df831ce4 r8:c27c0960 r7:00000004 r6:c27ba800 r5:c09611b8 r4:c27c0810
  rpm_callback from rpm_resume+0x480/0x7e0
  r7:00000004 r6:c27ba800 r5:c09611b8 r4:c27c0810
  rpm_resume from __pm_runtime_resume+0x58/0xb0
  r10:00000000 r9:c2587194 r8:c2587210 r7:c27c0810 r6:c27c08cc r5:60000113
  r4:c27c0810
  __pm_runtime_resume from host1x_probe+0x3d4/0x6d4
  r7:c27c0810 r6:c27c0800 r5:00000000 r4:c2587040
  host1x_probe from platform_probe+0x6c/0xc0
  r10:c191438c r9:c1aa8e20 r8:0000000d r7:c27c0810 r6:c1a2d354 r5:c27c0810
  r4:00000000
  platform_probe from really_probe.part.0+0xac/0x2c0
  r7:c27c0810 r6:c1a2d354 r5:c27c0810 r4:00000000
  really_probe.part.0 from __driver_probe_device+0xb8/0x14c
  r7:c27c0810 r6:c1a2d354 r5:00000000 r4:c27c0810
  __driver_probe_device from driver_probe_device+0x44/0x11c
  r7:c27c0810 r6:c27c0810 r5:c2137c58 r4:c2137c54
  driver_probe_device from __device_attach_driver+0xc8/0x10c
  r9:c1aa8e20 r8:c242c000 r7:00000000 r6:c27c0810 r5:df831e6c r4:c1a2d354
  __device_attach_driver from bus_for_each_drv+0x90/0xdc
  r7:00000000 r6:c09440f8 r5:df831e6c r4:00000000
  bus_for_each_drv from __device_attach+0xbc/0x1d4
  r6:c27c0854 r5:00000001 r4:c27c0810
  __device_attach from device_initial_probe+0x1c/0x20
  r6:c1a30df8 r5:c27c0810 r4:c27c0810
  device_initial_probe from bus_probe_device+0x98/0xa0
  bus_probe_device from deferred_probe_work_func+0x8c/0xbc
  r7:00000000 r6:c1a309e8 r5:c1a3099c r4:c27c0810
  deferred_probe_work_func from process_one_work+0x2b8/0x774
  r7:c25c8000 r6:c2407000 r5:c2557480 r4:c1a309f8
  process_one_work from worker_thread+0x17c/0x56c
  r10:00000088 r9:c25c8000 r8:c1905d40 r7:c240703c r6:c2557498 r5:c2407000
  r4:c2557480
  worker_thread from kthread+0x108/0x13c
  r10:00000000 r9:df815e2c r8:c2557500 r7:c2557480 r6:c0151924 r5:c25c8000
  r4:c2554540
  kthread from ret_from_fork+0x14/0x28
 Exception stack(0xdf831fb0 to 0xdf831ff8)
 1fa0:                                     00000000 00000000 00000000
00000000
 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c015ba68 r4:c2554540
 Code: e24cc004 ea000001 e1530006 0a000007 (e5be5004)
 ---[ end trace 0000000000000000 ]---


-- 
Best regards,
Dmitry
