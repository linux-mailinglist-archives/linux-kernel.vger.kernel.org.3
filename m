Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485354E4BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiCWEOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:14:18 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F5CC46168;
        Tue, 22 Mar 2022 21:12:48 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:49490.1900241467
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 65E70100295;
        Wed, 23 Mar 2022 12:12:44 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 9fdf852ba39e43dc86bc897a873f4e2f for robh@kernel.org;
        Wed, 23 Mar 2022 12:12:47 CST
X-Transaction-ID: 9fdf852ba39e43dc86bc897a873f4e2f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <9ea4d326-ad5f-4f2c-1609-4ca772699d1b@189.cn>
Date:   Wed, 23 Mar 2022 12:12:43 +0800
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
Content-Transfer-Encoding: 8bit
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
>> +/*
>> + * mainly for dc in ls7a1000 which have builtin gpio emulated i2c
>> + *
>> + * @index : output channel index, 0 for DVO0, 1 for DVO1
>> + */
>> +struct lsdc_i2c *lsdc_create_i2c_chan(struct device *dev, void *base, unsigned int index)
>> +{
>> +	char compat[32] = {0};
>> +	unsigned int udelay = 5;
>> +	unsigned int timeout = 2200;
>> +	int nr = -1;
>> +	struct i2c_adapter *adapter;
>> +	struct lsdc_i2c *li2c;
>> +	struct device_node *i2c_np;
>> +	int ret;
>> +
>> +	li2c = devm_kzalloc(dev, sizeof(*li2c), GFP_KERNEL);
>> +	if (!li2c)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	li2c->index = index;
>> +	li2c->dev = dev;
>> +
>> +	if (index == 0) {
>> +		li2c->sda = 0x01;
>> +		li2c->scl = 0x02;
>> +	} else if (index == 1) {
>> +		li2c->sda = 0x04;
>> +		li2c->scl = 0x08;
> Just require this to be in DT rather than having some default.
>
By design,  I am try very hard to let the code NOT fully  DT dependent. DT is nice , easy to learn and use.
But kernel side developer plan to follow UEFI + ACPI Specification on LS3A5000 + LS7A1000 platform. See [1]
There will no DT support then, provide a convention support  make the driver more flexible. I want the
driver works with minimal requirement. The driver just works on simple boards by put the following dc device
node in arch/mips/dts/loongson/loongson64g_4core_ls7a.dts,

             lsdc: display-controller@6,1 {
                 compatible = "loongson,ls7a1000-dc";

                 reg = <0x3100 0x0 0x0 0x0 0x0>;
                 interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
                 interrupt-parent = <&pic>;
             };

[1] 
https://lwn.net/Articles/869541/#:~:text=LoongArch%20is%20a%20new%20RISC%20ISA%2C%20which%20is,revision%20of%20ACPI%20Specification%20%28current%20revision%20is%206.4%29.

