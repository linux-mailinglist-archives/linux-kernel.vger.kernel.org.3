Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51947D4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhLVQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLVQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:04:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE3C061574;
        Wed, 22 Dec 2021 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=AkU5CTbPfYwafp7kpDyjYaPsr7IDWP2wJvX6uVQ3YIY=; b=WRjbGkNilG0DyVIjWOUkSgxnJo
        1DwQO9+FsVdowuuRWJYP7ElOF8R52M8ocYk2gtfgup++AuulT3VZVP8KA3I0rnh0OuWj8teKHyFeL
        z8CT/AD/0liCVDN3yPDyFAOLWT0lt0GuE8rrGWZM59mVttkt6cW+YycrIisHE+zkEHuE=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n0463-0003Xq-S5; Wed, 22 Dec 2021 17:04:07 +0100
Message-ID: <a83c5c25-c3f9-fbf9-93a9-39e763590c6e@nbd.name>
Date:   Wed, 22 Dec 2021 17:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>, john@phrozen.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-4-nbd@nbd.name>
 <04137b5dd876899af0da15f7dbc159fc@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v8 03/14] ARM: dts: Add basic support for Airoha EN7523
In-Reply-To: <04137b5dd876899af0da15f7dbc159fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-12-21 16:02, Marc Zyngier wrote:
> On 2021-12-20 21:18, Felix Fietkau wrote:
>> From: John Crispin <john@phrozen.org>
>> 
>> Add basic support for Airoha EN7523, enough for booting to console.
>> 
>> The UART is basically 8250-compatible, except for the clock selection.
>> A clock-frequency value is synthesized to get this to run at 115200 
>> bps.
>> 
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  arch/arm/boot/dts/Makefile       |   2 +
>>  arch/arm/boot/dts/en7523-evb.dts |  27 ++++++++
>>  arch/arm/boot/dts/en7523.dtsi    | 114 +++++++++++++++++++++++++++++++
>>  3 files changed, 143 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/en7523-evb.dts
>>  create mode 100644 arch/arm/boot/dts/en7523.dtsi
>> 
> 
> [...]
> 
>> +	gic: interrupt-controller@9000000 {
>> +		compatible = "arm,gic-v3";
>> +		interrupt-controller;
>> +		#interrupt-cells = <3>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		reg = <0x09000000 0x20000>, <0x09080000 0x80000>;
> 
> You are missing the 3 extra regions implemented by the A53 cores
> (GICC, GICV, GICH). Please see the binding and the A53 TRM.
The SoC memory map documentation contains an address for GICC, but not 
for the other two. Maybe this CPU doesn't implement them.
I will add GICC in v9

>> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
> 
> This is an ARMv8 CPU, even when used in 32bit mode.
> 
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>> +		clock-frequency = <25000000>;
> 
> Why isn't this properly configured by the firmware?
I don't know.

- Felix
