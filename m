Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7A4DAEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355285AbiCPLUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbiCPLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:20:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EE3388E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:18:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nURfz-0003xq-O8; Wed, 16 Mar 2022 12:18:47 +0100
Message-ID: <5ef2f1ae-f6b2-9905-801a-395c7269bd93@pengutronix.de>
Date:   Wed, 16 Mar 2022 12:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
 <Yh4304unzMxrQtoL@bogus>
 <2b4442d9-fb10-36ee-585d-4103b76abbbb@pengutronix.de>
 <CAN5uoS9eBfzezPZdjemBHbGRe4e50zm4=DDst-UCenN5ouQCoA@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAN5uoS9eBfzezPZdjemBHbGRe4e50zm4=DDst-UCenN5ouQCoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Etienne,

On 08.03.22 11:18, Etienne Carriere wrote:
> Hello Ahmad,
> 
> On Tue, 8 Mar 2022 at 10:51, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Hello Sudeep,
>>
>> On 01.03.22 16:12, Sudeep Holla wrote:
>>>
>>> Hi Ahmad,
>>>
>>> On Mon, Feb 28, 2022 at 05:01:39PM +0100, Ahmad Fatoum wrote:
>>>> Hello Etienne,
>>>>
>>>> On 28.10.21 16:00, Etienne Carriere wrote:
>>>>> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
>>>>> based on an OP-TEE service invocation. The compatible mandates a
>>>>> channel ID defined with property "linaro,optee-channel-id".
>>>>
>>>
>>> Not sure if Etienne's reply addressed your queries/concerns correctly.
>>> I thought I will add my view anyways.
>>>
>>>> I just found this thread via the compatible in the STM32MP131 patch set:
>>>> https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/
>>>>
>>>> Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
>>>> else, so there is just the arm,psci* compatible.
>>>>
>>>
>>> Correct, the interface to the kernel is fixed and hence we must be able
>>> to manage with the standard and fixed sole set of bindings for the same.
>>>
>>>> What's different about SCMI that this is not possible? Why couldn't the
>>>> existing binding and driver be used to communicate with OP-TEE as secure
>>>> monitor as well?
>>>>
>>>
>>> However with SCMI, the spec concentrates and standardises all the aspects
>>> of the protocol used for the communication while it allows the transport
>>> used for such a communication to be implementation specific. It does
>>> address some standard transports like mailbox and PCC(ACPI). However,
>>> because of the flexibility and also depending on the hardware(or VM),
>>> different transports have been added to the list. SMC/HVC was the one,
>>> followed by the virtio and OPTEE. While I agree SMC/HVC and OPTEE seem
>>> to have lot of common and may have avoided separate bindings.
>>>
>>> However the FIDs for SMC/HVC is vendor defined(the spec doesn't cover this
>>> and hence we utilised/exploited DT). Some vendors wanted interrupt support
>>> too which got added. OPTEE eliminates the need for FID and can also provide
>>> dynamic shared memory info. In short, it does differ in a way that the driver
>>> needs to understand the difference and act differently with each of the
>>> unique transports defined in the binding.
>>>
>>> Hope that explains and addresses your concern.
>>
>> Thanks for the elaborate answer. I see now why it's beneficial to have
>> an OP-TEE transport in general. I don't yet see the benefit to use it
>> in the STM32MP13x instead of SMCs like with STM32MP15x, but that a discussion
>> that I need to have in the aforementioned thread.
> 
> Some SCMI operations in OP-TEE need to execute in a threaded context
> (preemptible, ...).
> There is no SMC function ID defined for an SCMI thread entry in
> OP-TEE. We rather use standard invocation of a TEE service: opening a
> session and invoking commands.
> Invoked commands are executed in an OP-TEE native threaded context.
> The service accessed is referred to as the OP-TEE SCMI PTA.
> 
> As for STM32MP15x, one willing to extend resources assigned to secure
> world may also need to move mp15 SCMI from SMC transport to optee
> transport.

Yes. Makes sense.

Thanks again for explaining,
Ahmad

> 
> Regards,
> Etienne
> 
>>
>> Thanks again!
>> Ahmad
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
etienn

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
