Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0859C8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiHVTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiHVTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:31:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF013DD8;
        Mon, 22 Aug 2022 12:30:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c9so7547194qkk.6;
        Mon, 22 Aug 2022 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wCrEp0GD1MEQtauUK6wljsgzA5hgr1kFQ31N0O6sheQ=;
        b=GBt4fe+AK+6R1Jw5a0AFIA6jGoVQowCcIjLNNu3g4fCYTu85ADLCsuwJx6Rh9tE8uK
         xi/R3bXNFuLWwqjmcucCSL3PFvNwqrWGQuagIY2iVU/l48hTP0fizUfqUkqPN704fxKj
         Ik6cf1uOFxIV3qwjB9veQtwVthk0Vs/VA3HQF4Vh5UHXjQ0Jl7Dc8fGEJnT3LJD2zWTD
         NpMTt6REfsOD99YZa0pXBcdhOmgEn/wAiEf7g0uo9+ZwwZSa0Vj4JB+t/KKOLMmW1rYK
         EfGqJVdbNkkdX2DxlOdDm/zhceK4Nrwy+mOpn1LruAfcTynRdprZPsm/zqv7QB/6LmYs
         mbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wCrEp0GD1MEQtauUK6wljsgzA5hgr1kFQ31N0O6sheQ=;
        b=jqoycGR5qT6FtZOI2DenXAvmjO7+9Bn/P6YFdAiKc5BZHhyU30fw+kEavKRKD9uDmh
         R2ho8cm5fpMLfqVHA2gQ2IdFulo8o13Y1uQqppL/e17ILLhTcM7VMTPX49qJp9GuLr6e
         JYCJ4qgoGLqB8cf/Xy6nDb/kSCCs1mZx31f2/WJxTMVljN+PCqaBd+qgMfOb/3I1bELI
         ahhK6e1MmQjeA6qdMffC0lYH21D8v/jgvToC3hIg47U3W/xUaDtsZiWJky2zgpFTXDnu
         uHFAR3fC29SCKhaTQJ/K2la9vD/EAZDVHKUXI9k9sxut8nW1BHLLDuF+HyCCc+H75Nfo
         8Hgw==
X-Gm-Message-State: ACgBeo0eHn6aQIquxmJZipC3cRt4bxYyF6fsOJfcya8TTFUveDmJ72Wi
        IMXBGOdcQY6gNf8//O4484o=
X-Google-Smtp-Source: AA6agR4zCN7cTmZVhR/AZ/dO+6RhM78OlwpvA75LuUAcnPR4qVqLtIVZdBHGFcxDdMkebFRNLwTz0w==
X-Received: by 2002:a05:620a:6012:b0:6bc:2de8:ae4d with SMTP id dw18-20020a05620a601200b006bc2de8ae4dmr1978044qkb.363.1661196637603;
        Mon, 22 Aug 2022 12:30:37 -0700 (PDT)
Received: from [10.69.47.244] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a14cd00b003435983a263sm10069145qtx.46.2022.08.22.12.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:30:37 -0700 (PDT)
Message-ID: <7cd8ec1b-dd37-756b-0b74-c543fdce1995@gmail.com>
Date:   Mon, 22 Aug 2022 12:30:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] scsi: lpfc: add missing destroy_workqueue() on
 error path in lpfc_sli4_driver_resource_setup()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com
References: <20220819085049.1906233-1-yangyingliang@huawei.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220819085049.1906233-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 1:50 AM, Yang Yingliang wrote:
> Add the missing destroy_workqueue() before return from
> lpfc_sli4_driver_resource_setup() in error path.
> 
> Fixes: 3cee98db2610 ("scsi: lpfc: Fix crash on driver unload in wq free")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index c69c5a0979ec..a7bb1620fbe1 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -8053,7 +8053,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   	/* Allocate device driver memory */
>   	rc = lpfc_mem_alloc(phba, SGL_ALIGN_SZ);
>   	if (rc)
> -		return -ENOMEM;
> +		goto out_destory_workqueue;
>   
>   	/* IF Type 2 ports get initialized now. */
>   	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
> @@ -8481,6 +8481,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   	lpfc_destroy_bootstrap_mbox(phba);
>   out_free_mem:
>   	lpfc_mem_free(phba);
> +out_destory_workqueue:
> +	destroy_workqueue(phba->wq);
> +	phba->wq = NULL;
>   	return rc;
>   }
>   

Looks fine
but label needs spelling error corrected: out_destroy_workqueue

Please resend with this fixed

-- james

