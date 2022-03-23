Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8CD4E4F75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiCWJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiCWJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:33:33 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D94C76D1AD;
        Wed, 23 Mar 2022 02:32:02 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:35378.1509098416
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 3405D100225;
        Wed, 23 Mar 2022 17:31:58 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 61937688d8bb45d78e3cf3b4744afb5f for robh@kernel.org;
        Wed, 23 Mar 2022 17:32:02 CST
X-Transaction-ID: 61937688d8bb45d78e3cf3b4744afb5f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <f0db9bc0-ae9b-e86e-cc14-376dc40b86f4@189.cn>
Date:   Wed, 23 Mar 2022 17:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 7/7] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/23 04:49, Rob Herring wrote:
>> +
>> +	if (state) {
>> +		val = readb(li2c->dir_reg);
>> +		val |= mask;
>> +		writeb(val, li2c->dir_reg);
>> +	} else {
>> +		val = readb(li2c->dir_reg);
>> +		val &= ~mask;
>> +		writeb(val, li2c->dir_reg);
>> +
>> +		val = readb(li2c->dat_reg);
>> +		if (state)
> This condition is never true. We're in the 'else' because !state.
>
>> +			val |= mask;
>> +		else
>> +			val &= ~mask;
>> +		writeb(val, li2c->dat_reg);
> Shouldn't you set the data register low first and then change the
> direction? Otherwise, you may be driving high for a moment. However, if
> high is always done by setting the direction as input, why write the
> data register each time? I'm assuming whatever is written to the dat_reg
> is maintained regardless of pin state.

To be honest, i have rewrite GPIO emulated i2c several times.
Either give data first, then give the direction
or give the direction first, then the data
will be OK in practice.

In the theory, the GPIO data should be given before the GPIO direction,
I was told doing that way when learning Single-Chip Microcomputer (AT89S52).

But the high "MUST" be done by setting the direction as input.
It is "MUST" not "CAN" because writing code as the following
way works in practice.

         if (state) {
                 val = readb(li2c->dir_reg);
                 val |= mask;
                 writeb(val, li2c->dir_reg);
         } else {
                // ...
         }

If the adjust the above code by first set the detection as output,
then set the GPIO data register with high voltage level("1"). as
the following demonstrate code,

         if (state) {
		/* First set this pin as output */
		val = readb(li2c->dir_reg);
		val |= mask;
		writeb(val, li2c->dir_reg);

		/* Then, set the state to high */
		val = readb(li2c->dat_reg);
		val |= mask;
		writeb(val, li2c->dat_reg);
         } else {
                // ...
         }

Then i2c6 will NOT work as exacted, i2c7 will work, so strangely.
It may because the GPIO is open drained, not Push-pull output.
Output high is achieved by externalpull up resistance on the PCB.

