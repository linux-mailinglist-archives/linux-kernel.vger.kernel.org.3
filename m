Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6483758ED5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiHJNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiHJNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:32:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F394F695;
        Wed, 10 Aug 2022 06:32:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9jLuY021932;
        Wed, 10 Aug 2022 15:32:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TqnqDMKtZ1WAdVHcFGOzKix6VQ7541Gz7ENNe8e4NxI=;
 b=UoDUF9PUeTVkhoQazHdXjPZaYyF9eOe22/LlYtx1fV+1kIIT1q3Zt0EVrt2OaM0oE6ai
 FTBeplTzArseunk3FfopBfZjDntvkV0I7yx/Gg7gSotBmKIGS7s3FlR8D/RmKAgahdnB
 vPLAg29fE5Mua7O2/Py/N9hjSfhmjsaWQGA8zdCG7r3/aLsgzMDb2uT2qFcQ/s5Oesyb
 u46+QgLlyjKDxwlSM0CeK0wpEz7Xu4uVh7pv5CXqczOfbYVZwYuUP6VzXVmx1U0nVnxr
 h3Hx29PrWpaX2Cw3QWZ8pksv25VJbrHtoHVLIh0pXTH0ZeRgrNPHgQ2v/AvKIYeJgM6s vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3huwr4msff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 15:32:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DCDF100034;
        Wed, 10 Aug 2022 15:32:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 166B82309E5;
        Wed, 10 Aug 2022 15:32:01 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 10 Aug
 2022 15:32:00 +0200
Message-ID: <38200a6f-fdc1-fa94-7bc6-91ca528235ed@foss.st.com>
Date:   Wed, 10 Aug 2022 15:31:59 +0200
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
 <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
 <YvOxOg0vXSGrZLfP@sirena.org.uk>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <YvOxOg0vXSGrZLfP@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.120]
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



On 8/10/22 15:23, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 03:15:08PM +0200, Patrice CHOTARD wrote:
>> On 8/10/22 15:06, Mark Brown wrote:
> 
>>> Do we need to add something to the DT bindings to indicate that
>>> parallel-memories is valid?
> 
>> You mean in the st,stm32-qspi.yaml DT binding file ? Right i think it could be preferable to add it.
> 
> Yes.  Though I'm not clear if the bindings actually want to enforce it
> there, it's a device level property not a controller level one so it
> might not be something where controller support gets validated.

Ah yes, i see, parallel-memories should not be used in our qspi controller node.
So i can't reuse parallel-memories for my purpose.

So i need to add a new proprietary property at controller level as done in the v1 ?

