Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82224D1498
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbiCHKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbiCHKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:19:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09021E17
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:18:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt27so38197414ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJRzJEaEiciL+Nan42l5Fbs3eLckPdHReRoJIMrSaeM=;
        b=cSn0n/IpRFUfcdpnyJ8hYV0UqfK2rGdYVl3t+GDWwQoB2iG5FHHYhb9yJb/CK9KXUj
         LG14tTWxRXl+gZP98W1BiHviVmCj1tr1Mv7yyLJ0WxGu6IoJ7R0sfB8rdzoljmM73tXZ
         +UvXfohmxeRu6Bjvk0kr74K+G1MKkaWK02+l55kiZ1kP/gDUeqxdbAxmuSq8CU5fkccx
         iQotqdnw+NvUjKg+DLOOM2INPtac0GCTcnPqDGbizhyyWJizk0cop3bVDV3ruXMm8Gxo
         r5547ZH+sr2133o1B8WiMpETiemGPyixP/qshju3Qws9dcSBcvvAZRpEOiZt3Ie3DoZf
         v85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJRzJEaEiciL+Nan42l5Fbs3eLckPdHReRoJIMrSaeM=;
        b=sns0u9zXgoy2PWkqlZGAr4m7I9QLE22dqwfZLqfWJiyqEQR89AWNl6K1cMvtYKJJv2
         PWRvrhO3cMWgOaWU42ntKe9o0TR0JT1ctHYsISrHhZ+FW0YvQn4P/DOLEbPHM+qjNse/
         zqxlLd8DOgEHeiOUtza8oHXc7NyRTXS4tgFHAvRDqr3D12js4/Ep/7XyCmk1FmSMNirt
         QZG1/qo9x0Vgu7wRTovLZQQzSVQC4r2Y673wHJbVv01uf8Z72ZueMBo829iRERBnXXEZ
         wrpCM3mQ8tDyuRMQYdXWJ5tJsFHkqreBNNjWe557SLMhS+vIUpFrnejAXGC72yNZfR5I
         Tk4w==
X-Gm-Message-State: AOAM5319XWi2ygCRrwvyp6e2UrEeNawPEQdR4kNVEzcL26yc04sX5eCx
        NYcV2mGNZCoQReaqxQlmWB0yRGIoFhw3AQcL8gduiw==
X-Google-Smtp-Source: ABdhPJx3EQL/icr/MX5fhItL/ji0+anuY7+ku8SlMkyxeZTkF8Vvr8t6wm0oIlFkujJGnmsMLrRgwxyHfsxeS4dg4PQ=
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id
 bw22-20020a170906c1d600b006d6e0a3bbc7mr12548180ejb.484.1646734707884; Tue, 08
 Mar 2022 02:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de> <Yh4304unzMxrQtoL@bogus>
 <2b4442d9-fb10-36ee-585d-4103b76abbbb@pengutronix.de>
In-Reply-To: <2b4442d9-fb10-36ee-585d-4103b76abbbb@pengutronix.de>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 8 Mar 2022 11:18:16 +0100
Message-ID: <CAN5uoS9eBfzezPZdjemBHbGRe4e50zm4=DDst-UCenN5ouQCoA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmad,

On Tue, 8 Mar 2022 at 10:51, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Sudeep,
>
> On 01.03.22 16:12, Sudeep Holla wrote:
> >
> > Hi Ahmad,
> >
> > On Mon, Feb 28, 2022 at 05:01:39PM +0100, Ahmad Fatoum wrote:
> >> Hello Etienne,
> >>
> >> On 28.10.21 16:00, Etienne Carriere wrote:
> >>> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> >>> based on an OP-TEE service invocation. The compatible mandates a
> >>> channel ID defined with property "linaro,optee-channel-id".
> >>
> >
> > Not sure if Etienne's reply addressed your queries/concerns correctly.
> > I thought I will add my view anyways.
> >
> >> I just found this thread via the compatible in the STM32MP131 patch set:
> >> https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/
> >>
> >> Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
> >> else, so there is just the arm,psci* compatible.
> >>
> >
> > Correct, the interface to the kernel is fixed and hence we must be able
> > to manage with the standard and fixed sole set of bindings for the same.
> >
> >> What's different about SCMI that this is not possible? Why couldn't the
> >> existing binding and driver be used to communicate with OP-TEE as secure
> >> monitor as well?
> >>
> >
> > However with SCMI, the spec concentrates and standardises all the aspects
> > of the protocol used for the communication while it allows the transport
> > used for such a communication to be implementation specific. It does
> > address some standard transports like mailbox and PCC(ACPI). However,
> > because of the flexibility and also depending on the hardware(or VM),
> > different transports have been added to the list. SMC/HVC was the one,
> > followed by the virtio and OPTEE. While I agree SMC/HVC and OPTEE seem
> > to have lot of common and may have avoided separate bindings.
> >
> > However the FIDs for SMC/HVC is vendor defined(the spec doesn't cover this
> > and hence we utilised/exploited DT). Some vendors wanted interrupt support
> > too which got added. OPTEE eliminates the need for FID and can also provide
> > dynamic shared memory info. In short, it does differ in a way that the driver
> > needs to understand the difference and act differently with each of the
> > unique transports defined in the binding.
> >
> > Hope that explains and addresses your concern.
>
> Thanks for the elaborate answer. I see now why it's beneficial to have
> an OP-TEE transport in general. I don't yet see the benefit to use it
> in the STM32MP13x instead of SMCs like with STM32MP15x, but that a discussion
> that I need to have in the aforementioned thread.

Some SCMI operations in OP-TEE need to execute in a threaded context
(preemptible, ...).
There is no SMC function ID defined for an SCMI thread entry in
OP-TEE. We rather use standard invocation of a TEE service: opening a
session and invoking commands.
Invoked commands are executed in an OP-TEE native threaded context.
The service accessed is referred to as the OP-TEE SCMI PTA.

As for STM32MP15x, one willing to extend resources assigned to secure
world may also need to move mp15 SCMI from SMC transport to optee
transport.

Regards,
Etienne

>
> Thanks again!
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
