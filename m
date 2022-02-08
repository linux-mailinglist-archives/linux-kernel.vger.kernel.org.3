Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8F4AD3BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351072AbiBHImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351136AbiBHIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:41:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA78C03FEE4;
        Tue,  8 Feb 2022 00:41:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1239B81768;
        Tue,  8 Feb 2022 08:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E1C36AE2;
        Tue,  8 Feb 2022 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644309672;
        bh=M8ERU97tC1sqMQK1hLMFw4H14YME72E2tRW5DA1T+6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuUdA3yOSwnQj4/J1heh68JzckJNk0VYO2vOfuhsFXhpGT0CivGYrpzP0ZiNWUnum
         IcRKP8R1A0DdxiiC9ZtZnEWdz+PTpoyo6YXsazPp3wcIQKcRpTaj98zLS0GLSLlpaa
         FfIk3ruX6xpCpcZT66NPMttMssLH32I5P3jYhSPI=
Date:   Tue, 8 Feb 2022 09:41:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH 1/2] usb: typec: tcpm: add interface for passing
 supported_pd_rev from tcpc_dev
Message-ID: <YgIspfW4hdPBA15m@kroah.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208082026.4855-2-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208082026.4855-2-potin.lai@quantatw.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:20:25PM +0800, Potin Lai wrote:
> Current TCPM allways assume using PD_MAX_REV for negotiation,
> but for some USB controller only support PD 2.0, adding an interface
> for passing supported_pd_rev from tcpc_dev.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++--
>  include/linux/usb/tcpm.h      |  4 ++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 59d4fa2443f2..31770fa8643d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -571,6 +571,16 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
>  				    port->cc2 == TYPEC_CC_OPEN)));
>  }
>  
> +static u32 tcpm_pd_supported_rev(struct tcpm_port *port)
> +{
> +	u32 rev = PD_MAX_REV;
> +
> +	if (port->tcpc->supported_pd_rev)
> +		rev = port->tcpc->supported_pd_rev(port->tcpc);
> +
> +	return (rev > PD_MAX_REV) ? PD_MAX_REV : rev;

Please spell this out in a real if statement to make it obvious:
	if (rev > PD_MAX_REV)
		return PD_MAX_REV
	return rev

Or better yet:
	return min(PD_MAX_REV, rev);

right?

thanks,

greg k-h
