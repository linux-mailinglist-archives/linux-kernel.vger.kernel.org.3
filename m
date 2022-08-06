Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2658B744
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiHFRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHFRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:21:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F7642C;
        Sat,  6 Aug 2022 10:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCACAB8077B;
        Sat,  6 Aug 2022 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21097C433D6;
        Sat,  6 Aug 2022 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659806485;
        bh=xCBMuqsZV7iPHwJALXb/Dt7nFrNqloBL28h2XN5yuAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K6OisMtIuqpniraC55aPNLVoVLc4BYz2XdoQ2jnIEDAsk1DVbShma8vPN1Wz4L6A5
         1QgaqUdGpnrlVhFbPt5cm9uMpz0zLHygBJsEvBvyh8y02k7KFA4YDYFtWU0R0tVNJY
         tw3SMDQ31SEMmNbuD/HaV/O6d0KJYVUA+xC7tjCeiPAhoJeVkYvd5/9be/gWRB0wRb
         HVpD2aHHj7MlQdpsXv/v/q2AhEPyDpVvjd2D5tuxRcPdUSoVm+olAto6HMeWg46jVN
         WZOPJx6OlklC8Ywij6mT8Fmg356Wly5z5KCrYTzQMxHYmWLxquTDZiVXeeQe6DFs7E
         QqN7vpK/gICYg==
Date:   Sat, 6 Aug 2022 18:31:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: accel: use
 spi-peripheral-props.yaml
Message-ID: <20220806183132.77b383cd@jic23-huawei>
In-Reply-To: <89ea12c2-d4ef-490d-ff28-27b636adb05f@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
        <20220727164646.387541-3-krzysztof.kozlowski@linaro.org>
        <20220731164943.320babe4@jic23-huawei>
        <20220803212926.GA2639296-robh@kernel.org>
        <89ea12c2-d4ef-490d-ff28-27b636adb05f@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 09:27:37 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 03/08/2022 23:29, Rob Herring wrote:
> >>> I wonder if spi-3wire is device specific (not controller) and should be
> >>> rather explicitly mentioned by device schema. Just like spi-cpol/cpha.  
> >>
> >> I think it is, but Mark is expert on this.  
> > 
> > I would say yes as it's the device with a single data line.  
> 
> I will move it to device schema, just like cpol/cpha, and send a v3.
> After the merge window.
Works for me. I'll wait for v3 then.



> 
> >   
> >> In general I'm waiting on Mark's opinion on the whole idea!  
> > 
> > The prerequisite changes (except for spi-3-wire) are already queued up 
> > by Mark as are changes for other subsystems.  

Ah. Got it.

Thanks for driving this through.

Jonathan
> 
> 
> Best regards,
> Krzysztof

