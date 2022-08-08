Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826C58C954
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiHHNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiHHNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:24:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944E38B9;
        Mon,  8 Aug 2022 06:24:52 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A358022249;
        Mon,  8 Aug 2022 15:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659965090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jzINkXkKO8yNQwlFkJkH6eqYaw2VLPf7TS2uMiTSJg=;
        b=OkNMnNLO21IRliCtlkiyYpbBtAGZ0wSPkjdtyDDGvmm3hcOd3iAqmrLBbGnoxbWDZmkhkl
        o19vfLdffgCI64RpEQt6IsAl1Wl4iC9kmGBcTqf6tlZAZQC8+h7qNcKMkW1CUylhb6jEIy
        jUJ4eyA8a8OyzLClWO8g35uAZcTwdGQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 15:24:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5 00/33] New thermal OF code
In-Reply-To: <cd4fef23-15b3-15ab-8125-91860bd83315@linaro.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <cd4fef23-15b3-15ab-8125-91860bd83315@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8a979d0fcab90f4d5ffee95f322c5ace@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 2022-08-08 15:09, schrieb Daniel Lezcano:
> Does this fix solves this first issue ?
> 
> https://lore.kernel.org/all/YvDzovkMCQecPDjz@kili/

Unfortunately not, it is still the same:

[    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
[    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
[    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error -22
[    1.934189] Unable to handle kernel paging request at virtual address 
01adadadadadad88
[    1.942146] Mem abort info:
[    1.944948]   ESR = 0x0000000096000004
[    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.954042]   SET = 0, FnV = 0
[    1.957107]   EA = 0, S1PTW = 0
[    1.960253]   FSC = 0x04: level 0 translation fault
[    1.965147] Data abort info:
[    1.968030]   ISV = 0, ISS = 0x00000004
[    1.971878]   CM = 0, WnR = 0
[    1.974852] [01adadadadadad88] address between user and kernel 
address ranges
[    1.982016] Internal error: Oops: 96000004 [#1] SMP
[    1.986907] Modules linked in:
[    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
5.19.0-next-20220808-00080-g1c46f44502e0 #1697
[    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
[    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    2.011185] pc : kfree+0x5c/0x3c0
[    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
[    2.019761] sp : ffff80000a22bad0
[    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: 
ffff800009960464
[    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: 
ffff800009f09a40
[    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 
01adadadadadad80
[    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 
00000000fffffffb
[    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: 
ffff800008d0d154
[    2.056647] usb 1-1: new high-speed USB device number 2 using 
xhci-hcd
[    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: 
ffff8000088d5034
[    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : 
ffff800008d0eea8
[    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : 
ffff80000a0f53b8
[    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 
0000000000000000
[    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 
01adb1adadadad80
[    2.101244] Call trace:
[    2.103692]  kfree+0x5c/0x3c0
[    2.106666]  devm_thermal_of_zone_release+0x38/0x60
[    2.111561]  release_nodes+0x64/0xd0
[    2.115146]  devres_release_all+0xbc/0x350
[    2.119253]  device_unbind_cleanup+0x20/0x70
[    2.123536]  really_probe+0x1a0/0x2e4
[    2.127208]  __driver_probe_device+0x80/0xec
[    2.131490]  driver_probe_device+0x44/0x130
[    2.135685]  __driver_attach+0x104/0x1b4
[    2.139619]  bus_for_each_dev+0x7c/0xe0
[    2.143465]  driver_attach+0x30/0x40
[    2.147048]  bus_add_driver+0x160/0x210
[    2.150894]  driver_register+0x84/0x140
[    2.154741]  __platform_driver_register+0x34/0x40
[    2.159461]  qoriq_tmu_init+0x28/0x34
[    2.163133]  do_one_initcall+0x50/0x250
[    2.166979]  kernel_init_freeable+0x278/0x31c
[    2.171349]  kernel_init+0x30/0x140
[    2.174847]  ret_from_fork+0x10/0x20
[    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
[    2.184546] ---[ end trace 0000000000000000 ]---
[    2.189188] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    2.196869] SMP: stopping secondary CPUs
[    2.200803] Kernel Offset: disabled
[    2.204296] CPU features: 0x2000,0800f021,00001086
[    2.209100] Memory Limit: none
[    2.212158] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b ]---

-michael
