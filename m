Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C850A301
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389574AbiDUOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389564AbiDUOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:47:04 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD140E76;
        Thu, 21 Apr 2022 07:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1650552224; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nbdQctQ3NMB6Azygoollyi98j1+gOoW3m7kP8+kIzEJgV2tGoTDPbmS2Ivz8y7qFshxDSrpxgwFk5dgcGmgaee53NjiA8a9qEve8uyAWFYAp0dVaVaYM4xhHBpoyJCz95OKSxBM9Jj5VrWQ+FmMSMjKFGlG1AodNSubN9UMc2z8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1650552224; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ezL7d6UT6p1AeMHEGpnZeZmFAvnmD9WI18X7MSI3d/k=; 
        b=VH/Mi58H9v1KRSjeNyH5/jJxO+R2Pmhgf0IS1rGU8+ye0a/bG0kPsmQoiIEznVwPloJG1B626jzE9vE4hYg+7NfgF9Q07ENZZCkLD6azij+Onman5MacM6DnulqmGLv187YXghbXCu/WPAIw21QJvHOBwTvjs90U0dhPSQ28whk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1650552224;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ezL7d6UT6p1AeMHEGpnZeZmFAvnmD9WI18X7MSI3d/k=;
        b=AUzbWmEBG1bhlGXpDr/3Us4XJfC5rsXEH98tYb0vsCF9C8tTnA9sUo/cF5OGp4fq
        MB+7YT28SwlppWnpZxqptnOLD8Ug3lDZ2CtaQWCcDrxus/QqBBTEG5DsOhdVCDbf/yc
        Uo0EkzlovbchG+nUvwQGgYsJCZ2swQEdYIHZJStE=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1650552221122931.4968849395214; Thu, 21 Apr 2022 07:43:41 -0700 (PDT)
Message-ID: <26418320-64e0-3ed2-c792-7f72878b7592@arinc9.com>
Date:   Thu, 21 Apr 2022 17:43:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <CACRpkdbbMFYNNjAKwhysKpu1JVh2JSB-N=Y8QMx1JvMhCPBpwg@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CACRpkdbbMFYNNjAKwhysKpu1JVh2JSB-N=Y8QMx1JvMhCPBpwg@mail.gmail.com>
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

On 21/04/2022 17:27, Linus Walleij wrote:
> On Wed, Apr 13, 2022 at 8:08 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> 
>> This patch series brings complete refactoring to the Ralink pinctrl driver
>> and its subdrivers.
> 
> I just merged all the patches, the comments seem minor and any further
> fixes can certainly be done on top of this. Anyone interested in ralink
> working nicely is likely in the thread and we mostly care about that this
> works for OpenWrt, and if it works for them we are happy.
> 
>>    mips: dts: ralink: mt7621: use the new compatible string for MT7621 pinctrl
> 
> This was a bit scary since we usually take these through the respective
> SoC tree, but I just applied it anyway, it makes logical sense in the
> series.
> 
> I hope it will not lead to conflicts.
> 
> Good work with this series!

Thanks. There is a v2 of this series which has been waiting for a week, 
I hope that was the one you applied as you replied under v1 (I'm not 
sure which repository you applied this so I can't check myself).

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=632370

Arınç
