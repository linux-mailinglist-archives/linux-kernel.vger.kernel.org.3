Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F804A6F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiBBKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:46:30 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiBBKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643798785; x=1675334785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6k7tE3M6bpnJHQHnhJCh/DCDGRD7sVYF5zWLizvvIyY=;
  b=Qcr4y2hhSNTBg/PsN1RXPJ/A+XiH/kfnK3Fr/JkjAHgtsevx8Yq1p0/y
   K0ROq4uf3CoKh+sEGVoaJ2SPRFRoQmp7K7zu646OeO54TldUSrDybqKdN
   F6j/JyhVVzX39eGfapWHV0IHBWMtb7y2UZwGSBxnOCFKChoa+2byILk68
   UKyDlGlbVDRoOA7ezHCsRt31HpUxSVgbawvka+p4R1EPnE0+MgGBYRmtR
   qsGOCcVWE2WFKlWQj2u2TktSiXNEOgpGl3kCIZzwwWmLx+xYyoJnZq6Xx
   7tFExL4fDepMBBx4t5J1zfjGiJ1qNXT2+4opa7dF8KKrsse0brqd0UXWD
   g==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="303864284"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 18:46:25 +0800
IronPort-SDR: EVbCUULnnt4pRJMd3ahkceTYs3qaiJmIZe+qE2oxTrHSZ7wbbjjTApHmi5GxGRCb/TCUte29NN
 0JdC9yS02pDff4M51VAwmuuP+yuV93OqdmtpWjIHWbcGtb8dwnXKtHyeZY6H2VOWvgSd8nkSWc
 anr7hT65XfsHjrtjNL6ua+pfHCv+AqJGSNCoFPdOSYzwWjPqdL9OzOG0AOOW8Iim6pNEUO8XOP
 Sgz+wZKPVlU+kF6YTfIMUX9w6DQzW+uO6jStMw7pI28Qz2/jnp5SYXo4o6QkFK9QJ5ah1xxjuw
 MzHjD7beiYiJpbTUI6Gchgxn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:19:35 -0800
IronPort-SDR: gw+BHpJuLCxmUBNKmRu5v3tFvpfWfDUPsCBiaIMH1cTJZv+zmSEoBY+wNnbuZ0k2A33Az1qeH4
 olBiH301MW59dU+GUKf2gypDa22D27gKUZPI76Y9bFghzqKD0dnIMmn8H8UX0T2CM0uazZm1Of
 xCGyA2zCrJcZ29lPfOvGUSy40vufk3P8vUJgtFaffAKt9yACnng0XNjHVBmrvfJWvWMFnA9NCc
 6Z9AQ6phyCMcbD2Vojv896YiMmg+KEjVay8rALw3rHi9m6Rh0KJKwQaizzoyqxwQFb7HezSSZj
 4fk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 02:46:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpdl52SJxz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:46:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643798784; x=1646390785; bh=6k7tE3M6bpnJHQHnhJCh/DCDGRD7sVYF5zW
        LizvvIyY=; b=Xi88hxJNWip64lmBn8x6HoOeVthH818CFRxVaCnDn8mgkRPaZgb
        GFmn0hAJpD/CUOTOWiCcPI6NVcs+60OBFUkXygG3cGdlPTtDnOueL9C3lJgVhjyC
        Bx10geEuzaoLMONAjHmOt7H1ba2816Rp5KSaryC6S/zUOs1HyrV0eeuXg9gWZVM4
        hVuUhL6tqs978ud++ixMb63wir16MeuLVHgyHZ46Y0tmtBEt1z0YAjspJUDf5YlA
        fdXf7pYV6aZiES5+1jUOtj/nZ5T48vJhrsXo7DStb1sEiv7GLAV4XroURnsut5Je
        Y1hmmlDYg/ANxWhbqlD9IniYHe7jAJ/2kVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M8e6XZ-71IiS for <linux-kernel@vger.kernel.org>;
        Wed,  2 Feb 2022 02:46:24 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpdl36PLqz1RvlN;
        Wed,  2 Feb 2022 02:46:23 -0800 (PST)
Message-ID: <c49abe7a-bc95-a692-29d3-eb37ee6f2e1b@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 19:46:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
 <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
 <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
 <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
 <d16a1be7-d856-f6b7-5a1a-9f09f42195ee@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d16a1be7-d856-f6b7-5a1a-9f09f42195ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 18:24, Sergei Shtylyov wrote:
> On 2/2/22 1:56 AM, Damien Le Moal wrote:
> 
>>>>> Thanks for doing this Corentin!
>>>>>
>>>>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>>>>
>>>>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>>>>
>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>
>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>
>>>>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>>>>> this patch when he feels it looks good.
>>>>
>>>> What do you mean ? I am doing my best here to maintain ata !
>>>> But I definitely do not have all the hardware supported for testing :)
>>>
>>>    I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
>>> But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
>>> booted in a long while)...
>>
>> More reviews are always welcome ! Thanks !
> 
>    How about me submitting an "official" PATA reviewer entry in MAINTAINERS?

Sure. That works for me.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
