Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF694FF0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiDMHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiDMHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:55:45 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8572E6AE;
        Wed, 13 Apr 2022 00:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649836378; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mKct6M+UBGyU7j39wTQrgKyzwdh0KiMVeJk80Z4LzYctoK3TgOmrGQiyfoBVUJJujqzcWW7BqtbrTf9fyQUguhC1uNUmCFnAU7YqYg7ohWVI5miE+jcrFRYe7g6sv8nCWUtMuG/Bb3GWjWNQQV8wUIaRCztSV88wbnJBx9i1F/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649836378; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=zomQ5tkYUJQV/3TJDTF1FVvqyX+VAC+jOEvBXwvebdU=; 
        b=lb7QwzK65hotCejcO7hxT4y8YipfdATaywZzQshOxff7OC/Qr+3vImB4C+gZT9WMd0a9FWlcSqN2clsijrn5slsUgcipB1AJs1U2kRSJ7CTTyzt41Cpm4fMav75BM3kh1cXhpypHDPxFr83Puqfo+tyTMPBpdVtAGq/OmyCyqJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649836378;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=zomQ5tkYUJQV/3TJDTF1FVvqyX+VAC+jOEvBXwvebdU=;
        b=e89SmhNJ5FZkqrQW94QrXssLlzSV86kG+fLu1q2zzMgMavE9G/xMjsALSDHA8llN
        wb273CrdYKeR2l8CZQbKqehIC2veKw3S2gVI1cbRiRq235jizArTzPCXApRX+Ya72tU
        UtDO92ixvG8Nmvs0ZxEkhjKJ9XJsekSIhVcBFPpo=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649836376347263.13841951297684; Wed, 13 Apr 2022 00:52:56 -0700 (PDT)
Message-ID: <84088c4c-b4bd-30f3-ce25-d59c55d5898f@arinc9.com>
Date:   Wed, 13 Apr 2022 10:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <CAMhs-H_oRzpeqJY8Oe+7Su5v-4B1WPwzOfhrvBC08FVi-O6fVA@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H_oRzpeqJY8Oe+7Su5v-4B1WPwzOfhrvBC08FVi-O6fVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio,

On 13/04/2022 09:36, Sergio Paracuellos wrote:
> Hi Arinç,
> 
> On Wed, Apr 13, 2022 at 8:08 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> Hey everyone.
>>
>> This patch series brings complete refactoring to the Ralink pinctrl driver
>> and its subdrivers.
>>
>> The mt7620 pinctrl subdriver supports MT7628 and MT7688 SoCs along with
>> MT7620. These two share the same pin layout. The code used for MT7628 and
>> MT7688 is renamed from MT7628/mt7628an to MT76X8.
>>
>> Ralink pinctrl driver is called rt2880 which is the name of the Ralink
>> RT2880 SoC. A subdriver for the Ralink RT2880 SoC is called rt288x. Rename
>> rt2880 to ralink.
>>
>> Rename code from pinmux to pinctrl for where the operation is not about the
>> muxing of pins.
>>
>> Rename rt288x pinctrl subdriver for the RT2880 SoC to rt2880.
>>
>> Variables for functions include "grp" on the Ralink MT7620 and MT7621
>> subdrivers. Rename them to "func" instead as they define the functions for
>> the pin groups. This is already the case for the other 3 subdrivers;
>> RT2880, RT305x, RT3883.
>>
>> Fix Kconfig to call the subdrivers, well, subdrivers.
>>
>> Add new compatible strings for each subdriver and update DT binding
>> accordingly.
>>
>> Add Ralink pinctrl driver to MAINTAINERS and add me and Sergio as the
>> maintainers.
>>
>> Finally, fix the current rt2880 documentation and add binding for all of
>> the subdrivers.
>>
>> I have the patches here should anyone prefer to read them there:
>> https://github.com/arinc9/linux/commits/ralink-pinctrl-refactor
>>
>> Ralink pinctrl driver and the subdrivers were compile tested.
>> MT7621 pinctrl subdriver was tested on a private mt7621 board.
>> YAML bindings checked with:
>> ARCH=mips CROSS_COMPILE=mips-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/ -j$(nproc)
>>
>> Arınç ÜNAL (14):
>>    pinctrl: ralink: rename MT7628(an) functions to MT76X8
>>    pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink
>>    pinctrl: ralink: rename pinmux functions to pinctrl
>>    pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
>>    pinctrl: ralink: rename variable names for functions on MT7620 and MT7621
>>    pinctrl: ralink: rename driver names to subdrivers
>>    MAINTAINERS: add Ralink pinctrl driver
> 
> For all these rename stuff and MAINTAINERS change:
> 
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> 
>>    pinctrl: ralink: add new compatible strings for each pinctrl subdriver
>>    mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
>>    dt-bindings: pinctrl: rt2880: fix binding name, pin groups and functions
>>    dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
>>    dt-bindings: pinctrl: add binding for Ralink MT7621 pinctrl
>>    dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
>>    dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl
> 
> I think you cannot change compatible strings because you have to be
> compatible with previous stuff. That is the reason why when I
> refactored all of this stuff from 'arch/mips/ralink' into
> 'drivers/pinctrl' I maintained the same for all of them and only
> created one binding for all. I know that these SoCs are mostly used in
> openWRT and the way of doing things there is that when a new version
> is released a new dtb is also compiled so I understand the motivation
> of the change itself. In any case, Rob has the last word here, not me
> :).

I looked around pinctrl drivers for mediatek. What I see there is that 
each subdriver has its own compatible string. There's a documentation 
for each subdriver. Each subdriver contains different pin groups and 
functions like on ralink. My patch series basically does the same for 
Ralink.

I don't see this patch series causing much of an issue for OpenWrt. 
They're going to have to update their Ralink DTs with the new compatible 
strings when they either switch to the next LTS kernel or decide to 
backport Ralink pinctrl changes to the current LTS kernel.

Cheers.
Arınç
