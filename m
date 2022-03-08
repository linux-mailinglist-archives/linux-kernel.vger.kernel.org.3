Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8644D1870
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiCHM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiCHM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:57:28 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8847547;
        Tue,  8 Mar 2022 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646744168;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=N0uiBZn2X99YIa2R7oMyRvvyodifjNHPrFhmT4qjKWM=;
    b=dj1V3bPdkot3GmVUYUhCbuoNjRI8Gx2vEUwy//jdJqSnGV25/iIONM2DvcyLAEF1SZ
    WYjSiZgord8ZWkOSRDMXxMguy5dNNbiAlKb7jhBNC3E9x5J8lct1TEepJTRpT/kKt5HK
    oxK7+4wKEdanbKnppoUnClrF5qtmrfGGSVRe+sbLUBZnvBQVx2jfgHFzACdU9YD6hI4I
    b4eIH/h3Tevc32f7bq+KsyNU6BS/PSCjNwh6u25ELOu8v/iCeWlLonHqbTPY4/evUyOY
    hXHbnWzCvZVmyO8EWUlZfpj1f8ds1IttJ78zgWQjM4pv/RZIwNWQ65zSp/EAMyNXiTQT
    y/tA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbpc9Y="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey28Cu7SHj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Mar 2022 13:56:07 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Rob Herring <robh@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] partially Revert "usb: musb: Set the DT node on the child device"
Date:   Tue,  8 Mar 2022 13:56:06 +0100
Message-Id: <f62f5fc11f9ecae7e57f3fd66939e051bd3b11fc.1646744166.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the omap2430 changes of

commit cf081d009c44 ("usb: musb: Set the DT node on the child device")

Since v5.17-rc1, musb is broken on the gta04 and openpandora devices
(omap3530/dm3730). BeagleBone Black (am335x) seems to work.

Symptoms of this bug are

a) main symptom

[   21.336517] using random host ethernet address
[   21.341430] using host ethernet address: 32:70:05:18:ff:78
[   21.341461] using self ethernet address: 46:10:3a:b3:af:d9
[   21.358184] usb0: HOST MAC 32:70:05:18:ff:78
[   21.376678] usb0: MAC 46:10:3a:b3:af:d9
[   21.388305] using random self ethernet address
[   21.393371] using random host ethernet address
[   21.398162] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   21.421081] g_ether gadget: g_ether ready
[   21.492156] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   21.691345] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   21.803192] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   21.819427] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   22.124450] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   22.168518] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   22.179382] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.213592] musb-hdrc musb-hdrc.1.auto: pm runtime get failed in musb_gadget_queue
[   23.221832] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.227905] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.239440] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.401000] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.407073] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.426361] musb-hdrc musb-hdrc.1.auto: Could not enable: -22
[   23.734466] musb-hdrc musb-hdrc.1.auto: pm runtime get failed in musb_gadget_queue
[   23.742462] musb-hdrc musb-hdrc.1.auto: pm runtime get failed in musb_gadget_queue
[   23.750396] musb-hdrc musb-hdrc.1.auto: pm runtime get failed in musb_gadget_queue
... (repeats with high frequency)

This stops if the USB cable is unplugged and restarts if it is plugged in again.

b) also found in the log

[    6.498107] ------------[ cut here ]------------
[    6.502960] WARNING: CPU: 0 PID: 868 at arch/arm/mach-omap2/omap_hwmod.c:1885 _enable+0x50/0x234
[    6.512207] omap_hwmod: usb_otg_hs: enabled state can only be entered from initialized, idle, or disabled state
[    6.522766] Modules linked in: omap2430(+) bmp280_i2c bmp280 itg3200 at24 tsc2007 leds_tca6507 bma180 hmc5843_i2c hmc5843_core industrialio_triggered_buffer lis3lv02d_i2c kfifo_buf lis3lv02d phy_twl4030_usb snd_soc_omap_mcbsp snd_soc_ti_sdma musb_hdrc snd_soc_twl4030 gnss_sirf twl4030_vibra twl4030_madc twl4030_charger twl4030_pwrbutton gnss industrialio ehci_omap omapdrm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm drm_panel_orientation_quirks cec
[    6.566436] CPU: 0 PID: 868 Comm: udevd Not tainted 5.16.0-rc5-letux+ #8251
[    6.573730] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    6.580322] [<c010ed30>] (unwind_backtrace) from [<c010a1d0>] (show_stack+0x10/0x14)
[    6.588470] [<c010a1d0>] (show_stack) from [<c0897c14>] (dump_stack_lvl+0x40/0x4c)
[    6.596405] [<c0897c14>] (dump_stack_lvl) from [<c0130cc4>] (__warn+0xb4/0xdc)
[    6.604003] [<c0130cc4>] (__warn) from [<c0130d5c>] (warn_slowpath_fmt+0x70/0x9c)
[    6.611846] [<c0130d5c>] (warn_slowpath_fmt) from [<c011f4d4>] (_enable+0x50/0x234)
[    6.619903] [<c011f4d4>] (_enable) from [<c012081c>] (omap_hwmod_enable+0x28/0x40)
[    6.627838] [<c012081c>] (omap_hwmod_enable) from [<c0120ff4>] (omap_device_enable+0x4c/0x78)
[    6.636779] [<c0120ff4>] (omap_device_enable) from [<c0121030>] (_od_runtime_resume+0x10/0x3c)
[    6.645812] [<c0121030>] (_od_runtime_resume) from [<c05c688c>] (__rpm_callback+0x3c/0xf4)
[    6.654510] [<c05c688c>] (__rpm_callback) from [<c05c6994>] (rpm_callback+0x50/0x54)
[    6.662628] [<c05c6994>] (rpm_callback) from [<c05c66b0>] (rpm_resume+0x448/0x4e4)
[    6.670593] [<c05c66b0>] (rpm_resume) from [<c05c6784>] (__pm_runtime_resume+0x38/0x50)
[    6.678985] [<c05c6784>] (__pm_runtime_resume) from [<bf14ab20>] (musb_init_controller+0x350/0xa5c [musb_hdrc])
[    6.689727] [<bf14ab20>] (musb_init_controller [musb_hdrc]) from [<c05bccb8>] (platform_probe+0x58/0xa8)
[    6.699737] [<c05bccb8>] (platform_probe) from [<c05badf0>] (really_probe+0x170/0x2fc)
[    6.708068] [<c05badf0>] (really_probe) from [<c05bb040>] (__driver_probe_device+0xc4/0xd8)
[    6.716827] [<c05bb040>] (__driver_probe_device) from [<c05bb084>] (driver_probe_device+0x30/0xac)
[    6.726226] [<c05bb084>] (driver_probe_device) from [<c05bb3d0>] (__device_attach_driver+0x94/0xb4)
[    6.735717] [<c05bb3d0>] (__device_attach_driver) from [<c05b93f8>] (bus_for_each_drv+0xa0/0xb4)
[    6.744934] [<c05b93f8>] (bus_for_each_drv) from [<c05bb248>] (__device_attach+0xc0/0x134)
[    6.753631] [<c05bb248>] (__device_attach) from [<c05b9fcc>] (bus_probe_device+0x28/0x80)
[    6.762207] [<c05b9fcc>] (bus_probe_device) from [<c05b7e40>] (device_add+0x5fc/0x788)
[    6.770507] [<c05b7e40>] (device_add) from [<c05bd240>] (platform_device_add+0x70/0x1bc)
[    6.779022] [<c05bd240>] (platform_device_add) from [<bf177830>] (omap2430_probe+0x260/0x2d4 [omap2430])
[    6.789001] [<bf177830>] (omap2430_probe [omap2430]) from [<c05bccb8>] (platform_probe+0x58/0xa8)
[    6.798309] [<c05bccb8>] (platform_probe) from [<c05badf0>] (really_probe+0x170/0x2fc)
[    6.806610] [<c05badf0>] (really_probe) from [<c05bb040>] (__driver_probe_device+0xc4/0xd8)
[    6.815399] [<c05bb040>] (__driver_probe_device) from [<c05bb084>] (driver_probe_device+0x30/0xac)
[    6.824798] [<c05bb084>] (driver_probe_device) from [<c05bb4b4>] (__driver_attach+0xc4/0xd8)
[    6.833648] [<c05bb4b4>] (__driver_attach) from [<c05b9308>] (bus_for_each_dev+0x64/0xa0)
[    6.842224] [<c05b9308>] (bus_for_each_dev) from [<c05ba248>] (bus_add_driver+0x148/0x1a4)
[    6.850891] [<c05ba248>] (bus_add_driver) from [<c05bbd1c>] (driver_register+0xb4/0xf8)
[    6.859313] [<c05bbd1c>] (driver_register) from [<c0101f54>] (do_one_initcall+0x90/0x1c8)
[    6.867889] [<c0101f54>] (do_one_initcall) from [<c0893968>] (do_init_module+0x4c/0x204)
[    6.876373] [<c0893968>] (do_init_module) from [<c01b4c30>] (load_module+0x13f0/0x1928)
[    6.884796] [<c01b4c30>] (load_module) from [<c01b53a0>] (sys_finit_module+0xa0/0xc0)
[    6.893005] [<c01b53a0>] (sys_finit_module) from [<c0100080>] (ret_fast_syscall+0x0/0x54)
[    6.901580] Exception stack(0xc2807fa8 to 0xc2807ff0)
[    6.906890] 7fa0:                   b6e517d4 00052068 00000006 b6e509f8 00000000 b6e5131c
[    6.915466] 7fc0: b6e517d4 00052068 cd718000 0000017b 00020000 00037f78 00050048 00063368
[    6.924011] 7fe0: bed8fef0 bed8fee0 b6e4ac4b b6f55a42
[    6.929321] ---[ end trace d715ff121b58763c ]---

c) git bisect result on testing for "musb-hdrc" in the console log:

cf081d009c447647c6b36aced535ca427dbebe72 is the first bad commit
commit cf081d009c447647c6b36aced535ca427dbebe72
Author: Rob Herring <robh@kernel.org>
Date:   Wed Dec 15 17:07:57 2021 -0600

  usb: musb: Set the DT node on the child device

  The musb glue drivers just copy the glue resources to the musb child device.
  Instead, set the musb child device's DT node pointer to the parent device's
  node so that platform_get_irq_byname() can find the resources in the DT.
  This removes the need for statically populating the IRQ resources from the
  DT which has been deprecated for some time.

  Signed-off-by: Rob Herring <robh@kernel.org>
  Link: https://lore.kernel.org/r/20211215230756.2009115-3-robh@kernel.org
  Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

drivers/usb/musb/am35x.c    | 2 ++
drivers/usb/musb/da8xx.c    | 2 ++
drivers/usb/musb/jz4740.c   | 1 +
drivers/usb/musb/mediatek.c | 2 ++
drivers/usb/musb/omap2430.c | 1 +
drivers/usb/musb/ux500.c    | 1 +
6 files changed, 9 insertions(+)

Reverting this patch makes musb work again as before.

Fixes: cf081d009c44 ("usb: musb: Set the DT node on the child device")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/usb/musb/omap2430.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 7d4d0713f4f0..d2b7e613eb34 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -327,7 +327,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
 	musb->dev.coherent_dma_mask	= omap2430_dmamask;
-	device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-- 
2.33.0

