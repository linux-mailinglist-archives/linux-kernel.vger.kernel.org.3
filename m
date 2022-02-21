Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29A4BDB84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbiBUQ35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Feb 2022 11:29:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiBUQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:29:54 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F971D300
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:29:30 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:29:19 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Error when compiling kernel module - Re: More power management
 updates for v5.17-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     eh kernel <ehkernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <VSXN7R.644PDRMKJL992@crapouillou.net>
In-Reply-To: <CAJZ5v0iNLXVAR8fG-gjnRP4BSwReL1sZ9XiLHvO+YVKFJFjGOQ@mail.gmail.com>
References: <CAGsy+6s36Vf+n9cMbis2a=A4=dUNvsbda7K7rszHikq_HGOAtA@mail.gmail.com>
        <CAJZ5v0iNLXVAR8fG-gjnRP4BSwReL1sZ9XiLHvO+YVKFJFjGOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Le lun., févr. 21 2022 at 17:18:51 +0100, Rafael J. Wysocki 
<rafael@kernel.org> a écrit :
> On Mon, Feb 21, 2022 at 1:15 PM eh kernel <ehkernel@gmail.com> wrote:
>> 
>>  Hi Rafael,
>> 
>>  I now get an error when compiling the kernel module (out-of-tree) 
>> with the new PM macros.
>> 
>>  /home/ubuntu/pressure/bmp280-core.c:1163:28: error: expected 
>> ‘)’ before ‘(’ token
>>   1163 |      bmp280_runtime_resume, NULL);
> 
> Which of the macros has triggered this error?

I think the bug was introduced by 23a133c1ba67 ("iio:adc:ab8500: Switch 
from CONFIG_PM guards to pm_ptr() etc")

The macro takes 4 arguments and its first parameter should be the 
dev_pm_ops name, so "ab8500_gpadc_pm_ops".

It slipped during review.

Cheers,
-Paul

> 
>>        |                            ^
>>        |                            )
>>  /home/ubuntu/pressure/bmp280-core.c:1149:12: warning: 
>> ‘bmp280_runtime_resume’ defined but not used [-Wunused-function]
>>   1149 | static int bmp280_runtime_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~
>>  /home/ubuntu/pressure/bmp280-core.c:1141:12: warning: 
>> ‘bmp280_runtime_suspend’ defined but not used [-Wunused-function]
>>   1141 | static int bmp280_runtime_suspend(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~~~~~
>> 
>>  When I revert to the old file without the new PM macros it works 
>> just fine. Do I need to take some extra parameters into account now 
>> with the new format when compiling?
>> 


