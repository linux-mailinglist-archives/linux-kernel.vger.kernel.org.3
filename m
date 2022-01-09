Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854FB488869
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 09:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiAIIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 03:53:45 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59075 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiAIIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 03:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641718423; x=1673254423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSiH/twDmxaano1xqPfNIZ4td3CwYd/sSEPnGPMt4A4=;
  b=LHLJCojTqAqpRxYqc/tW5dAnNO1MYlYCgVsWideKQD675j1Mm9CaM6JF
   ItxUv91A1TzJPuGKyp1oBhiJ5JzVknBrqtEsr9qWza2OnvrFKBLh3CqHJ
   d9c+09HOJuw3z1n/KiZHdHnO62FWGYOuJB+NWWH3A3yKMsu6BHWspkDLb
   yEfxI+OkyGGLWrSlZZWD6Gp/aIGkbIsj84ejj8Se+I91ftC2OqlQaggOO
   HhS4GTsewcmJW0pNb4J3GLNnMdoRM4uHnfT1j16lJ+5VV/gnFyfdXXmfy
   8m3hAvC7v9BF9rj5Lqv98SDb0iiAU0Q/aMf+8+h0FNOfqNNTK7siTCeUq
   A==;
X-IronPort-AV: E=Sophos;i="5.88,274,1635177600"; 
   d="scan'208";a="190030269"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2022 16:53:42 +0800
IronPort-SDR: 97P++omE8Ddk3bnfc0UNzAEsjpg4BGfh97zYG4QXsG9rj+ZzyAkj/WIiidaCMoG3rEMC2LBEiB
 dsonf4iyip7W/LWlEGwpw2vFAJw2aVTmz2HWU6zIws6tPTA6Gdj9XMOkR7I/0z8MmBSu1OaNI/
 xlAlJoNTyvJWnHupHT7zcZ5ipUkMQQuAna2ovgTEfVu0xnEm+CMuFmcs78GOXCJXypZlMWwcbp
 i7jlWasHfJ01HMclcb4izEmu2VGhr0lxbtIcNi28/8kVjkdQWMfbRrAKWFCrKgH8uY3U2y2Gxm
 vp1NNfrQOt7jnasCF0O35K8f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 00:26:08 -0800
IronPort-SDR: 0XAdHZ1RbK/qv/V5I7pKplpOLIsvF2ZBTaB9/Iv7OnaLybHBdahqbqhpPa3ymmnx7TUHVl1bii
 BOo+KyetQ0FHKwQrhr6zDNziMOrcplHYAbCg/yEeqbrmlnV2nfTzhekP/cQ8sKeXN+fkGNNuZx
 KGV17xRfuq25U6DNi/4i64OoCiJfcIpdhxSx8SSIr3Y3Y6wcEtDGwDwhX6+hsVi3hWMPnZNrma
 2zeoA8oUwc40rpbec4Q5sPSVqaXVP2p0cisuRu96mWUy6P6gqBBmlR506croL56MOoF9x9xgDR
 3eI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 00:53:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JWrN71cWwz1VSkh
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 00:53:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641718422; x=1644310423; bh=GSiH/twDmxaano1xqPfNIZ4td3CwYd/sSEP
        nGPMt4A4=; b=q7FS87BLwWn4Sz5+cdMOazcLw6xn+l6YYe58Ojv4MKsu+g8PgYD
        oWL43OBZMeJT6TnmS9kYbJppVJxWr0weeRJP9lp9i5y/8de3TBJJsSHgJBilM25H
        tOfB6e/JQ4B0NDWkR419pux6puaasZPcXhvxdewhTkJcCnykATcqXgYXY6MI5Dbm
        iomjSOn2zFZg7f3UVGgSzS5WqPjuUMNnMJpablazHtLWSRaV9b10pubKKfOWFXqe
        BuWMEiWDXNIpzqEjiWZLHtYQKqoxm3zzVi0gDrneJFQQfX6FTp9zBj8wGaVUnyEe
        z2ISTyk2l69GNoy98zqZZLd5GWi/msSPq4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5SNvhQiKwFCK for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jan 2022 00:53:42 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JWrN53zGpz1VSkW;
        Sun,  9 Jan 2022 00:53:41 -0800 (PST)
Message-ID: <11d2e187-03eb-9a66-56ad-337fb5996b7b@opensource.wdc.com>
Date:   Sun, 9 Jan 2022 17:53:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, David.Laight@ACULAB.COM,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220108035552.4081511-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220108035552.4081511-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/08 12:55, Jiasheng Jiang wrote:
> On Sat, Jan 08, 2022 at 10:53:42PM +0800, Damien Le Moal wrote:
>>> Cc: stable@vger.kernel.org#5.10
>>
>> Please keep the space before the #
>>
>> Cc: stable@vger.kernel.org #5.10
> 
> Actually, I added the space before, but the when I use the tool
> 'scripts/checkpatch.pl' to check my format, it told me a warning
> that it should not have space.
> 
> The warning is as follow:
> WARNING: email address 'stable@vger.kernel.org #5.10' might be
> better as 'stable@vger.kernel.org#5.10'
> 
> So I have no idea what is correct.
> Is the tool outdated?
> If so, I will correct my cc and please update the tool.
> 
>> As commented before, what exactly was corrected ? That is what needs to be
>> mentioned here. In any case, I fail to see what code change you added between v2
>> and v3. The code changes are identical in the 2 versions.
> 
> Thanks, I will make the changelog more clear.
> In fact, in the v2 I was careless to write '!!alt_base'.
> So I removed the redundant '!' in v3.
> 
> Please tell me the right cc format, and then I will submit a new v3,
> without the problems above.

Cc: stable@vger.kernel.org # 5.10

Should work.

> 
> Sincerely thanks,
> Jiang
> 


-- 
Damien Le Moal
Western Digital Research
