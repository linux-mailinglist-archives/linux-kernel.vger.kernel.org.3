Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824A74B887A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiBPNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:07:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBPNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:07:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F03E016;
        Wed, 16 Feb 2022 05:07:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 0E7FF1F40AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645016828;
        bh=yrAn8vL3kOup+hs9ZweLwoFtSHWsggRpT/ckoMEaSno=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=IuvxH97K1TGXvozbseudBG1OIKYdfm6tSY80yTfWP3cKJuuBbglsSGMMOyRbP8qhv
         XDXu6sCfZ6gDTJG8Dtc6dcmkwyt5T+l2a0tC+z3uxNzwkziccrib0iQVCNYGZ43f9o
         1rShZrAOB5VIKvt6B8zj++xeo90iBo1ciPh9pHbyupneyF4fxBST7J0FAd+h69IJF3
         uJVkLZwbQc5j6QTNcQf0p7+H2To1ydmgvBaJ8jzXMup+9qrPhMir6li0A7ZvdYhOAt
         ZcWNVHhlGafV5n8StbHAH/YTo2RUv5QKwvhjYzkZzHZFNdZ4yqzuz7pPkL7TU0byyp
         IbpbAb7FiMA9g==
Message-ID: <284e2e05-9402-e480-7a69-3282b7e95b6f@collabora.com>
Date:   Wed, 16 Feb 2022 10:07:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: linux-next: build failure after merge of the spi tree
Content-Language: en-US
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220216161718.2c094b08@canb.auug.org.au>
 <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
In-Reply-To: <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 09:20 de 16/02/22, André Almeida escreveu:
> Hi Stephen,
> 
> Às 02:17 de 16/02/22, Stephen Rothwell escreveu:
>> Hi all,
>>
>> After merging the spi tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>
>> drivers/spi/spi-amd.c:333:37: error: 'spi_acpi_match' undeclared here (not in a function)
>>   333 |                 .acpi_match_table = spi_acpi_match,
>>       |                                     ^~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>   209043554915 ("spi: amd: Add support for version AMDI0062")
>>
>> CONFIG_ACPI is not set for this build.
>>
>> I have reverted that commit for today.
>>
> 
> Thanks for input. I'll send a new series with a patch to make this
> driver depends on ACPI then. My patch touched this line, but this
> variable was there before, so I think this build breakage is happening
> for some time.

Actually, the following diff in my commit is the problem:

-		.acpi_match_table = ACPI_PTR(spi_acpi_match),
+		.acpi_match_table = spi_acpi_match,

ACPI_PTR() make it as NULL if CONFIG_ACPI is not set, making the driver
suitable for test compiling even without ACPI enabled. Mark, I'll send a
v3 with this fixed.
