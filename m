Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14754D8B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbiCNR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiCNR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:57:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6E0A3EF05;
        Mon, 14 Mar 2022 10:56:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11997ED1;
        Mon, 14 Mar 2022 10:56:06 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2C333F66F;
        Mon, 14 Mar 2022 10:56:04 -0700 (PDT)
Message-ID: <5107aba4-a03d-a0c9-dc89-0e8472be1bd8@arm.com>
Date:   Mon, 14 Mar 2022 17:55:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
Content-Language: en-GB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
 <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
 <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
 <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
 <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
 <f497fb65-3568-cda2-f086-2275b50daf4b@mleia.com>
 <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
 <CAK8P3a1KLHwABtXwu-8Kg-GyKbETz1uRhdCz5edELOGG7JdaMg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAK8P3a1KLHwABtXwu-8Kg-GyKbETz1uRhdCz5edELOGG7JdaMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-14 12:32, Arnd Bergmann wrote:
> On Mon, Mar 14, 2022 at 1:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2022-03-14 11:50, Vladimir Zapolskiy wrote:
>>> On 3/14/22 1:43 PM, Robin Murphy wrote:
> 
>>>
>>> Thank you, it explains, why "apb_pclk" is required for all PrimeCell
>>> controllers on the SoC. Nevertheless, in commit 93898eb775e5 it was
>>> misidentified with the sspclk clock, the latter one is the only clock
>>> explicitly utilized by the driver in 2015 and till today. Fixes in dts
>>> files should be preceded by a fix in the driver.
>>
>> There's nothing to fix in the driver, though. In fact it can only be
>> working today because the Linux driver isn't very strict and simply
>> assumes that the first clock entry is SSPCLK *without* considering its
>> name (other consumers of the binding might be stricter; I don't know),
>> and because presumably the HCLK happens to be enabled already anyway.
>> Changing the driver behaviour would only stand to cause functional
>> regressions.
> 
> We can change the driver to look for an sspclk by name first, and
> then fall back to the first clk if none is found. This would be backwards
> compatible and allow new dts files to have an arbitrary order, though
> we still need to be careful about changing the existing dts files after
> that, to avoid breaking older kernels.

Yeah, I discounted that since schema is strict about the order of 
entries even when they're named, so we'd have nothing to gain except the 
potential to break compatibility in one direction and annoy users in the 
other. There's little point in having code to look up a clock by name 
when we know that for compatibility reasons it has to be the first 
clock, so it would be functionally identical to the fallback code that 
we also still have to have. All it could offer is additionally printing 
a message about it, and experience says that that achieves little except 
the aforementioned annoyance of users - I look as far as my Rockchip 
boards that have all been screaming an error at me every boot for nearly 
4 years now, where the ethernet driver fails to get a clock that only 
exists on some SoCs *other* than the ones I have :(

Robin.
