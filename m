Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDEB486020
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 06:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiAFFV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 00:21:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50389 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAFFV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 00:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641446487; x=1672982487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0BaOd74R0nJyKbQ+jBhvN8peJV4YhN/UlXzcYMifiJg=;
  b=TKgP3S9jgarCB9OsrRcPoD/TWlwc4YYgOr0bC4lrfD1v6+ssa0VnQUvE
   l84M7gmRVVAoc0pyY740w5WAOwX2tO+xZwAPGdsIlk86dwLo0l9rzLzHp
   SrSqZpwPDcMqy35nz/NX96TqyWOmfxBfBQgEBCYWhLhCimdBo9b+I1E4Y
   56aRjb0E5ZkbXBQMmKz3Bq7mw0prZMRIeKSqvUK2IAh2+HanGxUzAj5IJ
   Uv/0mE9PNNGWrC8mUu/GeswjUbOM3e7S+QEQLicAmZF/03Mjv3p2JmdOH
   pwaYEI7oKevKCguBxMiIl/yS5DDVt66em37dAO7S4vtmjRLh2xPQg6KKV
   w==;
X-IronPort-AV: E=Sophos;i="5.88,266,1635177600"; 
   d="scan'208";a="194609762"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2022 13:21:27 +0800
IronPort-SDR: ylYgWM+lGyikAi93oAIAg68+wbOIWmxy7CbsR5KYxZ6+p5aHzMSHOM237kskxRvKxAv7UOyWXM
 KTr7Ip+ksiV1D+/oGh2zE+547DkHXUXd83JB4YmEyIlkF5cPQR+XRZSlZX+jzwJ8XeCtNF+XxD
 Mddwczvij9dHAowhz/+WEbAxvTTC9nxnDEHsU05/KOq5a6z23+YWOQ8txjHv4itTluQJEknqJf
 UXk7/FRi13UTmzNgiFXc7Bxnsy8lgb6/0i9R6yLzjfKPWVh4vImUyoavn4TzLqAxlgCPtk1y+P
 EUd6pXHd9TV/FE4T19KwyOCw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 20:55:19 -0800
IronPort-SDR: wRThyWVq0SEn/tmTttv55W1p9BbDzf/4V/XozMyCvvzZuUzPO4h2SHe6Rm5F+nQkw3ZENGHgoZ
 cLuKcLMI/GbK3vw2bX7nWUk+faVeBPugNFc/RzTnFhNscB01H5kDhw58kdLYs8kBha04FomQWe
 hEr5YKbPemHfH82iUim6R/UdcLACNGb+mmxJDX9l/d0eXmtxgO6rq43ZApP6z3iApXXZGUaF2R
 1EvYVCbZ58wyE0hwgUpxUaeRatD5lBIcZyIqrGXpG4HzUH9Gc7VgskXJefhmH9L9ZVzkDQByDc
 uU0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 21:21:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTvpc0x2Mz1VSkj
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 21:21:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641446487; x=1644038488; bh=0BaOd74R0nJyKbQ+jBhvN8peJV4YhN/UlXz
        cYMifiJg=; b=frqhceKd0dIdvEYSBqdFVZ6be5y+Ipq012W6/9tAUaoZfFEerxR
        iEUxk18P4bFz8JeWr6B2UjNhtghlFnxfIz7Z5yG7vlnE3DTZ42shGFI2JaCeXBbG
        l2s89m3shqKSFMp0/vdt+Hr5ChjZHR39STUNL8PMlTns/ZWHPoM1GWPl7Pm0P6Uq
        WwDDTurHWhv85S/6SNpsu0iameUAKwT3Jj6YyGQkM/+Mo1CJP6c2FXJ71bIf5fVk
        JfB4mJWwCr23plishyZoCMv1xNHPxQ6Fp/FKC0XT3zMoeymjCdfxYqHWIsMzUFjO
        Ueb8GYAnamVVFph4bfm1Q7OfLGgf7lstR2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TwtBUShhqTMj for <linux-kernel@vger.kernel.org>;
        Wed,  5 Jan 2022 21:21:27 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTvpZ0td0z1VSkV;
        Wed,  5 Jan 2022 21:21:25 -0800 (PST)
Message-ID: <3cb24d6e-d52c-827f-7905-8e17411b23e1@opensource.wdc.com>
Date:   Thu, 6 Jan 2022 14:21:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
 <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
 <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
 <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
 <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
 <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
 <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com> <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 13:13, Martin K. Petersen wrote:
> 
> Maciej,
> 
>> Oh, you'll also need a follow-on patch that uses the cached ATA
>> Information VPD page. I'll try to get my full series out today.
> 
> I would really appreciate it if you would be willing give this a whirl:
> 
> 	https://git.kernel.org/mkp/h/5.18/discovery

Martin,

Indeed, my bad.

That said, it is weird that scsi_get_vpd_page() does not call
scsi_device_supports_vpd(). We could simplify everything like this:

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index f6af1562cba4..c27eabedf9e3 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -341,7 +341,7 @@ int scsi_get_vpd_page(struct scsi_device *sdev, u8
page, unsigned char *buf,
 {
        int i, result;

-       if (sdev->skip_vpd_pages)
+       if (!scsi_device_supports_vpd(sdev))
                goto fail;

        /* Ask for all the pages supported by this device */
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 65875a598d62..2ef7953512ed 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3316,12 +3316,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
                blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
                blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);

-               if (scsi_device_supports_vpd(sdp)) {
-                       sd_read_block_provisioning(sdkp);
-                       sd_read_block_limits(sdkp);
-                       sd_read_block_characteristics(sdkp);
-                       sd_zbc_read_zones(sdkp, buffer);
-               }
+               sd_read_block_provisioning(sdkp);
+               sd_read_block_limits(sdkp);
+               sd_read_block_characteristics(sdkp);
+               sd_zbc_read_zones(sdkp, buffer);

                sd_print_capacity(sdkp, old_capacity);

Since all the sd_read_xxx() functions do nothing if the vpd page needed
is not supported.


-- 
Damien Le Moal
Western Digital Research
