Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888A25A7A62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiHaJm5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Aug 2022 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHaJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:42:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F33979F0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:42:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKF3-0007XE-60; Wed, 31 Aug 2022 11:42:37 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKF1-0032Xk-Sl; Wed, 31 Aug 2022 11:42:35 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKF1-0004Nl-9s; Wed, 31 Aug 2022 11:42:35 +0200
Message-ID: <4ab6f79f54ad975d7c21c86c57fa2defbb8c98c0.camel@pengutronix.de>
Subject: Re: [PATCH v3 14/19] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Farber, Eliav" <farbere@amazon.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
Date:   Wed, 31 Aug 2022 11:42:35 +0200
In-Reply-To: <f49558fa-e987-145c-425e-0e8a7a9fba5f@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
         <20220830192212.28570-15-farbere@amazon.com>
         <89806ee9a80652d5877ef5c4a86574e82af48da4.camel@pengutronix.de>
         <f49558fa-e987-145c-425e-0e8a7a9fba5f@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2022-08-31 at 12:23 +0300, Farber, Eliav wrote:
> On 8/31/2022 11:23 AM, Philipp Zabel wrote:
> > On Di, 2022-08-30 at 19:22 +0000, Eliav Farber wrote:
> > > Add optional "moortec,ts-series" property to define the temperature
> > > equation and coefficients that shall be used to convert the digital
> > > output to value in milli-Celsius.
> > > Supported series: 5 (default) and 6.
> > 
> > Is this the difference between mr75xxx and mr76xxx series?
> > If so, should be a compatible "moortec,mr76006" instead?
> > If the temperature equation could be derived from the compatible, this
> > property would not be necessary.
> The PVT (Process, Voltage, Temperature) monitoring logic can be
> constructed from many different sub-blocks:
> *) CONTROLLER (mr75203) - controlling TS, PD and VM.
> *) TS (mr74137) - for measuring temperature in ring.
> *) PD (mr74139) - for measuring IO based transistors.
> *) VM (mr74138) - for measuring voltage rails across the SoC.
> *) Ring oscillators (mr76007/mr76008)
> *) Pre-scalers (mr76006)
>
> Besides mr75203 which is digital all other IPs are analog.
> There is a single mr75203 and there can be several or none of the other
> units.

Thank you for the explanation, I think this information would be nice
to have in a description in moortec,mr75203.yaml.

> The kernel driver is only for the controller (mr75203).
> The series 5 or 6 is relevant for the TS (mr74137) and not for the
> controller (mr75203).
> Each of the analog units can have a different series number (for example
> we use series 3 of the VM).
> 
> That is why I didn't change the compatible of mr75203, and instead added
> a TS-series parameter.

I see, I mistakenly assumed mr76006 referred to a new controller
version. This also invalidates my comment on patch 4.

regards
Philipp
