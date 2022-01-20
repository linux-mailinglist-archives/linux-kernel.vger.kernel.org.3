Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4714956FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiATX34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:29:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5977 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiATX3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642721393; x=1674257393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=psspI7jUka7l1HTgpKRAQLRWFYkD2vqA6mSKTaIxNZw=;
  b=TOldPPD7IFhjJyccBcq7QCzFwnO+NpvrMbvSMVBj8LF2rVcZ5u9hQ4b1
   KhKYlqoBtyHv0tyO0cm/oiHFSFbZJuHkyPn5yZT+wdyV96yB2PTjOZ97y
   0V3DMFsksy+J9p+Pnn/145jtxfKDT+74VK3F4VDTa8h6YDhz5EAxie1ta
   ud/ShlFdBmMqPmmxHHeGNWRhjHDVXKuPZ2b9oBcG/26fShHytOAqcnUxQ
   sQthERB7MF6fJHg/SMOv4GMUHZsbNDjTsYQK28QjbDyzGkhj0GT0VUzUa
   xa5qWr8360xIazjlCPNYTkLvEP7pg7VIBHiM4cU+wfM/eYRADkvC5W3OJ
   g==;
X-IronPort-AV: E=Sophos;i="5.88,303,1635177600"; 
   d="scan'208";a="195790172"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 07:29:53 +0800
IronPort-SDR: VizaH9XDHOx1qaqN8ofkC3RA7qta1UewHmFAl9H+US3zqyXJYPt/KcnKdR8QFItlQuvLw2epbP
 axygVI6+VMnT4hl9mz0l9dLrjtS7ljd3SATUJxPBAOyA4OiKrsJ3Pe6CmfLchYEdmfGEkDPmNb
 ZBs3nNBpWv2bjSuxWNUnnF5YScCf15aJlR1BQ7VN5MGJSxJaHxID8keADTDU93kR6gVuSbHsxo
 +LHNK2gFcLGxoH5R1NcktchM+CYHy94aoGidzveCRGyyytg/IxPmKzmQzbDvwHFm9I3DOKgmGo
 N2zQE2kH9FlsvGEzY9F7KLlw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 15:02:06 -0800
IronPort-SDR: mZPVRNCcrQg0GSMxctVrj1B5CpZbH7XSaburiAROp35ljKYTcDnD7YqZpudMdcVzJPjHEtlf/S
 1uqeXAJnPE0UZ/3c6R2Pk7j78VC8oOs9gLqyg2q7YyrLKBhiVvcLgIW11IsXT5PINBLUpXfcSm
 IENFtq8Mek+1AmrB9IWraE/UF6lpzk4Oxn8wNXx/5XBFpfVEO1id3M5kgHGhPqgJS+EmG9TpiU
 LF7dd2EnHy+L3E2P+xnmU6TwO0HI6C/SVbZVHOpY7WDi59NFAs7L8c+b4jOYTHDGKvSMXbLwEw
 Jw0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 15:29:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JfzJ23vbfz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:29:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642721393; x=1645313394; bh=psspI7jUka7l1HTgpKRAQLRWFYkD2vqA6mS
        KTaIxNZw=; b=nY+bK1p5f/y16LwFAL7SRWdDg7OIvvNrGkwWjmYQFwv5jekFLTp
        BNnh2xgLpwC33+Cz1um2D6OGCVGHUtfSQPgPJq7a63cS0SjdIg7vWa+Pvx6I6JYH
        i0RZftMH8W95u/hPMwYpipEfVl14/ZSrTWJ7qBY4NH68Padde8AsKTQJG6NtNuHM
        fWT76bnC1YYJ/m0g18kYzRevsV1Y9qDJOrW1MzcBLrLuynPboCY0I4UXPueuXWMM
        GMOgCCuiK/Vs6fU9gKaDqYmokP0wpYglni87fn1tnFgTNzW1YeQo+df9iaf/1Zx3
        JV72TK0jVg2JE0xZ9OlOTJcMeEqeeGeJfbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Nxg47vHItI2p for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jan 2022 15:29:53 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JfzJ030Z8z1RvlN;
        Thu, 20 Jan 2022 15:29:52 -0800 (PST)
Message-ID: <730eae0f-6d79-f84b-fe63-a1c4223d7379@opensource.wdc.com>
Date:   Fri, 21 Jan 2022 08:29:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re:
Content-Language: en-US
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Myrtle Shah <gatecat@ds0.me>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220120152828.4089364-1-gatecat@ds0.me>
 <CAM4kBBJqHVX_Q2C0VO7qKNZywRiWbHK9t0G076ov6u+_gwO2=A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAM4kBBJqHVX_Q2C0VO7qKNZywRiWbHK9t0G076ov6u+_gwO2=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/21 0:37, Vitaly Wool wrote:
> Hey,
> 
> On Thu, Jan 20, 2022 at 4:30 PM Myrtle Shah <gatecat@ds0.me> wrote:
>>
>> These are some initial patches to bugs I found attempting to
>> get a XIP kernel working on hardware:
>>  - 32-bit VexRiscv processor
>>  - kernel in SPI flash, at 0x00200000
>>  - 16MB of RAM at 0x10000000
>>  - MMU enabled
>>
>> I still have some more debugging to do, but these at least
>> get the kernel as far as initialising the MMU, and I would
>> appreciate feedback if anyone else is working on RISC-V XIP.
> 
> I'll try to support you as much as I can, unfortunately I don't have
> any 32-bit RISC-V around so I was rather thinking of extending the
> RISC-V XIP support to 64-bit non-MMU targets.

That would be great ! I am completing the buildroot patches for the K210. Got
u-boot almost working for SD card boot too (fighting a problem with rootfs
kernel mount on boot when using u-boot though).

> For now just please keep in mind that there might be some inherent
> assumptions that a target is 64 bit.
> 
> Best regards,
> Vitaly
> 
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


-- 
Damien Le Moal
Western Digital Research
