Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABB94B4CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiBNKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:45:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348656AbiBNKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:44:56 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1998AB86A;
        Mon, 14 Feb 2022 02:07:30 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:35964.414113341
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id CD6CD10029D;
        Mon, 14 Feb 2022 18:07:27 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 2ce5d89c9d2b4751bf53523b557ba63b for jiaxun.yang@flygoat.com;
        Mon, 14 Feb 2022 18:07:29 CST
X-Transaction-ID: 2ce5d89c9d2b4751bf53523b557ba63b
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <79f30dcb-48f5-e8b4-7cdd-770dd30d4896@189.cn>
Date:   Mon, 14 Feb 2022 18:07:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 0/7] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220213141649.1115987-1-15330273260@189.cn>
 <380d93a4-6f36-00d2-6cd3-e4428534cbb1@flygoat.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <380d93a4-6f36-00d2-6cd3-e4428534cbb1@flygoat.com>
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


On 2022/2/14 13:54, Jiaxun Yang wrote:
>
>
> 在 2022/2/13 14:16, Sui Jingfeng 写道:
>> There is a display controller in loongson's LS2K1000 SoC and LS7A1000
>> bridge chip, the DC is a PCI device in those chips. It has two display
>> pipes but with only one hardware cursor. Each way has a DVO interface
>> which provide RGB888 signals, vertical & horizontal synchronisations,
>> data enable and the pixel clock. Each CRTC is able to scanout from
>> 1920x1080 resolution at 60Hz. The maxmium resolution is 2048x2048
>> according to the hardware spec.
>
> Hi Jiangfeng,
>
> I see you added dts for those boards, but I didn't see you wire up them
> in Makefile and code? How can you use them in present systems?
>
> I guess to make those dts work for general all-in-one kernel, what you
> need to do is, for example Lemota A1901:
>
> 1. Add __dtb_lemote_a1901 to builtin_dtbs.h
>
> 2. Wire up with something like:
>
> if (!strcmp("LEMOTE-/LS3A4000/-7A1000-1w-V01-pc", eboard->name)
>     loongson_fdt_blob = __dtb_lemote_a1901
>
> In arch/mips/loongson64/env.c.
>
> Thanks.
> - Jiaxun

For most board, this driver is ready to be use out of box.
Device tree is for supplement purpose.

