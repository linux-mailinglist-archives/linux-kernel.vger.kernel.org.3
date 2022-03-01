Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C04C8EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiCAPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCAPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:13:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AE48BC2E;
        Tue,  1 Mar 2022 07:12:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAA6F1042;
        Tue,  1 Mar 2022 07:12:22 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A55A3F70D;
        Tue,  1 Mar 2022 07:12:21 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:12:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Message-ID: <Yh4304unzMxrQtoL@bogus>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ahmad,

On Mon, Feb 28, 2022 at 05:01:39PM +0100, Ahmad Fatoum wrote:
> Hello Etienne,
> 
> On 28.10.21 16:00, Etienne Carriere wrote:
> > Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> > based on an OP-TEE service invocation. The compatible mandates a
> > channel ID defined with property "linaro,optee-channel-id".
>

Not sure if Etienne's reply addressed your queries/concerns correctly.
I thought I will add my view anyways.

> I just found this thread via the compatible in the STM32MP131 patch set:
> https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/
> 
> Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
> else, so there is just the arm,psci* compatible.
>

Correct, the interface to the kernel is fixed and hence we must be able
to manage with the standard and fixed sole set of bindings for the same.

> What's different about SCMI that this is not possible? Why couldn't the
> existing binding and driver be used to communicate with OP-TEE as secure
> monitor as well?
>

However with SCMI, the spec concentrates and standardises all the aspects
of the protocol used for the communication while it allows the transport
used for such a communication to be implementation specific. It does
address some standard transports like mailbox and PCC(ACPI). However,
because of the flexibility and also depending on the hardware(or VM),
different transports have been added to the list. SMC/HVC was the one,
followed by the virtio and OPTEE. While I agree SMC/HVC and OPTEE seem
to have lot of common and may have avoided separate bindings.

However the FIDs for SMC/HVC is vendor defined(the spec doesn't cover this
and hence we utilised/exploited DT). Some vendors wanted interrupt support
too which got added. OPTEE eliminates the need for FID and can also provide
dynamic shared memory info. In short, it does differ in a way that the driver
needs to understand the difference and act differently with each of the
unique transports defined in the binding.

Hope that explains and addresses your concern.

-- 
Regards,
Sudeep
