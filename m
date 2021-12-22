Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC847CF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhLVJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhLVJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:41:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EEB6194B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5FCC36AE8;
        Wed, 22 Dec 2021 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640166096;
        bh=ll6r6iFiIjnDzOOMGdh3cRWmd3j5C6kuu3h5I41Vy5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kljr7CwXjMTDgWu3numUdUj33/4jHLsgDLTgvtTfzW2DZyP3TQaMtApKhfQb8Ta29
         a85IZZ6ZYoCfOWcaARnFtPou4ZgR6hKEY7i7v1IKf421lr+3to296XMrsFRSuLcedz
         yZiaIO+QoS4wSEhHzAdT892c1IUd8bMw18wb2dQ4=
Date:   Wed, 22 Dec 2021 10:41:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add comment to rx_lock mutex definition
Message-ID: <YcLyzSI6qeLhypzG@kroah.com>
References: <20211222093626.GA13332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222093626.GA13332@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:36:26PM +1300, Paulo Miguel Almeida wrote:
> Checkpatch reports: CHECK: struct mutex definition without comment.
> Fix this by documenting what rx_mutex struct is used for in pi433 driver.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 29bd37669059..aa0ecb3788c6 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -92,6 +92,7 @@ struct pi433_device {
>  	u32			rx_bytes_to_drop;
>  	u32			rx_bytes_dropped;
>  	unsigned int		rx_position;
> +	/* rx read and config operations can only be served one at the time */

What exactly does this mean?  What is this protecting?  This comment
doesn't seem to be explaining much :(

thanks,

greg k-h
