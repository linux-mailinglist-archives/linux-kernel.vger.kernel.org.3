Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D94539806
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347761AbiEaUef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbiEaUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D5994F3;
        Tue, 31 May 2022 13:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648B9612DC;
        Tue, 31 May 2022 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93414C385A9;
        Tue, 31 May 2022 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654029269;
        bh=7k+SyZk2P/BnS4w86E2eL0uEWgnk76t6CF+HTgTg0AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwp/6tjyjxCp5GCv6vLMwD9am8lKRAiPUFdqbbNoKWaEUEuYbmSeWIt9TXFkloHm3
         E2OMrcRtiyzUhr4/TJGq/90Ps7rSP4mC36Ly7tLyPC29q58uEnz2JG7avVkHwbJ91/
         C6Rfz/PDrpHD5H0hcMSjiCsi7q7/bDqfvATGGgcRwJBIyDp9sOQWACQWBEDl3K07KV
         LDINTykeU0xu3c6hkgrIerHS1GjWqmgxrNiMfYfSdFJ6pCrSDBNHkCv4tfTLFQ9Re0
         08BwvGyz/KPazINRI8XkYejSwicDmhqqzs60RkSNPTS+WG2eG9nuuxcg3YIpGj4gMQ
         lCPt6se3JHC6w==
Date:   Tue, 31 May 2022 20:34:28 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Message-ID: <YpZ71MU7+DRedq5S@gmail.com>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531201053.3300018-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 01:10:53PM -0700, Jaegeuk Kim wrote:
> UFS stack shows very low performance of FUA comparing to write and cache_flush.
> Let's add a quirk to adjust it.
> 
> E.g., average latency according to the chunk size of write
> 
> Write(us/KB)	4	64	256	1024	2048
> FUA		873.792	754.604	995.624	1011.67	1067.99
> CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 3 +++
>  drivers/scsi/ufs/ufshcd.h | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 3f9caafa91bf..811f3467879c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5035,6 +5035,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>  	 */
>  	sdev->silence_suspend = 1;
>  
> +	if (hba->quirks & UFSHCD_QUIRK_BROKEN_FUA)
> +		sdev->broken_fua = 1;
> +
>  	ufshcd_crypto_register(hba, q);
>  
>  	return 0;
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 94f545be183a..6c480c6741d6 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -602,6 +602,11 @@ enum ufshcd_quirks {
>  	 * support physical host configuration.
>  	 */
>  	UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
> +
> +	/*
> +	 * This quirk disables FUA support.
> +	 */
> +	UFSHCD_QUIRK_BROKEN_FUA				= 1 << 17,
>  };

"Broken" is ambiguous.  IIUC, the issue is that FUA performance is very bad, not
that it doesn't work.  Can you clarify the intent in the comment?

Also, this patch does nothing by itself.  Which UFS host driver(s) need this
quirk bit?  Can you update them to use it?  Or do they all need this, in which
case a quirk bit would be unnecessary?

- Eric
