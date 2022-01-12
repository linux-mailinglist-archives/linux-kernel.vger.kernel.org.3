Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC2D48CF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiALXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:52:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33252 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiALXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642031532; x=1673567532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/mqEmsBcJQ9azy/1G+hXvIN0/87aNRTsGuVkMDmO0dE=;
  b=Bb2b8K2o/+QTPcyiMHuKCxfOChvmhNKSbgdD3349jXGHYEoEmBLC1LxQ
   R5WfZQACG4bh8ovDY14LitzSk/5v2HqIfUp8ru3YUulFuqCzyiDVjii87
   tf6sq/75youahiX8TTPm7x0nhcU9ZwCdg/sS6xz7VA1Y6XC6Q787B/YsM
   cI05+TtYqU1Li0Wd4jeA4W8oG9zhsNqz1TEIMVHgUF13pQYeihKi6tojk
   NPBTIwnOr4K8mf5VUufFui1wDEL97yWMLWf/P58KUq6akrPnq1eDYvzrS
   f0dcg2+uqxGpmMl3NqDEhAYgq5M0IYm/IHnZEHDt/HwzmAYuq6/XeIIpX
   g==;
X-IronPort-AV: E=Sophos;i="5.88,284,1635177600"; 
   d="scan'208";a="195114697"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2022 07:52:11 +0800
IronPort-SDR: 6lt5yPxEOJ7/oHgmOTYT+0JF+uYVSRxA0Dm+I8Se1QVBdAcXoPTmY1NmLJIrsHlO+6Wj6YNaWR
 6txn/7Im+77uB6qzkKf04PXosGx/YxyZkCE9XJnHLaGhR7iLCFUUg5mEChBuH/xiT87PxQc4FY
 LGbqnoYaux2EmXRDgy/5CMeQIsvQxHhwfHfw1FU7Nry3l70D43LfDpgOB/0jLoBJNIJaJ4Flhd
 cPiljfW1QAU7Hvgd9mseLbSDlzm+Njb+eFoZfa/ZUHqmO6ZoRI+8QXD9H22O3IgRCkjg9fEya1
 Pe9FW2N3Ln61CoSMnEk3E80r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:24:33 -0800
IronPort-SDR: dlyRj6DiEA4sY7W2p07kZ4yGQU6ACO9OMQlnAcxqgNlPyRg8yQ2b0t5T7Zc4jaQokOp1CkLPDT
 iu8w3W4JWx/t97HdzRbkBX6xYGt7CuCqE5EgEw0e9U8EifP3T2kqvllreSYHAzSPILFZf+r7SF
 XV9K5KfcnW1wpJkIPbQN4S5F3WQSnIlU7sGXXB2w8DpF+XaCD0R5yi+9O1lfyik0dQJAzQZZgW
 /UqXKn2e7smK7TZAaodXLfG8HXy1sDhA2t2EWbZRG4SO+8az0lq2wIqMZxbA2rBgrqNGF4ByWU
 +lU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:52:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JZ49R6CrTz1VSkZ
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:52:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642031531; x=1644623532; bh=/mqEmsBcJQ9azy/1G+hXvIN0/87aNRTsGuV
        kMDmO0dE=; b=bX+45SacwqwDbCXir+ULwzJpqD/MzXCjzrM9pB4OstZvmMIxZ6d
        bDoK4AyMqWQZ78fAt6U/zbtUZUJoN6fWRR6YFWQRA+xl5CRrwQ4pu8HxQaWc1t6u
        q1cH8l5Wd8sPuaIR1nOy0nueSQS0O+90Xq2uSy95+eYQGJAGHXsXUwoYqL7N3nEz
        6yfTXRpyfJl4xOTaTZUhaqwkal8tnvasJKfS5mUEMwwylVsd96rE2JxfLtWbSG+A
        XpLICwUZIBPN4mqdenKBJTn8tzVSnHKB2kgvrjp6b+oXCR39uNub/yfMDSexc7m8
        cKMcvpL636p3JqX4Xv6QNEz42SZjEU9QrKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LViFinyOszPn for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jan 2022 15:52:11 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JZ49Q5nx5z1VSjC;
        Wed, 12 Jan 2022 15:52:10 -0800 (PST)
Message-ID: <2d9b4f08-967e-6040-a954-e7bfa7e4dce1@opensource.wdc.com>
Date:   Thu, 13 Jan 2022 08:52:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: pata_ali: remove redundant return statement
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112234741.1232858-1-colin.i.king@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220112234741.1232858-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 08:47, Colin Ian King wrote:
> A return statement is unnecessarily complicated, currently value
> in variable mask is bitwise-masked and the variable is being
> updated and then returned. Just updating the mask is all that is
> required as the following statement is a return.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/ata/pata_ali.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index ab28a6707b94..1b90cda27246 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -123,7 +123,7 @@ static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
>  		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>  	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  	if (strstr(model_num, "WDC"))
> -		return mask &= ~ATA_MASK_UDMA;

Yeah, not to mention that is really ugly as the return should really
have been:

return mask & ~ATA_MASK_UDMA;

> +		mask &= ~ATA_MASK_UDMA;
>  	return mask;
>  }
>  

Will queue this up.

-- 
Damien Le Moal
Western Digital Research
