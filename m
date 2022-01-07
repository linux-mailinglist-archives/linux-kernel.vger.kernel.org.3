Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7707B4871AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiAGEIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:08:42 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:14049 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiAGEIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:08:41 -0500
Received: from [10.28.39.73] (10.28.39.73) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 Jan 2022
 12:08:40 +0800
Message-ID: <3d4eff52-431d-438d-bbe6-3267d87e2d37@amlogic.com>
Date:   Fri, 7 Jan 2022 12:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] mtd: rawnand: meson: fix the clock after discarding
 sd_emmc_c_clkc
Content-Language: en-US
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220106032504.23310-1-liang.yang@amlogic.com>
 <20220106090832.42225c49@xps13>
 <9c7b1d77-cff1-b40c-6d02-f67ca8b9b683@amlogic.com>
In-Reply-To: <9c7b1d77-cff1-b40c-6d02-f67ca8b9b683@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.73]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

refine the clock framework diagram.

On 2022/1/7 10:40, Liang Yang wrote:
>> What is nand_divider?
> i simplify our clock framework below, so nand divider is 
> SD_EMMC_CLOCK[5:0] here.
>                 -----          -----            -----
>         the other------|    \        |     |       |     |
>                     | mux    | -----  |  N  | ----------| NFC/|
>         FCLK_DIV2------|     |        |     |       | EMMC|
>                 -----/         -----         -----
>              SD_EMMC_CLOCK[7:6] SD_EMMC_CLOCK[5:0]


                          -----           -------         --------
               the other-|      \        |       |       |        |
                         | mux  |--------|  N    |-------|   NFC/ |
                         |      |        |       |       |   EMMC |
               fclk_div2-|      /        |       |       |        |
                          -----           -------         --------
                   SD_EMMC_CLOCK[7:6]   SD_EMMC_CLOCK[5:0]
