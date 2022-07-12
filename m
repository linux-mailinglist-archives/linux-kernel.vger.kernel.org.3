Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B83571E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiGLPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiGLPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B378CF6CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657638307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYGQowRRWMmN0sxEy+ystye0hklNDwtwy22gwY/oCHU=;
        b=CjOkQxw4qxv2VokG+83sUO91xVn9Cl3XyPABakij50chA+EJto7gc+Mp+7+b0Jmty8Q8Wz
        9hrxAcFOrE2n2NRYOrrupo2MWvvb2kzmjYc49R+fVvff6f4bxTudXm5KJq/T4P/3AT8xGk
        P3YMlP+6q6sQqv/6NkSLIEPfLHu2jgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-_M5s2jpoPKCcE32j_hm0tA-1; Tue, 12 Jul 2022 11:05:04 -0400
X-MC-Unique: _M5s2jpoPKCcE32j_hm0tA-1
Received: by mail-wm1-f71.google.com with SMTP id y14-20020a7bcd8e000000b003a2ea282944so903861wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=UYGQowRRWMmN0sxEy+ystye0hklNDwtwy22gwY/oCHU=;
        b=Q/O5HQ0/vSsjnfjV+Lj3IKdrCtt/hRxREBo2xexFl3+xm+pKONHEW6CuU2Y/31ZKr3
         M6u3kYDEPZcLQz7kjB+bk6/X9rUNmyJbRG15FRm3PFab2+riE7XJ+1aGPFgC5J476bSQ
         sct+IZ/bID2DIkl/W3VurD/X3QrSaDayH7NR60plqOCsAZAHwQfQEg3D967RJyaiIiwa
         NLtojuWP++SNCouHkuZSRlQzAnNsnICHyL/hdFutn+nXUZnKbp5wNsJI4UEN0LpRDunb
         AGD3MoGVgEMYbCrmjSLurEnJping8qsIcAi/SFhmTEo1FTvu129RO5nD3tnJ52/0XBdL
         Lbrw==
X-Gm-Message-State: AJIora9yAFsI5Gl8AS+LMWPnAgnl97JT2/MVaPAXLqYwJ0hM6FPiNjXN
        9nOEGBqgiiUGlYGuYs5AzKQJHuido4gEQCuaIqjhZLW0R91pmXxgNgYz3b/C0YW1p/G3is2xV4S
        JvcaOxC7ZVzK18RkLuW3kJHo=
X-Received: by 2002:a5d:5846:0:b0:21d:a98a:b236 with SMTP id i6-20020a5d5846000000b0021da98ab236mr9133163wrf.674.1657638303593;
        Tue, 12 Jul 2022 08:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9DslN6RE054elR+7RG4LKNVXeLPBmWOEg+8DTB3NT7tuycRzCk/nDHHFVlmgVhISImkhmFg==
X-Received: by 2002:a5d:5846:0:b0:21d:a98a:b236 with SMTP id i6-20020a5d5846000000b0021da98ab236mr9133136wrf.674.1657638303418;
        Tue, 12 Jul 2022 08:05:03 -0700 (PDT)
Received: from [192.168.9.27] (net-2-34-30-100.cust.vodafonedsl.it. [2.34.30.100])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003976fbfbf00sm9491042wms.30.2022.07.12.08.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:05:02 -0700 (PDT)
Message-ID: <23a5d310-7d5e-a8ee-bd66-b80505e0553e@redhat.com>
Date:   Tue, 12 Jul 2022 17:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     matthew.gerlach@linux.intel.com
Cc:     basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
References: <20220707150549.265621-3-matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
 C6100 cards
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20220707150549.265621-3-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-07 17:05, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add pci_dev_table entries supporting the Intel N6000, N6001
> and C6100 cards to the dfl-pci driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Tested-by: Marco Pagani <marpagan@redhat.com>

> ---
> v3: added necessary subdevice ids
>     removed 'drivers: ' from title
> 
> v2: changed names from INTEL_OFS to INTEL_DFL
> ---
>  drivers/fpga/dfl-pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index fd1fa55c9113..94eabdf1d2f7 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -77,12 +77,19 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
> +#define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
>  
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>  #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
> +#define PCIE_DEVICE_ID_INTEL_DFL_VF		0xbccf
> +
> +/* PCI Subdevice ID */
> +#define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
> +#define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
> +#define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
>  
>  static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> @@ -96,6 +103,18 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);

