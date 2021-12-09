Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2834346EAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhLIPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:13:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58144 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhLIPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:13:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11EE6B82503;
        Thu,  9 Dec 2021 15:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F4DC341D3;
        Thu,  9 Dec 2021 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639062605;
        bh=U6ztHGouKLYBRw/akAYNLv9KsMRJgPYo7HpUyAVcfAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUnO/E+WkuhTnHbF9769He2y5u8eG2YnwHlCTUMWN+ofequY3YwApFr8+GS23LklD
         LQR4BgdzPkdg/FAhbxZUQBZC6RAAmGby2E+E3wk8gQpkn0/JQce+te4xF9eUdUC6U7
         w8MgldlL8xFs8h6ieeWGm/IMCxJKb+8lHIO9y6U8=
Date:   Thu, 9 Dec 2021 16:10:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: if T_LENGTH is zero, dma direction should be
 DMA_NONE
Message-ID: <YbIcS+07ix53hIoY@kroah.com>
References: <1639062020-5621-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639062020-5621-1-git-send-email-george.kennedy@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:00:20AM -0500, George Kennedy wrote:
> Avoid data corruption by rejecting pass-through commands where
> T_LENGTH is zero (No data is transferred) and the dma direction
> is not DMA_NONE.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/ata/libata-scsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 1b84d55..d428392 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  
> +	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
> +	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
> +		fp = 2 + cdb_offset;
> +		goto invalid_fld;
> +	}
> +
>  	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
>  		tf->protocol = ATA_PROT_NCQ_NODATA;
>  
> -- 
> 1.8.3.1
> 

Odd, why send this to me?

Also, you should look at:
	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to send patches to automatically get included in stable
releases, which is what I think you want here.

thanks,

greg k-h
