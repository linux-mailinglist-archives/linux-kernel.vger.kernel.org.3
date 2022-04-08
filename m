Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562954F8E20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiDHEsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiDHEsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1A29D5EA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D958B61E86
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34DFC385A3;
        Fri,  8 Apr 2022 04:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649393155;
        bh=7lE1WpCl6Wiqc1IF6o6ROkQcTmCYCmlk5yThG4LhwDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuJu3pzZADimLOrM+BO+8kpLs+0MgZud2+AAAxm7ReoOY5YQImOnFHlZMDQUN3VTl
         5S/CpvmtpY8Bq5VJ3+qrN9K5fUM37sNEfk5GNw2moXv9YUAZDpbaELsI6gm44hvUBp
         BBXj3VKudp/7WW+fhqXNJyA2V8iQV03XPQcr3Sgk=
Date:   Fri, 8 Apr 2022 06:45:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <Yk++AMDTu7LCbjHu@kroah.com>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> Use container_of() to get vif. This improves the code in two ways:
> [1] it speeds up the compilation because container_of() saves steps to
> retrieve vif (the representation of ieee80211_vif), and
> [2] it eliminates the need to define multiple pointers. Previously,
> after setting the pointer to drv_priv, another pointer had to be
> defined by vif in struct wfx_vif to point back to ieee80211_vif.
> Remove vif from the struct wfx_vif, define a macro wvif_to_vif(ptr)
> for container_of(), and replace all wvif->vif with the newly defined
> container_of() construct.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
> Note: 
> This is a revised patch to sequence the wfx.h file (with the new defines) to show up first on the diff, which makes the ordering of the diff more logical.
> 
> Questions:
> - These changes had built without errors for me but it would be great if someone can test it on the actual hardware.
> - We noticed that the development of the wfx driver is happening in the netdev tree instead of Greg's tree. Do you suggest that I use the net-next tree for this change? 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/drivers/staging/wfx
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/wfx
> 
> drivers/staging/wfx/wfx.h     |  3 ++-
>  drivers/staging/wfx/data_rx.c |  4 ++--
>  drivers/staging/wfx/data_tx.c |  2 +-
>  drivers/staging/wfx/key.c     |  3 +--
>  drivers/staging/wfx/queue.c   |  2 +-
>  drivers/staging/wfx/scan.c    |  6 ++---
>  drivers/staging/wfx/sta.c     | 45 ++++++++++++++++-------------------
>  7 files changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> index 6594cc647c2f..78f2a416fe4f 100644
> --- a/drivers/staging/wfx/wfx.h
> +++ b/drivers/staging/wfx/wfx.h
> @@ -25,6 +25,8 @@
>  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
>  #define USEC_PER_TU 1024
>  
> +#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))

Always use whitespace properly.

>  struct wfx_hwbus_ops;
>  
>  struct wfx_dev {
> @@ -61,7 +63,6 @@ struct wfx_dev {
>  
>  struct wfx_vif {
>  	struct wfx_dev             *wdev;
> -	struct ieee80211_vif       *vif;

You need to test this on real hardware.  For an outreachy-first-task,
this is not a good one at all.

Also this code is no longer in drivers/staging/  Please work on the
netdev mailing list as I can not take these changes anymore.

good luck!

greg k-h
