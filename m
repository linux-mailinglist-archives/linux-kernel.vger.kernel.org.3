Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED6E49CF15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiAZQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:00:48 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34087 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235066AbiAZQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:00:46 -0500
Received: (qmail 141403 invoked by uid 1000); 26 Jan 2022 11:00:44 -0500
Date:   Wed, 26 Jan 2022 11:00:44 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
Message-ID: <YfFwLDLX5D4dYLTb@rowland.harvard.edu>
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
>  				      "READ TOC");
>  		if (reply == 0)
>  			reply = do_read_toc(common, bh);

You've been anticipated:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-testing&id=89ada0fe669a7abf8777b793b874202a0767a24f

Alan Stern
