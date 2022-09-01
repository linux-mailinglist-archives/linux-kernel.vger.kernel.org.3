Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FB5AA3AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiIAXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIAXXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:23:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151F9F8E9;
        Thu,  1 Sep 2022 16:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hgMGVZdMKhyqLshIUrsmX7Hqg1+VgGsYk2UgsOp9efM=; b=Wn52tRpu39wZbFJINIaQN8A17x
        ASTWsfCR2CZ0+v+79nboPKwgYFtQDYeXAdHUdsYlDb/ovDam88ggKtmn5w+Nw9rn7zrEmRmrnjSTd
        zSX3IqszBE8EBLQs/yks6l9rm66no4L0sLPXfyxaarHOwptwHpffvdmapDpb7FxuW2nFpxI9LBUzd
        CBCBy9PuUlT0bTmXaULu/3oJzpuzUOtQnkD4I+IkL2TnNZXVVuVM/f9HCkRXJqXJtHRx4tYU2PbiH
        7Z/IS+3yPzVpuDMCCElJcjf4yLzFZKNIX0aBdnIQauV5fB1qDhgFTbVapoFLySF1dKuYdeEs7Ay29
        HW/+uCKA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTtWL-00FlIA-4F; Thu, 01 Sep 2022 23:22:49 +0000
Message-ID: <3b86cb68-2b30-76dd-baf5-90af0b0a60a4@infradead.org>
Date:   Thu, 1 Sep 2022 16:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 01/20] net: add helper eth_addr_add()
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-2-michael@walle.cc>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220901221857.2600340-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 15:18, Michael Walle wrote:
> Add a helper to add an offset to a ethernet address. This comes in handy
> if you have a base ethernet address for multiple interfaces.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
> changes since v1:
>  - none
> 
>  include/linux/etherdevice.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index a541f0c4f146..f144cadbe99d 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -507,6 +507,20 @@ static inline void eth_addr_inc(u8 *addr)
>  	u64_to_ether_addr(u, addr);
>  }
>  
> +/**
> + * eth_addr_add() - Add (or subtract) and offset to/from the given MAC address.

                                         an offset
?

> + *
> + * @offset: Offset to add.
> + * @addr: Pointer to a six-byte array containing Ethernet address to increment.
> + */
> +static inline void eth_addr_add(u8 *addr, long offset)
> +{
> +	u64 u = ether_addr_to_u64(addr);
> +
> +	u += offset;
> +	u64_to_ether_addr(u, addr);
> +}
> +
>  /**
>   * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
>   * @dev: Pointer to a device structure

-- 
~Randy
