Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255DE4B70D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiBOQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiBOQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00F8D10B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644941787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B52YMK1HFvXByJ7MNOOTdlfyH5lYACIthHaLpPUqg9M=;
        b=a+gs1f74epAu1URvNZnKP2yr+uh8xovuoicX9W2v2P3ilbZtstIfalWl91jmUWWne9DoGY
        JwtYPtrN2ebMBfAoD4jXmuvdMYVewc3dqrtUwzUK5ZZdT0X71VlZKrfPUSfceY4qi986C/
        5G6c7hoXDV7HdX0JyRDjiRCFPPSW3q4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-bM16kfXQO_OTICbaeh_cyw-1; Tue, 15 Feb 2022 11:16:25 -0500
X-MC-Unique: bM16kfXQO_OTICbaeh_cyw-1
Received: by mail-ot1-f69.google.com with SMTP id h3-20020a9d6003000000b005acef9b2c7dso595487otj.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B52YMK1HFvXByJ7MNOOTdlfyH5lYACIthHaLpPUqg9M=;
        b=ppYhcNusetYAO6diWNIo2hvMugiLI4Yg/m8AbEB+ear2a7CGEZI6A9+YyabU9JNtFB
         qYXzxyXlmQuvq69zj5b84aKn+eSFQgGXQ/0DoQhXCNT+HdJbvYUeAgxzHWXB/3ABxa4I
         mDyj6nfCWn4ncAdXnppRmNLiBodiIroaOjJjNzsnhg19A4djRikdpY2mNzCttaeQwTdm
         4H7B/CO+5M1AM6ZfxQez7zTiBJSuhbPi14LHKkgm0MU/NJUeVqthbTaxWFXZgG8kBXfv
         m3GqXaQy1u7esf6MTBAxcxAmuHccfO1YNHBjR58Zn9rHPrCmZh8lnQkDjr+JHRR+ZtLD
         DnhQ==
X-Gm-Message-State: AOAM5322Tog9MVb/U4CcJVrk+AMBfJ3MnRHA5SwSd1zcG3HFUEAPTkR/
        bXCMhtj20zMF1TgxZQSx0OoW+a8/2n9149Ga1ZEXcdLM8QBfO1/Qr574SDqxu3sf1YwkucNqqhJ
        gAkzImKXde0fcIjxuhou1xCRg
X-Received: by 2002:a4a:d5ca:: with SMTP id a10mr1537659oot.88.1644941785066;
        Tue, 15 Feb 2022 08:16:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvkXRkoitgTXd23UUFGnfd4xIFxcrT3/1sw6kemCC5pmflPuTRt9zwwMNWa6pDW67BJj5ghQ==
X-Received: by 2002:a4a:d5ca:: with SMTP id a10mr1537642oot.88.1644941784822;
        Tue, 15 Feb 2022 08:16:24 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s11sm13619826otq.69.2022.02.15.08.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:16:24 -0800 (PST)
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
Date:   Tue, 15 Feb 2022 08:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-8-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add the PCI product id for an Open FPGA Stack PCI card.
Is there a URL to the card ?
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl-pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 83b604d6dbe6..cb2fbf3eb918 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>   #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>   #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>   #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
> +#define PCIE_DEVICE_ID_INTEL_OFS		0xbcce

INTEL_OFS is a generic name, pci id's map to specific cards

Is there a more specific name for this card ?

Tom

>   
>   /* VF Device */
>   #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>   #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>   #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>   #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
> +#define PCIE_DEVICE_ID_INTEL_OFS_VF		0xbccf
>   
>   static struct pci_device_id cci_pcie_id_tbl[] = {
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> @@ -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>   	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>   	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS_VF),},
>   	{0,}
>   };
>   MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);

