Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F04FF512
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiDMKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiDMKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:50:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164D58823;
        Wed, 13 Apr 2022 03:48:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DAm2wA021355;
        Wed, 13 Apr 2022 05:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649846882;
        bh=O+86ub9Rq04Lr287UmBX3aEvJAug5Lag0f/aY757xB0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=yF/m8g9Geh0XYqYAtaSSjFLMfZ9zL+2AAuc/UbSnnzDdLFX4sNOrnfnl/V4YMiIpm
         eYCsMBKbcU1m8TVeSt2W+HDkDmf1o8MnEAhXCbTMZxFzz37/CusGic9Q7DE7rVZRKy
         sGHpW0nqSPQ2TZKW3tGNCTVxx7vzvLN+Z2iq69EU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DAm2jm101447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 05:48:02 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 05:48:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 05:48:01 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DAlvJS128379;
        Wed, 13 Apr 2022 05:47:58 -0500
Message-ID: <09dde54e-de77-4f53-b674-8253069c6b05@ti.com>
Date:   Wed, 13 Apr 2022 16:17:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] usb: typec: tipd: Add support for polling interrupts
 status when interrupt line is not connected
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220412145059.4717-1-a-govindraju@ti.com>
 <YlaZIual4Fa/a81I@kuha.fi.intel.com>
 <5672af5d-d4a9-08ab-0594-7da57cd0972b@ti.com>
 <Ylan/MzWWTeE8hDh@kuha.fi.intel.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <Ylan/MzWWTeE8hDh@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 13/04/22 16:07, Heikki Krogerus wrote:
> On Wed, Apr 13, 2022 at 03:32:50PM +0530, Aswath Govindraju wrote:
>> Hi Heikki,
>>
>> On 13/04/22 15:04, Heikki Krogerus wrote:
>>> Hi Aswath,
>>>
>>> On Tue, Apr 12, 2022 at 08:20:58PM +0530, Aswath Govindraju wrote:
>>>> In some cases the interrupt line from the pd controller may not be
>>>> connected. In these cases, poll the status of various events.
>>>
>>> Well, if the alert/interrupt line is not connected anywhere, then
>>> polling is the only way to go. I'm fine with that, but the driver
>>> really should be told that there is no interrupt. Using polling
>>> whenever request_threaded_irq() returns -EINVAL is wrong. We really
>>> should not even attempt to request the interrupt if there is no
>>> interrupt for the device.
>>>
>>> Isn't there any way you can get that information from DT? Or how is
>>> the device enumerated in your case?
>>>
>>
>> Would checking if (client->irq) field is populated, to decide between
>> polling and interrupts be a good approach?
>>
>> I am sorry but I did not understand what you meant by device getting
>> enumerated. The device is on an I2C bus and gets enumerated based on the
>> I2C address provided. The device does not have I2C_IRQ line connected,
>> in my case.
> 
> "I2C devices are not enumerated at hardware level":
> https://www.kernel.org/doc/html/latest/i2c/instantiating-devices.html
> 
> So your PD controller I2C slave device has to be either described in
> Devicetree or ACPI tables, or there is a board file or platform driver
> that actually populates the device for it.
> 
> Can you tell a little bit about the platform you are running? Is it
> ARM, x86, or what, and is it ACPI or DT platform?
> 

Got it. Currently I am testing on a ARM platform and the I2C device tree
nodes are populated in the device tree. This is how the PD controller
gets enumerated.


> thanks,
> 


-- 
Thanks,
Aswath
