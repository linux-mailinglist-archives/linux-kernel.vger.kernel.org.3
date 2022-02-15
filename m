Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8724B68CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiBOKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:05:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiBOKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:05:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DC24F;
        Tue, 15 Feb 2022 02:04:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49D92315;
        Tue, 15 Feb 2022 11:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644919494;
        bh=KMRUUPC3zf0oe4gWL8qDF9DIC3uliWx9md2lcfBf1H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZ2+nH4c/zvYR8pmF4F74hNzJs6/HqrbnBa5xdTfnyW4VV1Hz1u5xXg+d+eNYXx7e
         jiZfMnkT0EDDGX/IhTrpOQbsh3a6H0zfjdbVKo71lUlWPQr+w5uQTGsjwKJyAziXI2
         cGrvYei0hJgWr69W9Ra3bUKEoi18Mwb6IBjX3CyI=
Date:   Tue, 15 Feb 2022 12:04:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 37/66] media: sun6i-csi: Move power management to
 runtime pm in capture
Message-ID: <Ygt6vwydxg9/WuDH@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
 <YgqftcDgfrsZfTdF@paasikivi.fi.intel.com>
 <Ygt4xh2Mq0qStyKs@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ygt4xh2Mq0qStyKs@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Feb 15, 2022 at 10:56:22AM +0100, Paul Kocialkowski wrote:
> On Mon 14 Feb 22, 20:30, Sakari Ailus wrote:
> > On Sat, Feb 05, 2022 at 07:54:00PM +0100, Paul Kocialkowski wrote:
> > > Let's just enable the module when we start using it (at stream on)
> > > and benefit from runtime pm instead of enabling it at first open.
> > > 
> > > Also reorder the call to v4l2_pipeline_pm_get.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> > Nice patch!
> 
> Thanks!
> 
> > Do you still need v4l2_pipeline_pm_put()? Removing it would be a separate
> > patch of course.
> 
> My understanding is that this is still useful if there are drivers in the
> pipeline that rely on s_power instead of rpm (a typical case could be an
> old sensor driver). So that's why this is kept around, but all other components
> of the pipeline (isp/csi/mipi csi-2) are using rpm now.

If that's not the case on your test platforms, I think it would be
better to drop support for this old API, and convert drivers that still
use .s_power() if someone needs to use one on an Allwinner platform.

-- 
Regards,

Laurent Pinchart
