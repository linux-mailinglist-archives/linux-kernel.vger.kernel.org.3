Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54464B7337
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiBOPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:06:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiBOPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47AAD108579
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644937560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8jOHYZYbA4jfSLJsozB4dmcPQCNz7v+Rkf0nVLhgeE=;
        b=D+3bE1ZL6E6NWI8mKM37vnrLboCP3DI3CIbFikmnvLlYzagLHCfzlMmuEpJg8RSQ/u8XYI
        LEfXGp/9h9JiCU1eeKK6dqfw8tBcPRhjdgB7DbtVV4trSkayohGGCrNf8cyzZmnmTwzGaL
        Phyeizrjb5Z+IshTHVYW2uGBN+dbj5I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-z2-vCJFaOqGNSjYu5WX-yw-1; Tue, 15 Feb 2022 10:05:59 -0500
X-MC-Unique: z2-vCJFaOqGNSjYu5WX-yw-1
Received: by mail-oi1-f197.google.com with SMTP id bi18-20020a056808189200b002cda020b174so4759027oib.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y8jOHYZYbA4jfSLJsozB4dmcPQCNz7v+Rkf0nVLhgeE=;
        b=JB0ePBcGUtMBV+Ss4EKqwwrhSPGFYr5/rrS+iEFvdc+5io3AGjqRevCz1IimtsFRK1
         02gnz/CGEsKEtZTH7La10vq7gngMJpU/9CyIF4A24DBymKMzmfTSRbBC1lkURHHLrb/c
         YjMcdNxqorgYznwc7/lbBt2corbi+77I/miuZqoxPKFsBEagM8E9XTmQEmv2pmH8wnit
         c650BGe148VUUOqEUMSzWgamhluGIFcJdSQaeWyMo09YlByve3qkTkAsTlyuWAD9jHCE
         fmggZhv/hZpTK+Jx90Zh7J8f/rAtjtPSd02/XKtdGlRkCjzdHm4XpgSUMPeDWAffI4Jx
         sgiA==
X-Gm-Message-State: AOAM533axYOZiUjLKJPlbL8OITseO5SAeDl80rFXdVpSD/0XEGAo2xhx
        WJhgmThtb/1Yv6LSPJPdNGlUcR4GioTKe7ZK32FU6dbyG0mXozWMi02EvG79UItmDWrGfi5hCEE
        oVNcW1PEfu00s91wSMfsKAxzJ
X-Received: by 2002:a05:6870:1284:: with SMTP id 4mr1499027oal.237.1644937558263;
        Tue, 15 Feb 2022 07:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVovLR+b6s5gf/IniSELroXTJ36lsSG5z6YFueoHAg9Edc5evG7o1wiRDX2UOg2n6RnV6AtQ==
X-Received: by 2002:a05:6870:1284:: with SMTP id 4mr1499013oal.237.1644937558019;
        Tue, 15 Feb 2022 07:05:58 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m7sm13932894ots.32.2022.02.15.07.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:05:57 -0800 (PST)
Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
Date:   Tue, 15 Feb 2022 07:05:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-4-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
>  From a fpga partial reconfiguration standpoint, a port
> may not be connected any local BAR space.  The port could
> be connected to a different PCIe Physical Function (PF) or
> Virtual Function (VF), in which case another driver instance
> would manage the endpoint.

It is not clear if this is part of iofs or a bug fix.

> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl-pci.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4d68719e608f..8abd9b408403 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   		v = readq(base + FME_HDR_CAP);
>   		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
>   
> +		dev_info(&pcidev->dev, "port_num = %d\n", port_num);
>   		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
>   
>   		for (i = 0; i < port_num; i++) {
> @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   			 */
>   			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>   			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar >= PCI_STD_NUM_BARS) {

Is bar set to a better magic number that pci_std_num_bars ? maybe 0xff's

How do you tell between this case and broken hw ?

Move up a line and skip getting an offset that will not be used.

> +				dev_info(&pcidev->dev, "skipping port without local BAR space %d\n",
> +					 bar);
> +				continue;
> +			} else {
> +				dev_info(&pcidev->dev, "BAR %d offset %u\n", bar, offset);
> +			}
>   			start = pci_resource_start(pcidev, bar) + offset;
>   			len = pci_resource_len(pcidev, bar) - offset;
>   

Is similar logic needed for else-if (port) block below this ?

Tom

