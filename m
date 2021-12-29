Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492B480E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhL2Ar0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:47:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22768 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbhL2ArZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640738844; x=1672274844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wP3H4SA7VvXxziK/A2hUAsABBjyVMyttXyCPdeD5U/s=;
  b=ZU+I8H4YqQKC1/ikFJAf0yeY/MNUR0tfhX0eANBvX3BXr2TE6PRtTHcw
   w25d5Roj738pDSth0+qus+RCbX5/LuXz+Rm1plWNJlKre6hfOWCqaGRGf
   vioG7U9Nm7H6F08/qcQfxgETDec1NyFxLYpVR+UOHEWAS3npg2xgZoxUa
   zwBU12dp+IEvshQxfcKoO97XNtU44JN/cDxulAHop54sKRrSjnECTTVd8
   +cMQYN/o0ZXL3TE3dVSMGmHfjAJsrBPvWkm5Gn/Ds82cfuwRjG3VgBCbr
   iLeUrs0bipGN57iwTWfNCoN/JxPXCX/LvuCdk47oJcsg0Md9CnhVDATNA
   w==;
X-IronPort-AV: E=Sophos;i="5.88,243,1635177600"; 
   d="scan'208";a="188246451"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2021 08:47:24 +0800
IronPort-SDR: 3F5mQpREmMVHbdYDajgBKV9Kt/KV3w/VQLMxzfuFogyCpGZDMrDgttCF/Ks5sopUJoGGuVXj8Z
 iFJ3WDqnenwR4YumQorAvsBxfqzGGgUfpX016Sht8Y7hFKyaUmif1MQdcB2dNgaUaSpAf3ciab
 WyA7LKgb9CmtuREC0CdQLsfmp3HXcIWWxOy0JGgF+M8CfMz/zevwSr8Hcr+S3GtqQdEafm9ynV
 xuFPmMVpEUmh7X5xk7v7ViEj3Di+Ti8/0G6WANznhrJ0v6nfARfYVdC4X4emLiUHEA9VbAsx29
 CtIuK0vtAGybO99qIuqzEJh3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 16:20:03 -0800
IronPort-SDR: 33nrQXPSErU01lae9yi7fdrco7bh5TYIAnifmPZtZ3BzUgDkWR2gwK3bGjHuEXTV6Nv3dQENQF
 sVD0JIF55NjQy00N9c6XYM/Bs4WaQ0r6Q9uI1itigIkovY2+H8BBcjzpOnp6/X66E0ox/bi+fr
 eGshJjk0X1p8t83VxjKsf6HTEH4gL+i6xUEtKA3OdWDbqngHbWCRUxnjqSUj2aLWcHuVIUZfNn
 LhX2NBwHFQYm5MrrAwz7n/z9X/RniO7FnKOFIhOrPiu2pkqaMNr8k0LypoNiia5FzuKfLNq0io
 oeU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 16:47:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JNt636ShLz1RvTg
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:47:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640738843; x=1643330844; bh=wP3H4SA7VvXxziK/A2hUAsABBjyVMyttXyC
        PdeD5U/s=; b=C+BJZQleyy0zXRskBkT1Tbu2s7z8gTb6mkxe2i9YLhYjA1tLWVc
        cMh1SNQfgW8ZnHz46BlHmIisBd3Ky8PLPrKfxYHBtYLIqOlLydaDqdYDiF3+H7nX
        nd9y/LxBrh8GjadLdQUo+7sId+/yQcQtCousN6B6tgpcljDa32qAJbZT2JMUI44w
        e/EaZXjTAsNdSb5y7tXwSYm7rIdzTw+U5yCRGRKyuLHRMoQw+nA+HK7G65H62XMT
        EVmLF7ONeazZOJFRPIwVgmcW7tGhA5Jh5vHdgv934p0qEkAZZ4VetKORec930FSK
        OiIPXt6Gb4IkavZs4W+j9W41ZsmvSI7rqQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9ydEHt19dH5E for <linux-kernel@vger.kernel.org>;
        Tue, 28 Dec 2021 16:47:23 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JNt624NRTz1RtVG;
        Tue, 28 Dec 2021 16:47:22 -0800 (PST)
Message-ID: <7aebe7bc-37b0-836e-6d5b-ecf7f17906ac@opensource.wdc.com>
Date:   Wed, 29 Dec 2021 09:47:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211227155735.10519-1-pmenzel@molgen.mpg.de>
 <20211227155735.10519-2-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211227155735.10519-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 00:57, Paul Menzel wrote:
> Use the defined macro from `include/linux/pci_ids.h`.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1e1167e725a4..6a2432e4adda 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -436,7 +436,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  		.class_mask = 0xffffff,
>  		board_ahci_al },
>  	/* AMD */
> -	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>  	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>  	/* AMD is using RAID class only for ahci controllers */

Missing patch 1/3 for this series. Not in my inbox. If it is not related
to ata, then please split the series.

-- 
Damien Le Moal
Western Digital Research
