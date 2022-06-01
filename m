Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB2B539C94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349611AbiFAFYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiFAFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:24:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CC9808E;
        Tue, 31 May 2022 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654061084; x=1685597084;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xQX06L/jjtHWDY6RNz/MSNPKBx6FjSI+BucvNOskFdQ=;
  b=WNGmPGOiy8HZnVKi5EgYf2dEGDICid/2pP52DOoxVHl3P71nH1C4qRqm
   zlxTAQ27/AoS5Et8lE2Pp2TlU9KXT/0bGyST10+v58VfzmY5adMY7KcQ+
   Et6Qi5Xw71fHfr0LXzJsEypZQsY43I7aZlModN82LXavXpPxLlGh4uMoA
   o2UhyXCQEjH0pQqNn0x6kEvigrHPS78UxWahgoYJ1CqIT1dUvuJDaeC9e
   ILyzryrp8etSr0ufvoI5/GlgI+qfzddOPvBhR8VvhIGJolWShRlHzZI7a
   sycGHzU6kTUt3++60NCj8sgddAM8o9WzQFrXgEekKYY0yn9OVtD6bijGS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275556165"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275556165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:24:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="606070502"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:24:40 -0700
Message-ID: <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
Date:   Wed, 1 Jun 2022 08:24:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220531201053.3300018-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/22 23:10, Jaegeuk Kim wrote:
> UFS stack shows very low performance of FUA comparing to write and cache_flush.
> Let's add a quirk to adjust it.
> 
> E.g., average latency according to the chunk size of write
> 
> Write(us/KB)	4	64	256	1024	2048
> FUA		873.792	754.604	995.624	1011.67	1067.99
> CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37

Wouldn't it depend on how much data might be in the cache?
Do you have real-world use-cases where the difference is measurable?

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

Wouldn't it be more appropriate to make it a UFS_DEVICE_QUIRK_
since it presumably depends on the UFS device not the host controller?

Also, as already commented by others, there needs to be a user of
the quirk

>  };
>  
>  enum ufshcd_caps {

