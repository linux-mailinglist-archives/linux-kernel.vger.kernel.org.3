Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC7583A04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiG1IHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiG1IG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:06:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EDC61D5F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:06:58 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LtjnQ1NTCz67Lgb;
        Thu, 28 Jul 2022 16:03:06 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 28 Jul 2022 10:06:56 +0200
Received: from [10.126.174.188] (10.126.174.188) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:06:56 +0100
Message-ID: <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
Date:   Thu, 28 Jul 2022 09:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.188]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trim list

On 25/07/2022 13:51, Arnd Bergmann wrote:
>>> CONFIG_SLIMBUS=m
>> Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from
>> config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly
>> require config SLIMBUS enabled in the defconfig.
> That 'imply' looks like it was added to solve a problem using the old 'imply'
> semantics that are not what this keyword does today. I suspect it's still
> broken when CONFIG=SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
> and the correct fix is to use a dependency like
> 
>        depends on SLIMBUS || !SLIMBUS
> 
> so the defconfig symbol should stay.
> 

JFYI, building for CONFIG_SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m is ok. 
The driver has a runtime check for CONFIG_SLIMBUS in qcom_swrm_probe().

That implementation seems consistent with guidance in 
kconfig-language.rst - so do you think that there is still a problem?

thanks,
John
