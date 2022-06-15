Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1054C37E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbiFOI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbiFOI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:29:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9733E10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:29:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1OOf-0006I8-Ry; Wed, 15 Jun 2022 10:29:05 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1OOY-0005jK-G6; Wed, 15 Jun 2022 10:28:58 +0200
Date:   Wed, 15 Jun 2022 10:28:58 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [v2,2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad
 driver
Message-ID: <20220615082858.vmdhzhkwsv6kdnak@pengutronix.de>
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
 <20220613080638.1339-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613080638.1339-1-Gireesh.Hiremath@in.bosch.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
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

Hi,

sry. for jumping in again.

On 22-06-13, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Hi Krzysztof,
> 
> >You wrote pretty long message explaining how the device works, but I
> >still do not see the answer to questions - why it cannot be part of
> >matrix keypad?
> 
> Following are the difference between matrix keypad and Bosch keypad
> make us to add another keypad driver.
> 
> matrix keypad:
> 	- By hardware schematic, a column GPIO line will intersect only
> 	  with row GPIO lines, not with the other column GPIO lines
> 	- so, row and column GPIO property are fixed, because of this
> 	- key scanning work based on interrupt mode
> 	- and key press is determined based on setting column as output,
> 	  row GPIO as input and set interrupt to monitor the changes in state,
> 	  serve the key pressed in ISR
> 
> Bosch keypad:
>     - By hardware schematic column GPIO line can intersect with row GPIO line
> 	  as well as other column GPIO lines
> 	- so, all GPIO act as row as well as column, because of this
> 	- key scanning based on polling mode
> 	- a key pressed is determined by setting one of GPIO line as output and
> 	  other as input and poll for change in the state of input GPIO lines.
> 	  Setting one of a GPIO line as output and remaining GPIO lines as input is on
> 	  round robin bases.

Thanks again for listing this here but please get our point, that this
seems like just another 'mode' for the matrix keypad driver which can be
selected by the system integrator.

> >"It looks like this driver has smaller number of features than
> >matrix-keypad, so it should be integrated into the matrix-keypad.
> >matrix-keypad features are superset to this one."
> >
> >"But anyway this should be just merged into matrix-keypad. It's a
> >simpler set of that binding."
> 
> This keypad driver specific to Bosch measuring tool or similar devices.

Once it lands in mainline, it can be used by everyone.

> Please let me know to send latest patch which resolves build warning
> and gpiod API support.

I would really appreciate if you could integrate your work into matrix
keypad driver.

Regards,
  Marco
