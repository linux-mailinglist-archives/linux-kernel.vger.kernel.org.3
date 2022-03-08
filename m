Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB87A4D189E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbiCHNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbiCHNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:04:50 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C503A72F;
        Tue,  8 Mar 2022 05:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646744618;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=l1dgMSGICGJL3G77F/MPWlIsjBwTBpqOBLaKyLXW79w=;
    b=DmqrWWPHGZ8QJ4BswwQFN7jzgi05Pb8UnZ/RgxewGrLoUgORkbaOzhaOAuX0r/t0S6
    TZvDK8VF4xDrgBN35MWNaCs2pHbQ9eARMTI//y7m5UjxKgc48zXUtyVA5n3uFgHV4EFH
    vRP4fJdxRN/4+yCXpqXxwfxFCDOOCefu1pzJPWyymCy2uisk7vaB36hfbyOKrcrDyXf+
    nTgTzmg8Vf12SEVI/JwsiXncQfD5ZKDtiP4qpKX1NrryTaS/ZwKUMiM0zhkaYnkoP1Bk
    fITk2JtEpe8S0fW+v6W1KTCi5Tcoj8uY/fMkLb9R3PBAhkPktpdGEyDcpzxokx29KcZZ
    X/PQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbpc9Y="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey28D3cSKb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Mar 2022 14:03:38 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm
Date:   Tue,  8 Mar 2022 14:03:37 +0100
Message-Id: <af3b750dc2265d875deaabcf5f80098c9645da45.1646744616.git.hns@goldelico.com>
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

Usually, the vbus_regulator (smps10 on omap5evm) boots up disabled.

Hence calling regulator_disable() indirectly through dwc3_omap_set_mailbox()
during probe leads to:

[   10.332764] WARNING: CPU: 0 PID: 1628 at drivers/regulator/core.c:2853 _regulator_disable+0x40/0x164
[   10.351919] unbalanced disables for smps10_out1
[   10.361298] Modules linked in: dwc3_omap(+) clk_twl6040 at24 gpio_twl6040 palmas_gpadc palmas_pwrbutton
industrialio snd_soc_omap_mcbsp(+) snd_soc_ti_sdma display_connector ti_tpd12s015 drm leds_gpio
drm_panel_orientation_quirks ip_tables x_tables ipv6 autofs4
[   10.387818] CPU: 0 PID: 1628 Comm: systemd-udevd Not tainted 5.17.0-rc1-letux-lpae+ #8139
[   10.405129] Hardware name: Generic OMAP5 (Flattened Device Tree)
[   10.411455]  unwind_backtrace from show_stack+0x10/0x14
[   10.416970]  show_stack from dump_stack_lvl+0x40/0x4c
[   10.422313]  dump_stack_lvl from __warn+0xb8/0x170
[   10.427377]  __warn from warn_slowpath_fmt+0x70/0x9c
[   10.432595]  warn_slowpath_fmt from _regulator_disable+0x40/0x164
[   10.439037]  _regulator_disable from regulator_disable+0x30/0x64
[   10.445382]  regulator_disable from dwc3_omap_set_mailbox+0x8c/0xf0 [dwc3_omap]
[   10.453116]  dwc3_omap_set_mailbox [dwc3_omap] from dwc3_omap_probe+0x2b8/0x394 [dwc3_omap]
[   10.467021]  dwc3_omap_probe [dwc3_omap] from platform_probe+0x58/0xa8
[   10.481762]  platform_probe from really_probe+0x168/0x2fc
[   10.481782]  really_probe from __driver_probe_device+0xc4/0xd8
[   10.481782]  __driver_probe_device from driver_probe_device+0x24/0xa4
[   10.503762]  driver_probe_device from __driver_attach+0xc4/0xd8
[   10.510018]  __driver_attach from bus_for_each_dev+0x64/0xa0
[   10.516001]  bus_for_each_dev from bus_add_driver+0x148/0x1a4
[   10.524880]  bus_add_driver from driver_register+0xb4/0xf8
[   10.530678]  driver_register from do_one_initcall+0x90/0x1c4
[   10.536661]  do_one_initcall from do_init_module+0x4c/0x200
[   10.536683]  do_init_module from load_module+0x13dc/0x1910
[   10.551159]  load_module from sys_finit_module+0xc8/0xd8
[   10.561319]  sys_finit_module from __sys_trace_return+0x0/0x18
[   10.561336] Exception stack(0xc344bfa8 to 0xc344bff0)
[   10.561341] bfa0:                   b6fb5778 b6fab8d8 00000007 b6ecfbb8 00000000 b6ed0398
[   10.561341] bfc0: b6fb5778 b6fab8d8 855c0500 0000017b 00020000 b6f9a3cc 00000000 b6fb5778
[   10.595500] bfe0: bede18f8 bede18e8 b6ec9aeb b6dda1c2
[   10.601345] ---[ end trace 0000000000000000 ]---

Fix this unnecessary warning by checking if the regulator is enabled.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index e196673f5c64..efaf0db595f4 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -242,7 +242,7 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		break;
 
 	case OMAP_DWC3_ID_FLOAT:
-		if (omap->vbus_reg)
+		if (omap->vbus_reg && regulator_is_enabled(omap->vbus_reg))
 			regulator_disable(omap->vbus_reg);
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG;
-- 
2.33.0

