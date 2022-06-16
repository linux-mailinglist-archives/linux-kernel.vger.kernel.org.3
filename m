Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CE54DDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbiFPIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376642AbiFPIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:54:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5F5E161;
        Thu, 16 Jun 2022 01:52:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9ED816601745;
        Thu, 16 Jun 2022 09:51:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655369519;
        bh=23ovZaBNRPxqVpFGtTYFhJNEhe3Arny8xrxLGcB24LU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bte3D/ZevCMuzsqY8vuxglJ8b5kBWgRtByfk6Ts/443xXWkEun3wFQJKzpjHV33pT
         1IlBD41Er+scyhSwviQcpNof+IK+MgipYVGAKVD4CSiEer9GuICckzrY9HhU/Q4PE8
         tSTfICGpDsKtMHdyHiHon1IR4vrJiNeuEnXnzngkZB+LnqWCdD6mjP2LbNqWvCR8qi
         yy8C1fO7WaynvaSsBwru9Rq8yeIzoDjBXw5ZW0IUed4mRRI2f3I2BbBHsAeEqt9u+K
         KlKHMLHtf0M2ldftRkT/jaLdyOaf43AVC8enfVVFy2SuWA9rZmUuUb0xwmL4VSq0z8
         YVM/3z78FRqgQ==
Message-ID: <b48b3de0-d521-a9ad-f9f9-1312f8486ba7@collabora.com>
Date:   Thu, 16 Jun 2022 10:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] clk: mediatek: clk-mt8195-vdo0: Set rate on
 vdo0_dp_intf0_dp_intf's parent
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "chun-jie.chen@mediatek.com" <chun-jie.chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jitao.shi@mediatek.com, mandyjh.liu@mediatek.com
References: <20220614091020.21472-1-angelogioacchino.delregno@collabora.com>
 <3de597c1ab963cc8f6dd89da089c6f0660517f34.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <3de597c1ab963cc8f6dd89da089c6f0660517f34.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/06/22 09:12, Rex-BC Chen ha scritto:
> On Tue, 2022-06-14 at 17:10 +0800, AngeloGioacchino Del Regno wrote:
>> Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
>> clock: this is required to trigger clock source selection on
>> CLK_TOP_EDP, while avoiding to manage the enablement of the former
>> separately from the latter in the displayport driver.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c
>> b/drivers/clk/mediatek/clk-mt8195-vdo0.c
>> index 261a7f76dd3c..07b46bfd5040 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
>> @@ -37,6 +37,10 @@ static const struct mtk_gate_regs vdo0_2_cg_regs =
>> {
>>   #define GATE_VDO0_2(_id, _name, _parent, _shift)			
>> \
>>   	GATE_MTK(_id, _name, _parent, &vdo0_2_cg_regs, _shift,
>> &mtk_clk_gate_ops_setclr)
>>   
>> +#define GATE_VDO0_2_FLAGS(_id, _name, _parent, _shift, _flags)	
>> 	\
>> +	GATE_MTK_FLAGS(_id, _name, _parent, &vdo0_2_cg_regs, _shift,	
>> \
>> +		       &mtk_clk_gate_ops_setclr, _flags)
>> +
>>   static const struct mtk_gate vdo0_clks[] = {
>>   	/* VDO0_0 */
>>   	GATE_VDO0_0(CLK_VDO0_DISP_OVL0, "vdo0_disp_ovl0", "top_vpp",
>> 0),
>> @@ -85,7 +89,8 @@ static const struct mtk_gate vdo0_clks[] = {
>>   	/* VDO0_2 */
>>   	GATE_VDO0_2(CLK_VDO0_DSI0_DSI, "vdo0_dsi0_dsi", "top_dsi_occ",
>> 0),
>>   	GATE_VDO0_2(CLK_VDO0_DSI1_DSI, "vdo0_dsi1_dsi", "top_dsi_occ",
>> 8),
>> -	GATE_VDO0_2(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf",
>> "top_edp", 16),
>> +	GATE_VDO0_2_FLAGS(CLK_VDO0_DP_INTF0_DP_INTF,
>> "vdo0_dp_intf0_dp_intf",
>> +			  "top_edp", 16, CLK_SET_RATE_PARENT),
>>   };
>>   
>>   static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
>> -- 
>> 2.35.1
>>
> 
> Hello Angelo,
> 
> Thanks for this patch.
> Another dp clock should also be fix.
> After confirming with Jitao who is our dp expert.
> The parent of CLK_VDO1_DPINTF should be top_dp instead of top_vpp.
> 
> Thanks!

Hey.

Yes, we should really fix that, I can send a separated series with:
* A first commit fixing the clock parent (with a Fixes: tag)
* A second commit adding the CLK_SET_RATE_PARENT

...and I'll do that ASAP.

Thank you!
Angelo
