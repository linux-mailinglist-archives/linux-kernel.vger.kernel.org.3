Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BBC4B5A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiBNTer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:34:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiBNTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:34:46 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDAF68CE;
        Mon, 14 Feb 2022 11:34:30 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id i6so29065373pfc.9;
        Mon, 14 Feb 2022 11:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ExIxNXqqgrHdK1kZ6JH/FGJOcN5wTaLxWYB94zLwWk=;
        b=3EU9LG1Kf21MXyLc4NsFZzmoEaRNN+UQNVNO5q6K8WbzKRdolHiLMxdJYZW/QScvhl
         9yo58tdnOMNH4lnBKag3zysL9g+uoeqXDeXTzVzxvKCCxxXIBOE28nDW10VuSMRXGT6g
         3jwarwuAGQ5WgqMx+enpzdZY7IhEj08NQVBtiAWDw5BxwX4EWSphPs+AaG/8/YcV+BQN
         qTlqq1lXBhJCW7blE4ZrrEXUz1xbUMHpXtNTQ6ZAg1kk0l7Lb2JUaImGw+gym1KFY++k
         8lJgAfQkqbq3VZ40JGaXEzqZPbB3V865Ji6gkgiFPNIn52KZhjpSrwxB1OAOUR+MHZHv
         9Ipg==
X-Gm-Message-State: AOAM5339661mxmCErrLjjiD6NGjS0dzyXLL+Xlzj/o1eeBlo+lkyOvRp
        WO6bKPDMB/Nu1PbkcyqxuLg=
X-Google-Smtp-Source: ABdhPJzgNkJZP+2jVtDP/65BE7x2NnucJrnDd0NwGpVjygZ6+cfDZW7L5nveVzjW6B9J57IdJLVrNQ==
X-Received: by 2002:a05:6a00:1828:: with SMTP id y40mr176402pfa.15.1644866952957;
        Mon, 14 Feb 2022 11:29:12 -0800 (PST)
Received: from ?IPV6:2600:1010:b05a:bf8:cd06:5464:d61e:f6b4? ([2600:1010:b05a:bf8:cd06:5464:d61e:f6b4])
        by smtp.gmail.com with ESMTPSA id o125sm2883479pfb.116.2022.02.14.11.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 11:29:12 -0800 (PST)
Message-ID: <62a5170b-48c0-a372-5392-08f5112d7a06@acm.org>
Date:   Mon, 14 Feb 2022 11:29:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
 <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 23:39, Kiwoong Kim wrote:
> clk_scaling_lock is to prevent from running clkscaling related operations
> with others which might be affected by the operations concurrently.
> I think it looks hardware specific.
> If the feature isn't supported, I think there is no reasonto prevent from
> running other functions, such as ufshcd_queuecommand and
> ufshcd_exec_dev_cmd, concurrently.
> 
> So I add a condition at some points protecting with clk_scaling_lock.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 460d2b4..8471c90 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -2980,7 +2980,8 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>   	/* Protects use of hba->reserved_slot. */
>   	lockdep_assert_held(&hba->dev_cmd.lock);
>   
> -	down_read(&hba->clk_scaling_lock);
> +	if (ufshcd_is_clkscaling_supported(hba))
> +		down_read(&hba->clk_scaling_lock);
>   
>   	lrbp = &hba->lrb[tag];
>   	WARN_ON(lrbp->cmd);

I don't like this patch at all. This patch makes testing the UFS driver 
more complicated without having any clear benefit. Additionally, adding 
if-statements in front of locking makes static source code analysis 
harder and is an anti-pattern. Please don't do this.

Bart.
