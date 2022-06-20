Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF36552070
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiFTPUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbiFTPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:20:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60F1EECE;
        Mon, 20 Jun 2022 08:13:40 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KC9fn8006964;
        Mon, 20 Jun 2022 17:13:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1oPWdJ+//Nblq7WtAbY8XqP8ikmhOJuE2xTdicCqfMU=;
 b=fa2IZogG8gkWE4+RBdVPb2APCY/mXSlPIHrTJZfEMit/C7+0+QHRWrS40jyuHxv1ouR8
 6tJaZljyfwN0RzKGdvvh5eAOzyEpy959bS9BSmflCibMB5Nnp7Kzg11gB5jiMHlFtiR1
 8jCmExJN0SfOh/P9FDEmynhPCBz6/kKI8VVtUfq6ybn7yIbICNOrjXi+yddnawzxE1bp
 pdEp4YDx5ee5CUUwg80uY4PrZCs7Orv3EWpjKMXblh+kszA3d7OUZgedDau2v4xGF5gU
 8z+W5lMwbeurW268C+RwnwfJOwX06kolDxa/zGX28bJjJ9nAteDib9L0hhepUXK+1RAR DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gtnj9tsmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 17:13:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 212F010002A;
        Mon, 20 Jun 2022 17:13:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0FB8722D18A;
        Mon, 20 Jun 2022 17:13:23 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.118) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 20 Jun
 2022 17:13:21 +0200
Message-ID: <ce4b0d5f-398e-7d2d-91e2-883e16c2dec1@foss.st.com>
Date:   Mon, 20 Jun 2022 17:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 00/14] Introduction of STM32MP13 RCC driver (Reset
 Clock Controller)
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
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel

On 5/16/22 09:05, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> v4: (rebased on next-20220512)
>    - rename scmi_shm@0 node into scmi-sram@0
>    - move sram node
>    - add reserved memory for optee
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
> Gabriel Fernandez (14):
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
>    ARM: dts: stm32: add optee reserved memory on stm32mp135f-dk
> 
>   .../bindings/clock/st,stm32mp1-rcc.yaml       |    2 +
>   arch/arm/boot/dts/stm32mp131.dtsi             |  142 +-
>   arch/arm/boot/dts/stm32mp133.dtsi             |    4 +-
>   arch/arm/boot/dts/stm32mp135f-dk.dts          |   16 +
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
>   16 files changed, 4813 insertions(+), 71 deletions(-)
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

DT Patches [12][13][14] applied on stm32-next.

Cheers
Alex
