Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB558E7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHJHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHJHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:40:14 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0682DC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:40:12 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oLgK1-0004qp-Fj; Wed, 10 Aug 2022 17:40:09 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OH8n6y/l454uovpaFdrSCGfhI2SsmH1/0lM9gmJQFdc=; b=OcYBWTxb8HaZOuQyeHx5U/aFEP
        Xfxmg6vDuf+EmJemumjZOvFz0DRBIGxvcS01PkbHdFqUxWbpniSZIh21Q5i6njSebFxYKId1g9zpe
        Dk5KHPvPtAVZAWp8t1d16ww2BckGU+fIpvZ18beli3YshQ4X4mxj5jW22chEHGzjsEoc=;
Message-ID: <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
Date:   Wed, 10 Aug 2022 15:40:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
 <YvKCRPtoN6m2rMr2@lahna>
Content-Language: en-US
In-Reply-To: <YvKCRPtoN6m2rMr2@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Mika,

On 9/8/22 23:50, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Aug 09, 2022 at 11:16:27PM +0800, Brad Campbell wrote:
>> If I then reboot and load the driver it fails.
>>
>> The only thing I could think of doing was an lspci -vvv after the boot and module load
>> and an lspci -vvv after a warm reboot and diff them, because there are changes around the
>> thunderbolt bridge devices. I've done a diff -u50 to try and keep as much context as possible.
>>
>> On the first boot I can unload/reload the thunderbolt module repeatedly and there's no issue
>> but loading it after a reboot locks up. There are no lspci changes on the first boot after the
>> initial module load unless I rescan the PCI bus, but they're minor and it doesn't cause an issue
>> with loading the thunderbolt module.
>>
>> The firmware *must* be doing something on reboot I suppose or the PCIe configs wouldn't change.
> 
> Okay, let's try a bigger hammer and reset all the ports upon load. That
> should hopefully clear out the "bad state" too. This is completely
> untested but it should trigger reset and then re-initialize the TBT
> links.
> 
> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> index 633970fbe9b0..c419c2568de4 100644
> --- a/drivers/thunderbolt/lc.c
> +++ b/drivers/thunderbolt/lc.c
> @@ -6,6 +6,8 @@
>    * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>    */
>   
> +#include <linux/delay.h>
> +
>   #include "tb.h"
>   
>   /**
> @@ -327,6 +329,34 @@ void tb_lc_xhci_disconnect(struct tb_port *port)
>   	tb_port_dbg(port, "xHCI disconnected\n");
>   }
>   
> +int tb_lc_reset_port(struct tb_port *port)
> +{
> +	struct tb_switch *sw = port->sw;
> +	int cap, ret;
> +	u32 val;
> +
> +	if (sw->generation != 3)
> +		return -EINVAL;
> +
> +	cap = find_port_lc_cap(port);
> +	if (cap < 0)
> +		return cap;
> +
> +	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +	if (ret)
> +		return ret;
> +
> +	val |= TB_LC_PORT_MODE_DPR;
> +	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +	if (ret)
> +		return ret;
> +
> +	msleep(20);
> +
> +	val &= ~TB_LC_PORT_MODE_DPR;
> +	return tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +}
> +
>   static int tb_lc_set_wake_one(struct tb_switch *sw, unsigned int offset,
>   			      unsigned int flags)
>   {
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 0ae8a7ec7c9c..21ac3ccf1cf9 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -740,6 +740,11 @@ int tb_port_disable(struct tb_port *port)
>   	return __tb_port_enable(port, false);
>   }
>   
> +int tb_port_reset(struct tb_port *port)
> +{
> +	return tb_lc_reset_port(port);
> +}
> +
>   /*
>    * tb_init_port() - initialize a port
>    *
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 8030fc544c5e..48a7396994ef 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -1875,6 +1875,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
>   static int tb_start(struct tb *tb)
>   {
>   	struct tb_cm *tcm = tb_priv(tb);
> +	struct tb_port *p;
>   	int ret;
>   
>   	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
> @@ -1911,6 +1912,12 @@ static int tb_start(struct tb *tb)
>   				false);
>   	/* Enable TMU if it is off */
>   	tb_switch_tmu_enable(tb->root_switch);
> +
> +	tb_switch_for_each_port(tb->root_switch, p) {
> +		if (tb_port_is_null(p))
> +			tb_port_reset(p);
> +	}
> +
>   	/* Full scan to discover devices added before the driver was loaded. */
>   	tb_scan_switch(tb->root_switch);
>   	/* Find out tunnels created by the boot firmware */
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 28bb80d967d6..fe5edefec712 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1028,6 +1028,7 @@ int tb_port_clear_counter(struct tb_port *port, int counter);
>   int tb_port_unlock(struct tb_port *port);
>   int tb_port_enable(struct tb_port *port);
>   int tb_port_disable(struct tb_port *port);
> +int tb_port_reset(struct tb_port *port);
>   int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
>   void tb_port_release_in_hopid(struct tb_port *port, int hopid);
>   int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
> @@ -1121,6 +1122,7 @@ bool tb_lc_is_usb_plugged(struct tb_port *port);
>   bool tb_lc_is_xhci_connected(struct tb_port *port);
>   int tb_lc_xhci_connect(struct tb_port *port);
>   void tb_lc_xhci_disconnect(struct tb_port *port);
> +int tb_lc_reset_port(struct tb_port *port);
>   int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags);
>   int tb_lc_set_sleep(struct tb_switch *sw);
>   bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index f8c1ca3464d9..8fd12bc2d500 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -555,6 +555,9 @@ struct tb_regs_hop {
>   #define TB_LC_POWER				0x740
>   
>   /* Link controller registers */
> +#define TB_LC_PORT_MODE				0x26
> +#define TB_LC_PORT_MODE_DPR			BIT(6)
> +
>   #define TB_LC_CS_42				0x2a
>   #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
>   
> 

Yep, that certainly solves the lockup/reboot issues and all PCIe devices are
discovered and appear to work. I can reboot repeatedly and that seems to be ok.

It causes some peculiarity in the DP tunnel however where one or both will fail to come up
leaving this in dmesg (in this instance both failed) :

[   10.550439] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
[   10.551032] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
[   11.180398] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
[   11.180830] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22

Oddly enough X thinks the displays are there and is pretending to display on them, but they
remain black. This can be one, the other or both depending on the boot.

I have probably cold/warm booted 50 times now with varying combinations of activation to attempt
to pin some form of determinism on this behaviour, but I've got nothing at this point.

Regards,
Brad

