Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7D535805
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiE0DVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiE0DU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:20:58 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55A99693
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:20:57 -0700 (PDT)
Received: from [10.28.39.121] (10.28.39.121) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 27 May
 2022 11:20:55 +0800
Message-ID: <a71892eb-8482-2905-54fc-dac5e2ba6d51@amlogic.com>
Date:   Fri, 27 May 2022 11:20:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/4] mtd: rawnand: meson: fix the clock
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-3-liang.yang@amlogic.com> <7hwne88dha.fsf@baylibre.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <7hwne88dha.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.121]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks for your review.

On 2022/5/27 0:28, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> Liang Yang <liang.yang@amlogic.com> writes:
> 
>> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
>> which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
>> the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
>> a common MMC and NAND sub-clock was discussed and planed to be implemented
>> as NFC clock provider, but now this series of patches of a common MMC and
>> NAND sub-clock are never being accepted.  the reasons for giving up are:
>> 1. EMMC and NAND, which are mutually exclusive anyway
>> 2. coupling the EMMC and NAND.
>> 3. it seems that a common MMC and NAND sub-clock is over engineered.
>> and let us see the link fot more information:
>> https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
>> so The meson nfc can't work now, let us rework the clock.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> Thank you for your persistence in working on multiple iterations of this
> until we came to a final agreement.
> 
> Kevin
> 
> .
