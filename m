Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E392855CD06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiF0OC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiF0OCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911510FE9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2D5E60B07
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C8EC3411D;
        Mon, 27 Jun 2022 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338540;
        bh=HqnmPX+RaZcEbcpHB4WxJc5NFbPDlcVOD2QtlPCs1y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQdQRWz5BH7+IVRd9T80YU9QXYDjBVXCpHz8CZUniE8RIkpDlvFubjXjXTBBlBq8S
         QngpxqYpgopry8LqEE/m0GQ3q4xIMls8QMfKh7VlDb49Hhi37N2hAjPxH5w8MI752c
         ENxHHrPDgxjnR2aMdrHu1jyug1ZbqZ887IQoWoVQ=
Date:   Mon, 27 Jun 2022 16:02:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/14] mei: debugfs: add pxp mode to devstate in
 debugfs
Message-ID: <Yrm4aZa4y6nwJBva@kroah.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
 <20220619133721.523546-14-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619133721.523546-14-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:37:20PM +0300, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> CC: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

We can not take patches without any changelog text, you know this :(

> ---
>  drivers/misc/mei/debugfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
> index 1ce61e9e24fc..4074fec866a6 100644
> --- a/drivers/misc/mei/debugfs.c
> +++ b/drivers/misc/mei/debugfs.c
> @@ -86,6 +86,20 @@ static int mei_dbgfs_active_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_active);
>  
> +static const char *mei_dev_pxp_mode_str(enum mei_dev_pxp_mode state)
> +{
> +#define MEI_PXP_MODE(state) case MEI_DEV_PXP_##state: return #state
> +	switch (state) {
> +	MEI_PXP_MODE(DEFAULT);
> +	MEI_PXP_MODE(INIT);
> +	MEI_PXP_MODE(SETUP);
> +	MEI_PXP_MODE(READY);

Just spell out the case and return lines, don't create macros for no
good reason please.

thanks,

greg k-h
