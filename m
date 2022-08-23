Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC91759E795
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiHWQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245045AbiHWQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:37:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E04D7CF1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:45:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQV99-0004jZ-Jk; Tue, 23 Aug 2022 16:44:51 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQV98-0007MY-Tu; Tue, 23 Aug 2022 16:44:50 +0200
Date:   Tue, 23 Aug 2022 16:44:50 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <20220823144450.ctjmby53prjw5qis@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
 <20220822075426.qjgxue7sjehazga4@pengutronix.de>
 <YwNJ8RpSR+oVxnS/@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwNJ8RpSR+oVxnS/@paasikivi.fi.intel.com>
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

Hi Sakari,

On 22-08-22, Sakari Ailus wrote:
> On Mon, Aug 22, 2022 at 09:54:26AM +0200, Marco Felsch wrote:
> > Hi Sakari,
> > 
> > On 22-08-22, Sakari Ailus wrote:
> > > Hi Marco,
> > > 
> > > On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > > > Currently the driver turn off the power after probe and toggle it during
> > > > .stream by using the .s_power callback. This is problematic since other
> > > > callbacks like .set_fmt accessing the hardware as well which will fail.
> > > > So in the end the default format is the only supported format.
> > > 
> > > It'd be much better to add runtime PM support to the driver instead.
> > 
> > I got your point, but didn't have the time for it right now, I will drop
> > the patch from my v2.
> 
> The API is different but generally involves doing more or less the same
> what this and the 4th patch do together.

I know :) as soon as I got feedback on my TC35 series [1] I give it a
try and change it to dev-pm.

[1] https://lore.kernel.org/linux-media/20220818143307.967150-1-m.felsch@pengutronix.de/T/#t

Regards,
  Marco


> 
> -- 
> Sakari Ailus
> 
