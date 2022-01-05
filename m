Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A26484DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiAEF7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:59:42 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:32922 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236313AbiAEF7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:59:40 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTJj84s01z1VSkZ
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:59:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:content-language:references:to:subject
        :from:user-agent:mime-version:date:message-id; s=dkim; t=
        1641362380; x=1643954381; bh=ixgm5wrw3iqKwyb/nIXCFir57CNaqFLuUTn
        7Yx0jVH8=; b=o8u5CAwc5YA5Ga6k3Wn/qsZHCkPiNKvS9fYtLOkz861E75UCfaR
        uLFly+y4Ry+HDtrygKdcHeS8qekre3lo3euAn8UtYnVPs7ZBndi3BtdhL99aoBrZ
        By9eModxub18F17gTuxZeQAoID0lBMwZvI2rqVUS9txpjk8HhKtPfBWnFDoY+QOV
        fgadmiI+KuXfxRvI72OkhWgyZDTrAL0/NwmG7qxJRS4XlUKyqNmUxRRxW26FT+NH
        B+8JtXpnEO/YVPlv36jAN925PFooxNxQ8JfVKeJaOfQDt9HXV/qWtQxCHmneh+R7
        ksRf5v2EmE1sTjsw4au3flboOEp7Zz9ipQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZpyJbFDGGnXV for <linux-kernel@vger.kernel.org>;
        Tue,  4 Jan 2022 21:59:40 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTJj73bLcz1VSkV;
        Tue,  4 Jan 2022 21:59:39 -0800 (PST)
Message-ID: <1e29d5e0-aee0-e020-4b43-9f0510d75f81@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 14:59:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH demo] ata_scsi_queuecmd: Make input parameters check more
 clearly
To:     Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <20220105021704.1679067-1-haowenchao@huawei.com>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20220105021704.1679067-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 11:17, Wenchao Hao wrote:
> This is just a clean code. Since each branch of "if" state would check
> scmd->cmd_len, so move the check of scmd->cmd_len out of "if" state to
> simplify the logic of input parameters check.
> 
> The patch do not change origin function logic.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 313e9475507b..1c653b5327db 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4020,19 +4020,18 @@ void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  {
>  	u8 scsi_op = scmd->cmnd[0];
> -	ata_xlat_func_t xlat_func;
> +	ata_xlat_func_t xlat_func = NULL;

Not needed. xlat_func is always set for the non-error cases.

>  	int rc = 0;
>  
> +	if (unlikely(!scmd->cmd_len))
> +		goto bad_cdb_len;
> +
>  	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
> -		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
> +		if (unlikely(scmd->cmd_len > dev->cdb_len))
>  			goto bad_cdb_len;
>  
>  		xlat_func = ata_get_xlat_func(dev, scsi_op);
>  	} else {
> -		if (unlikely(!scmd->cmd_len))
> -			goto bad_cdb_len;
> -
> -		xlat_func = NULL;
>  		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
>  			/* relay SCSI command to ATAPI device */
>  			int len = COMMAND_SIZE(scsi_op);

I would go further and cleanup the if else { if else } sequence too.
Something like this:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a16ef0030667..ed8be585a98f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3958,42 +3958,39 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
struct ata_device *dev)
 {
 	u8 scsi_op = scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
-	int rc = 0;
+
+	if (unlikely(!scmd->cmd_len))
+		goto bad_cdb_len;

 	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
-		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
+		if (unlikely(scmd->cmd_len > dev->cdb_len))
 			goto bad_cdb_len;

 		xlat_func = ata_get_xlat_func(dev, scsi_op);
-	} else {
-		if (unlikely(!scmd->cmd_len))
-			goto bad_cdb_len;
+	} else if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
+		/* relay SCSI command to ATAPI device */
+		int len = COMMAND_SIZE(scsi_op);

-		xlat_func = NULL;
-		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
-			/* relay SCSI command to ATAPI device */
-			int len = COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len ||
-				     len > dev->cdb_len ||
-				     scmd->cmd_len > ATAPI_CDB_LEN))
-				goto bad_cdb_len;
+		if (unlikely(len > scmd->cmd_len ||
+			     len > dev->cdb_len ||
+			     scmd->cmd_len > ATAPI_CDB_LEN))
+			goto bad_cdb_len;

-			xlat_func = atapi_xlat;
-		} else {
-			/* ATA_16 passthru, treat as an ATA command */
-			if (unlikely(scmd->cmd_len > 16))
-				goto bad_cdb_len;
+		xlat_func = atapi_xlat;
+	} else {
+		/* ATA_16 passthru, treat as an ATA command */
+		if (unlikely(scmd->cmd_len > 16))
+			goto bad_cdb_len;

-			xlat_func = ata_get_xlat_func(dev, scsi_op);
-		}
+		xlat_func = ata_get_xlat_func(dev, scsi_op);
 	}

 	if (xlat_func)
-		rc = ata_scsi_translate(dev, scmd, xlat_func);
-	else
-		ata_scsi_simulate(dev, scmd);
+		return ata_scsi_translate(dev, scmd, xlat_func);

-	return rc;
+	ata_scsi_simulate(dev, scmd);
+
+	return 0;

  bad_cdb_len:
 	scmd->result = DID_ERROR << 16;






-- 
Damien Le Moal
Western Digital Research
