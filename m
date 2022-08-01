Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F6586579
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiHAHDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHAHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:02:56 -0400
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0CAB2D1E6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:02:48 -0700 (PDT)
Received: from [172.16.17.104] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IPRloMNQvrvmbIPRtoYyHu; Mon, 01 Aug 2022 09:02:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1659337366; bh=Wd/dk6WgwcmYzulpakk3XkYo7pS/C66SXLh+hBK2Upo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=P8fjloOPovjZHcGGAREz7aJJBgemF4OjOiq+Dd62vehhCOG2qE40ZT9DdQ2fSz28C
         +mGS7kiRZZQI5zGeAqXJGMMrSM1ZZLhCwKDMoqIREvMk0c/xOlGAC4mka8EwBvpM7s
         x+fkypjzF09KgyEx7SLxPBfSSfrCJPQNstl94G4+jF9VTrYi4ha/4+L0Q4KKVzN8Nq
         h6jMBo2bEqZk31AElk7GVHoRqzNjq++P24+3K74JYEFUXyPPVxM1JNLnJRAKUL+pw6
         mv8uxSLpOpcAUYye2BB1xgtsJdLP7LZOSJ0bdmJf5ueXG2mIOyVcl4yDSmFP+/bxg3
         +QQXB2jiuNlmA==
Message-ID: <0bcf5494-3366-0dd3-8927-b2f109b574e7@brickedbrain.com>
Date:   Mon, 1 Aug 2022 09:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] ads7846: don't report pressure for ads7845
Content-Language: en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
 <20220721083458.6412-2-luca.ellero@brickedbrain.com>
 <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
 <YuPlwMP+W1zGKG1D@smile.fi.intel.com>
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <YuPlwMP+W1zGKG1D@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK474JnZGDb27zNg7UfOAQKZEtHBs23cG1k1W4lCSVppncN8Y9i9vcaVXUy0Lb3WvOiebDuN/c+C0VBWRBDsr65mXfCj3OQH5Mx6ad9wXmhqNStgcESK
 NXtgHvNzu3no02+9rDwTN368aIcJikXJl3BQlXaYFG8SNVLjKYxEzfCNEvWFqJPn0/LtwO7KBsdVYxpWvlNtyZ07WUAn6Mm+V2IH28KZK8b5JJGO1Gxxes4h
 bftaOWBaxpZOOH26j4VzcUuKpN9OrjA5gBFKr65H2Gzs1ShPPljM+DZiIzZtyVEu21gdyCGxTnOmAbdnHZknRpEU0Ey0e8iYZ6FZaptR1uCIom6cV5k8SOjL
 c5rWoCaNH60UNg4J/XxPv547aP00CdEEtG7SKtcdzTP3XV+eVZCktWQgXjO6BpncDSGerpDJyuZFbW1F8evdf0hvD8R0e0/Gz4N+NCd1ViaI5xP3qAj0qt73
 XJ/X69sWH6KEykQljLZU6dHzQE4+zVTHgCYPfNius3qrxk/02iHaXwY6DIMnBFQWpW4R2gzOqOMShAOjSpY1NFEcB7RdoKGfuE1B3ISkh2emB2o1poYnAmTu
 /7M=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 15:50, Andy Shevchenko wrote:
> On Thu, Jul 21, 2022 at 10:48:35PM +0200, Uwe Kleine-König wrote:
>> On Thu, Jul 21, 2022 at 10:34:56AM +0200, Luca Ellero wrote:
>>> From: Luca Ellero <l.ellero@asem.it>
>>>
>>> ADS7845 doesn't support pressure.
>>> This patch avoids the following error reported by libinput-list-devices:
>>> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
>>>
>>> Signed-off-by: Luca Ellero <l.ellero@asem.it>
>>
>> I don't know how picky Dmitry is, but some maintainers would ask you to
>> either add a Signed-off-by with the email address you sent this patch
>> from, or make sure to send it from the asem.it address.
> 
> It's fine to be sent from different email of the same person.
> But like you said, some maintainers are really picky and that
> may block contribution (I have been seen a case, where actually
> allowing to do as above unblocks contribution since person can't
> re-sent properly the change from another address by some reasons).
> 
> 
Hi Andy,
thank you for your reply.
Ok, I will resend from the proper email.
Regards
Luca


-- 
Luca Ellero

E-mail: luca.ellero@brickedbrain.com
Internet: www.brickedbrain.com

