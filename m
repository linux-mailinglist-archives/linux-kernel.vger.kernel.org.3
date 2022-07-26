Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF0580F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiGZIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiGZIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:54:59 -0400
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4D31352
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:54:57 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oGGL6-0002fl-Dq; Tue, 26 Jul 2022 10:54:52 +0200
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 26Q8snZh029298
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 26 Jul 2022 10:54:49 +0200
Message-ID: <ae2a4f1c-6bf9-b2dd-35c8-5cdc5f102e03@fivetechno.de>
Date:   Tue, 26 Jul 2022 10:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Sync initial otg state
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
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1658825697;ba5caa59;
X-HE-SMSGID: 1oGGL6-0002fl-Dq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
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

with recent linux-next kernels, here with next-20220725 my rk3399-roc-pc does not 
boot. Bisecting pointed to this commit.
By reverting this commit the board boots again.

  2.431005] Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000000
[    2.432152] Mem abort info:
[    2.432519]   ESR = 0x0000000086000004
[    2.433001]   EC = 0x21: IABT (current EL), IL = 32 bits
[    2.433674]   SET = 0, FnV = 0
[    2.434075]   EA = 0, S1PTW = 0
[    2.434484]   FSC = 0x04: level 0 translation fault
[    2.435102] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000001765000
[    2.435911] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    2.436775] Internal error: Oops: 86000004 [#1] SMP
[    2.437397] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd xhci_hcd 
rockchipdrm drm_cma_helper dwc3 analogix_dp dw_hdmi realtek dwc3_of_simple 
drm_display_helper dw_mipi_dsi drm_kms_helper syscopyarea ohci_platform ohci_hcd 
ehci_platform sysfillrect sysimgblt ehci_hcd dwmac_rk fb_sys_fops stmmac_platform 
stmmac pcs_xpcs phylink drm usbcore drm_panel_orientation_quirks
[    2.441651] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.19.0-rc8-next-20220725 #417
[    2.442609] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
[    2.443415] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.444289] pc : 0x0
[    2.444594] lr : call_timer_fn.constprop.0+0x24/0x80
[    2.445247] sp : ffff800008f43a50
[    2.445678] x29: ffff800008f43a50 x28: 0000000000000005 x27: 0000000000000020
[    2.453334] x26: ffff000000646580 x25: ffff800008f43b00 x24: 0000000000000000
[    2.461028] x23: 0000000000000001 x22: 00000000000000e0 x21: 0000000000000100
[    2.466727] x20: ffff000000646580 x19: 0000000000000000 x18: ffff00000679e80c
[    2.471614] x17: ffff8000eec73000 x16: ffff800008d84000 x15: 0000000000004000
[    2.476524] x14: ffff000000646580 x13: ffff8000eec73000 x12: ffff0000f7786ef0
[    2.481408] x11: 0000000000000001 x10: 0000000000000000 x9 : 000000000000006d
[    2.486309] x8 : ffff0000f7786ea8 x7 : ffffffffffffffff x6 : 0000000000000000
[    2.491197] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800008f43b00
[    2.496077] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000018e0b10
[    2.500871] Call trace:
[    2.505098]  0x0
[    2.509249]  expire_timers+0xcc/0x100
[    2.513533]  run_timer_softirq+0x11c/0x300
[    2.517842]  _stext+0x124/0x2a4
[    2.522050]  __irq_exit_rcu+0xcc/0xfc
[    2.526289]  irq_exit_rcu+0x10/0x1c
[    2.530448]  el1_interrupt+0x38/0x54
[    2.534601]  el1h_64_irq_handler+0x18/0x24
[    2.538791]  el1h_64_irq+0x64/0x68
[    2.542892]  cpuidle_enter_state+0x130/0x2f0
[    2.547064]  cpuidle_enter+0x38/0x50
[    2.551167]  do_idle+0x228/0x2ac
[    2.555267]  cpu_startup_entry+0x24/0x30
[    2.559396]  secondary_start_kernel+0x124/0x140
[    2.563526]  __secondary_switched+0xb0/0xb4
[    2.567599] Code: bad PC value
[    2.571567] ---[ end trace 0000000000000000 ]---
[    2.575625] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[    2.579901] SMP: stopping secondary CPUs
[    2.584020] Kernel Offset: disabled
[    2.587955] CPU features: 0x2000,0820b021,00001082
[    2.592000] Memory Limit: none
[    2.595844] ---[ end Kernel panic - not syncing: Oops: Fatal exception in 
interrupt ]---


Gruß,
-- 
Markus Reichl
