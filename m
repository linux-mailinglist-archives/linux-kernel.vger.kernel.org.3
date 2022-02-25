Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552654C496D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiBYPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbiBYPoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:44:00 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A81B5115;
        Fri, 25 Feb 2022 07:43:26 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PD6pq4031745;
        Fri, 25 Feb 2022 16:43:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=MBoowDQHPfD1JA5SFm2tPIXGpLPPrwVQpuzL9/QQv20=;
 b=OmyHVP7XKeH06zdmOAYu3zu/hZ/Nuja8/4COwZUTHGgwqGn+AWfahVMR+FeMrD7l5pt1
 NqdKTrEb2OnZe5u2bkgS8wQG5hLFdZmjgm1a/cUPb7gLFE1JBPBV4HgCQDd/LsyyTcXu
 GwzxOURKLINGKMVgQl8YaOS5Gx9f8Y5ZGLueE635n0SgGcEzcPPR5my+ZxN5HmKw0MBh
 fBH9O/ebNcfG6EBCfoQAsbeniNEMiKtIlLMVVVnPdaHqGOiOJmJwu7QLEtURoBe3mWVZ
 b0BrtWctGTanPYtYUyCS6TQF68pG2Btrt2ARESG/hzJPh+qpI/c1yJiRyaVzmryGevNb eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrf2y6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 16:43:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31B5F10002A;
        Fri, 25 Feb 2022 16:43:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28BDC22FA49;
        Fri, 25 Feb 2022 16:43:09 +0100 (CET)
Received: from [10.201.22.79] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb
 2022 16:43:08 +0100
Message-ID: <7d1c5ef9-beca-9804-471f-92abd8a6e168@foss.st.com>
Date:   Fri, 25 Feb 2022 16:43:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Linux-stm32] [PATCH v2 00/13] Introduction of STM32MP13 RCC
 driver (Reset Clock Controller)
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
 <3e2f8cf8-3a41-d2e2-c9f1-6c1240b4a610@pengutronix.de>
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <3e2f8cf8-3a41-d2e2-c9f1-6c1240b4a610@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

many thanks for your review.

I'll check linux-stm32 mailing list issue.

Best Regards

Gabriel

On 2/25/22 16:28, Ahmad Fatoum wrote:
> On 25.02.22 14:31, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> This patchset introduce the reset and clock driver of STM32MP13 SoC.
>> It uses a clk-stm32-core module to manage stm32 gate, mux and divider
>> for STM32MP13 and for new future STMP32 SoC.
>>
>> v2:
>>    - Resend because patch 9,10,12,13 has not been sent
>>    - add Reviewed by Krzysztof Kozlowski for patch 1
>>
>> Gabriel Fernandez (13):
>>    dt-bindings: rcc: stm32: add new compatible for STM32MP13 SoC
>>    clk: stm32: Introduce STM32MP13 RCC drivers (Reset Clock Controller)
> This patch seems to not have reached linux-stm32. It's not in my inbox
> and https://st-md-mailman.stormreply.com/pipermail/linux-stm32/2022-February/014533.html
> doesn't list it either. It's indexed by lore.kernel.org though.
>
> Cheers,
> Ahmad
>
>
