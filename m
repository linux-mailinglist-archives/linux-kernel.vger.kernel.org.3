Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4105AEEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiIFPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiIFPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E9B93;
        Tue,  6 Sep 2022 07:44:22 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMSBJ4RYmzkWSs;
        Tue,  6 Sep 2022 22:16:56 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 22:19:29 +0800
Message-ID: <55bc9edd-f76a-c875-1b94-54f2f7fe4446@huawei.com>
Date:   Tue, 6 Sep 2022 22:19:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next v3] rtc: fsl-ftm-alarm: Use module_init and add
 module_exit
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220905062613.1119008-1-chris.zjh@huawei.com>
 <5472f57c-9805-4021-fbc7-38363aab0e88@prevas.dk>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <5472f57c-9805-4021-fbc7-38363aab0e88@prevas.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a good idea, thanks.

在 2022/9/5 21:17, Rasmus Villemoes 写道:
> On 05/09/2022 08.26, Zhang Jianhua wrote:
>> fsl-ftm-alarm driver can be built out of tree, so change the
>> macro device_initcall() to module_init() for standard usage.
> "out of tree" usually refers to modules that are not part of the
> mainline kernel.
>
> "can be built as a module" is more accurate and less confusing.
>
>> fsl-ftm-alarm registers a platform driver in module_init function,
>> however there is no module_exit function to unregister it, and it will
>> occur resource leak, so add ftm_alarm_exit() function for module_exit.
> It seems that you can avoid a lot of boilerplate using the
> module_platform_driver macro. The single line
>
> module_platform_driver(ftm_rtc_driver);
>
> should/could replace the ftm_alarm_init/ftm_alarm_exit functions and the
> explicit module_init()/module_exit() lines.
>
> Rasmus
