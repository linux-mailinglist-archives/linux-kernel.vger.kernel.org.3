Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0552289E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiEKAxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiEKAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:53:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6774EDE0;
        Tue, 10 May 2022 17:53:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24B0qxhP067232;
        Tue, 10 May 2022 19:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652230379;
        bh=YIhmBlmyKor7om4BgPFzbhiD0XkdpxQSj9rB5hcG4mk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=a0KLXKu3m7spo6zT1P6A5W/mx7E7j1xa5FdCTE+tQu9+vPp92ZxyWvkTFTK+Sqltp
         /+v8VrgeQ3URT46OeiV6DxV5T+EYanbWBMoCKu27Rjt6XRe4/itpqPOcmXlkwZAyzz
         +7t6bQSP4Qy4tNu+Wu0oiPNhQZAgOhSj7MqZMTfU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24B0qxRS000359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 May 2022 19:52:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 10
 May 2022 19:52:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 10 May 2022 19:52:58 -0500
Received: from [10.249.32.196] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24B0qvAh024876;
        Tue, 10 May 2022 19:52:58 -0500
Message-ID: <92aa19b5-0e6e-057f-9dd8-becd7733d1f0@ti.com>
Date:   Tue, 10 May 2022 19:52:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2 2/2] rtc: Introduce ti-k3-rtc
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220511002600.27964-1-nm@ti.com>
 <20220511002600.27964-3-nm@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220511002600.27964-3-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 7:25 PM, Nishanth Menon wrote:
> Introduce support for Texas Instruments Real Time Clock controller on
> newer K3 family of SoCs such as AM62x.
> 
> The hardware module that is being supported is the "digital only"
> version which does'nt have capability of external wakeup sources and
> external power backup. However, for many practical applications, this
> should suffice as RTC is operational across low power sequences.
> 
> The hardware block by itself is split into two distinct domains
> internally to further reduce the power consumption with the actual
> counter block and comparators clocked off a 32k clock source (which
> based on SoC integration can be sourced by an external crystal) and an
> register interface block which is driven by the bus clock. While optimal
> from power perspective, it does create some complicated synchronizations
> and sequences that one must be wary of in the driver handling.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> (Andrew's comments):
> * Moved entirely to regmap fields - except for setting time, which I
>    have documented as to why regmap is necessary
> * Dropped the redundant MOD_ALIAS

Isn't regmap fun :)

Acked-by: Andrew Davis <afd@ti.com>
