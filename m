Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF049D165
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiAZSFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiAZSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:05:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88439C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:05:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27CF461BBE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F20EC340E3;
        Wed, 26 Jan 2022 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643220334;
        bh=4mOTV3T/OhqNoQq9ppaU5uGUyXH2XX18wSlRzpX73pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ot/Fc1GoZLezYx/ro5TJdySOQTjQc5ONJkSxMbJ6HIxMKaEFfwvhbZYo1QWrw0Fpj
         L3qQxSqVm3JHWEvEOyoM0DvVo82YzBsMFoG9449Lerv81JGO3cLiEbDndfrzcWt3qL
         xmpUkqz6RnUm6DcuvNq4Fu5i/nqWZwG6M/4uoYvg=
Date:   Wed, 26 Jan 2022 19:05:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mei: add support for graphics system controller
 (gsc) devices
Message-ID: <YfGNbK6n3Ag/ORFJ@kroah.com>
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
 <20220119155807.222657-3-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119155807.222657-3-alexander.usyskin@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:58:04PM +0200, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> GSC is a graphics system controller, based on CSE, it provides
> a chassis controller for graphics discrete cards, as well as it
> supports media protection on selected devices.
> 
> mei_gsc binds to a auxiliary devices exposed by Intel discrete
> driver i915.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/Kconfig  |  14 +++
>  drivers/misc/mei/Makefile |   3 +
>  drivers/misc/mei/gsc-me.c | 192 ++++++++++++++++++++++++++++++++++++++
>  drivers/misc/mei/hw-me.c  |  27 +++++-
>  drivers/misc/mei/hw-me.h  |   2 +
>  5 files changed, 236 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/misc/mei/gsc-me.c
> 
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index 0e0bcd0da852..ec119bb98251 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -46,6 +46,20 @@ config INTEL_MEI_TXE
>  	  Supported SoCs:
>  	  Intel Bay Trail
>  
> +config INTEL_MEI_GSC
> +	tristate "Intel MEI GSC embedded device"
> +	select INTEL_MEI
> +	select INTEL_MEI_ME

Please don't select, why not just depend on?

thanks,

greg k-h
