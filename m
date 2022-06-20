Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5A551334
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiFTItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiFTItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:49:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E371F584;
        Mon, 20 Jun 2022 01:49:19 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRNYs0rzQz1KC3v;
        Mon, 20 Jun 2022 16:47:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:48:48 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:48:47 +0800
Subject: Re: [PATCH] media: ov7251: add missing clk_disable_unprepare() on
 error in ov7251_set_power_on()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <mchehab@kernel.org>, <djrscally@gmail.com>,
        <sakari.ailus@linux.intel.com>
References: <20220617013943.851327-1-yangyingliang@huawei.com>
 <YqxVWg21PsdkMz2Y@smile.fi.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <a6731874-1c72-898e-fe8f-8d08d4a4d74e@huawei.com>
Date:   Mon, 20 Jun 2022 16:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YqxVWg21PsdkMz2Y@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/6/17 18:20, Andy Shevchenko wrote:
> On Fri, Jun 17, 2022 at 09:39:43AM +0800, Yang Yingliang wrote:
>> Add the missing clk_disable_unprepare() before return
>> from ov7251_set_power_on() in the error handling case.
> ...
>
>>   	if (ret < 0) {
>>   		dev_err(ov7251->dev, "error during global init\n");
>> +		clk_disable_unprepare(ov7251->xclk);
>>   		ov7251_regulators_disable(ov7251);
> Logically it should go here. Please, read a code above this check.
Do you mean print the error code on error path ?

Thanks,
Yang
>
>>   		return ret;
>>   	}
