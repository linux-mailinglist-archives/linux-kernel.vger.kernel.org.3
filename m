Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BE573764
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiGMN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiGMN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:29:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9613D3C;
        Wed, 13 Jul 2022 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657718965; x=1689254965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L4CProI6gki3JdTLeUa3J0QD35v7lRC9rLkvXYbbm7s=;
  b=lV/hhsEbkyd+L7t3ZQqw6MWnR9E18g8YfiL4VeXmzltRn/Wl5Ld0w8Ij
   WvydpqY+Vn4rAmnoF/9KGGv00GIsL6Hgq1w7JbQtmIjwmPcZObUu1mV1Q
   jv0gzWQpunN3QYPiyka3BNhDJ9gTGmKKp5k+NQ3yKOjdBylBs+0URuc3k
   BYr+vkRarW+wj09oOSwn0TaOVdoEC6CWSTOx5Pw2JJk/FxJCw6UcK9Dox
   7EV66XKD+4kB/RLeOvbJbJwNzkLfmzg5cG5I3ZAnksE7IUlOGFVJ+oEkD
   yQqnaeg/8by2xkD+qlGyzTOWwT7md43TXq6e9uV7vUJctEyuyo5qDgQ6I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="346891062"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="346891062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 06:29:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="622940542"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.236])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 06:29:22 -0700
Message-ID: <0c1da7b8-1be0-76a9-f613-ef307bac4e36@intel.com>
Date:   Wed, 13 Jul 2022 16:29:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] scsi: ufs: ufs-pci: default clock frequency for Intel's
 UFS controller
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220708141612.1.Ice2e8173bd0937c7c4898b112350120063572269@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220708141612.1.Ice2e8173bd0937c7c4898b112350120063572269@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/07/22 07:17, Daniil Lunev wrote:
> ARM platforms rely on 'ref_clk' of a UFS controller's node in DTS to set
> up the proper bRefClkFreq for the UFS storage device. The facility is
> not available on x86. To circumvene that, default the parameter,
> responsible for carrying the value to the UFS storage device
> initialization, to the one that Intel's controllers support. This is
> required to support provisioning of UFS storage devices from userspace,
> without relying on FW and/or bootloader to make the necessary
> preparations.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> ---
> 
>  drivers/ufs/host/ufshcd-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
> index 04166bda41daa..a6f9222cbea74 100644
> --- a/drivers/ufs/host/ufshcd-pci.c
> +++ b/drivers/ufs/host/ufshcd-pci.c
> @@ -336,6 +336,7 @@ static int ufs_intel_common_init(struct ufs_hba *hba)
>  	struct intel_host *host;
>  
>  	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
> +	hba->dev_ref_clk_freq = REF_CLK_FREQ_19_2_MHZ;

I have seen requirement documents saying 19.2 or 38.4, so this is would
be a problem since it overwrites the value even if it has been set correctly
to something other than 19.2 MHz.

>  
>  	host = devm_kzalloc(hba->dev, sizeof(*host), GFP_KERNEL);
>  	if (!host)

