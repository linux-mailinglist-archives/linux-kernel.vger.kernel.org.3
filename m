Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F97F4FF112
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiDMH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiDMH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:58:05 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518D49694;
        Wed, 13 Apr 2022 00:55:44 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.1.92])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id E1E6D23F7BC;
        Wed, 13 Apr 2022 07:55:41 +0000 (UTC)
Received: from [192.168.1.42] (88.125.132.16) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 09:55:40 +0200
Message-ID: <e433c3b8-5118-47ad-0cfd-8ca79acbf7e0@traphandler.com>
Date:   Wed, 13 Apr 2022 09:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <linux@roeck-us.net>, <wim@linux-watchdog.org>,
        <geert+renesas@glider.be>, <linux-watchdog@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220408200205.2833931-1-jjhiblot@traphandler.com>
 <20220408200205.2833931-3-jjhiblot@traphandler.com>
 <YlOJVzA49rTrBDH3@google.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <YlOJVzA49rTrBDH3@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.16]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 9366924277373221365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhephfeitdehtddtgeeugefgtdejgedtieelfedtgeehuedtteejueeihedtvedvfeeinecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehphhhilhdrvggufihorhhthhihsehrvghnvghsrghsrdgtohhm
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/04/2022 03:50, Tzung-Bi Shih wrote:
> On Fri, Apr 08, 2022 at 10:02:05PM +0200, Jean-Jacques Hiblot wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> With a minor comment:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for the time you took reviewing this.

>
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	wdt->wdtdev.timeout = DEFAULT_TIMEOUT;
>> +	ret = watchdog_init_timeout(&wdt->wdtdev, 0, dev);
> Could it drop the assignment if `ret` is unused?

I'll keep the assignment but check the value: watchdog_timeout_invalid()

will return an error if the dt supplied value is out of range.

JJ


