Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B024B0315
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiBJCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:07:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiBJCHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:07:30 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716736691
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644458566; x=1675994566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nLVhITLvnNdZ/095iT3c/FfIaBXC4iqvMall8v8FwWk=;
  b=eQ9vsV/VJqw4BeQer1qffpiFwTwBcnGVr7v297psEHI0TuGNYK4hCN7i
   WxMGf2b+g36HS2m0o2rFKP6Itwx6h+u+d2HR7EtIWwnQwxNQoIJdkQz4Y
   kKsuOFGr5llvPp/Be2PifSQFVgpLllXyB9j3gbfqWPuDFfZlV8n+DS4dq
   q4AWtmIMvMQdyx3QqVG7MWKEtQPtfRK++VF4FJ9LjijfOfe6UxitS3eIr
   nZhQf6AQPFTJt5VGBhaup1I8qHAt/dNC2JlQpIbs6vbrigr7hpEUcaM6K
   xJ7bp56CD1ulJjN4ysgIyRE2HL7aZ6Ooc26jojGWXScpJ+l3K+BJOh1Gl
   g==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="192546152"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 07:59:23 +0800
IronPort-SDR: RpOiSBxeGK7QjObttPxrdOFBhrLSe3F7VeQubUyVZJWoYimtCXGNSLTUo8u3W7UP/XuK1FNjvr
 7JrybCOjTzjMoiQnmPvRun/nM3tTzM5uf0iV5wBAkrdf8OZcmSl553FwXiaxPvj65m1NMevIZY
 qdueoEyN6M/0jXwrbVby3I6N3hvic0IXqtjv5Df1Wiz0MWUWaWQmAFJIRD0KqV5l33y1xzvOSo
 OTdwkXaEW9m4HR5fOz9g3xPTWBIQY0o5UyoWgRmK7Uf31cdJHkyqCnrcenJTsFES9RKGaTsi8s
 4KnuY6CMCWWQE8NqrdVCWtMC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:31:12 -0800
IronPort-SDR: aEUPxK9lWO0Ax7ZnB7ijSxA32JIPyqfruCHjIVaLcVqBjYv+IMwgDkuvY5YPKXMFQy1W22sBJf
 d/EsUfSeVmRO3HuZcKbZwysGNMm+9d8g37pJTOlBCXz5HkLMqeYvgCf4VHDVg0QhGeMC0zHHY6
 bZquubqDZRDEnYlMveBrCNkjbBnQFcIDuGZZDBjTjx0OqJFB3u3IS5Lw+mjkZHmBSiDPROps0I
 50/w2uDslbCH0+C8SeGD9JwPaJO1zwxYHf3ClMo0qjTphxg/omDaXw9TUtuxTCVhcG4tmkkWVo
 HhY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:59:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvH0r2ggvz1SVny
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:59:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644451163; x=1647043164; bh=nLVhITLvnNdZ/095iT3c/FfIaBXC4iqvMal
        l8v8FwWk=; b=snKbSf8xORdo5qYWy/Ofvcu1Vpz6ujDj5qVdLt39Vchamnh8Pzi
        4bwqLqefSFwWSWg+F9uFfh9DUxpS9FqbfhWPW5aS4HIKqqFLhPCLglJlnNPYIPRQ
        IFcKA7F6m162PnyPihT2DsdGzCF9MbUDIdydFMJrAxbzLTUpA3h2OEpp4zPKFnQw
        c9O5QmNtjPDxoVVfEeZhMtWA+y0k7Mpb1bn2AdZnsCKmou+D/f4x8OUGPZgqkx+E
        WaUZ97nn71xH6ZpbPWfc9Dxldqrbt2A8977CiDgcuQuhNWrJZn8cdeu6xuqNcbSN
        aj2P2A8mOjGbzLTOxtVCL/9AYl+guZ8PWQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mK_4VXIMq_2K for <linux-kernel@vger.kernel.org>;
        Wed,  9 Feb 2022 15:59:23 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvH0q03STz1Rwrw;
        Wed,  9 Feb 2022 15:59:22 -0800 (PST)
Message-ID: <5449119d-29e7-0179-d865-d0cb47db367b@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 08:59:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] pinctrl: k210: Fix bias-pull-up
Content-Language: en-US
To:     Sean Anderson <seanga2@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220209182822.640905-1-seanga2@gmail.com>
 <fb3e9786-87e9-6346-cf84-2617adfa5b8d@opensource.wdc.com>
 <4911f3a7-fe4b-8eb0-f504-667ee5ea1294@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4911f3a7-fe4b-8eb0-f504-667ee5ea1294@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/10 8:52, Sean Anderson wrote:
> On 2/9/22 6:34 PM, Damien Le Moal wrote:
>> On 2/10/22 03:28, Sean Anderson wrote:
>>> Using bias-pull-up would actually cause the pin to have its pull-down
>>> enabled. Fix this.
>>>
>>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>>> ---
>>>
>>>   drivers/pinctrl/pinctrl-k210.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
>>> index 49e32684dbb2..1ad61b32ec88 100644
>>> --- a/drivers/pinctrl/pinctrl-k210.c
>>> +++ b/drivers/pinctrl/pinctrl-k210.c
>>> @@ -527,7 +527,7 @@ static int k210_pinconf_set_param(struct pinctrl_dev *pctldev,
>>>   	case PIN_CONFIG_BIAS_PULL_UP:
>>>   		if (!arg)
>>>   			return -EINVAL;
>>> -		val |= K210_PC_PD;
>>> +		val |= K210_PC_PU;
>>>   		break;
>>>   	case PIN_CONFIG_DRIVE_STRENGTH:
>>>   		arg *= 1000;
>>
>> Ooops... My bad :)
> 
> (This is in U-Boot as well, so it looks like it's my bad)

I copy-pasted a bug, still my bad :)

-- 
Damien Le Moal
Western Digital Research
