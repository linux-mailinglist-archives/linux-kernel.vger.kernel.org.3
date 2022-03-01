Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7994C880F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiCAJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiCAJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4719ADEC;
        Tue,  1 Mar 2022 01:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646127234; x=1677663234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=048tbWG3NAZMNu9WZUi/GCpvqCa2ZO3Gyg1+Y/iqdfs=;
  b=AkjUEnRR3/dpseIbwAu0+GnatluPc2cSWR9Hste7EpQvkq3JNlR/dxRp
   FOfWDU1oen0qgU0tyrNewJzQN3XGFJwyzF36cFqHvX8m+d9wbaZ3pYM1H
   n7c99x2fEc9KdZQ9IHAC+yiV7ySdpAewHsjteIHhkI13Us+lWiPma8D4U
   ITwDUmP/bEiLvWFfF5DEyuD4drZ8XYm0V/uRPX0uYtSJBTIgITlNSB8ex
   JjP+aww5usYRwqOvEP8oZQB59diX8s+zWBN2LZ3UuUvFtaxCxXnDn/b17
   Q0rZk1hW7C2ERohDQ0AzHJ2iGfpcGNN91E0zkgFGpew3ThvEFQsVqfxOV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250679807"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="250679807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 01:33:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="685662305"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 01 Mar 2022 01:33:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 01 Mar 2022 11:33:50 +0200
Date:   Tue, 1 Mar 2022 11:33:50 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb:typec: Add sysfs support for Type C connector's
 physical location
Message-ID: <Yh3ofnlEx0bT/R6E@kuha.fi.intel.com>
References: <20220301022625.469446-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301022625.469446-1-wonchung@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

On Tue, Mar 01, 2022 at 02:26:25AM +0000, Won Chung wrote:
> When ACPI table includes _PLD field for a Type C connector, share _PLD
> values in its sysfs. _PLD stands for physical location of device.
> 
> Currently without connector's location information, when there are
> multiple Type C ports, it is hard to distinguish which connector
> corresponds to which physical port at which location. For example, when
> there are two Type C connectors, it is hard to find out which connector
> corresponds to the Type C port on the left panel versus the Type C port
> on the right panel. With location information provided, we can determine
> which specific device at which location is doing what.
> 
> _PLD output includes much more fields, but only generic fields are added
> and exposed to sysfs, so that non-ACPI devices can also support it in
> the future. The minimal generic fields needed for locating a port are
> the following.
> - panel
> - vertical_position
> - horizontal_position
> - dock
> - lid
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
> 
> Changes in v2:
> - Use string for location.
> - Clarify get_pld() with naming and return type.
> 
>  Documentation/ABI/testing/sysfs-class-typec |  35 ++++++
>  drivers/usb/typec/class.c                   | 113 ++++++++++++++++++++
>  drivers/usb/typec/class.h                   |   3 +
>  3 files changed, 151 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 75088ecad202..4497a5aeb063 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -141,6 +141,41 @@ Description:
>  		- "reverse": CC2 orientation
>  		- "unknown": Orientation cannot be determined.
>  
> +What:		/sys/class/typec/<port>/location/panel
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes which panel surface of the system’s housing the
> +		port resides on.
> +
> +What:		/sys/class/typec/<port>/location/vertical_position
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes vertical position of the port on the panel surface.
> +		Valid values: upper, center, lower
> +
> +What:		/sys/class/typec/<port>/location/horizontal_position
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes horizontal position of the port on the panel surface.
> +		Valid values: left, center, right
> +
> +What:		/sys/class/typec/<port>/location/dock
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Set as "yes" if the port resides in a docking station or a port
> +		replicator, otherwise set as "no".
> +
> +What:		/sys/class/typec/<port>/location/lid
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Set as "yes" if the port resides on the lid of laptop system,
> +		otherwise set as "no".
> +

I've probable lost track of the topic during my winter break, I'm
sorry about that, but why are you proposing now that this should be
made Type-C specific?
This information is not Type-C specific, so it definitely does not
belong here.

Br,

-- 
heikki
