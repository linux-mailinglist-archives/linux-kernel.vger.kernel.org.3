Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B448EE93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbiANQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:42:15 -0500
Received: from foss.arm.com ([217.140.110.172]:35704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbiANQmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:42:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBBF76D;
        Fri, 14 Jan 2022 08:42:12 -0800 (PST)
Received: from [10.57.67.190] (unknown [10.57.67.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2F13F766;
        Fri, 14 Jan 2022 08:42:11 -0800 (PST)
Message-ID: <d2d54776-b4ee-2cda-334d-f868a6bbdf8b@arm.com>
Date:   Fri, 14 Jan 2022 16:42:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable the GPU on Quartz64
 Model A
Content-Language: en-GB
To:     Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
 <20211126151729.1026566-5-knaerzche@gmail.com>
 <EB2E04F1-BACA-4A4F-97F9-0257F29D57B5@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <EB2E04F1-BACA-4A4F-97F9-0257F29D57B5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-14 16:25, Piotr Oniszczuk wrote:
> 
> 
>> Wiadomość napisana przez Alex Bee <knaerzche@gmail.com> w dniu 26.11.2021, o godz. 16:17:
>>
>> From: Ezequiel Garcia <ezequiel@collabora.com>
>>
>> Enable the GPU core on the Pine64 Quartz64 Model A.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>> arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> index 4d4b2a301b1a..625489c60622 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> @@ -205,6 +205,11 @@ &gmac1m0_clkinout
>> 	status = "okay";
>> };
>>
>> +&gpu {
>> +	mali-supply = <&vdd_gpu>;
>> +	status = "okay";
>> +};
>> +
>> &i2c0 {
>> 	status = "okay";
>>
>> -- 
>>
> 
> Alex, Ezequiel
> 
> I'm playing with 5.16 mainline on rk3566 based tvbox (x96-x6)
> 
> Box boots and I have working SD card, Eth, HDMI.
> 
> I applied this series as I want to get GPU working but I'm getting:
> 
> [    3.169144] panfrost fde60000.gpu: get clock failed -517
> [    3.169646] panfrost fde60000.gpu: clk init failed -517
> [    3.213653] panfrost fde60000.gpu: get clock failed -517
> [    3.214156] panfrost fde60000.gpu: clk init failed -517
> [    3.230505] panfrost fde60000.gpu: get clock failed -517
> [    3.231006] panfrost fde60000.gpu: clk init failed -517
> [    3.258072] panfrost fde60000.gpu: get clock failed -517
> [    3.258575] panfrost fde60000.gpu: clk init failed -517
> 
> Maybe you have some hints here?

517 is EPROBE_DEFER, which implies it's waiting for the relevant clock 
provider to show up. I see from patch #2 that SCMI is involved, so I'd 
check that that's working and you have CONFIG_COMMON_CLOCK_SCMI enabled.

Robin.
