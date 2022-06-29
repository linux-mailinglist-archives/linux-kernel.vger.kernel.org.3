Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394735609A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiF2Sqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiF2SqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:46:23 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 11:46:21 PDT
Received: from 9.mo548.mail-out.ovh.net (9.mo548.mail-out.ovh.net [46.105.48.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F2340C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:46:20 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.177])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id A8D0B20747;
        Wed, 29 Jun 2022 18:07:45 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Wed, 29 Jun
 2022 20:07:44 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-96R00198260963-dde8-461b-8c1a-012665a8672e,
                    DF7F9948BD89912A9BBE6A4903E17E70B6709CC1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d272ce4b-c338-c3ea-3770-6c85ddf60ec5@kaod.org>
Date:   Wed, 29 Jun 2022 20:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/2] spi: aspeed: Fix division by zero
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ian Woloschin <ian.woloschin@akamai.com>,
        Ian Woloschin <iwolosch@akamai.com>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org> <YryHVsrqNlhdwKzq@sirena.org.uk>
 <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
 <YryLj6iWVkqWowDg@sirena.org.uk>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <YryLj6iWVkqWowDg@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3fc20af5-91b9-41c4-b2e6-732ae46bea70
X-Ovh-Tracer-Id: 10732359387039697912
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkeetjedtleekjedvveffudfhteetleeifeegfeffuefghfefkeehffeufeeludejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehifiholhhoshgthhesrghkrghmrghirdgtohhmpdfovfetjfhoshhtpehmohehgeek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 19:27, Mark Brown wrote:
> On Wed, Jun 29, 2022 at 07:21:08PM +0200, Cédric Le Goater wrote:
>> On 6/29/22 19:09, Mark Brown wrote:
>>> On Wed, Jun 22, 2022 at 06:16:17PM +0200, Cédric Le Goater wrote:
>>>
>>>> Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
>>>
>>> This commit isn't in mainline.
> 
>> drat. It's the OpenBMC kernel. I will resend. Sorry about that.
> 
> It's OK, I fixed it up locally.


Thanks,

C.
