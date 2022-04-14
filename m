Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6A500851
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiDNI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiDNI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:50 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDB5403E9;
        Thu, 14 Apr 2022 01:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649924769; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TS/8AbcqCcTg0XG6oD4ZAE+/nlorL1IE/FgNXvAKY8/FXCi4dpfQtmtWgd+bUnaSu2BJ4WQYG07yrnBODvM/G3NsF7Jbfo3KAlXsUcutEnwjfFNJTvkLuxAWsFhxCItt4zFANxBJgYHNx6aU927chAUEIDu3Ur3a+A7Q7XHiTgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649924769; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9Xw4AMUNkwII/4xbpRieFUaGZTpw21Ls4OfPB8J1Qu0=; 
        b=FWGuaCtSaof2Kb+Tmr2tT5kNYw2FI/7amq+6KT22VIh7EVtOlGzGOQAYm90D6SEsgnZQxdNFa6UHQJOD+NBrYBlSx6iyTjgfT/Pdn2fVZfru9+dbYMC3/AF6PQ5dL56qlk8OHv807IECuI0948/OyvYnZNqGIl+eRN5ErZKSl20=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649924769;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9Xw4AMUNkwII/4xbpRieFUaGZTpw21Ls4OfPB8J1Qu0=;
        b=QwmRSeZ9Awu88SodbDp1aVMHhVIHOHfwUTi8j70ziaPnmPo6LkUc+uMNpvuKLCEX
        n1wFWdmdyVW9Gislvx/ndRiTV8Im+vtCYeJSmbCws0Ci0QxfruRnxrhgkaPEv0JBv0T
        44ZuuLrdvftxCw9Lq08rh+5L3RPRAbObLe0dL5+M=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649924767135253.6117557774876; Thu, 14 Apr 2022 01:26:07 -0700 (PDT)
Message-ID: <b8a5b9d0-0020-31d7-f9c1-3e971f28aa94@arinc9.com>
Date:   Thu, 14 Apr 2022 11:26:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
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
 <e6424c41-fadd-d326-49af-28db51606c2d@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <e6424c41-fadd-d326-49af-28db51606c2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 18:39, Krzysztof Kozlowski wrote:
> On 13/04/2022 08:36, Sergio Paracuellos wrote:
>> I think you cannot change compatible strings because you have to be
>> compatible with previous stuff. That is the reason why when I
>> refactored all of this stuff from 'arch/mips/ralink' into
>> 'drivers/pinctrl' I maintained the same for all of them and only
>> created one binding for all. I know that these SoCs are mostly used in
>> openWRT and the way of doing things there is that when a new version
>> is released a new dtb is also compiled so I understand the motivation
>> of the change itself. In any case, Rob has the last word here, not me
>> :).
> 
> Breaking other users is usually not accepted, so some good reason would
> be needed here...

As I explained on my response to Sergio, this doesn't necessarily break 
anything.

> 
> 
> Best regards,
> Krzysztof
