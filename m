Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574754C355
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiFOISI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiFOISF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:18:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D23C8275DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:18:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFBA7139F;
        Wed, 15 Jun 2022 01:18:03 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56F2C3F792;
        Wed, 15 Jun 2022 01:18:02 -0700 (PDT)
Date:   Wed, 15 Jun 2022 09:17:52 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Message-ID: <YqmVsMGgxKuIT5rx@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:45:11AM +0200, Florian Fainelli wrote:
> 
> 
> On 3/30/2022 5:05 PM, Cristian Marussi wrote:
> > Using the common protocol helper implementation add support for all new
> > SCMIv3.1 extended names commands related to all protocols with the
> > exception of SENSOR_AXIS_GET_NAME.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> This causes the following splat on a platform where regulators fail to
> initialize:
> 

Hi Florian,

thanks for the report.

It seems a memory error while allocating so it was not meant to be
solved by the fixes, anyway, I've never seen this splat in my testing
and at first sight I cannot see anything wrong in the devm_k* calls
inside scmi_voltage_protocol_init...is there any particular config in
your setup ?

Moreover, the WARNING line 5402 seems to match v5.19-rc1 and it has
slightly changed with -rc-1, so I'll try rebasing on that at first and
see if I can reproduce the issue locally.

Thanks,
Cristian

> [    0.603737] ------------[ cut here ]------------
> [    0.603752] WARNING: CPU: 1 PID: 1 at mm/page_alloc.c:5402
> __alloc_pages+0x6c/0x184
> [    0.603797] Modules linked in:
> [    0.603809] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.19.0-rc1-g44dbdf3bb3f4 #42
> [    0.603818] Hardware name: BCX972160SV (DT)
> [    0.603825] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    0.603834] pc : __alloc_pages+0x6c/0x184
> [    0.603841] lr : kmalloc_order+0x40/0x88
> [    0.603851] sp : ffffffc00a40b850
> [    0.603856] x29: ffffffc00a40b850 x28: 0000000000000000 x27:
> ffffffc008d60404
> [    0.603867] x26: ffffff80c1e3e1a8 x25: ffffffc00877bd78 x24:
> 0000000000000058
> [    0.603878] x23: ffffffc0081921a8 x22: ffffffc008cb04b0 x21:
> 0000000000000000
> [    0.603889] x20: 000000000000000b x19: 000000000000000b x18:
> 0000000000000000
> [    0.603900] x17: 0000000000000001 x16: 0000000100000000 x15:
> 000000000000000a
> [    0.603911] x14: 0000000000000000 x13: ffffff80c1e3c20a x12:
> ffffffffffffffff
> [    0.603922] x11: 0000000000000020 x10: 0000000000000880 x9 :
> ffffffc008159dac
> [    0.603932] x8 : ffffff80c02708e0 x7 : 0000000000000004 x6 :
> 000000000041a880
> [    0.603943] x5 : 0000000000000001 x4 : ffffff8000000000 x3 :
> 0000000000000000
> [    0.603954] x2 : 0000000000000000 x1 : 0000000000000001 x0 :
> ffffffc00a32d3f2
> [    0.603965] Call trace:
> [    0.603970]  __alloc_pages+0x6c/0x184
> [    0.603977]  kmalloc_order+0x40/0x88
> [    0.603984]  kmalloc_order_trace+0x30/0xd0
> [    0.603992]  __kmalloc_track_caller+0x64/0x19c
> [    0.603999]  devm_kmalloc+0x5c/0xe0
> [    0.604009]  scmi_voltage_protocol_init+0x14c/0x2f4
> [    0.604020]  scmi_get_protocol_instance+0x128/0x1f4
> [    0.604030]  scmi_devm_protocol_get+0x64/0xc8
> [    0.604037]  scmi_regulator_probe+0x5c/0x42c
> [    0.604049]  scmi_dev_probe+0x28/0x38
> [    0.604056]  really_probe+0x1b8/0x380
> [    0.604065]  __driver_probe_device+0x14c/0x164
> [    0.604073]  driver_probe_device+0x48/0xe0
> [    0.604080]  __driver_attach+0x160/0x170
> [    0.604087]  bus_for_each_dev+0x78/0xb8
> [    0.604095]  driver_attach+0x28/0x30
> [    0.604101]  bus_add_driver+0xf4/0x208
> [    0.604108]  driver_register+0xb4/0xf0
> [    0.604116]  scmi_driver_register+0x5c/0xa4
> [    0.604123]  scmi_drv_init+0x28/0x30
> [    0.604132]  do_one_initcall+0x80/0x1a4
> [    0.604141]  kernel_init_freeable+0x220/0x23c
> [    0.604149]  kernel_init+0x28/0x128
> [    0.604158]  ret_from_fork+0x10/0x20
> [    0.604166] ---[ end trace 0000000000000000 ]---
> [    0.604194] scmi-regulator: probe of scmi_dev.2 failed with error -12
> [    0.604792] arm-scmi brcm_scmi@0: Failed. SCMI protocol 22 not active.
> -- 
> Florian
