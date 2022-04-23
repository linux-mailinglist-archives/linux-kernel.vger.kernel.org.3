Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C650C793
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiDWFWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiDWFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:22:13 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F3939A5;
        Fri, 22 Apr 2022 22:19:17 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id h12so11540932plf.12;
        Fri, 22 Apr 2022 22:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FKNF8Dy16FqWhNugEObDWx1at4kneVLrik2sikA3QTo=;
        b=0AI4zv224Fzn777XgT+Ap0BvPeCP/2/6oHG9p+B0NEtS9kUQdS+t5oW8LFOr87mFq6
         6TtDh41YmorvzMxetDiO7M1FEE0VRlT7NeQ6Bc6eNfpGNciGgwlEkclZZF9djgpdaHDI
         B1YPYKjULqAJt0CN7EfL3b1/BoLkACGgGuXqpomlTxRwcZK/ompA2Nrcu3MCPKEj06jM
         4XVSEMsSHorfxBZzYeoGcma0b2ITeLwkY5JEHVEN2f/5P2vBX2zPMzLzUlrnK0qEVQbo
         Kli05/WEeL6u80knuyz3tFC5sT5UivbsIUmvC75tC/rY9WSYzfuvKkEQD2gtC7QMc7xQ
         Xv6g==
X-Gm-Message-State: AOAM530M9MHaAAZmpSnq/Ef9HBFoA3W+PuVVJZ0iOE4P6fh2+4gLDHuK
        HGQiLt8IRia6YVYxD+8Z9VuTtbKGLmM=
X-Google-Smtp-Source: ABdhPJzYf2llY10iFZlcna8z+sViSmEPIUIxUMW3D6rCoY6nGo53evPLONAxpdpOnCm34QifKnxaNA==
X-Received: by 2002:a17:90a:c70f:b0:1bf:3e2d:6cfa with SMTP id o15-20020a17090ac70f00b001bf3e2d6cfamr9277826pjt.70.1650691156888;
        Fri, 22 Apr 2022 22:19:16 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id m13-20020a62a20d000000b004fe0ce6d7a1sm4406579pff.193.2022.04.22.22.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 22:19:16 -0700 (PDT)
Message-ID: <10d7e4a7-4364-b579-fecf-53c953d22b7d@acm.org>
Date:   Fri, 22 Apr 2022 22:19:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] scsi: ufs: core: Remove redundant wmb() in
 ufshcd_send_command()
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
 <20220422132140.313390-5-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220422132140.313390-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 06:21, Manivannan Sadhasivam wrote:
> The wmb() inside ufshcd_send_command() is added to make sure that the
> doorbell is committed immediately.

That's not the purpose of the wmb() call so I think the comment is wrong.

> This leads to couple of expectations:
> 
> 1. The doorbell write should complete before the function return.
> 2. The doorbell write should not cross the function boundary.
> 
> 2nd expectation is fullfilled by the Linux memory model as there is a
> guarantee that the critical section won't cross the unlock (release)
> operation.

I think you meant that the writel() won't cross the unlock operation?

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 9349557b8a01..ec514a6c5393 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -2116,9 +2116,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   	__set_bit(task_tag, &hba->outstanding_reqs);
>   	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
>   	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
> -
> -	/* Make sure that doorbell is committed immediately */
> -	wmb();
>   }

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
