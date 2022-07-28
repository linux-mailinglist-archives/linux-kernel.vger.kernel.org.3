Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37235846AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiG1TwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiG1TwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:52:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FB1CFD5;
        Thu, 28 Jul 2022 12:52:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l193so1936102pge.9;
        Thu, 28 Jul 2022 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q6Nd+Q0znhV0oBUcJ9SffYMNHCPkVgH2JbTP7gR3xXw=;
        b=alecOQsYpv2iZLHlSQSZ8Pv/W0uldMCf/G3vQ/8QXQu/XhBmIaeA44YEqkPbt8iDS5
         FTLUhAR2OtfhLK7KIirjYSjGoW8dDTllCAk4mKkIAtFTWWGzmbVwuZ8t5z5kuz+sYB26
         qvo1xcqRqwhz4+tIix6DMdtbvaBZQWNWy0eYctGWrT7RafPhHSZArbwHFx9ML77a4GxA
         84aOhEvZJDvq7kPc03npiGoF1fKAzQ3Xr5sdF1Jd2++QGYTFYOBLpJ66XFAx0CJ+9PaY
         GJkX5z+WNtartBSWU/8BV8Q2C2xnEFbx7M42EUPn9pdH97f5R4Yt3oXs9SBqdxwnTGIZ
         iLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q6Nd+Q0znhV0oBUcJ9SffYMNHCPkVgH2JbTP7gR3xXw=;
        b=l2mrqQKet2YrXEvsZFuHJ93DD7Wp0uX2HoLupJaWBs0PFrjjJS23/12YglT/v9X3aC
         GFTLc5Poq2pMgMIjuj5gOE78n3nSe7z4tjWgNMKV5IgYmWeeH5GT+7AOzkiMeM+erSuy
         YKWCwdTuTbG73bHqYaqNj+EgYEfR1pkWUvVC0Ey7zNajP34UJGPw29WT7g5fv8uESllf
         N+vdbOY6teNfmEMHLMKVi+cqC9UBlKInRyu3mnktQz7kAuhy0D94kZPxskMxajZqNUX2
         a7fI+2iqxeyQjPqnpeW04gN4ykTEIMZY2ngeSoCIG2LEStXYlEZWmV81c8K9mjH/to5j
         UW8g==
X-Gm-Message-State: AJIora+1GABj9dfu4HtRYo/d5PxVOfbMiH9SxzOlTBQ4PsXjOl0s3nDJ
        bfAKEwaOn0YuTdLt29QQe90=
X-Google-Smtp-Source: AGRyM1suCrcDF6++nJ3oOFqhptT6beAHWVLcZwrncorVv/8TNUI45oZSjY6ot1xjaLv0iT9q/G7hDw==
X-Received: by 2002:a05:6a00:a29:b0:52a:c0c3:4379 with SMTP id p41-20020a056a000a2900b0052ac0c34379mr143615pfh.15.1659037932535;
        Thu, 28 Jul 2022 12:52:12 -0700 (PDT)
Received: from [10.69.47.244] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d710d8af7sm1719223pln.142.2022.07.28.12.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 12:52:12 -0700 (PDT)
Message-ID: <36eb306c-2e44-4639-5d1a-e1f3e09c3a47@gmail.com>
Date:   Thu, 28 Jul 2022 12:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] scsi: lpfc: check the return value of alloc_workqueue()
Content-Language: en-US
To:     williamsukatube@163.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
References: <20220723064027.2956623-1-williamsukatube@163.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220723064027.2956623-1-williamsukatube@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/2022 11:40 PM, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> The function alloc_workqueue() in lpfc_sli4_driver_resource_setup() can
> fail, but there is no check of its return value. To fix this bug, its
> return value should be checked with new error handling code.
> 
> Fixes: 3cee98db2610f ("scsi: lpfc: Fix crash on driver unload in wq free")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 750dd1e9f2cc..8e9594f4ed16 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -7958,6 +7958,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   
>   	/* The lpfc_wq workqueue for deferred irq use */
>   	phba->wq = alloc_workqueue("lpfc_wq", WQ_MEM_RECLAIM, 0);
> +	if (!phba->wq)
> +		return -ENOMEM;
>   
>   	/*
>   	 * Initialize timers used by driver

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james
