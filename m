Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF447CF98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhLVJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhLVJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:56:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2177C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:56:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4521CE1B41
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1217AC36AEA;
        Wed, 22 Dec 2021 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640166963;
        bh=90tu7+bkE6IYbofZ2964o98/gnlM2A9BjSYg3ev7U94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euQMCJZ83FeGrxXaGUUpSgYPwCEURQS4bL3yek5wEj/5j5c0zMmfNNv3aCUaN2aZz
         /YPGiAL4xNVMMIYWK/fOCOVfb4g4SV7H3A58B90J0+iwwi54GA0CxPfK2nMQn4USSe
         6cW2YWi6vvxKqr38AjipIX67Tsp5UDnjm/ajN963hZP3vDV9gOgyxo06Yftpe4ohxd
         apCUE36sNPVCF7ic6SnQfh/OxYtrJdfCQeeH6pld8BDbFABqf174EeiZKV+8aZRa5W
         m/xufp6f5tpIYpDHp7bx6vKQtzJqiw4kESBXeH56WO9fgZhJeUPMyqUFDEKsFOroLL
         Ru0emIBiHtQUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzyLi-0003HG-VB; Wed, 22 Dec 2021 10:55:55 +0100
Date:   Wed, 22 Dec 2021 10:55:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: document registration-failure
 requirement
Message-ID: <YcL2KpAFPOuWYlei@hovoldconsulting.com>
References: <20211222085229.11657-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222085229.11657-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:52:29AM +0100, Johan Hovold wrote:
> Add an explicit comment to document that the reference initialised by
> platform_device_register() needs to be released by a call to
> platform_device_put() also when registration fails (cf.
> device_register()).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 598acf93a360..38fdcbdba4a4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -762,6 +762,10 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>  /**
>   * platform_device_register - add a platform-level device
>   * @pdev: platform device we're adding
> + *
> + * NOTE: _Never_ directly free @pdev after calling this function, even if it
> + * returned an error! Always use platform_put_device() to give up the

This should have been platform_device_put().

Greg, I'll send a v2 for you to consider since this documents the
current behaviour even if you wanted to look into ways to change this.

> + * reference initialised in this function instead.
>   */
>  int platform_device_register(struct platform_device *pdev)
>  {

Johan
