Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1C47E0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347368AbhLWJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:05:51 -0500
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17316 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhLWJFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:05:50 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 04:05:50 EST
ARC-Seal: i=1; a=rsa-sha256; t=1640249434; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dwpB7OFNGflmjcKbDeSVkrH/tUMQeqdSxS4FpU295UHclhe6KDQUaeZxW4wWpaVUWt0qHvK5NBIV9IxFQVxHbwsxntpvHjWKvWcMuj2eUJNVUTd1i7Ho9XgAvyCpVJAls04tjUPGfx6hVN32BAEFleDR1m7bnX/ViKFTASWBaMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1640249434; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DJkdSSAVJ0Fgxtxqhs8xqbc2KjyAFqGIpOZQ3XEaDHs=; 
        b=Suspb8Le3GipEeUge3xEFYvjaXWEm/BB5K/cXtqzlXsYuDbiYNAkXy7hIetlJK62J+OQnV3YvCtTp8Grxhhy8kULiN1k9RW2+rj/pN3DGfK1gvzWPjUhzcYOz/XizZjF9XfpixbuKSN4I0uscckqX7w/5kJAECc7X3HGBDxqNIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1640249434;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=DJkdSSAVJ0Fgxtxqhs8xqbc2KjyAFqGIpOZQ3XEaDHs=;
        b=MpW2bVwSs8TvWAwZWEvyoaECMgc+9lXKwumfPflGJ8s4cOvGmip/IVxeNQ2arOxd
        +cYS9wfnvykbqeXOsolL5z3uRyioBrGDWApnEzwVFMMuOoniyViqKVE5pvhd1XNHRMZ
        mBqQnqlM3iRHfW9nUxUVB6h/NMyeIeBstrBges8w=
Received: from [10.10.10.216] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1640249432932810.9005630667605; Thu, 23 Dec 2021 00:50:32 -0800 (PST)
Message-ID: <00324e0f-7825-4ddc-a823-40a698715442@arinc9.com>
Date:   Thu, 23 Dec 2021 11:50:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: build warning after merge of the arm-soc tree
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211223085944.0095eaf5@canb.auug.org.au>
 <CAK8P3a3WxP1x60fj7oPzY2=gTUEgA68x1vc17tRHEJ-O19-UTQ@mail.gmail.com>
 <6a830fc3-2186-0335-a600-8410abc24ea2@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <6a830fc3-2186-0335-a600-8410abc24ea2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Florian.

I'm not sure I understand what's going wrong here. I did everything 
according to the documentation here:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/dsa/realtek-smi.txt#L158

On 23/12/2021 02:58, Florian Fainelli wrote:
> On 12/22/21 3:22 PM, Arnd Bergmann wrote:
>> On Wed, Dec 22, 2021 at 10:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Hi all,
>>>
>>> After merging the arm-soc tree, today's linux-next build (arm
>>> multi_v7_defconfig) produced this warning:
>>>
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:109.4-14: Warning (reg_format): /switch/ports:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #address-cells value
>>> arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_default_addr_size): /switch/ports: Relying on default #size-cells value
>>>
>>> Maybe introduced by commit
>>>
>>>    3d2d52a0d183 ("ARM: dts: BCM5301X: define RTL8365MB switch on Asus RT-AC88U")
>>
>> Confirmed, and now reverted as I'm already tagging the final pull requests.
>>
>> Arınç, Florian: Feel free to resubmit a fixed version for the "late"
>> branch that Olof
>> may still pick up when I'm out of office, in case this is an important
>> change. Otherwise
>> I guess we can leave it for 5.18
> 
> Will do, thanks and sorry about not catching this earlier, I did not see
> it it in the build log somehow.
