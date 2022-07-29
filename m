Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6A5855FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiG2UQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:16:38 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D1E8AEE5;
        Fri, 29 Jul 2022 13:16:38 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id q16so4817954pgq.6;
        Fri, 29 Jul 2022 13:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Oy4qUGZWXPlIDUNNbQ5N/E9k+z0m3V8PivYub989Lys=;
        b=JSdT8wi7ilCWtyaOOm8uTzx3ilzxbn36g/RYLT8Yi9gk6Xi70b9rrVhjx1mZU+Wcjd
         jXQUBsh9ftsG2UCXN5U2TWMZLaZ1KmPKyPAqsxDwBDGfj/4MO8ZBcMTvkgHRryR6I0Xi
         i5Z5zuj5DxLRV6uPSIfW8ytK7nWqFwg+CLw5E/k9tnm5H6llzC0PF79LtNmKjHdSblEx
         bpA15jpr2UsuEkMQ0Tc/m+q+1qUUNuqg9yWiKAAo50yciM7TyUCTzNaL+ZB3IZ59AoCH
         GbdzzhOsggLVLUVCoRww4S+7R2u0Z5VpTM2ml8xCLtDtDvN2rlJNzIaD//VqGbDgnSuD
         viyg==
X-Gm-Message-State: AJIora88Oes+8e18riuPgweHYMJHsnL4dpH0dvJbbFXeOZWcOqYKtz71
        OXaToXIwlgEdWMmPoYbMldI=
X-Google-Smtp-Source: AA6agR4mbh+EQVGMYnvNnyGvVsz7e222331FYdJ8cC8pW/VthJQGeTEn0YHbT4C/BMwDUQFgfYyNIQ==
X-Received: by 2002:a05:6a00:1812:b0:52a:c171:7cc5 with SMTP id y18-20020a056a00181200b0052ac1717cc5mr5037264pfa.81.1659125797322;
        Fri, 29 Jul 2022 13:16:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id ij21-20020a170902ab5500b0016c0c82e85csm4066461plb.75.2022.07.29.13.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:16:36 -0700 (PDT)
Message-ID: <360e6b66-30f6-5c54-c03f-b5d267f6703a@acm.org>
Date:   Fri, 29 Jul 2022 13:16:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/6] scsi: ufs: wb: Change wb_enabled condition test
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p7>
 <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 21:52, Jinyoung CHOI wrote:
> Changed to improve readability.
> As implemented in ufshcd_wb_togle_flush(), the conditional test is
> modified in the same way.
> 
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 8f11f118c30e..bbf12aa6a5ae 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5730,10 +5730,8 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
>   {
>   	int ret;
>   
> -	if (!ufshcd_is_wb_allowed(hba))
> -		return 0;
> -
> -	if (!(enable ^ hba->dev_info.wb_enabled))
> +	if (!ufshcd_is_wb_allowed(hba) ||
> +	    hba->dev_info.wb_enabled == enable)
>   		return 0;
>   
>   	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
