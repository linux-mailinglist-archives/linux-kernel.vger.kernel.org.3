Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3159F34B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiHXF7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiHXF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:59:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162B91D03;
        Tue, 23 Aug 2022 22:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44A46B820E2;
        Wed, 24 Aug 2022 05:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9076DC433C1;
        Wed, 24 Aug 2022 05:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661320752;
        bh=3UOExyhBJWI58bskqf1OVcbIGVqWq4fcBmpW9lG1Mak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQxP137GqYPwNImbfxYo9yNEHQajXByUoomLUNG16UIh8Z7rsTj4dsZapeoRppTcG
         0F0OSEN9GbBVKBWy0ynS+XCnso4raEZaEI0rM4qdEqyrCMleA3hUZszdQmcMf3z87x
         5NztAL0vdHLx7rdA2dUSqcl+GiindfaT9alqhTtU=
Date:   Wed, 24 Aug 2022 07:59:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@intel.corp-partner.google.com>
Cc:     heikki.krogerus@linux.intel.com, rajat.khandelwal@intel.com,
        shawn.c.lee@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enter safe mode only when pins need to be reconfigured
Message-ID: <YwW+LI345ind56ks@kroah.com>
References: <20220823170949.2066916-1-rajat.khandelwal@intel.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823170949.2066916-1-rajat.khandelwal@intel.corp-partner.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 10:39:49PM +0530, Rajat Khandelwal wrote:
> From: Lee Shawn C <shawn.c.lee@intel.com>
> 
> There is no point to enter safe mode during DP/TBT configuration
> if the DP/TBT was already configured in mux. This is because safe
> mode is only applicable when there is a need to reconfigure the
> pins in order to avoid damage within/to port partner.
> 
> 1. if HPD interrupt arrives and DP mode was already configured,
> safe mode is entered again which is not desired.
> 2. in chrome systems, IOM/mux is already configured before OS
> comes up. Thus, when driver is probed, it blindly enters safe
> mode due to PD negotiations but only after gfx driver lowers
> dp_phy_ownership, will the IOM complete safe mode and send
> ack to PMC.
> Since, that never happens, we see IPC timeout.
> 
> Hence, allow safe mode only when pin reconfiguration is not
> required, which makes sense.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>

First off, don't use invalid "corp-partner.google.com" email addresses,
you know that's not going to work and just bounce everywhere and there's
no proof that this has any relationship to your intel address :(

And your signed-off-by chain is incorrect.

And most importantly, you did not follow the required Intel rules for
how to submit kernel patches.  Please go work with your internal groups
to learn what is needed and how to do this properly.  Until then, I'm
not allowed to take your changes at all, sorry.

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index d238913e996a..4bf84466d1ff 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -432,6 +432,25 @@ static int pmc_usb_connect(struct pmc_usb_port *port, enum usb_role role)
>  	return pmc_usb_command(port, msg, sizeof(msg));
>  }
>  
> +static bool
> +pmc_usb_mux_allow_to_enter_safe_mode(struct pmc_usb_port *port,
> +				      struct typec_mux_state *state)
> +{
> +	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, DP) ||
> +	     IOM_PORT_ACTIVITY_IS(port->iom_status, DP_MFD)) &&
> +	     state->alt &&
> +	     state->alt->svid == USB_TYPEC_DP_SID)
> +		return false;
> +
> +	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
> +	     IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB)) &&
> +	     state->alt &&
> +	     state->alt->svid == USB_TYPEC_TBT_SID)
> +		return false;
> +
> +	return true;

Return normal 0/-ERROR for functions like this, don't mess with bool for
a return value, that's just confusing to everyone involved.

thanks,

greg k-h
