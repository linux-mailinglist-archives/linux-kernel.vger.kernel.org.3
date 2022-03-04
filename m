Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2CE4CDCE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbiCDSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiCDSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:48:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D666C95C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 616E0B82676
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 18:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60810C340E9;
        Fri,  4 Mar 2022 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646419662;
        bh=zt5al4jTsRsU7Pa0Y8bCtBzVEsnEOIExqZXVkNxpRVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWXCd44EQsMMzDcozVVmkNO3raUzWvo/wfSUEYgb8RIQbDnuOIu49SjwzTebrxGct
         d6EvJqrZxiw0iekrbPCOqVwUORBnzznrX8IgncRqQ9ASjs/47RK1IwsMt8LwUGevls
         tYLJl6ETMyE+/rzIAn3GTDV/yn93OxZTTw52hIwo=
Date:   Fri, 4 Mar 2022 19:47:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Add sysfs support for physical location
 of a device
Message-ID: <YiJeyEznIbyfbniV@kroah.com>
References: <20220304182152.2038961-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304182152.2038961-1-wonchung@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 06:21:52PM +0000, Won Chung wrote:
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-physical_location
> @@ -0,0 +1,42 @@
> +What:		/sys/devices/.../physical_location
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		This directory contains information on physical location of
> +		the device connection point with respect to the system's
> +		housing.
> +
> +What:           /sys/devices/.../physical_location/panel
> +Date:           March 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:

Use tabs everywhere please, stop mixing spaces and tabs in the same file
:(

> +static ssize_t panel_show(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	const char *panel;
> +
> +	switch (dev->location.panel) {
> +	case DEVICE_PANEL_TOP:
> +		panel = "top";
> +		break;
> +	case DEVICE_PANEL_BOTTOM:
> +		panel = "bottom";
> +		break;
> +	case DEVICE_PANEL_LEFT:
> +		panel = "left";
> +		break;
> +	case DEVICE_PANEL_RIGHT:
> +		panel = "right";
> +		break;
> +	case DEVICE_PANEL_FRONT:
> +		panel = "front";
> +		break;
> +	case DEVICE_PANEL_BACK:
> +		panel = "back";
> +		break;
> +	default:
> +		panel = "unknown";
> +	}
> +	return sprintf(buf, "%s\n", panel);

Always use sysfs_emit() for new sysfs files.

thanks,

greg k-h
