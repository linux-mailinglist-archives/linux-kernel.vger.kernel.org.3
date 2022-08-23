Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521859D02C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiHWEpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiHWEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A350734
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50014B81ADD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA305C433C1;
        Tue, 23 Aug 2022 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661229838;
        bh=Dp7gbWMfCc+Qey6kWzIzvpYLCRNtpnuNWSiTmmgZOe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qX+ktb0oTz/9ehojKauRgUdXEBIgE3/IN9ol2UQKc3l+SmBX4zuemEAiO4b7RxjBp
         S0OxTer40WTlx6NRpN3ZdfI+CpglS/RnGdfA3W1t0pgFkjlSsvhj1uIMYIQEFFCykR
         1nciKNd86u0r1x69LeELIhRgGvwoAOAn7WdliOrPm7/uMUHaKP7M9xcOg7zazqDpOI
         uPuzghDjHsgzwfXSTc5voG+4R9otE6LQvKY2hkYaZi+8gGs6M0XbaGwSGLh/AJELa/
         cwrBWpJSBJgoWd1x/lZMkHwmXABl5IDG1nZRKrufq7sgFGeb5NE034hHDrEALMuK94
         hN5kYbbZQWD1Q==
Date:   Tue, 23 Aug 2022 04:43:54 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_typec: Use Type-C driver
 data
Message-ID: <YwRbCvOy8WXUEphH@google.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-5-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:08:05PM +0000, Prashant Malani wrote:
> Altmode driver callbacks need EC-specific port information to
> communicate with the ChromeOS EC. To accomplish this, save a
> pointer to the driver-specific port struct in the Type-C port's
> driver data field.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 7daf4207c11e..e3f75440030d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -379,6 +379,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  		ret = cros_typec_parse_port_props(cap, fwnode, dev);
>  		if (ret < 0)
>  			goto unregister_ports;
> +		cap->driver_data = cros_port;

Same as previous patch.  I would suggest to send it in later series.  For
example, I have no knowledge to judge if `cap` is a correct place to save
the driver data.

For example, I'm wondering: is the `cap` "the Type-C port's driver"?
