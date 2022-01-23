Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFB497639
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbiAWXCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:02:43 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220]:55623 "EHLO
        smtpout2.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbiAWXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:02:42 -0500
X-Greylist: delayed 1111 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jan 2022 18:02:42 EST
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.173])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 8337FD984D66;
        Sun, 23 Jan 2022 23:44:07 +0100 (CET)
Received: from kaod.org (37.59.142.102) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 23:44:05 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R004b7e6303c-d087-4cdd-8e9a-f381c1422b65,
                    90EAC8BD64EA4EE21D802F9E5F0AC1C4B4718499) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d4ba6413-57ce-14c1-ed48-d00db2f74bd3@kaod.org>
Date:   Sun, 23 Jan 2022 23:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: aspeed-smc: improve probe resilience
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Potin Lai <potin.lai@quantatw.com>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com> <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com> <20220103171721.46c8e697@xps13>
 <YdSP6tKyQ2ZRUC+2@heinlein> <20220105063244.lno3xur64uepa7i5@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220105063244.lno3xur64uepa7i5@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 62bc6a40-d1d1-4864-991d-9b803c761a1a
X-Ovh-Tracer-Id: 15724036627872713720
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrvdehgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhhfelgeeukedtteffvdffueeiuefgkeekleehleetfedtgfetffefheeugeelheenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I had an offline discussion with someone who knew more history on this driver.
>> My understanding is that the linux-aspeed team is aware of this being deprecated
>> but that there was some missing support for interface training that nobody has
>> gotten around to write?  If that is the case this really isn't even a "simple"
>> port to a new API at this point.
> 
> Unless the controller needs some unique feature (I don't think it does
> on a quick glance), the conversion should not be too difficult. For any
> experienced developer, even if they are unfamiliar with the SPI MEM API,
> I don't think it should take more than 2-3 days to do the conversion.
> The code to program the registers would stay the same, all that needs to
> change is the API through which it is accessed.

Writing a spimem driver is not a problem, I think people have done
that in house. Aspeed has one for AST2600. We have one for u-boot
I wrote sometime ago. I even have one for Linux but training comes
with ugly hacks to fit in the current stack.

All Aspeed SoCs need training and that has been the problem for the
last 4 years or so because we can not do training without knowing
a minimum about the flash being trained :/ The previous framework
offered a way to do a first scan and tune the delay settings
afterwards. It worked pretty well on AST2400, AST2500 and AST2600
even if more complex.

One alternative was to include the setting in the DT but the flash
modules are not always soldered on the boards, at least on OpenPOWER
systems which have sockets for them. The board are large, the wires
long, the need is real, some chips freak out if not tuned correctly.

spimem needs an extension I think. Sorry I have not been able to
push that forward. Lack of time and other tasks to address on the
host side of the machine. This is really a software problem, we
have the HW procedures ready. If a spimem expert could get involved
to make a few proposals, I would be happy to help and do some testing.
QEMU models are good enough for the software part. We can do the
training validation on real HW when ready.

Thanks,

C.
