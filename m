Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECA49C7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbiAZKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:51:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52592 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiAZKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BB061835;
        Wed, 26 Jan 2022 10:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4684BC340E3;
        Wed, 26 Jan 2022 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643194272;
        bh=qKqDdH8fT1bUejTXj94PeLOWoPEeCNsRZYLJVmoIVZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1TA3Fcfce6HRDQ5yBJSd5XVUB4aTXjaBpL05mQUO84PsMzxgIF0C05gzHR+HFS6w
         fB+OyK/zU/SZpbAvAMjrpONvDyOm0mOhMw2f8MhoOUvmtpKNtb77kkrX8FaiZPdM2y
         uBNhCMqxmjkQOQ9z0pPVM2JxFH7LByxMDWXaObq4=
Date:   Wed, 26 Jan 2022 11:51:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
Message-ID: <YfEnnWuL1cC6airb@kroah.com>
References: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 06:08:56PM +0800, Neal Liu wrote:
> READ_TOC cmnd[2] specifies Format Field which is defined
> in SCSI-3 spec. Add command mask to avoid marking this
> sense data as invalid.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 46dd11dcb3a8..14d51695b8ae 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1944,7 +1944,7 @@ static int do_scsi_command(struct fsg_common *common)
>  		common->data_size_from_cmnd =
>  			get_unaligned_be16(&common->cmnd[7]);
>  		reply = check_command(common, 10, DATA_DIR_TO_HOST,
> -				      (7<<6) | (1<<1), 1,
> +				      (7<<6) | (1<<1) | (1<<2), 1,

Can we have real names here instead of magic numbers?

And what commit does this fix?  Is it a regression or has it always
never worked properly?

thanks,

greg k-h
