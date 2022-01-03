Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C8482DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiACEQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:16:18 -0500
Received: from mp-relay-01.fibernetics.ca ([208.85.217.136]:57256 "EHLO
        mp-relay-01.fibernetics.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbiACEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:16:17 -0500
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jan 2022 23:16:17 EST
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 893A0E132F;
        Mon,  3 Jan 2022 04:09:27 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id 7F05929FBB;
        Mon,  3 Jan 2022 04:09:27 +0000 (UTC)
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id AbydJ1UqSbbB; Mon,  3 Jan 2022 04:09:27 +0000 (UTC)
Received: from [192.168.48.23] (host-45-58-208-241.dyn.295.ca [45.58.208.241])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 139D829FB9;
        Mon,  3 Jan 2022 04:09:25 +0000 (UTC)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
 <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
Date:   Sun, 2 Jan 2022 23:09:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-02 6:23 p.m., Maciej W. Rozycki wrote:
> Set the allocation length to 255 for the ATA Information VPD page
> requested in the WRITE SAME handler, so as not to limit information
> examined by `scsi_get_vpd_page' in the supported vital product data
> pages unnecessarily.
> 
> Originally it was thought that Areca hardware may have issues with a
> valid allocation length supplied for a VPD inquiry, however older SCSI
> standard revisions[1] consider 255 the maximum length allowed and what
> has later become the high order byte is considered reserved and must be
> zero with the INQUIRY command.  Therefore it was unnecessary to reduce
> the amount of data requested from 512 as far down as to 64, arbitrarily
> chosen, and 255 would as well do.

Not arbitrary, 64 bytes would get all the fields less the 512 byte ATA
DEVICE IDENTIFY data field.

> With commit b3ae8780b429 ("[SCSI] Add EVPD page 0x83 and 0x80 to sysfs")
> we have since got the SCSI_VPD_PG_LEN macro, so use that instead.
> 
> References:
> 
> [1] "Information technology - Small Computer System Interface - 2",
>      WORKING DRAFT, X3T9.2, Project 375D, Revision 10L, 7-SEP-93, Section
>      8.2.5 "INQUIRY command", pp.104-108

Yes, 1992, long withdrawn and only used by several billion USB keys.

But the ATA Information VPD page first appeared in SAT around 2006 and the
length of that page was (and still is in SAT-5 drafts) "238h" (572 bytes
long (when the 4 byte header is considered)). So it needs 16 bits to
represent that length. SPC-3 (2005) bumped the allocation length field in
the INQUIRY command from 8 to 16 bits.

Finally SAT-1 in its approved references [2.2] says:
ISO/IEC 14776-453, SCSI Primary Commands - 3 (SPC-3) [ANSI INCITS 408-2005]

So any SAT layer that supplies the ATA Information VPD page should also
support (translating) an INQUIRY with a 16 bit allocation field.

How does your problem arise? Could USB mass storage be involved?

And this patch solves your problem by returning part of the ATA DEVICE
IDENTIFY data (which is 512 bytes long)? If so, why not say so.

And what about using 0x2ff as the INQUIRY allocation length? If the
broken device ignores the top byte, you get 255 bytes back. If a
correct device takes both bytes it should return 0x23c bytes after
resid is taken into account.



Not related to this patch:
sd_read_write_same() seems a strange name for a function given that
it is checking on WRITE SAME support. How about s/read/report/ ?
And calling scsi_report_opcode() on INQUIRY seems a weird time waster
(it actually checks if the SCSI version is < SPC-3 or does the check
on a _mandatory_ command). And for modern disks scsi_report_opcode()
is called 5 times. Why not call the REPORT SUPPORTED OPERATION CODES
command once and cache its result? It would save 4 commands in every
disk setup (or revalidation).

Doug Gilbert


> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: af73623f5f10 ("[SCSI] sd: Reduce buffer size for vpd request")
> Tested-by: Nick Alcock <nick.alcock@oracle.com>
> ---
> Changes from v2:
> 
> - Add Nick's Tested-by annotation.
> 
> No changes from v1.
> ---
>   drivers/scsi/sd.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> linux-scsi-write-same-vpd-buffer.diff
> Index: linux-macro/drivers/scsi/sd.c
> ===================================================================
> --- linux-macro.orig/drivers/scsi/sd.c
> +++ linux-macro/drivers/scsi/sd.c
> @@ -3101,16 +3101,13 @@ static void sd_read_write_same(struct sc
>   	}
>   
>   	if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, INQUIRY) < 0) {
> -		/* too large values might cause issues with arcmsr */
> -		int vpd_buf_len = 64;
> -
>   		sdev->no_report_opcodes = 1;
>   
>   		/* Disable WRITE SAME if REPORT SUPPORTED OPERATION
>   		 * CODES is unsupported and the device has an ATA
>   		 * Information VPD page (SAT).
>   		 */
> -		if (!scsi_get_vpd_page(sdev, 0x89, buffer, vpd_buf_len))
> +		if (!scsi_get_vpd_page(sdev, 0x89, buffer, SCSI_VPD_PG_LEN))
>   			sdev->no_write_same = 1;
>   	}
>   
> 

