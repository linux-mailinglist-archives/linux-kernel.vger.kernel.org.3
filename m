Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107855AC943
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiIEDyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIEDyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:54:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0F2B8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662350068; x=1693886068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgWI7pXo/iFPZ6k4JkJ0VyK0XDakMC57Y0/q2O6Q7+Y=;
  b=A8VZf0yT3BgT2Cu2EjD10i/ZN7H4tiuxdOJTVc9aCg+fV6uPdghQgPM/
   rJA3qMHwD5sVh0vIesjx9LX0QwWl95Iow3MNPoDb6sACN4bIKZhsLAYGD
   Nd5EsurljRaawN0koWT9oNN7QvXKmSgekIticC/86/MQI2qoo7TamV4s5
   xOq30/4ti+H3iVEdmVeDRXBWO1nbk6CBw43s5Q0lKEsTGNMbMwvJa7W6r
   A2UfvsbJN5WmZD8OlNgOE96QLOEY6LK4JBTH4i8UW6sP+ATuc57WLDWfA
   8VxWjDtrvPPcBYv6cfZ/v/8iViPDDYrAWm48H9jxNfNIKP3azHtiYTgKU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,290,1654531200"; 
   d="scan'208";a="210977848"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 11:54:22 +0800
IronPort-SDR: z/dmezlIQTUrN/O4uNZ3XRkBXx8u8OHnKg1JokTw1VSvQ72wcrs7q2SAwTXDVak5PehbLghxNH
 rp0gjxh1inU23Oiu4ymzV8Gvgban3nGgbdKwR/jHeASeipumbm1YgcJSt/ksCkvMdl3jyFe6OZ
 e/bYenhkTTWDjxgQF0xD+cGeefLwuZ/w4zALPt+PKqsaVQwjSExG5T/Hz2p1mcEoPPmLtDzpWW
 O1HpjE/uHv/n9WlUSd493d0FnUcwpfhD0L7/uVnXrd8z4V3B2VI3e1RelCUWlz0BiqUhUBBs+M
 1F/QQgvhYOhxUTb8hIY0vOpb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 20:14:46 -0700
IronPort-SDR: 4qho7bycIXaQvj/Xz+abHR46sgJhWmDQdBpOQ5p2FFLt6YiTaKFIvnldwxPb1EMMnOuI+FY3+J
 BNhbuA0+zC2vjC3TYhDvOOAWgC/DrkvPH7oY86VdxWZoo4zR5v9RLENOe0lDS2iHEDiRA70aPW
 rZrBk7CsvkcmIsx3yYQItRayNBMXaMJ/ZwUW4H3b4ICRpwk2ukI19yJen5HxLxM9OC/szTEXdf
 zdWvpB8GcQPStcJAQJJMwzDtT+Ie/9qdYrPS84DT1qroG2GvqSSbWQRTRD3cfANANOLaqkvPC5
 37E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 20:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MLZQQ2DFQz1RvTr
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:54:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662350061; x=1664942062; bh=CgWI7pXo/iFPZ6k4JkJ0VyK0XDakMC57Y0/
        q2O6Q7+Y=; b=an25YydaQGwwCDDtb0A16UCvnEVVBD1BNr2csbHOZCAfNePowTA
        2FuyJqosaLx0vu89m8BiXWrQFi3eXYLe0n8FHTvegKd492Efkg36bV0B8znkHTCT
        cm1c8P2QCSA7Q4+udePuHFYg8bJ2bO+WhAfPiD/QJvt2mfPVJ2j41gJuWfoaB4sD
        AuKiV/ckIXpBDG2NSyzRUcP5Hd2u085BNQNZph5AIV7E6jaGMLad4KiFlnClaPGb
        lSvpecyUpyMi7VkH5nw9A3XXTVGS/X6g1nMqmAv2tlT4srwX/6pWYs+HyNK6EKh3
        CyRvQBah66e5r6Q31FUJ4yCCm/mdIDOjutA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hwkYt6VDQI_A for <linux-kernel@vger.kernel.org>;
        Sun,  4 Sep 2022 20:54:21 -0700 (PDT)
Received: from [10.225.163.60] (unknown [10.225.163.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MLZQN5P4nz1RvLy;
        Sun,  4 Sep 2022 20:54:20 -0700 (PDT)
Message-ID: <ea747f8e-257c-a4f6-6dce-5ea26de4083f@opensource.wdc.com>
Date:   Mon, 5 Sep 2022 12:54:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block/blk-map: Remove set but unused variable 'added'
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220905022553.77178-1-jiapeng.chong@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220905022553.77178-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 11:25, Jiapeng Chong wrote:
> The variable added is not effectively used in the function, so delete
> it.
> 
> block/blk-map.c:273:16: warning: variable 'added' set but not used.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2049
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  block/blk-map.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 2fbe298d3822..a06919822a73 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -270,7 +270,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  	while (iov_iter_count(iter)) {
>  		struct page **pages, *stack_pages[UIO_FASTIOV];
>  		ssize_t bytes;
> -		size_t offs, added = 0;
> +		size_t offs = 0;

offs is initialized with the call to iov_iter_get_pages_alloc2() so I do
not think it needs to be initialized to 0 here, unless you have a compiler
or sparse warning. If that is the case, this should be mentioned in the
commit message too.

>  		int npages;
>  
>  		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
> @@ -306,7 +306,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  					break;
>  				}
>  
> -				added += n;
>  				bytes -= n;
>  				offs = 0;
>  			}

-- 
Damien Le Moal
Western Digital Research

