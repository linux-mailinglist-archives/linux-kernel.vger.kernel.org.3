Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF858ECE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiHJNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiHJNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:15:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE514D39;
        Wed, 10 Aug 2022 06:15:27 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9YPt2022853;
        Wed, 10 Aug 2022 15:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rkpHv8Tbh6b+APur6AAgNWkVAtNoRSLElkQ+Ih3mAgQ=;
 b=6hXZBpjPuIjZqE4eqHtYmkWVRABPpkWAAiwdbmrONw++06+XoIhLE+Cj78ukYOtf2/hO
 sWDKmGcSSEf7TAzfybv00k9q0cg0EP0VjIzhu5AvcdiOUdQDO6VHLBhRkJz/fhLsxhZY
 9u9AumrORfRWG/rzyTmdlRYzo8OxuKEOWs2PqoJZVX68AymXzZlGIGweqy2GmS8+d56a
 atgFS8RxGgbJFuDe0QyJxJvllire8LXNz+twwMU5JFyQeZOZgenTONY/H1kOxJTHhT34
 FBsssktjpmStdVfGEY7IAyY+tjpshpb8V1f//6ha+NQmnSxMt7XGMgHYFBuenPqGCSua Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3huwrr5158-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 15:15:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C8F710002A;
        Wed, 10 Aug 2022 15:15:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B05E2132EC;
        Wed, 10 Aug 2022 15:15:10 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.121) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 10 Aug
 2022 15:15:09 +0200
Message-ID: <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
Date:   Wed, 10 Aug 2022 15:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
 <20220810093215.794977-2-patrice.chotard@foss.st.com>
 <YvOtZtrRHd4AT+j+@sirena.org.uk>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <YvOtZtrRHd4AT+j+@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 8/10/22 15:06, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 11:32:14AM +0200, patrice.chotard@foss.st.com wrote:
> 
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> v2: _ use parallel-memories property
>>     _ set auto_runtime_pm to true
>>     _ remove pm_runtime_*() usage in transfer_one_message() callback
>> ---
> 
> The changelog should come after the --- so that it gets automatically
> stripped out by tooling.  No need to resend just for this.
> 
>> +	/*
>> +	 * Dual flash mode is only enable in case "parallel-memories" and
>> +	 * "cs-gpios" properties are found in DT
>> +	 */
>> +	if (of_property_read_bool(dev->of_node, "parallel-memories") &&
>> +	    of_gpio_named_count(dev->of_node, "cs-gpios")) {
>> +		qspi->cr_reg = CR_DFM;
>> +		dev_dbg(dev, "Dual flash mode enable");
>> +	}
> 
> Do we need to add something to the DT bindings to indicate that
> parallel-memories is valid?

You mean in the st,stm32-qspi.yaml DT binding file ? Right i think it could be preferable to add it.


Patrice
