Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3414481875
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhL3CTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:19:36 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:13476 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234548AbhL3CTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:19:31 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPWz06hbKz1RtVc
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:13:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640830412; x=1643422413; bh=EcOFL+Z1sNiS+MLXgzMpfX01MRz+4HdgPLm
        +zkfEwJ8=; b=lIkWw9QMKHvP9eJG4XGuvUNP1xr9I0lCdiKHqB1c/pP08SvqoBV
        2SGlAX2JtcQe9v48Z9NBtliQ8o/vab0GtX4+h9d7bItyav1wmFexNl7DsL+liC2M
        7jUxaezGdK4pkot9EEyYoPfCTNjGKHrUBwc1r8V2qLMZFQ0D5bLwYU+1fJPFB9wr
        I90Wv6N2jbks/JxsWd2xswNJ1uAhvVxaCXq1dR2nwfHQIs1i2r50lNqUpQpBelQk
        auaTee29h2YL3FHR7nhmWu721BG8VzKZrd2cqHwxaBmIwHcBLEyh/87U0klZNgpE
        +JYCvRFGedKT19bypPG0qm09iUAQIwFe+wQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sTihTHgOjBqh for <linux-kernel@vger.kernel.org>;
        Wed, 29 Dec 2021 18:13:32 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPWz017Pdz1RtVG;
        Wed, 29 Dec 2021 18:13:31 -0800 (PST)
Message-ID: <88daa493-dc08-06ea-97d3-94a9a3d7e51c@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 11:13:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-2-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211229161119.1006-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 01:11, Paul Menzel wrote:
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

That breaks the style of the declarations here... And since
PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE is used only in drivers/pci/quirks.c,
I do not really see the point of this change.

>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>  	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
>  	/* AMD is using RAID class only for ahci controllers */


-- 
Damien Le Moal
Western Digital Research
