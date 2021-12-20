Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53747B0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhLTQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:02:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbhLTQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:02:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F41A3B80EED;
        Mon, 20 Dec 2021 16:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F2C36AE5;
        Mon, 20 Dec 2021 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640016117;
        bh=oTr5lmB/AOCPZAKEr55ybpKBNLtYmk8VqybebtzBBcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sh8wnWx5TxKoyvc4hsKs3SFRa71glpPiXxE+sthu3kFwNod+sWv3n/XuVqwsQGhEB
         2acS/62eC3zaFGfutLeTO49Cbe5RMCMguAqEUOlOVlp/T6jeWrai4wb9/zHpoNCMk9
         rHV7SVgDM32gb6q+LK9G4fcuz/+YNwJZr/y0isD0=
Date:   Mon, 20 Dec 2021 17:01:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     tim@cyberelk.net, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] paride: fix up build warning on mips platforms
Message-ID: <YcCo8+jTG3b+5GTA@kroah.com>
References: <20211130084626.3215987-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130084626.3215987-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:46:26AM +0100, Greg Kroah-Hartman wrote:
> MIPS include files define "PC" so when building the paride driver the
> following build warning shows up:
> 
> 	rivers/block/paride/bpck.c:32: warning: "PC" redefined
> 
> Fix this by undefining PC before redefining it as is done for other
> defines in this driver.
> 
> Cc: Tim Waugh <tim@cyberelk.net>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/block/paride/bpck.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
> index f5f63ca2889d..d880a9465e9b 100644
> --- a/drivers/block/paride/bpck.c
> +++ b/drivers/block/paride/bpck.c
> @@ -28,6 +28,7 @@
>  
>  #undef r2
>  #undef w2
> +#undef PC
>  
>  #define PC			pi->private
>  #define r2()			(PC=(in_p(2) & 0xff))
> -- 
> 2.34.1
> 

Given the lack of objections to this, I'll just take it through one of
my trees for 5.17-rc1.

thanks,

greg k-h
