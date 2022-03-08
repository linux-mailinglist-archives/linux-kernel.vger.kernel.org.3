Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064EA4D13DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiCHJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiCHJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:52:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAD4198D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:51:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nRWVX-00065y-Ic; Tue, 08 Mar 2022 10:51:55 +0100
Message-ID: <2b4442d9-fb10-36ee-585d-4103b76abbbb@pengutronix.de>
Date:   Tue, 8 Mar 2022 10:51:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
 <Yh4304unzMxrQtoL@bogus>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <Yh4304unzMxrQtoL@bogus>
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

Hello Sudeep,

On 01.03.22 16:12, Sudeep Holla wrote:
> 
> Hi Ahmad,
> 
> On Mon, Feb 28, 2022 at 05:01:39PM +0100, Ahmad Fatoum wrote:
>> Hello Etienne,
>>
>> On 28.10.21 16:00, Etienne Carriere wrote:
>>> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
>>> based on an OP-TEE service invocation. The compatible mandates a
>>> channel ID defined with property "linaro,optee-channel-id".
>>
> 
> Not sure if Etienne's reply addressed your queries/concerns correctly.
> I thought I will add my view anyways.
> 
>> I just found this thread via the compatible in the STM32MP131 patch set:
>> https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/
>>
>> Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
>> else, so there is just the arm,psci* compatible.
>>
> 
> Correct, the interface to the kernel is fixed and hence we must be able
> to manage with the standard and fixed sole set of bindings for the same.
> 
>> What's different about SCMI that this is not possible? Why couldn't the
>> existing binding and driver be used to communicate with OP-TEE as secure
>> monitor as well?
>>
> 
> However with SCMI, the spec concentrates and standardises all the aspects
> of the protocol used for the communication while it allows the transport
> used for such a communication to be implementation specific. It does
> address some standard transports like mailbox and PCC(ACPI). However,
> because of the flexibility and also depending on the hardware(or VM),
> different transports have been added to the list. SMC/HVC was the one,
> followed by the virtio and OPTEE. While I agree SMC/HVC and OPTEE seem
> to have lot of common and may have avoided separate bindings.
> 
> However the FIDs for SMC/HVC is vendor defined(the spec doesn't cover this
> and hence we utilised/exploited DT). Some vendors wanted interrupt support
> too which got added. OPTEE eliminates the need for FID and can also provide
> dynamic shared memory info. In short, it does differ in a way that the driver
> needs to understand the difference and act differently with each of the
> unique transports defined in the binding.
> 
> Hope that explains and addresses your concern.

Thanks for the elaborate answer. I see now why it's beneficial to have
an OP-TEE transport in general. I don't yet see the benefit to use it
in the STM32MP13x instead of SMCs like with STM32MP15x, but that a discussion
that I need to have in the aforementioned thread.

Thanks again!
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
