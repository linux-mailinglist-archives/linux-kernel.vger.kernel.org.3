Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270DC53E0E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiFFFs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFFFs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9852CCB7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2A460F95
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E3C341CA;
        Mon,  6 Jun 2022 05:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494532;
        bh=Dvz2wGZ0SUD3hGXKJv7F+hdhAS0fs0Hbg/vlNnnbu04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+z3WMkQml0kACZBfXKVHiwEluGjiPMXHHkh1Xsjlju7rllZb+S/QgR2iofAO3pkk
         FZ8Pw6HwSSXZsb0Y5vzhy27dNt8fR2BWo4+mMVsZat2i3t2QNjsk5uDCxyu2vzsvL0
         mCf/j5jWCzNrqIRGwJ3k3c8HnXP9ta2KQycdobsU=
Date:   Mon, 6 Jun 2022 07:48:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/4] staging: r8188eu: add error handling of rtw_read16
Message-ID: <Yp2VQU9G1xVw9lHE@kroah.com>
References: <cover.1652994483.git.paskripkin@gmail.com>
 <fd10125ab8f4a64572742ec01d3202af2a79b1d0.1652994483.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd10125ab8f4a64572742ec01d3202af2a79b1d0.1652994483.git.paskripkin@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:09:55AM +0300, Pavel Skripkin wrote:
> rtw_read16() reads data from device via USB API which may fail. In case
> of any failure previous code returned stack data to callers, which is
> wrong.
> 
> Fix it by changing rtw_read16() prototype and prevent caller from
> touching random stack data
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes since v1:
> 	- Fixed style issue
> 
> ---
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 21 ++++++++++++---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  8 ++++--
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 27 ++++++++++++++++---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 13 ++++++---
>  drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  9 ++++---
>  drivers/staging/r8188eu/os_dep/os_intfs.c     |  6 ++++-
>  7 files changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index e67ecbd1ba79..6662ebc30f7b 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -249,11 +249,14 @@ static void efuse_read_phymap_from_txpktbuf(
>  		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
>  
>  		if (i == 0) {
> +			u16 reg;
> +
>  			/* Although lenc is only used in a debug statement,
>  			 * do not remove it as the rtw_read16() call consumes
>  			 * 2 bytes from the EEPROM source.
>  			 */
> -			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
> +			res = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &reg);
> +			(void)res;

Same here, that line isn't ok.

thanks,

greg k-h
