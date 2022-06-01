Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC353A024
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiFAJPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiFAJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:15:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9722403DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:15:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C32B6D1;
        Wed,  1 Jun 2022 11:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654074942;
        bh=UjU1q9TfgLsD2gDqTRWjVsva+5u/3ygk3/IJVilsQA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtFZzgzfAZtcU9NHzndDP3NLtIX7FHh/DGIyWu5/zSirZa+AJ20oVn2Sewrc5b65b
         2XQqCbj005zgB5u0XNoXrGAmij8hSbTP7oY6qf7hSud9rLXuAy7RlrCJJOVLzxjCNi
         745kQ5Egt1XxJX1RVGVhCPVP3t7dEjRue07Hl8g8=
Date:   Wed, 1 Jun 2022 12:15:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, maxime@cerno.tech,
        sam@ravnborg.org, alsi@bang-olufsen.dk, jagan@amarulasolutions.com,
        biju.das.jz@bp.renesas.com, l.stach@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drm: bridge: adv7511: Add check for
 mipi_dsi_driver_register
Message-ID: <YpcuOfeil7ZpE2gH@pendragon.ideasonboard.com>
References: <20220601084501.2900380-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601084501.2900380-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 04:45:01PM +0800, Jiasheng Jiang wrote:
> On Wed, Jun 01, 2022 at 02:52:00PM +0800, Laurent Pinchart wrote:
> >>  static int __init adv7511_init(void)
> >>  {
> >> -	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
> >> -		mipi_dsi_driver_register(&adv7533_dsi_driver);
> >> +	int ret;
> >> +
> >> +	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
> >> +		ret = mipi_dsi_driver_register(&adv7533_dsi_driver);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >>  
> >>  	return i2c_add_driver(&adv7511_driver);
> > 
> > While at it, should this then call mipi_dsi_driver_unregister() on
> > failure ?
> 
> Well, as far as I am concerned, the adv7511_exit() in the same file has already dealt with the issue.
> Therefore, it might not be necessary to add another mipi_dsi_driver_unregister().

The issue is that adv7511_exit() is not called if adv7511_init() fails.

-- 
Regards,

Laurent Pinchart
