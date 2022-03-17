Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92BC4DC2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiCQJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCQJfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:35:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512F16C0A5;
        Thu, 17 Mar 2022 02:33:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 58D771F44F7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647509631;
        bh=8Er5GMCq22zzAAuQZRr5EH7rpvXOYy2RxuXWgEVIUdU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OXQ44H9PyxXsqT7XBKE+MUrrBX6Bte9NHGf9ZYP1I3YTg0m7l7yWzXM4a6sk5h2Pc
         3uySIHDN3dAo6mixFH88PgXju5IGvpvjiUQr6fj/SaT6U0k5P+wSjL/9w3UKh0ccQ4
         UnSpTM3cJW7NSl6JWFz8rs+H5uC2nUArtmAVPxPT9TTmHqEeLNKCGlH+4rucCmZuQt
         VdQK3lJAMliqNv0Zh3eXf5mz48J2PDUm/bPqNwrMmYI0FA1Q86FvIabDuTTDriq17p
         9SCS7ZG8oKJAPxPUbqvdt5W6R8zrqwmNGmpCsM24hHK/t2IHfv6LVHCIwM00WeXGzw
         K4G4rcZ6Z7E4Q==
Message-ID: <b6394c1a-28ee-f4bb-434f-afd311893fb8@collabora.com>
Date:   Thu, 17 Mar 2022 10:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V4 4/6] spi: mediatek: add spi memory support for ipm
 design
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
 <20220315032411.2826-5-leilk.liu@mediatek.com>
 <b237c1fe-9ddd-0a2e-ecf2-05bfb984c5dd@collabora.com>
 <602f93f020967789eff49e2fd821d1b03f5b009f.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <602f93f020967789eff49e2fd821d1b03f5b009f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/22 10:27, Leilk Liu ha scritto:
> On Tue, 2022-03-15 at 10:31 +0100, AngeloGioacchino Del Regno wrote:
>> Il 15/03/22 04:24, Leilk Liu ha scritto:
>>> this patch add the support of spi-mem for ipm design.
>>>
>>> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
>>> ---
>>>    drivers/spi/spi-mt65xx.c | 349
>>> ++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 348 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
>>> index 1a0b3208dfca..8958c3fa4fea 100644
>>> --- a/drivers/spi/spi-mt65xx.c
>>> +++ b/drivers/spi/spi-mt65xx.c
>>
>> ...snip...
>>
>>> +
>>> +static void of_mtk_spi_parse_dt(struct spi_master *master, struct
>>> device_node *nc)
>>> +{
>>> +	struct mtk_spi *mdata = spi_master_get_devdata(master);
>>> +	u32 value;
>>> +
>>> +	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>>
>> Hello Leilk,
>>
>> thanks for considering my advice about "spi-{tx,rx}-bus-width", but
>> there's
>> something that you have misunderstood about it.
>>
>> Simply, you don't need this function at all. Whatever you are doing
>> here is
>> already being performed in the Linux SPI framework: at the end of the
>> probe
>> function, this driver is calling the (legacy)
>> devm_spi_register_master(),
>> which calls devm_spi_register_controller().
>>
>> In drivers/spi/spi.c, function spi_register_controller(), will in
>> turn call
>> of_register_spi_devices(ctlr) -> of_register_spi_device(ctlr, nc)...
>> that
>> will end up finally calling function of_spi_parse_dt(ctlr, spi, nc).
>>
>> The last mentioned function already contains the logic and setup to
>> check
>> devicetree properties "spi-tx-bus-width" and "spi-rx-bus-width" (and
>> some
>> others, as well).
>>
>> This means that spi-mt65xx.c already probed these even before your
>> IPM
>> implementation, hence ***function of_mtk_spi_parse_dt() is not
>> needed***.
>>
>> Simply drop it and don't check for these properties: that's already
>> done.
>>
>>
>> Regards,
>> Angelo
>>
> Hi Angelo,
> 
> Thanks for your advice.
> 
> There are two spi controllor on MT7986. One supports single/dual mode,
> the other supports quad mode. Both of them can support spi memory
> framework(one's tx/rx bus width is 1/2, the other one's tx/rx bus width
> is 1/2/4).
> 
> Can I use of_mtk_spi_parse_dt() to parse the information? What's your
> suggestion?
> 
> Thanks!
> 

As I've already said, this does NOT require any devicetree handling in
spi-mt65xx.c, as setting the right mode_bits is already handled in
drivers/spi/spi.c - please follow the explaination that I have given
before to fully understand the situation.

Regards,
Angelo


> 
>>> +		switch (value) {
>>> +		case 1:
>>> +			break;
>>> +		case 2:
>>> +			master->mode_bits |= SPI_TX_DUAL;
>>> +			break;
>>> +		case 4:
>>> +			master->mode_bits |= SPI_TX_QUAD;
>>> +			break;
>>> +		default:
>>> +			dev_warn(mdata->dev,
>>> +				 "spi-tx-bus-width %d not supported\n",
>>> +				value);
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
>>> +		switch (value) {
>>> +		case 1:
