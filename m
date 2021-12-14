Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC675474152
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhLNLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhLNLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:17:54 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 03:17:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6A4E23FA5E;
        Tue, 14 Dec 2021 11:17:49 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pci-gli: GL9755: Support for CD/WP
 inversion on OF platforms
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211212070210.141664-1-marcan@marcan.st>
 <20211212070210.141664-2-marcan@marcan.st>
 <72e29a9d-7e2a-5c2e-c44b-42172aae4f2d@intel.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <82faec71-31f7-f64e-e8e7-cf698b29fa16@marcan.st>
Date:   Tue, 14 Dec 2021 20:17:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <72e29a9d-7e2a-5c2e-c44b-42172aae4f2d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 19.41, Adrian Hunter wrote:
>>   #define PCI_GLI_9755_PECONF   0x44
>> -#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
>> -#define   PCI_GLI_9755_DMACLK   BIT(29)
>> +#define   PCI_GLI_9755_LFCLK          GENMASK(14, 12)
>> +#define   PCI_GLI_9755_DMACLK         BIT(29)
> 
> Please don't mix in white space changes.

This is aligning the existing code with the additions; is it preferable 
to have the new ifdefs below misaligned?

>> +#define   PCI_GLI_9755_INVERT_CD      BIT(30)
>> +#define   PCI_GLI_9755_INVERT_WP      BIT(31)
>>   
>>   #define PCI_GLI_9755_CFG2          0x48
>>   #define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
>> @@ -570,6 +573,18 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>>   	gl9755_wt_on(pdev);
>>   
>>   	pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
>> +#ifdef CONFIG_OF
>> +	if (pdev->dev.of_node) {
> 
> As Robin wrote, please remove #ifdef and if (pdev->dev.of_node)
> because they are not needed.

Ack, will send out a v3 soon with the requested changes and hopefully it 
should be good to go :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
