Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1F50D65C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbiDYArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiDYArm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:47:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8B65D1F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650847478; x=1682383478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w5zLXzL4wFyNDf1UHVnJxkjWiPLqYrBtKIh58L/3R7A=;
  b=PV9WKl8Ge+F5MpO+e6NJ/9a5vBADVGK8F20EaWQGUusNYINWABBrGARc
   lpPM0MXgDNUTdT+n2kxPg0tChe6nPv9AAqE8nGkEYkVen11eKikTmsXa5
   CGEeBMx3RnPPQCcJNp1dYzMKmbUg0gMkFx5Ins7IXYWzd8rL9/PJ43sIp
   rBWhsXN62S9iitf/VH+HmwTOlxGApjRZNZwoHCoFW8qvwXbN7F5bf12fP
   Hhh3N49Oy3yZQIhl0PbJbPz2VXEj6is0T8PfgC5grJw5rQ/oP/GVsBJ/Y
   +W/RO1ZJJTUCImVahvojOtP2gxiebUM6+sN9L6VfvPGQfoK4JTTWCHKkk
   w==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="199600609"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:44:32 +0800
IronPort-SDR: CWUuAjfNCF28KU9uptXFuajNy0JZRK+nhq9x5XVSXSZHq1osD2Ib8LgZ56rbIrlPjXap2SpAgo
 TlZM3r78/TSjK+9awj3r5XKPG5spm2ePEGrnYAs7+XdgaXjXbp9pmZW+1gi7qR2quOyggH4S07
 q3Ulo+xkfzu70/bRDMJ1rGr9lMAJjzrsSJRltpr0O48kDcJkJbKvIVTPHqD8Y+dyrNpqQskgFi
 RjbKKv1bYdMCRWDukS/7VmqykF+vgICZHsxB2gLPOVfpALqxcTzSgv3b5LDloVQoclKEqQwxhE
 dLwI1Epu57FfcT6DyGrT4ZJ2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:15:29 -0700
IronPort-SDR: 6Rrmh3j/crY6vaqo2Sf1ViGK88ieXyNp6wmAvhINVgGgKm6WY9pDrfJ8TC6X36Yv6ItlhumExO
 7orJd6n8adf+fSl6BCaAj0lAuO4sRO/6Pr7fe6SX/YjzCycVpP3Hd2V8Ne+tURftkrQXH/zXkm
 0w3+879J93EKxAWnzwpFiwva50e/HDS87ZA914GP/qH+oQ2iKD+JAugAumag3e7hJph03RCZ1j
 DSb0V2COo1difvxHnTFPIxIHq26FFF5gYw0U4MK6BpvtnuHivKQ7lHwEOXpqW9r//4xuLXjrQC
 dEg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:44:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmVl6NF2z1SVny
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:44:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650847471; x=1653439472; bh=w5zLXzL4wFyNDf1UHVnJxkjWiPLqYrBtKIh
        58L/3R7A=; b=h6NKfpsvFOX7OsJ591fXvH17ksMhSekrPFDHlAgdGwuzsb/3xy/
        AshBiBjmxgrWFF8xP35jwEwBRXLn1NMSoAeTTFYe9t7kQnmOpppQBrqaMbU+W1Dd
        vYXl6ZjOM0DrV+2pt45VLw7+giFYysBfFHvgmRaa902uUmHFYMbCkW+O/vXidmqL
        MLw2B6ia4rEBpvfnRP9efsFVWBBGW4PxY6T+iAa8PspLHCz+VnVLPdiVOeh5cG1T
        1EYVBpEJ4u7cKf3iaJt8J53vqnoKPv3jrJaKR0C5My4BpDSFaYA+ordHR3eOwVR7
        I1Gon4xEtKphGrAiqKkdPAiQiJ6kX6WM54A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ky5MZYk0pODK for <linux-kernel@vger.kernel.org>;
        Sun, 24 Apr 2022 17:44:31 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmVk2vGlz1Rvlx;
        Sun, 24 Apr 2022 17:44:30 -0700 (PDT)
Message-ID: <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:44:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     arnd@arndb.de, b.zolnierkie@samsung.com, robert.jarzmik@free.fr
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220424093420.2129779-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 18:34, Yang Yingliang wrote:
> If devm_platform_ioremap_resource() fails, it never return
> NULL pointer, replace the check with IS_ERR().
> 
> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")

This commit ID does not exist in Linus tree. Is this a commit in the ARM
tree ? If yes, then Arnd, can you take this patch ?


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/ata/pata_palmld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
> index 400e65190904..51caa2a427dd 100644
> --- a/drivers/ata/pata_palmld.c
> +++ b/drivers/ata/pata_palmld.c
> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>  
>  	/* remap drive's physical memory address */
>  	mem = devm_platform_ioremap_resource(pdev, 0);
> -	if (!mem)
> -		return -ENOMEM;
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
>  
>  	/* request and activate power and reset GPIOs */
>  	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);


-- 
Damien Le Moal
Western Digital Research
