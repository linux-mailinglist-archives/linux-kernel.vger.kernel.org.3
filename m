Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C547369A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhLMVhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:37:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41262 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhLMVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639431451; x=1670967451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/GI6FNIzJRnBbEtJSRLeyRNy8FgPpkgoZ+66ISYfIE=;
  b=n75DhDN2mAzNFl0r4Un/8C7gVL5dP0A4wNOrKaSbYMXHmMeH15HRqv4o
   vc/KqR5cPt2XON7P0KZ8ypMBBMd/nCeHW/UCYt8vJGTv8bgyYmH4KtNpd
   AXkUoxWvLZ1NGMLLLqZArPVOmP65OA80DVGRy/ViPwENYx+8hY1YU+5OP
   w3jMklqlUYCY3QxALyu6vcAErI78ehZrovN6YNPEX38icQOrmxATn8qtl
   pRawgBP5/pRjt+dqCejqLj8DWuYlJO7pYhMUfrv/+iNbyhR3GfbxRcm4u
   ZpptUMiviu/cR3au4oIOBrnbc8OeXhWddjqwqrxfOGemXRT7SZBAVDUWy
   w==;
X-IronPort-AV: E=Sophos;i="5.88,203,1635177600"; 
   d="scan'208";a="292142885"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 05:37:31 +0800
IronPort-SDR: n7h4rLJE8bnGQKUHasW8O5amfqT882aT1aqIpnPcRiUyg3+4zt8pjYz70Kcgtlfqe8xKezJWqh
 6hZEPXnxrQts26SSW4xsGjNE7zulXdjLLwnjlMkVCvWtuh8I29BYlQfWSOivbhB//9Lti7CN7L
 fMOL4j6X90gs2sjlcAXb610R/IuyFPayHBf4rsElBioKQ9nkFfE6k+LYV0GQQnry6KuepvXpbS
 8/NaFOkG69VuTLQSz7hy7/Lt4Pbrt78bpOxXCXgyfkIhLnMwKitN9LNfNvtzyjxuwMVRo9yRr4
 8nbCVgAWTOV/OyBdYtCslDRU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:10:28 -0800
IronPort-SDR: u56IHdPAXg3Txqqtn02TKEWBCeDvtMdpfsPt/wRiCXMPsTgQ36HZY/k+2/l0kdfAw4rGPiqPMI
 OUNcVqzpvOA4rbOm+W7apxrfdnL/gq3saXx/L5rvBPgG/2eBt2YtkPP7u91F1EpoK22eoMf8dp
 UtaB5lhwQjOqLAHH5LRhIqjFOXzvRChABppAtKJeQTx0vXGdBpPKWT/e0luou2ZJszfipPkfHI
 6y/q0Q0NxtkMFDSdu6lfvEz/1TkvskFhsd4RuPUyPY5CALFg5o5HlV2vrTg9HpB3gMqbmAaJLN
 bMY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:37:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JCZbv1Pqbz1RvTh
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:37:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639431450; x=1642023451; bh=p/GI6FNIzJRnBbEtJSRLeyRNy8FgPpkgoZ+
        66ISYfIE=; b=csGrzl4Ef2XD6pS33qD7pGUEvzgkysLbTbjE3JYTfBgH+vdAvPx
        Jfg7L8CtIQ3eNEAlLScyr51YZETgO+W7aNt1epC/GiBCe/1GrKw3+Cuqqus1h4yQ
        2LYO20AoTaXCAl8bz541MSJ2aZPgocEHJRdyU+ipapCF0VtAha4ivKLNCmYFTGXW
        OWZ1OwAKTFI3BbewQB32L2wU81A6SnA3otTOws7LUDFonEWpiE6OLuMei88vrSbP
        KTnbULMUQJnPqcznvqVZAx+k6QjVRclM0ttssMnWfezY0FGGOpfeO4+jmzXCH6lN
        SZNAOP2T1hCH2Raub3qb24unix2uC5I74Iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uuHWb6wkw-XY for <linux-kernel@vger.kernel.org>;
        Mon, 13 Dec 2021 13:37:30 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JCZbt39Nnz1RtVG;
        Mon, 13 Dec 2021 13:37:30 -0800 (PST)
Message-ID: <c6212443-e40a-2813-1920-905e89884204@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 06:37:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 2] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/14 0:33, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
> 
> Cc:<stable@vger.kernel.org>  # 5.4.y

5.4 only ? What about other LTS versions ? They do not have that bug ?

> Reported-by: syzkaller<syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> ---
>   drivers/ata/libata-scsi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..d428392 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>   		goto invalid_fld;
>   	}
>   
> +	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
> +	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
> +		fp = 2 + cdb_offset;
> +		goto invalid_fld;
> +	}
> +
>   	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
>   		tf->protocol = ATA_PROT_NCQ_NODATA;
>   
> -- 1.8.3.1
> 


-- 
Damien Le Moal
Western Digital Research
