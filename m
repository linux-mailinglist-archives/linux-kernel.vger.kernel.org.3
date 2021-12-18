Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2102479956
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhLRHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:20:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLRHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBB260AF7;
        Sat, 18 Dec 2021 07:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0B6C36AE0;
        Sat, 18 Dec 2021 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639812021;
        bh=9i1TUA+CDSWdDEUdjwQ9lj0DV16oXIazcbfoNTlRc4w=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=QS4UBPx9DDuwV+dyeqw0LHv0rrsHiiLwKQDqWeBVbVw254Nw95lmtCh31fuz4ChR/
         5QLMExa7WXf1jKb5VVL5Gk75Q65uyovkQiGj8MKcjB/11EzTrn9PMBJzeDdptQJHSJ
         dyqyD2FBIQrYVs05YiSPmiXz/Ti60XOwPdj3pO2vGMrPoBo3axny5BLPRApGxzGMGH
         Q/ORuAfHAhcp+AHC9LNvhOAVe091fBYTJQxmjhi17Cq+9/kic3mMS8K7DN8O4lH2BC
         ZIZitjBzJqNTQI+MLqPQGD31qNqMq2gar8f+jhN6ULTqNMsjG2zhblakpkal+AJV4F
         S0xiUDsyaRhSQ==
References: <20211217125757.1193256-1-balbi@kernel.org>
 <20211217125757.1193256-3-balbi@kernel.org>
 <e2ed8317-a656-f6ac-9fc5-810588f33105@somainline.org>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch 2/2] arm64: boot: dts: qcom: surface duo: add
 minimal framebuffer
Date:   Sat, 18 Dec 2021 09:19:07 +0200
In-reply-to: <e2ed8317-a656-f6ac-9fc5-810588f33105@somainline.org>
Message-ID: <878rwi4bwt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Konrad Dybcio <konrad.dybcio@somainline.org> writes:

> On 17.12.2021 13:57, Felipe Balbi wrote:
>> From: Felipe Balbi <felipe.balbi@microsoft.com>
>>
>> Add a minimal framebuffer device so we can use the display on the
>> Surface Duo device.
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
>> ---
>>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
>> index a73317e1a824..c629ec115fec 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
>> @@ -25,6 +25,17 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	framebuffer0: framebuffer@9c000000 {
>> +		compatible = "simple-framebuffer";
>> +		reg = <0 0x9c000000 0 0x02400000>;
>
> You can remove the leading 0 in the size cell.

okay

>> +		status = "okay";
>
> This line is unnecessary, as it's enabled by default

understood

>> @@ -472,6 +483,14 @@ &pon_resin {
>>  	linux,code = <KEY_VOLUMEDOWN>;
>>  };
>>  
>> +&reserved_memory {
>> +	splash_region: splash_region@9c000000 {
>> +		/* We expect the bootloader to fill in the size */
>
> Would it be different than the framebuffer size?

honestly, I used this mainly to get the correct base address and size. I
had 0 everywhere and bootloader filled the entire thing for me. I can
just hardcode with the expected values anyway.

-- 
balbi
