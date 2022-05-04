Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC651AF43
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiEDUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiEDUhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:37:37 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DA50056;
        Wed,  4 May 2022 13:34:00 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1ADC8368;
        Wed,  4 May 2022 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651696440;
        bh=trlMOjtWkd7XqnXMGA5JjHGfbv9dxG2pazytgCE5Oyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0zHKO3IbCmer9BBIXCEN4j9MtcU9+XmJxldO8xQsIHcjzm+a5ivHI9AxXP20vIdS
         rc/0bpjTK09s+bB/uQNOlSHmlsi+kXyJEAiubmp1vGAFxnRDeUydTbFdvwm7FBfbAx
         5fpVKKWMYfCQftq0qIUkl93GM5ql0mCDBt3G2Nvo=
Date:   Wed, 4 May 2022 13:33:58 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/6] dt-bindings: regulator: Add reg-external-output
 binding
Message-ID: <YnLjNn9WVhvd4izZ@hatter.bewilderbeest.net>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
 <20220504065252.6955-2-zev@bewilderbeest.net>
 <YnJ32bG4IkSrRtHV@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YnJ32bG4IkSrRtHV@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:55:53AM PDT, Mark Brown wrote:
>On Tue, May 03, 2022 at 11:52:48PM -0700, Zev Weiss wrote:
>> This describes an external output supplied by a regulator, such as a
>> power outlet on a power distribution unit (PDU).
>
>OK, so this is that represnetation of the connection - which raises the
>question about why the regulator needs a property?
>
>> +description: |
>> +  This describes an external output supplied by a regulator, such as
>> +  a power outlet on a power distribution unit (PDU).
>> +
>> +properties:
>> +  compatible:
>> +    const: reg-external-output
>> +
>> +  vout-supply:
>> +    description:
>> +      Phandle of the regulator supplying the output, which should have
>> +      the regulator-external-output property.
>> +
>> +required:
>
>I think at a minimum anything like this would need some sort of
>representation of how the output physically appears so that people can
>work out how outputs are mapped to the hardware they see.

I don't quite understand what you're describing here -- could you 
elaborate on what you mean by "how the output physically appears", and 
what that might look like in a DT binding?

>However we
>already have a subsystem for external connectors - extcon.  Perhaps this
>should be a regulator client in the extcon API?  It's common for
>connectors to include some sort of power provision so it seems like this
>would fit right in.

Interesting -- I wasn't previously aware of the extcon subsystem, thanks 
for the pointer.  However, after looking at it a bit, I'm not sure I see 
how it'd be applicable here, since it looks like it's built to handle 
hardware that's at least sophisticated enough for software to tell 
whether or not something's plugged in, which isn't the case here.  The 
connector is just a ground pin and +12VDC pin, no presence-detection 
mechanism or anything else.  Outside of the regulator itself there's 
really no "device" there for software to talk to or otherwise interact 
with at all.


Thanks,
Zev

