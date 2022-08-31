Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42625A7414
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiHaCry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 22:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiHaCrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:47:51 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944DB4EA1;
        Tue, 30 Aug 2022 19:47:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNoyAM8_1661914066;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VNoyAM8_1661914066)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 10:47:47 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
 accelerator driver
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <MW5PR84MB184271E7C3085CB1004ED6A6AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Date:   Wed, 31 Aug 2022 10:47:45 +0800
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        "xuchun.shang@linux.alibaba.com" <xuchun.shang@linux.alibaba.com>,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2BDADCE3-5045-4BCF-88FF-76945A0780B3@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
 <1661334621-44413-2-git-send-email-guanjun@linux.alibaba.com>
 <MW5PR84MB184271E7C3085CB1004ED6A6AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliott,
Thanks for your comments.

> 2022年8月24日 下午10:57，Elliott, Robert (Servers) <elliott@hpe.com> 写道：
> 
> 
> 
>> -----Original Message-----
>> From: 'Guanjun' <guanjun@linux.alibaba.com>
>> Sent: Wednesday, August 24, 2022 4:50 AM
>> To: herbert@gondor.apana.org.au
>> Subject: [PATCH v1 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
>> accelerator driver
>> 
> ...
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index 3e6aa31..d739354 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -799,6 +799,8 @@ source "drivers/crypto/hisilicon/Kconfig"
>> 
>> source "drivers/crypto/amlogic/Kconfig"
>> 
>> +source "drivers/crypto/ycc/Kconfig"
>> +
>> config CRYPTO_DEV_SA2UL
>> 	tristate "Support for TI security accelerator"
>> 	depends on ARCH_K3 || COMPILE_TEST
> 
> This menu isn't perfectly sorted, but since the new entry is for
> "Alibaba YCC", putting this at the top of the file would be
> better positioned for eventual sorting.
> 
> Naming the directory alibaba/ rather than ycc/ might be more
> welcoming for future drivers, too.

Alibaba and T-Head (a semiconductor chip business entity of Alibaba Group) combined efforts
on the platform Yitian, so our cryptographic accelerator which is integrated in Yitian was named YCC,
the acronym for Yitian Cryptography Complex. We prefer ycc for our crypto related drivers.

Anyway, thanks for your suggestions. I will adjust in alphabetical order in next version.

Best regards,
Guanjun

> 
> ...
>> diff --git a/drivers/crypto/ycc/Kconfig b/drivers/crypto/ycc/Kconfig
>> +++ b/drivers/crypto/ycc/Kconfig
>> @@ -0,0 +1,8 @@
>> +config CRYPTO_DEV_YCC
>> +	tristate "Support for Alibaba YCC cryptographic accelerator"
>> +	depends on CRYPTO && CRYPTO_HW && PCI
>> +	default n
>> +	help
>> +	  Enables the driver for the on-chip cryptographic accelerator of
>> +	  Alibaba Yitian SoCs which is based on ARMv9 architecture.
>> +	  If unsure say N.
> 

