Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB714F08F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356890AbiDCLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356871AbiDCLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D552ED5F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1A961040
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D554C340F0;
        Sun,  3 Apr 2022 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648984523;
        bh=3/02qgq2W7WAA66zUjzaoQPC8uVWNkOWSOwDoAZAqrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nR+DcjPcTcqp4jM+ilIGIBd8OCvEI6wEJrPE6xe+rYMnM7GuSYTJ2jfwWsOuZd4cJ
         DoJm52NHXPJxq+Lxx6CvGHIH1ykLG2EuRoN+/SDUiRipKNHIv5gpf2IydXEDL8DHFE
         nbffh8vv3ZlT2ABGSPZbyYhWGm+hSI9wgVHBfNog=
Date:   Sun, 3 Apr 2022 13:15:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix unsafe memory access by memcmp.
Message-ID: <YkmBxD4H+tUgiuVg@kroah.com>
References: <Ykdcv6Sm3oDE9IEp@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykdcv6Sm3oDE9IEp@sckzor-linux.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 04:12:47PM -0400, Charlie Sands wrote:
> This patch fixes sparse warnings about the memcmp function unsafely
> accessing userspace memory without first copying it to kernel space.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 7df213856d66..1cfac1b27eb7 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -3233,23 +3233,27 @@ static int rtw_p2p_get(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> +	char wrqu_data_ptr[9];
> +	if (copy_from_user(wrqu_data_ptr, wrqu->data.pointer, 9))
> +		return 0;

Please do not add checkpatch issues when trying to fix up other issues
:(

And that's a very odd variable name you are creating.  That is not a
pointer at all, and either way, it should not be part of a variable
name, this isn't Windows code :)

thanks,

greg k-h
