Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8969C5A5F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiH3JjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiH3Jii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:38:38 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE59E1915;
        Tue, 30 Aug 2022 02:36:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2E68922CF;
        Tue, 30 Aug 2022 11:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661852199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVoTxfXy8cDqrSIhz4HpBP22qZhpepvVK6F1WYi9tQc=;
        b=ekkB0CUy37+MNjEXna5X662xWN2c19XCvS+Tz/efZLb2PBH5oMPE0q0bSDqKrFodNksUau
        1PqOnYx7crQ2Ev8h1/LqM5nu5Aqy/M1w5PTT5wpwToKtqpnw15G1H9TYOP9aK+xM5fzGjp
        a5kcIEADlvSHDqggxoevpOyGZj7mSqT59K/UxFKyhWl+FFeZgPoGlO62swPVncIHDiCpPC
        2Wmy3Q9q741BAiOnAFq1D5/ESvShjcPcSc1Fnmx3kWmCHqeAHYoWTt4oZJcFPxIbcDt6d4
        7FsyIQ7dhGSisEuEl0fdBxZUzn/QKTzxMrZHd0gawVCsBz6c6NsZ9kbU5l91UQ==
MIME-Version: 1.0
Date:   Tue, 30 Aug 2022 11:36:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios property
In-Reply-To: <9a63271b-48c0-1b31-c450-5abc9eedbced@linaro.org>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-2-sai.krishna.potthuri@amd.com>
 <9a63271b-48c0-1b31-c450-5abc9eedbced@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6619ebc290f12fbb7613f32087aa9200@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-08-30 11:21, schrieb Krzysztof Kozlowski:
> On 29/08/2022 12:05, Sai Krishna Potthuri wrote:
>> SPI-NOR flashes have RESET pin which can be toggled using GPIO
>> controller, for those platforms reset-gpios property can be used to
>> reset the flash device.
>> 
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> ---
>>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml 
>> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> index 7149784a36ac..d2fc8e9c787f 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> @@ -70,6 +70,12 @@ properties:
>>        be used on such systems, to denote the absence of a reliable 
>> reset
>>        mechanism.
>> 
>> +  reset-gpios:
>> +    description:
>> +      contains a GPIO specifier.
> 
> Skip this part - obvious.
> 
>> The reset GPIO is asserted and then deasserted
>> +      to perform device reset. If "broken-flash-reset" is present 
>> then having
>> +      this property does not make any difference.
> 
> Isn't then broken-flash-reset conflicting with this one (e.g.
> disallowing it)?

Sometimes the spi-nor driver needs to switch modes, which are persistent
until you either switch em back or do a hardware reset (or software
reset IIRC) of the flash. If broken-flash-reset is set, we try hard
to leave the flash in the mode which it is normally in after reset or
don't switch modes at all.
Of course we cannot make sure, our shutdown gets called in each case,
thus there is may be warning during startup.

So, even if you have a reset-gpio it might be broken I guess. Think
of it being high active, but someone forgot the pull-up. So, if you
do an unexpected reset, the flash chip might not be reset
automatically. So yes, I think, even if there is a dedicated reset
gpio, it could still be messed up. How likely is it? I don't know,
probably not very.

-michael
