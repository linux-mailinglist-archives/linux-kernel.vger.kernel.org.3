Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81147E115
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbhLWKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:05:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:34198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242964AbhLWKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640253918; x=1671789918;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5TBTPDRw7ZCsc7Ug2RN/LBBlv3YBnEKzeV22HaXHZoI=;
  b=HCB0rvoSphniTGaTgpcx1GWCZK8X+nBzjBZdStYClv6AlxTRWbk6cEs2
   0qdXlCipUcmJWnzn2LyC1h8ISE7kPoYIDCpD+DZzv9fsK1zAHVB9kKt3C
   93UcWsmE4SluJqJNtUsWvBPLy8uWXu7ZFMmlOcFf2tRZms4dlTXzjSry0
   GlMLIuhhVWrXnjkrXVdDGI3uljJeCDvsVHSe8ZPcq49fZLAVOYeMx+L2P
   xOH4XzVspDetP+cGm9VDan4LvHUhce+xAZ5HtwHWV5ZK5j29Tw3ochLuj
   DwmgBZCzSShNUpci4KtewmAgPUtZ3yCcXpjW4HCBJvRAgmDtYwB9bqSDl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240601917"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="240601917"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:05:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="508809439"
Received: from shartkam-mobl.ger.corp.intel.com ([10.249.35.254])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:05:13 -0800
Date:   Thu, 23 Dec 2021 12:05:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_exar: derive nr_ports from ID for
 Acces I/O cards
In-Reply-To: <20211222194413.75069-1-andriy.shevchenko@linux.intel.com>
Message-ID: <6c60d8c1-ff64-8e93-79f1-1a3dd352d7a2@linux.intel.com>
References: <20211222194413.75069-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021, Andy Shevchenko wrote:

> In the similar way how it's done in 8250_pericom, derive number of
> UART ports from PCI ID for Acces I/O cards.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 37 ++++++++++-------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index a4508ac0cac9..cf16bd889abd 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -611,7 +611,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  
>  	maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
>  
> -	nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
> +	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
> +		nr = BIT(((pcidev->device & 0x38) >> 3) - 1);

Shouldn't this be nr_ports = ...

-- 
 i.


> +	else if (board->num_ports)
> +		nr_ports = board->num_ports;
> +	else
> +		nr_ports = pcidev->device & 0x0f;
>  
>  	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
>  	if (!priv)
> @@ -710,22 +715,6 @@ static int __maybe_unused exar_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
>  
> -static const struct exar8250_board acces_com_2x = {
> -	.num_ports	= 2,
> -	.setup		= pci_xr17c154_setup,
> -};
> -
> -static const struct exar8250_board acces_com_4x = {
> -	.num_ports	= 4,
> -	.setup		= pci_xr17c154_setup,
> -};
> -
> -static const struct exar8250_board acces_com_8x = {
> -	.num_ports	= 8,
> -	.setup		= pci_xr17c154_setup,
> -};
> -
> -
>  static const struct exar8250_board pbn_fastcom335_2 = {
>  	.num_ports	= 2,
>  	.setup		= pci_fastcom335_setup,
> @@ -810,13 +799,13 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
>  	}
>  
>  static const struct pci_device_id exar_pci_tbl[] = {
> -	EXAR_DEVICE(ACCESSIO, COM_2S, acces_com_2x),
> -	EXAR_DEVICE(ACCESSIO, COM_4S, acces_com_4x),
> -	EXAR_DEVICE(ACCESSIO, COM_8S, acces_com_8x),
> -	EXAR_DEVICE(ACCESSIO, COM232_8, acces_com_8x),
> -	EXAR_DEVICE(ACCESSIO, COM_2SM, acces_com_2x),
> -	EXAR_DEVICE(ACCESSIO, COM_4SM, acces_com_4x),
> -	EXAR_DEVICE(ACCESSIO, COM_8SM, acces_com_8x),
> +	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM_8S, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM232_8, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM_2SM, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
> +	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
>  
>  	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
>  	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
> 

