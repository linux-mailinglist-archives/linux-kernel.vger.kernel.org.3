Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACFE518444
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiECM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiECM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:29:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D337A9D;
        Tue,  3 May 2022 05:26:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2438jkLk016074;
        Tue, 3 May 2022 14:25:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=47vTGwiYTxtIa15R2nQGwX54FUlIo/9LF6dDi/n3mKI=;
 b=vKnMCjo7utP6wU8DFbsi5wQm1OujYfjcHwuwdKU7Rn8JxDWCQW7ZwTZ2hk9C7lU/KdFd
 QJkO8LorREmPY21saT52zUS1Fz7UKRQHkGeE4yzyP2mkn9msd9eaRlBJx5OLNZpXPHKT
 QT3BnksozOemq9DoZkeCUaunnbEoE0AX73mf7GugWo1jOzcvsYUhtPas35tjKA1Lo+y4
 9ExSbuHZ0MUv5NHqZw5syiDCLaItxuxpt53weqR/K5oqDyfOau8y4JvoSxUSnSICAEk7
 P0is1jfGp0mTuxZ/EGYfBNfQufaK+vwbYe8gs40jSxiRsSsfdXOMIa1pvempEHgUN0Uy kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0g6yda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 14:25:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C01DE100034;
        Tue,  3 May 2022 14:25:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B921721BF66;
        Tue,  3 May 2022 14:25:39 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 3 May
 2022 14:25:38 +0200
Message-ID: <28627ccb-21ef-1b86-e5d7-460daf672d6d@foss.st.com>
Date:   Tue, 3 May 2022 14:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 1/1] iio: trigger: stm32-lptimer-trigger: Make use of
 device properties
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
 <20220428193304.016c46a3@jic23-huawei> <YnEB97YfPYpe2aCn@smile.fi.intel.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <YnEB97YfPYpe2aCn@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_03,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/22 12:20, Andy Shevchenko wrote:
> On Thu, Apr 28, 2022 at 07:33:04PM +0100, Jonathan Cameron wrote:
>> On Wed, 13 Apr 2022 21:56:56 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> Convert the module to be property provider agnostic and allow
>>> it to be used on non-OF platforms.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> MAINTAINERS entry for this one uses extensive wild cards so may
>> escape scripts...
>>
>> +CC Fabrice.
> 
> Thanks!
> 
> Not sure it might break anything, it's quite straightforward conversion.

Hi Andy, Jonathan,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Best Regards,
Fabrice

> 
