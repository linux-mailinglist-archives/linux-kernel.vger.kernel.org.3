Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700824A5A08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiBAKaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiBAKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:30:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE25C061714;
        Tue,  1 Feb 2022 02:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58848614B0;
        Tue,  1 Feb 2022 10:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D86C340EB;
        Tue,  1 Feb 2022 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643711394;
        bh=DO/5tto/KvRThhB0CnZdPqXUn59sr1UuCm6ArhhNsTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixMSL+V+zo9kSzBuZPGUCXcz2dhn2Z0YFFm+AO9nzGhNWFHp/AdJukECx9y91/Nxc
         qWaJAN2QjmorKA9qdZWJ/V733Qs1isW1kUvxT4q1acH6L/Hmin8h0eJbsaRBS9CrUR
         ulfo87sI9e/jlEqDXFG0mpLobrKkPAXPgs/Fvk5o=
Date:   Tue, 1 Feb 2022 11:29:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: typec: Support the WUSB3801 port controller
Message-ID: <YfkLn4UTjAea22wL@kroah.com>
References: <20220201032440.5196-1-samuel@sholland.org>
 <20220201032440.5196-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201032440.5196-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:24:40PM -0600, Samuel Holland wrote:
> +static enum typec_role wusb3801_get_default_role(struct wusb3801 *wusb3801)
> +{
> +	switch (wusb3801->port_type) {
> +	case TYPEC_PORT_SRC:
> +		return TYPEC_SOURCE;
> +	case TYPEC_PORT_SNK:
> +		return TYPEC_SINK;
> +	case TYPEC_PORT_DRP:
> +	default:
> +		if (wusb3801->cap.prefer_role == TYPEC_SOURCE)
> +			return TYPEC_SOURCE;
> +		return TYPEC_SINK;
> +	}
> +}
> +
> +static int wusb3801_map_port_type(enum typec_port_type type)
> +{
> +	switch (type) {
> +	case TYPEC_PORT_SRC:
> +		return WUSB3801_CTRL0_ROLE_SRC;
> +	case TYPEC_PORT_SNK:
> +		return WUSB3801_CTRL0_ROLE_SNK;
> +	case TYPEC_PORT_DRP:
> +	default:
> +		return WUSB3801_CTRL0_ROLE_DRP;
> +	}
> +}
> +
> +static int wusb3801_map_pwr_opmode(enum typec_pwr_opmode mode)
> +{
> +	switch (mode) {
> +	case TYPEC_PWR_MODE_USB:
> +	default:
> +		return WUSB3801_CTRL0_CURRENT_DEFAULT;
> +	case TYPEC_PWR_MODE_1_5A:
> +		return WUSB3801_CTRL0_CURRENT_1_5A;
> +	case TYPEC_PWR_MODE_3_0A:
> +		return WUSB3801_CTRL0_CURRENT_3_0A;
> +	}
> +}
> +
> +static unsigned int wusb3801_map_try_role(int role)
> +{
> +	switch (role) {
> +	case TYPEC_NO_PREFERRED_ROLE:
> +	default:
> +		return WUSB3801_CTRL0_TRY_NONE;
> +	case TYPEC_SINK:
> +		return WUSB3801_CTRL0_TRY_SNK;
> +	case TYPEC_SOURCE:
> +		return WUSB3801_CTRL0_TRY_SRC;
> +	}
> +}
> +
> +static enum typec_orientation wusb3801_unmap_orientation(unsigned int status)
> +{
> +	switch (status & WUSB3801_STAT_ORIENTATION) {
> +	case WUSB3801_STAT_ORIENTATION_NONE:
> +	case WUSB3801_STAT_ORIENTATION_BOTH:
> +		return TYPEC_ORIENTATION_NONE;
> +	case WUSB3801_STAT_ORIENTATION_CC1:
> +		return TYPEC_ORIENTATION_NORMAL;
> +	case WUSB3801_STAT_ORIENTATION_CC2:
> +		return TYPEC_ORIENTATION_REVERSE;
> +	}
> +
> +	unreachable();

Some of these functions use use unreachable() and others you do not.
Pick one style and stick with it please.

thanks,

greg k-h
