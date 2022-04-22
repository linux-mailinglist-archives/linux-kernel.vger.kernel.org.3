Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18E50B051
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444271AbiDVGRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442942AbiDVGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:17:21 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B25046F;
        Thu, 21 Apr 2022 23:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1650608037; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Upc29wFEZbY9EpRHZYitREhkrRXSEoAPDtx8gDCsqYwhKkJNleVA5Fm4X91oEzQuYjB/8+Peb6ZTQLcub1fM3CiTv2KxB8Svg+igpE3DNeIc7BDu9BbhW2A0sUyRjzw/JZx26VqggDaF46jej7IGF4Y/lDzGmA/zFipRv9C5J3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1650608037; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UFvld06qgXbqQi+xJzwXOyVaCMSC9MrrcLtY4RAgqNI=; 
        b=FfqMs5rwPZedfIDvP5jj+A32qjrU7nt89H46DUvNMa/vwrzj2jMNwbsj/4WeERRRX8cID6b+2fn0+Jny5wZe383wv34fq9+YrkznEULl0mppOhVEiYSL4iwTUA/kcZYig3/stDaP4uzPeUKHw9iAtKBNmW6ZlbwDHTgjvMp0LcY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1650608037;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=UFvld06qgXbqQi+xJzwXOyVaCMSC9MrrcLtY4RAgqNI=;
        b=WfNpEQFRk5/DPSn8YyQZnbOY1qy0b5Ub/T9xf0jbigszz5Aipcm4k81w6k/txiz2
        xhD+WXL4Z3NLjJ8sy4UzEIjCndqiJ+gIbYrA/S81g9mgbV/M5woDGiFw6GijzyrsTHB
        c8W44JeyWq3sT0KWGLPoMZzDn5P6Gc+B3saEqbOs=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1650608035654467.1535935949838; Thu, 21 Apr 2022 23:13:55 -0700 (PDT)
Message-ID: <6cdec3bc-4715-29c8-f4a1-df1408940a75@arinc9.com>
Date:   Fri, 22 Apr 2022 09:13:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
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
 <CACRpkdbbMFYNNjAKwhysKpu1JVh2JSB-N=Y8QMx1JvMhCPBpwg@mail.gmail.com>
 <26418320-64e0-3ed2-c792-7f72878b7592@arinc9.com>
 <CAMhs-H_d8jUa4=4eVjQxo+h-XeRgiMYC1H_xYtPLb8jHDVYL2Q@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H_d8jUa4=4eVjQxo+h-XeRgiMYC1H_xYtPLb8jHDVYL2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 08:21, Sergio Paracuellos wrote:
> Hi Arinç,
> 
> On Thu, Apr 21, 2022 at 4:44 PM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> On 21/04/2022 17:27, Linus Walleij wrote:
>>> On Wed, Apr 13, 2022 at 8:08 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>
>>>> This patch series brings complete refactoring to the Ralink pinctrl driver
>>>> and its subdrivers.
>>>
>>> I just merged all the patches, the comments seem minor and any further
>>> fixes can certainly be done on top of this. Anyone interested in ralink
>>> working nicely is likely in the thread and we mostly care about that this
>>> works for OpenWrt, and if it works for them we are happy.
>>>
>>>>     mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
>>>
>>> This was a bit scary since we usually take these through the respective
>>> SoC tree, but I just applied it anyway, it makes logical sense in the
>>> series.
>>>
>>> I hope it will not lead to conflicts.
>>>
>>> Good work with this series!
>>
>> Thanks. There is a v2 of this series which has been waiting for a week,
>> I hope that was the one you applied as you replied under v1 (I'm not
>> sure which repository you applied this so I can't check myself).
> 
> Linus adds patches through the linux-pinctrl tree as pinctrl maintainer. Check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Thanks Sergio. I see v1 was applied, oops. What to do?

Arınç
