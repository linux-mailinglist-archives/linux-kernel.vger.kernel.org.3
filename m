Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822F51F8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiEIJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiEIJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:16:25 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D6205270;
        Mon,  9 May 2022 02:12:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.411162|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0325975-0.00943409-0.957968;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.NgYRNRV_1652087532;
Received: from 192.168.1.123(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NgYRNRV_1652087532)
          by smtp.aliyun-inc.com(33.40.73.199);
          Mon, 09 May 2022 17:12:19 +0800
Subject: Re: [PATCH v2 0/3] Clock fixes for Ingenic SoCs
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, sboyd@kernel.org,
        mturquette@baylibre.com, tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
From:   =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Message-ID: <f5ca7c72-6526-d733-93fd-933aa9b719bc@wanyeetech.com>
Date:   Mon, 9 May 2022 17:12:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/29 上午12:44, Aidan MacDonald wrote:
> I ran across a problem trying to get Linux running on an Ingenic X1000 SoC:
> since the memory clock isn't referenced by any driver, it appears unused and
> gets disabled automatically. After that, the system hangs on any RAM access.
>
> There is a hack in board-ingenic.c to forcibly enable the CPU clock, but this
> is insufficient for the X1000 since the memory clock has its own gate and mux
> that isn't tied to the CPU.
>
> This patch series fixes the bug by adding CLK_IS_CRITICAL flags to important
> clocks, which seems to be the approach used in many other SoC clock drivers.
>
> v2: Add comments to patch 02 to explain why we need CLK_IS_CRITICAL.
>
> Aidan MacDonald (3):
>    clk: ingenic: Allow specifying common clock flags
>    clk: ingenic: Mark critical clocks in Ingenic SoCs
>    mips: ingenic: Do not manually reference the CPU clock
>
>   arch/mips/generic/board-ingenic.c | 26 --------------------------
>   drivers/clk/ingenic/cgu.c         |  2 +-
>   drivers/clk/ingenic/cgu.h         |  3 +++
>   drivers/clk/ingenic/jz4725b-cgu.c | 10 ++++++++++
>   drivers/clk/ingenic/jz4740-cgu.c  | 10 ++++++++++
>   drivers/clk/ingenic/jz4760-cgu.c  | 10 ++++++++++
>   drivers/clk/ingenic/jz4770-cgu.c  |  5 +++++
>   drivers/clk/ingenic/jz4780-cgu.c  | 15 +++++++++++++++
>   drivers/clk/ingenic/x1000-cgu.c   | 15 +++++++++++++++
>   drivers/clk/ingenic/x1830-cgu.c   | 11 +++++++++++
>   10 files changed, 80 insertions(+), 27 deletions(-)


Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> # On X1000 and 
X1830


