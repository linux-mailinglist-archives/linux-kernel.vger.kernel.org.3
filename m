Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374F648462E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiADQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:48:00 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:34786 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiADQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:48:00 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 11:47:59 EST
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 5EFADC7F1A;
        Tue,  4 Jan 2022 16:39:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo01-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3SsEdDYT7Fnq; Tue,  4 Jan 2022 16:39:35 +0000 (UTC)
Received: from mail.gonehiking.org (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        by mailout.easymail.ca (Postfix) with ESMTPA id 13D47C7EDF;
        Tue,  4 Jan 2022 16:39:35 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 1AE7F3EF3C;
        Tue,  4 Jan 2022 09:39:33 -0700 (MST)
Message-ID: <a6a99a33-9124-bbc5-610b-a67d7af76c4a@gonehiking.org>
Date:   Tue, 4 Jan 2022 09:39:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 1/3] scsi: Provide for avoiding trailing allocation
 length with VPD inquiries
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nix <nix@esperi.org.uk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
 <alpine.DEB.2.21.2201020021000.56863@angie.orcam.me.uk>
 <20220103082338.GA28606@lst.de>
From:   Khalid Aziz and Shuah Khan <azizkhan@gonehiking.org>
In-Reply-To: <20220103082338.GA28606@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 01:23, Christoph Hellwig wrote:
> On Sun, Jan 02, 2022 at 11:23:45PM +0000, Maciej W. Rozycki wrote:
>> Allow SCSI hosts to request avoiding trailing allocation length with VPD
>> inquiries, and use the mechanism to work around an issue with at least
>> some BusLogic MultiMaster host bus adapters and observed with the BT-958
>> model specifically where issuing commands that return less data than
>> provided for causes fatal failures:
> Wouldn't it make more sesnse to hide this quirk insde of
> scsi_vpd_inquiry to also handle the scsi_get_vpd_buf case?  Something
> like:
>
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 211aace69c22c..194a51f772aaa 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -289,8 +289,8 @@ EXPORT_SYMBOL(scsi_track_queue_full);
>    *
>    * Returns size of the vpd page on success or a negative error number.
>    */
> -static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> -							u8 page, unsigned len)
> +static int __scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> +		u8 page, unsigned len)
>   {
>   	int result;
>   	unsigned char cmd[16];
> @@ -321,6 +321,20 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
>   	return get_unaligned_be16(&buffer[2]) + 4;
>   }
>   
> +static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
> +		u8 page, unsigned len)
> +{
> +	if (sdev->host->no_trailing_allocation_length) {
> +		int ret = __scsi_vpd_inquiry(sdev, buffer, page, min(4U, len));
> +
> +		if (ret < 4)
> +			return ret;
> +		len = min_t(unsigned int, ret, len);
> +	}
> +
> +	return __scsi_vpd_inquiry(sdev, buffer, page, len);
> +}
> +
>   /**
>    * scsi_get_vpd_page - Get Vital Product Data from a SCSI device
>    * @sdev: The device to ask

This is certainly better. It consolidates all the special cases for 
getting VPD pages in one location and ensures no cases are missed.

--
Khalid
