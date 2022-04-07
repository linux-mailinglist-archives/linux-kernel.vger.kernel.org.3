Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72284F7F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiDGMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiDGMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:53:54 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF2224741;
        Thu,  7 Apr 2022 05:51:54 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237Aq0jf009474;
        Thu, 7 Apr 2022 14:51:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=13b18C+QnCO96hAQswheWvxn/oYiNl1M/rXD0ThSX+o=;
 b=pzC0Z1TuNgjH4uMUvTS0kcpw+02eWvd/3XkZGoakzGMa7sjEyFM3Yg7MUheEh0HTbOwH
 VmvyQOIFjpj2NTdIYMlhHt47GnXNoFXyPmciTpB1iLc1e+vaqubl7YGzq5Qg+4Q3KMRR
 2p1yPs3XChyMlevkosOJpnNBl47eZ6c417MZ18n/eGisfLL5kdwSMLQ3APtG2R9K5Ufz
 jdvx/2tjDDMj9wt0xg9ZAjA3KnXNPIuFhbBdSXkVqmTcbhuZ607gG7OvtaQRXIT3iCLY
 2n60AKkdncFjGPFtMBiAQBpGLQevJIjmuV/J7gRPfIWNzR4/h9dvEMx7CG4x5Xsr582Q Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f8x4rm2j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:51:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72D5F10002A;
        Thu,  7 Apr 2022 14:51:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DB7A21B52C;
        Thu,  7 Apr 2022 14:51:41 +0200 (CEST)
Received: from [10.48.0.142] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 7 Apr
 2022 14:51:40 +0200
Message-ID: <60b04d4f-71ae-2c06-4570-eacd1f3db172@foss.st.com>
Date:   Thu, 7 Apr 2022 14:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v3 00/13] Introduction of STM32MP13 RCC driver
 (Reset Clock Controller)
Content-Language: en-US
To:     <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220316131000.9874-1-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_01,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On 3/16/22 14:09, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> v3:
>    - cosmetic change from Stephen Boyd
>    - rename some functions in clk-stm32-core
>    - add missing static for variables or functions
> 
> v2:
>    - Resend because patch 9,10,12,13 has not been sent
>    - add Reviewed by Krzysztof Kozlowski for patch 1
> 
> Gabriel Fernandez (13):
>    dt-bindings: rcc: stm32: add new compatible for STM32MP13 SoC
>    clk: stm32: Introduce STM32MP13 RCC drivers (Reset Clock Controller)
>    clk: stm32mp13: add stm32_mux clock management
>    clk: stm32mp13: add stm32_gate management
>    clk: stm32mp13: add stm32 divider clock
>    clk: stm32mp13: add composite clock
>    clk: stm32mp13: manage secured clocks
>    clk: stm32mp13: add all STM32MP13 peripheral clocks
>    clk: stm32mp13: add all STM32MP13 kernel clocks
>    clk: stm32mp13: add multi mux function
>    clk: stm32mp13: add safe mux management
>    ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP13
>    ARM: dts: stm32: add RCC on STM32MP13x SoC family
> 

DT patches look good for me. I'll apply them on stm32-next as soon as 
dt-bindings + drivers patch are applied.

cheers
Alex



>   .../bindings/clock/st,stm32mp1-rcc.yaml       |    2 +
>   arch/arm/boot/dts/stm32mp131.dtsi             |  128 +-
>   arch/arm/boot/dts/stm32mp133.dtsi             |    4 +-
>   arch/arm/boot/dts/stm32mp13xf.dtsi            |    3 +-
>   drivers/clk/Kconfig                           |    5 +
>   drivers/clk/Makefile                          |    1 +
>   drivers/clk/stm32/Makefile                    |    1 +
>   drivers/clk/stm32/clk-stm32-core.c            |  695 +++++++
>   drivers/clk/stm32/clk-stm32-core.h            |  188 ++
>   drivers/clk/stm32/clk-stm32mp13.c             | 1620 +++++++++++++++
>   drivers/clk/stm32/reset-stm32.c               |  122 ++
>   drivers/clk/stm32/reset-stm32.h               |    8 +
>   drivers/clk/stm32/stm32mp13_rcc.h             | 1748 +++++++++++++++++
>   include/dt-bindings/clock/stm32mp13-clks.h    |  229 +++
>   include/dt-bindings/reset/stm32mp13-resets.h  |  100 +
>   15 files changed, 4794 insertions(+), 60 deletions(-)
>   create mode 100644 drivers/clk/stm32/Makefile
>   create mode 100644 drivers/clk/stm32/clk-stm32-core.c
>   create mode 100644 drivers/clk/stm32/clk-stm32-core.h
>   create mode 100644 drivers/clk/stm32/clk-stm32mp13.c
>   create mode 100644 drivers/clk/stm32/reset-stm32.c
>   create mode 100644 drivers/clk/stm32/reset-stm32.h
>   create mode 100644 drivers/clk/stm32/stm32mp13_rcc.h
>   create mode 100644 include/dt-bindings/clock/stm32mp13-clks.h
>   create mode 100644 include/dt-bindings/reset/stm32mp13-resets.h
> 

