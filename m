Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69BA48A9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiAKIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:39:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43742 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiAKIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:39:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6C01B81835;
        Tue, 11 Jan 2022 08:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A551DC36AE9;
        Tue, 11 Jan 2022 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641890357;
        bh=KjstXm3UHpeHJfoTkZoKATZzxW41gK7OpFVYXonL5iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCIy90jPlxSI99Xmyt2NHEbGN96tQGKdimqXEHyYyAM0DU0RYtOExwHzn6w0Wgsd1
         bKKf5xrgxSx397kVq/a6U4Nicr9T/IMxCdPTC+ARySBudcPWmpkCgUENr/K5nLXDAz
         8urQ+sjhw4RgRwjbuJL+UBH5pdm+hbc0T7bQlhlY=
Date:   Tue, 11 Jan 2022 09:39:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Check error number after calling
 ida_simple_get
Message-ID: <Yd1CMdAzIXaT/QBB@kroah.com>
References: <20220111071751.590487-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111071751.590487-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:17:51PM +0800, Jiasheng Jiang wrote:
> If allocation fails, the ida_simple_get() will return error number.

How can allocation fail?  Have you been able to trigger this?

> So altmode_id_get() may return error number.
> And then id will be used in altmode_id_remove, causing the BUG_ON().
> Or it will be assigned to alt->id.
> Therefore, it should be better to check it and return error if fails,
> like the ida_simple_get() in typec_register_port().
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/usb/typec/class.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index aeef453aa658..67b3670ede99 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -516,6 +516,9 @@ typec_register_altmode(struct device *parent,
>  	struct altmode *alt;
>  	int ret;
>  
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
>  	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
>  	if (!alt) {
>  		altmode_id_remove(parent, id);
> -- 
> 2.25.1
> 

How did you test that this change will work properly?

As I have said before, I'm not going to take changes from you unless you
can prove they have been tested, due to all of the previous problems in
your submitted patches.

greg k-h
