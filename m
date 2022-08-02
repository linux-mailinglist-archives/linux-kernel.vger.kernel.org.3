Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23B587C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiHBMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHBMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:39:42 -0400
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6B20BC2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:39:40 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oIrBR-0003Qp-Dc; Tue, 02 Aug 2022 14:39:37 +0200
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 272CdYrP002926
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 2 Aug 2022 14:39:35 +0200
Message-ID: <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
Date:   Tue, 2 Aug 2022 14:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
Content-Language: de-DE
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622003140.30365-1-pgwipeout@gmail.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
In-Reply-To: <20220622003140.30365-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1659443980;411e59fa;
X-HE-SMSGID: 1oIrBR-0003Qp-Dc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with linux-next-20220728 rk3399-roc-pc does not boot.
Bisecting pointed to this commit.
By reverting this commit the board boots again.

[    2.398700] Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000008
[    2.399517] Mem abort info:
[    2.399772]   ESR = 0x0000000096000004
[    2.400114]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.400594]   SET = 0, FnV = 0
[    2.400873]   EA = 0, S1PTW = 0
[    2.401161]   FSC = 0x04: level 0 translation fault
[    2.401602] Data abort info:
[    2.401864]   ISV = 0, ISS = 0x00000004
[    2.402212]   CM = 0, WnR = 0
[    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000001376000
[    2.403071] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[    2.403687] Internal error: Oops: 96000004 [#1] SMP
[    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd xhci_hcd 
dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_display_helper 
dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_hcd 
drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimgblt 
fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_quirks
[    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted 
5.19.0-rc8-next-20220728 #437
[    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
[    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
[    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
[    2.414332] lr : process_one_work+0x1d8/0x380
[    2.416948] sp : ffff800009373d60
[    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 0000000000000000
[    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000000000000c
[    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80000888ec10
[    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 0000000000000001
[    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 0000000000000000
[    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 0000000034d4d91d
[    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff000001aa7a74
[    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff000001aa7a74
[    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00000356c808
[    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80000888eb34
[    2.447190] Call trace:
[    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
[    2.452169]  process_one_work+0x1d8/0x380
[    2.454684]  worker_thread+0x170/0x4e0
[    2.457056]  kthread+0xd8/0xdc
[    2.459354]  ret_from_fork+0x10/0x20
[    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
[    2.464338] ---[ end trace 0000000000000000 ]---

Am 22.06.22 um 02:31 schrieb Peter Geis:
> The initial otg state for the phy defaults to device mode. The actual
> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
> state during initialization.
> 
> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 6711659f727c..6e44069617df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>   					EXTCON_USB_HOST, &rport->event_nb);
>   		if (ret)
>   			dev_err(rphy->dev, "register USB HOST notifier failed\n");
> +
> +		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
> +			/* do initial sync of usb state */
> +			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> +			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> +		}
>   	}
>   
>   out:

Gruß,
-- 
Markus Reichl
