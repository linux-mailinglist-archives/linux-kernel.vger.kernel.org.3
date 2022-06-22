Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F83554C94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353487AbiFVOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358160AbiFVOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:15:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CE63A72E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:15:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso13542249pjn.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUm+qbvggOOIU8QNOfGeCKHl5m47NZXFeW6MN5yOfEM=;
        b=PyhYKk+zZUXiePZXZZFxwVzuirShTXiZ7dU+3gesFMQgdTTGKBcVLcrxUXffBFWX07
         JNPopssrUnNQl+uX8IGZCyQiJ38UleMekm56S1XyGBysOVNRnqgcf4KxIuAulVSYbr0v
         TLhi52EJ8DwJDF4RQwRmGGKcW8rWGGAUs81HmNxlv8Gacbr6ezhM9KUU3XXsUHQ/jP1T
         RpsXk7X2+1g1pDbxppoQJ3heA32qX7UK6JYupDgEH6VYSyRuWCUHIytKMQAgYzwJlPcm
         aoQCEYFAxxzgZjkLoezP1xz8YskREF9XAJUeQ82CpKJs/dq0nPVwLq46YxVGv9lLGDwo
         Ar7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUm+qbvggOOIU8QNOfGeCKHl5m47NZXFeW6MN5yOfEM=;
        b=WNYyWbSyRsZlBfN3yuIVLY2DPWypPYJ3sJE7UBe5+qFyYOgOle01bbchBZn7UiMGRj
         HgVk7LW3yvCL9Hr7K4c2B9XwG/8uAlixHYAud5KfkH8HgVrLUGPTNP8mhkbXjAcZkMEt
         4X9BNRGkDF8hD4UTGwtuNX02U0kuJAyb7fQrPWjkzWsBTSjCy3yHnpHVQLAcmztSUbqy
         SiA03chnV1LZzpjuXwiwIH7HQuLsosC/6jclx9LaczyMPn2V/DH7xHbNi96f+cxkWscn
         WyEwMXpcfxGXxtuNTJNW4ri5g1IoyDv/OI/QmwIe1dpMuBmHPWI4FsooCAXyd/F7pDF4
         x1Jg==
X-Gm-Message-State: AJIora91pn5K154fFp6MksJrhkafWLkTkAyDi6Uz4wZfukOolAqcr0z1
        gVwt3OSVB549I9Ow8sObw+ci1g==
X-Google-Smtp-Source: AGRyM1ta3nXBXgqW9Sg+eQZChpxKpYjCt/THBQJNjUJM5wAc6fNN6eLHGl2ZD3gRDvb14t+aQtZJoQ==
X-Received: by 2002:a17:902:e54f:b0:16a:29de:9603 with SMTP id n15-20020a170902e54f00b0016a29de9603mr14057526plf.46.1655907313654;
        Wed, 22 Jun 2022 07:15:13 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090ab39300b001ec87220fb9sm8645465pjr.16.2022.06.22.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:15:13 -0700 (PDT)
Date:   Wed, 22 Jun 2022 19:45:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-22, 14:47, Jon Hunter wrote:
> I am seeing the following panic on -next and bisect is point to
> this commit ...
> 
> [    2.145604] 8<--- cut here ---
> [    2.145615] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    2.145625] [00000000] *pgd=00000000
> [    2.145647] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
> [    2.145660] Modules linked in:
> [    2.145671] CPU: 1 PID: 35 Comm: kworker/u8:1 Not tainted 5.19.0-rc3-next-20220622-gf739bc2a47f6 #1
> [    2.145688] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [    2.145697] Workqueue: events_unbound deferred_probe_work_func
> [    2.145740] PC is at 0x0
> [    2.145750] LR is at _set_opp+0x194/0x380
> [    2.145779] pc : [<00000000>]    lr : [<c086b578>]    psr: 20000013
> [    2.145789] sp : f08f1c80  ip : c152cb40  fp : c264c040
> [    2.145798] r10: 00000000  r9 : c152cb40  r8 : c16f3010
> [    2.145806] r7 : c264c034  r6 : 00000000  r5 : c265d800  r4 : c264c000
> [    2.145815] r3 : 00000000  r2 : c265d800  r1 : c264c000  r0 : c16f3010
> [    2.145825] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    2.145840] Control: 10c5387d  Table: 8000404a  DAC: 00000051
> [    2.145847] Register r0 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
> [    2.145883] Register r1 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
> [    2.145914] Register r2 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
> [    2.145942] Register r3 information: NULL pointer
> [    2.145955] Register r4 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
> [    2.145983] Register r5 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
> [    2.146012] Register r6 information: NULL pointer
> [    2.146023] Register r7 information: slab kmalloc-256 start c264c000 pointer offset 52 size 256
> [    2.146052] Register r8 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
> [    2.146081] Register r9 information: slab task_struct start c152cb40 pointer offset 0
> [    2.146105] Register r10 information: NULL pointer
> [    2.146116] Register r11 information: slab kmalloc-256 start c264c000 pointer offset 64 size 256
> [    2.146146] Register r12 information: slab task_struct start c152cb40 pointer offset 0
> [    2.348527] Process kworker/u8:1 (pid: 35, stack limit = 0x(ptrval))
> [    2.354896] Stack: (0xf08f1c80 to 0xf08f2000)
> [    2.359273] 1c80: 00000001 c0868db0 00000000 7a13d783 c152cb40 c264c000 c16f3010 c265d800
> [    2.367471] 1ca0: c2661c40 00000001 c2661c40 00000001 c2661c40 c086b8e8 00000000 7a13d783
> [    2.375666] 1cc0: c12ea5a0 c265d800 000f4240 c058cfcc ef7dddec 000f4240 00000000 c2661e88
> [    2.383861] 1ce0: 000f4240 000f4240 c2661e98 c068d238 00000000 c2665e00 000f4240 000f4240
> [    2.392056] 1d00: c2666258 00000000 c2666000 00000001 c2661c40 c068d15c 00000000 c2666000
> [    2.400253] 1d20: c16fd140 00000000 c16fd140 00000000 00000000 c16b78b8 c16b5e00 c068d2d8
> [    2.408450] 1d40: c16b7810 c26661d8 c2666000 c068ed98 c2663d00 c2663d00 00000000 c086914c
> [    2.416647] 1d60: c2663d00 c16b7810 c068ebec c16b7894 00000004 c0174868 00000000 c16b78b8
> [    2.424843] 1d80: c16b5e00 c0684630 c16b7810 c068ebec 00000000 00000004 c0174868 c152cb40
> [    2.433041] 1da0: c16b78b8 c0684794 c16b7810 c068ebec 00000000 c068506c 00000a00 c265e040
> [    2.441237] 1dc0: c0f5bdd4 00000004 00000000 7a13d783 00000000 c16b7810 c16b7894 00000004
> [    2.449434] 1de0: 60000013 00000000 c265e10c c265e154 00000000 c06854c4 c265e040 c16b7800
> [    2.457629] 1e00: c16b7810 c152cb40 00000000 c05e42b0 00000001 00000000 ffffffff 00000000
> [    2.465824] 1e20: c16b7810 ff8067a4 01000000 7a13d783 c16b7810 c16b7810 00000000 c12f7700
> [    2.474020] 1e40: 00000000 00000001 c1367c20 c140f00d c1405800 c067a668 c16b7810 00000000
> [    2.482214] 1e60: c12f7700 c0678280 c16b7810 c12f7700 c16b7810 00000017 00000001 c06784e4
> [    2.490411] 1e80: c13b6754 f08f1ee4 c16b7810 c0678574 c12f7700 f08f1ee4 c16b7810 c152cb40
> [    2.498609] 1ea0: 00000001 c06788bc 00000000 f08f1ee4 c0678834 c067675c c1367c20 c14b4e70
> [    2.506804] 1ec0: c1ea60b8 7a13d783 c16b7810 c16b7810 c152cb40 c16b7854 c12fa050 c067810c
> [    2.515001] 1ee0: c1400000 c16b7810 00000001 7a13d783 c16b7810 c16b7810 c12fa2f0 c12fa050
> [    2.523197] 1f00: 00000000 c0677410 c16b7810 c12fa038 c12fa038 c06778d0 c12fa06c c176a180
> [    2.531394] 1f20: c1405800 c140f000 00000000 c013dd2c c152cb40 c1405800 c1203d40 c176a180
> [    2.539592] 1f40: c1405800 c140581c c1203d40 c176a198 00000088 c1367177 c1405800 c013e2a4
> [    2.547790] 1f60: c0f07434 00000000 f08f1f7c c176f7c0 c152cb40 c013e064 c176a180 c176f640
> [    2.555984] 1f80: f0831eb4 00000000 00000000 c01459b4 c176f7c0 c01458ac 00000000 00000000
> [    2.564180] 1fa0: 00000000 00000000 00000000 c01001a8 00000000 00000000 00000000 00000000
> [    2.572373] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.580569] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    2.588768]  _set_opp from dev_pm_opp_set_opp+0x38/0x78
> [    2.594038]  dev_pm_opp_set_opp from tegra_pmc_core_pd_set_performance_state+0x44/0xb0
> [    2.602010]  tegra_pmc_core_pd_set_performance_state from _genpd_set_performance_state+0x180/0x1d0
> [    2.611018]  _genpd_set_performance_state from _genpd_set_performance_state+0xa4/0x1d0
> [    2.618972]  _genpd_set_performance_state from genpd_set_performance_state+0x50/0x7c
> [    2.626752]  genpd_set_performance_state from genpd_runtime_resume+0x1ac/0x25c
> [    2.634016]  genpd_runtime_resume from __rpm_callback+0x38/0x14c
> [    2.640073]  __rpm_callback from rpm_callback+0x50/0x54
> [    2.645335]  rpm_callback from rpm_resume+0x394/0x7a0
> [    2.650424]  rpm_resume from __pm_runtime_resume+0x4c/0x64
> [    2.655947]  __pm_runtime_resume from host1x_probe+0x29c/0x654
> [    2.661824]  host1x_probe from platform_probe+0x5c/0xb8
> [    2.667080]  platform_probe from really_probe+0xc8/0x2a8
> [    2.672433]  really_probe from __driver_probe_device+0x84/0xe4
> [    2.678308]  __driver_probe_device from driver_probe_device+0x30/0xd0
> [    2.684789]  driver_probe_device from __device_attach_driver+0x88/0xb4
> [    2.691350]  __device_attach_driver from bus_for_each_drv+0x54/0xb4
> [    2.697647]  bus_for_each_drv from __device_attach+0xf0/0x194
> [    2.703430]  __device_attach from bus_probe_device+0x84/0x8c
> [    2.709129]  bus_probe_device from deferred_probe_work_func+0x7c/0xa8
> [    2.715608]  deferred_probe_work_func from process_one_work+0x214/0x54c
> [    2.722269]  process_one_work from worker_thread+0x240/0x508
> [    2.727960]  worker_thread from kthread+0x108/0x124
> [    2.732872]  kthread from ret_from_fork+0x14/0x2c
> [    2.737602] Exception stack(0xf08f1fb0 to 0xf08f1ff8)
> [    2.742669] 1fa0:                                     00000000 00000000 00000000 00000000
> [    2.750865] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.759061] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.765690] Code: bad PC value
> [    2.768990] ---[ end trace 0000000000000000 ]---
> 
> 
> Let me know if you have any thoughts.

Maybe I understand what's going on here now, Dmitry too reported this yesterday,
cc'd. Does below fix it for you ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c1ae1286376..a7c7f6f40a7e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1120,9 +1120,11 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
                }
        }

-       ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
-       if (ret)
-               return ret;
+       if (opp_table->config_clks) {
+               ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
+               if (ret)
+                       return ret;
+       }

        /* Scaling down? Configure required OPPs after frequency */
        if (scaling_down) {

-- 
viresh
