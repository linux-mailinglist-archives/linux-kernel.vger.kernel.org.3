Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3B49DFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiA0Koc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiA0Ko3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:44:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8EC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:44:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so2989228wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iKifaOc9BJNsPhhZWXxvCORQUmFhdoLB1/L1im+j4Bw=;
        b=lzqbWkgNumeAcUAhOU+IXhVTzWpBSTLyGhZ2xhO+cApu3VTxgrX8WjEDopdkP5hVoD
         l/MXDqzcA0L2Ev6oc5IkZhze7ODYIA7azKkthZJtspXxgtRhHSwnDVgsy2sN40js+map
         9V8H5bl77xrAn/MJgRxVRy6TjcEnIU7F1Y7kEqJJ/yCBKPciV/UInLTHm0e4GgMRTIdO
         z8kwoWK3sdChLrLtpjcuQqh2c7tyaRkccBSF5Ax17ETBo9AMkP0c/dPTcL4Lspu3Y2j1
         DGrHO0UIOHkDk6xGs9+oAPCpKfy/biXxjqDdUVxuuGqFOyFuiHtvo8ERAswg0yMENYup
         LkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iKifaOc9BJNsPhhZWXxvCORQUmFhdoLB1/L1im+j4Bw=;
        b=cSoK9CAeXz+B+xsRzDnRO2jtlseTX2LILkdSRGiNWLOoOsxqnVVhHddkva9MXiB0mU
         Twv7s2CdqBo+7CQgPqEVXBJ/1yxwgr/sQ4OWY85LxRIOyvWtyzhq7lhTklzCqF58ZheB
         MHa6ADUbgg3d+SsodkGvZw02fHKvj3zdHn+earGsbRVwpqii2ynFpnBRTIW32UBx3FPI
         C6TrPbej30F2ETOThd05Du6ZJdl9ND18h8pk06ZA504dRHmTTmK7wLvj9htMilYDl6xj
         nOQ+5sKVK6gIMYDNCSJswOUiOAEkms5X96QfAN795mVBmGm/9lSXuncP/7BmNoENXWie
         HBzQ==
X-Gm-Message-State: AOAM5331BM3ODlaScVIUn6B9rRxWthRaPfQEX8cBGBCVwWCI+nRBVRBa
        f5MxGiZwx1R/TelcR/6Cm7kfllyTaoyvUw==
X-Google-Smtp-Source: ABdhPJy3LLNGEkfT2tqGaRBRmvMSGiTJQTiSHEfsmvm0wejzQhgHaj9YDISNOPKRKd2NwcQlTPF+8g==
X-Received: by 2002:a05:600c:4e49:: with SMTP id e9mr2669723wmq.92.1643280266901;
        Thu, 27 Jan 2022 02:44:26 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id f6sm1749482wrj.26.2022.01.27.02.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:44:26 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: dts: meson-gx: add ATF BL32 reserved-memory
 region
To:     Vyacheslav <adeep@lexina.in>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-2-christianshewitt@gmail.com>
 <a279c365-0615-1c7f-5596-dec9ad1c8229@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3924894b-d479-7ec2-ff68-b830137f3b79@baylibre.com>
Date:   Thu, 27 Jan 2022 11:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a279c365-0615-1c7f-5596-dec9ad1c8229@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/01/2022 06:35, Vyacheslav wrote:
> Hi!
> 
> 26.01.2022 07:49, Christian Hewitt wrote:
>> Add an additional reserved memory region for the BL32 trusted firmware
>> present in many devices that boot from Amlogic vendor u-boot.
>>
>> Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 6b457b2c30a4..aa14ea017a61 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -49,6 +49,12 @@
>>               no-map;
>>           };
>>   +        /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
>> +        secmon_reserved_bl32: secmon@5300000 {
>> +            reg = <0x0 0x05300000 0x0 0x2000000>;
>> +            no-map;
>> +        };
>> +
> How do I check if we need a similar patch for axg boards?
> 
> 
>>           linux,cma {
>>               compatible = "shared-dma-pool";
>>               reusable;
>>
> 

For AXG board with BL32 booting from vendor u-boot, yes.

Neil
