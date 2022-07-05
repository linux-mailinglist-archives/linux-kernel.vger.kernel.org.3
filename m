Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C964C5678FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGEU5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiGEU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:54 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2D20185;
        Tue,  5 Jul 2022 13:56:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1FC652223E;
        Tue,  5 Jul 2022 22:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657054599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOzOlPYC9QLTNXDxfMuIfd898otegibqv7vNfNZw3/o=;
        b=rc7Gmt2LNhl29R0WDdNeU3ouKO9XQLLRRarWHieIfdyp59VeXbsMfav5TpVdm1jXrN6C4w
        t1ZhtU7xVJLBbcKrRvhUgEq6w0AWZkOzsG0RIS3r4UqfF152aETwEEtf4rc8gJbsFdpbsa
        456LPtl/dOWvUYw5OfTCbJP9bn5RWcE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jul 2022 22:56:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: udc: atmel: check rc of
 devm_gpiod_get_optional()
In-Reply-To: <CAGETcx9W3W1P2fHVBuLOJNYz1rOU6hm9fc0=JukhbxJM6gRB1w@mail.gmail.com>
References: <20220705131951.1388968-1-michael@walle.cc>
 <CAGETcx9W3W1P2fHVBuLOJNYz1rOU6hm9fc0=JukhbxJM6gRB1w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7673314425958a56a07899b300226554@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-05 20:53, schrieb Saravana Kannan:
> On Tue, Jul 5, 2022 at 6:19 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> devm_gpiod_get_optional() might still return an error code, esp.
>> EPROBE_DEFER. Return any errors.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c 
>> b/drivers/usb/gadget/udc/atmel_usba_udc.c
>> index ae2bfbac603e..48355e0cee76 100644
>> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
>> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
>> @@ -2165,6 +2165,8 @@ static struct usba_ep * atmel_udc_of_init(struct 
>> platform_device *pdev,
>> 
>>         udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, 
>> "atmel,vbus",
>>                                                 GPIOD_IN);
>> +       if (IS_ERR(udc->vbus_pin))
>> +               return ERR_CAST(udc->vbus_pin);
> 
> I'm confused. Is it really an optional resource if you treat a failure 
> to get it
> as a reason to fail a probe?

If the gpio isn't found NULL is returned.

-michael
