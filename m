Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7348C539
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353762AbiALNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:54:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55880 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353747AbiALNyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:54:19 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CAbtYb018364;
        Wed, 12 Jan 2022 14:54:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sdH0K0eSe3S08hG8n1xmryhD86m71VUW2ZVs/ElIu9U=;
 b=wnGc49ldGz4lYlfm1lDeBhRGNoC7duO7H+5A3eUCocSE0ZqXhXf3wdcDs/xlUVm+fEYc
 pgW5+z18yO1VR6NQFXKp70LEkwBofu+JxMTT4kaCB6TeSTeN5WObQNyj4b2NwduFWjNb
 jn3Ti8EK1AItDmLdX5sLfcAQUf6+qYz3jhJcceSsmvbfubyJZ4sEFiOTagVC7gSTy1+I
 7fec/xjY6JVsnNmZhQ/FhTpdhj5rE5r77FlyCOPFHHfYqpk6cTNqqVXx28Tq1YcJ9Cds
 x77boKCBbYBEkD/CjgGVIcSaz/IrVts5BFTu0kRoXn4X/kPuNxhn94467Hi6/aPGZqjx EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dhssdtpuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 14:54:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0E7C10002A;
        Wed, 12 Jan 2022 14:54:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E42EF235F1B;
        Wed, 12 Jan 2022 14:54:09 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan
 2022 14:54:09 +0100
Subject: Re: spi: stm32-qspi: Update spi registering
To:     Lukas Wunner <lukas@wunner.de>
CC:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20220106132052.7227-1-patrice.chotard@foss.st.com>
 <20220108194819.GA5467@wunner.de>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <ba5de6f6-a4f0-4974-cc68-abcb62ebf96e@foss.st.com>
Date:   Wed, 12 Jan 2022 14:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220108194819.GA5467@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas

On 1/8/22 8:48 PM, Lukas Wunner wrote:
> On Thu, Jan 06, 2022 at 02:20:52PM +0100, patrice.chotard@foss.st.com wrote:
>> --- a/drivers/spi/spi-stm32-qspi.c
>> +++ b/drivers/spi/spi-stm32-qspi.c
>> @@ -784,7 +784,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
>>  	pm_runtime_enable(dev);
>>  	pm_runtime_get_noresume(dev);
>>  
>> -	ret = devm_spi_register_master(dev, ctrl);
>> +	ret = spi_register_master(ctrl);
>>  	if (ret)
>>  		goto err_pm_runtime_free;
>>  
>> @@ -817,6 +817,7 @@ static int stm32_qspi_remove(struct platform_device *pdev)
>>  	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
>>  
>>  	pm_runtime_get_sync(qspi->dev);
>> +	spi_unregister_master(qspi->ctrl);
>>  	/* disable qspi */
>>  	writel_relaxed(0, qspi->io_base + QSPI_CR);
>>  	stm32_qspi_dma_free(qspi);
> 
> NAK, this introduces a use-after-free because the "qspi" allocation
> is freed by spi_unregister_master(), yet is subsequently accessed.
> 
> You need to convert the driver to devm_spi_alloc_master() to avoid that.
> Do it in the same patch to ease backporting.

Ok i see, spi_unregister_controller() is releasing the controller if it wasn't
 previously devm allocated. I will make usage of devm_spi_alloc_master as you suggested.

> 
> Please add a stable designation and a Fixes: tag.  Chances are the patch
> needs to be backported all the way back to the release when the driver
> was first introduced.
> 
> Thanks,
> 
> Lukas
> 
Thanks
Patrice
