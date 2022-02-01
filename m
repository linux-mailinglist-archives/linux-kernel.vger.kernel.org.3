Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13F4A6846
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiBAW4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:56:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38560 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242426AbiBAW4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643756199; x=1675292199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEXkrnQvPN5XB3Pk+Ih5O9VSg3x9zd2WVW69XYIHQXo=;
  b=pe4zeJ3DU2e2urRIpXNQZrXNjO4InCrtsTtkIbUqBQSrGtobhw8WSzjb
   TA6AOT9TjX9hmXAmJ7yeeHszXcvvad5K24OepmdMzAsZrI2KhqPpVHdty
   igZTs0EkXDcU10JAyR43Nxt54miMCpUrgec/D9/SF8OJg5X6mlpIC8/uZ
   fpxIHHItOxe4gw0kH/e7KdKLcP5sGRzZOZ5G1UWMMYQejqvTqSHViISu4
   J1Qhb4fYj/XWHt1AzM0GCLdh5TkW+mXwki5SjQWb5YerrxWFebRZ8Mwyb
   Ib6hz65Gde5nkQ6c+M7EQgnJ/d2iejvLt/vT8+MJmw3twBqe9Ukcqepre
   A==;
X-IronPort-AV: E=Sophos;i="5.88,335,1635177600"; 
   d="scan'208";a="296012930"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 06:56:39 +0800
IronPort-SDR: +yCdZ6Q5Nbi8rNfxUKtcFYYZhHAn1vNG7g4nPMu7jhiXZI9Uo5HEFQ3uAuHAj0Xs7SBgqqCuxu
 GYL//KJJb33OhqcCv3NWE5LVuc/mt4UH0zLuKt3BLF0xwQaFNQA9AvoyvNASERccLId7ZmmltO
 qP1BrPrAjf9Y/7obFU7cCO+ud/5Fq8V1yEHREq4DfDY7UoctKHttU0jFhw/d43najf//5f5CrA
 E866syjO6uD8yvVqWK2mzNT/sztgy5m/x8ghJ1ZAH8FXCbL4DHmH1qWDYeS8D7nr4sk+29Z9/P
 rS3LSzQRzzA+mfO1Gxei6Uv6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:28:36 -0800
IronPort-SDR: 8i+FEJAFxv5Arll2YM8wKMtDvf3ftdLkwLuXb7RjWmqLVOXbW9DMY/cgoWJaP2wrG4XflAmhy4
 vYo4JTqKTv5cAZrnrz0ghE0Xa7De4gm4DGIq1KEa0wbkSXPeBoKrusj55YJoo2XZpi5Rf9hD+g
 Ig1BSEWBYadaqSgfv6sjCZ5UrYaIQB3gcsJY4aCBhRiHooXFAT7L5tpMXFhJRnRK4vkINvlJzl
 9AzRlWKNWtUgfhicsnMA/otJYYUyAXZRP5DhMg6279peUlh4dAr9UR8ZEcfFqqKUPxzPXbdAsb
 M2s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:56:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpL070jcCz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:56:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643756198; x=1646348199; bh=JEXkrnQvPN5XB3Pk+Ih5O9VSg3x9zd2WVW6
        9XYIHQXo=; b=JAcVQ7YyIMFXVN6X56CITpdVT2t9cAumbhzIvWWg2laLykayK8x
        Yi1c9BDGwQqB7V+sE0mGtwPayADdz1T82ksV7zeJQndSd/dPUPYySCvIaknko/ua
        azM02t1ugCpfOhZkns2a0VOAqQRvJ28yfJkhUGc9Z34n9YacqqreRSZ1/b1zSSiS
        5gZsj51kTUIqlHULtEClRjWUOUYVZ0FxjsFuSN16cKaEq0rq7muEegYsihKjHqr4
        qI/QggMkNH+dqfnlE9KNTa2ElEegR9KK0vVSajj+8JORE/wfdf5r4vYm9nhY2U7i
        C+b9lk30g3clJl9ioafig1yTdOtFzUN7dfQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LA_FBVp5gPCa for <linux-kernel@vger.kernel.org>;
        Tue,  1 Feb 2022 14:56:38 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpL0515WZz1RvlN;
        Tue,  1 Feb 2022 14:56:36 -0800 (PST)
Message-ID: <5a1d66d3-d3c2-ab77-f874-c3d6b10a0d2b@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 07:56:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/02 2:36, Sergei Shtylyov wrote:
> On 1/31/22 2:56 AM, Damien Le Moal wrote:
> 
>>> Thanks for doing this Corentin!
>>>
>>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>>
>>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>>
>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>>> this patch when he feels it looks good.
>>
>> What do you mean ? I am doing my best here to maintain ata !
>> But I definitely do not have all the hardware supported for testing :)
> 
>    I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
> But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
> booted in a long while)...

More reviews are always welcome ! Thanks !

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
