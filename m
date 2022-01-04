Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D722D4846E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiADRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:20:50 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38514 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiADRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:20:47 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3231692009C; Tue,  4 Jan 2022 18:20:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 22C8492009B;
        Tue,  4 Jan 2022 17:20:46 +0000 (GMT)
Date:   Tue, 4 Jan 2022 17:20:46 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christoph Hellwig <hch@lst.de>
cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nix <nix@esperi.org.uk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] scsi: Provide for avoiding trailing allocation
 length with VPD inquiries
In-Reply-To: <20220103082338.GA28606@lst.de>
Message-ID: <alpine.DEB.2.21.2201041707270.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020021000.56863@angie.orcam.me.uk> <20220103082338.GA28606@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022, Christoph Hellwig wrote:

> > Allow SCSI hosts to request avoiding trailing allocation length with VPD 
> > inquiries, and use the mechanism to work around an issue with at least 
> > some BusLogic MultiMaster host bus adapters and observed with the BT-958 
> > model specifically where issuing commands that return less data than 
> > provided for causes fatal failures:
> 
> Wouldn't it make more sesnse to hide this quirk insde of
> scsi_vpd_inquiry to also handle the scsi_get_vpd_buf case?  Something
> like:

 I guess so, except that...

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 211aace69c22c..194a51f772aaa 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -289,8 +289,8 @@ EXPORT_SYMBOL(scsi_track_queue_full);
>   *
>   * Returns size of the vpd page on success or a negative error number.
>   */
> -static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> -							u8 page, unsigned len)
> +static int __scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> +		u8 page, unsigned len)
>  {
>  	int result;
>  	unsigned char cmd[16];
> @@ -321,6 +321,20 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
>  	return get_unaligned_be16(&buffer[2]) + 4;
>  }
>  
> +static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> +		u8 page, unsigned len)
> +{
> +	if (sdev->host->no_trailing_allocation_length) {
> +		int ret = __scsi_vpd_inquiry(sdev, buffer, page, min(4U, len));
> +
> +		if (ret < 4)
> +			return ret;

... I think this needs to be:

		if (ret <= 4)
			return ret;

because we don't need to repeat the call where (len == 4).

 Somehow I missed your reply in the flood of messages yesterday, sorry 
about that, and it's only Khalid's response that made me notice it, so 
I'll update and retest the change now, and then repost it as a new series 
along with Martin's proposal updated according to my earlier observations.

 Thank you and Khalid for your input!  I'm glad we're making progress now.

  Maciej
