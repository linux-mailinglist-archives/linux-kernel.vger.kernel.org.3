Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6751A1F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351172AbiEDORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351123AbiEDORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:17:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399C42490
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:14:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nmFlZ-0001VG-Ix; Wed, 04 May 2022 16:14:09 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nmFlU-0006LT-3Q; Wed, 04 May 2022 16:14:04 +0200
Date:   Wed, 4 May 2022 16:14:04 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad
 driver
Message-ID: <20220504141404.onom7x5lycyg3b22@pengutronix.de>
References: <20220504105254.1576-2-Gireesh.Hiremath@in.bosch.com>
 <20220504134817.1490-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504134817.1490-1-Gireesh.Hiremath@in.bosch.com>
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

On 22-05-04, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> The existing matric_keypad.c use different gpio line for row and colunm,
> where in mt_matrix_kepad.c use same gpio line for row as well as column.
> a key can be placed at each intersection of a unique row number 
> not equal to a unique column and they are diagonally symmetric.
> Advantage of this is with existed gpio line we can get more keys
>   
> example: in matrix_keypad.c for 5 gpio line possible matrix is 2X3 or 3X2
> and maximum possible keys are 6 but 
> in mt_matrix_kepad.c for same 5 gpio line possible matrix is 5X5 and maximum
> possible buttons are 10, below table will discribe that

Nobody should stop you to increase the amount of max. possible keys, so
this isn't a real block.

> 	------------------------------------------------------
> 	|Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
> 	------------------------------------------------------
> 	| GPIO 0 |  X    | KEY_9  | KEY_2  | KEY_3  | KEY_1  |
> 	------------------------------------------------------
> 	| GPIO 1 | KEY_9 |  X     | KEY_6  | KEY_5  |  KEY_0 |
> 	------------------------------------------------------
> 	| GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
> 	------------------------------------------------------
> 	| GPIO 3 | KEY_3 | KEY_5  | KEY_4  |  X     | KEY_8  |
> 	------------------------------------------------------
> 	| GPIO 4 | KEY_1 |  KEY_0 | KEY_7  | KEY_8  |  X     |
> 	------------------------------------------------------
> 	X - invalid key
> 	KEY_x - preferred key code

That should be pointed somewhere very clearly, thanks for the
description. Also what is than the benefit of the original matrix_keypad
driver?

> both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
> my openion is not to merge both.

IMHO from the user/system-integrator pov it is looking the same and so
one driver should be fine. To distinguish between both modes we could
add dt-property or add a new dt-compatible like "gpio-matrix-keypad-v2".

Regards,
  Marco
