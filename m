Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE0509CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387807AbiDUJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380705AbiDUJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:47:20 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2F25593;
        Thu, 21 Apr 2022 02:44:30 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5588F2222E;
        Thu, 21 Apr 2022 11:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650534268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K01P/G+CWauK4toU/LzXTmQWdHHNJGWFolPPvXFB4f8=;
        b=YJYZ8QLxWmTaBccIVDc7P7vwdCKrddAJuGkjwLtP8zppuvfIzApujj8b9VklHCIz31mP/C
        uy2D00edLX1hDmIAs6v2xHCTb0E5LGq9xcrbhX3Y5MY+mHCQq9mSrv2zv0xQm9Txxos+3o
        Ys3W1c38UAzP9S+ryQ1usgPt8IsBWPs=
From:   Michael Walle <michael@walle.cc>
To:     krzysztof.kozlowski@linaro.org
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jerry.huang@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
Date:   Thu, 21 Apr 2022 11:44:21 +0200
Message-Id: <20220421094421.288672-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 11:11, Jerry Huang wrote:
>> Please also answer Michael's comments.
>> 
>> [Jerry Huang] I double checked the MikroBus devices, we used two MikcroBus devices:
>> BLE P click: https://www.mikroe.com/ble-p-click
>> BEE click: https://www.mikroe.com/bee-click 
>> Both of them are SPI interface connect to ls1028ardb through MiKcroBus interface.
>> So the name "semtech sx1301" is not correct for this node.
>
> I asked to remove the words "Devicetree bindings" and this was not finished.
> 
> Now you mention that entire name of device is wrong... It's confusing. I
> don't know what device you are describing here. I expect you know. :)
> 
> What is this binding about exactly?

I *think* it's just exposing the mikrobus connector as an spidev device.
There was a former attempt by Vladimir here [1]. Now as it the nature
of such a connector that you can connect a myriad of devices there, it
doesn't really make sense to have a just particular one described. What
happens if that one will switch from spidev to a real driver in the
kernel? So using "spidev" for the compatible would be the first reflex.
But as described in the spidev driver this is plain wrong (and also causes
a warning/info message it) because it should describe the actual hardware.

Thus I proposed to use DT overlays which are loaded according to what
is actually attached to the header, so a real driver could be loaded.

But there *could* be a sane default which then could be replaced in
an DT overlay. Like "mirkobus-socket" or similar, which might expose
spidev. Actually it is more than just SPI, there is GPIO and resets and
I2C. Maybe it should be an MFD? I don't know. But that is something for
the DT maintainers to decide if they'll allow such "generic" devices.

-michael

[1] https://lore.kernel.org/linux-devicetree/20200318001603.9650-13-olteanv@gmail.com/
