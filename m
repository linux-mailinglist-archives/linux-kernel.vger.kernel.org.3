Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE450A3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389973AbiDUPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384968AbiDUPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:19:33 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CB36E1D;
        Thu, 21 Apr 2022 08:16:42 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AEC7E221D4;
        Thu, 21 Apr 2022 17:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650554200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odKtWziO2WG/lqEMmbPEUMEcrAn1teMSt8jVk5MPZY8=;
        b=EJS8v/SJvQW/cid+n5Ivz1rgMJEjaoOyH1ZMDe0L+cfpbecS+YBXTqL64X660RmcRNXU0f
        +Ycsy0L/nyTddJT1877XYmyZsJVQpamG4p9go5FuyKtAqYcN/zzOvX7Y1jNXtiU1S1ukux
        2XDZj2k5b2Ml5wrYzYi3COTdPJyLMh0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 17:16:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, jerry.huang@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, shawnguo@kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
In-Reply-To: <YmFo+EntwxIsco/t@robh.at.kernel.org>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
 <YmFo+EntwxIsco/t@robh.at.kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <30f2f62406bab8225cc88013b414016d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-21 16:23, schrieb Rob Herring:

> What's needed here is a connector node (and driver) for the mikrobus
> socket. The connector node's purpose is to decouple the host DT from
> add-on board overlay DT. Something like this:

Funny I had a similar idea to have a connector with all the
properties, but I failed to see how that would be of any help.

Do you mind an example of such an overlay? Judging by the spi
and i2c subnode, I guess it will amend the connector node and
fill in it's devices?

And all the child device properties will reference the connector,
correct?

> connector {
> 	// And a more specific compatible if pins can have alt funcs?
> 	// Spec version needed?
> 	compatible = "mikrobus-socket";
> 
> 	// Will need regulators defined if child devices expect
> 	// regulators
> 	vcc-33-supply = <&reg33>;
> 	vcc-5-supply = <&reg5v>;
> 
> 	i2c-parent = <&i2c1>; // Already a defined property
> 	spi-parent = <&spi0>; // New

uart/serial needed too?

> 
> 	// RST pin
> 	reset-gpios = <&gpio 4 0>;
> 
> 	// remap 'INT' (index 0) to host interrupt
> 	#interrupt-cells = <2>;
> 	#address-cells = <0>;
> 	interrupt-map = <0 0 &gpio 3 0>;
> 
> 	spi {

For example:

my-device@0 {
   reg = <0>;  // really needed? there is only one SPI CS line
   compatible = "my-device";
   reset-gpios = // may be left unset if it's optional, but what
                 // what if it is a required property and in hardware
                 // its connected to the RST pin of the module?
   other-gpios = <&connector 2>;
   vdd-supply = // what comes here? <&connector VCC_33>?
   interrupts-extended = <&connector 0 ..>;
}

-michael

> 		//devices
> 	};
> 
> 	i2c {
> 
> 	};
> };
> 
> The DT spec defines 'foo-map' properties extending interrupt-map.
> Currently only GPIO is defined. We might want to do the same thing for
> PWM. Or we make the connector node both a PWM consumer and provider.
> 
> Rob
