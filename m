Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4759E826
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiHWQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiHWQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:53:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E40133BBB;
        Tue, 23 Aug 2022 06:22:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p9so12374303pfq.13;
        Tue, 23 Aug 2022 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ShH42rQzWj1EeMirCoVLYtSWZK8NNLe3xFxBUFTqrzg=;
        b=gO54e0Jh/ejzga4Xgm6cPvu7HZg3zY285ZKPkD32+C3f/CCYJBb4T1DAXmFn3hypNK
         hHId8K1IaqItWbI+8qIAVM64nWpvnrwUWfYmKtmWbI3KwIxYd+HTUFon/Y4QnIiZdCe4
         pWCMbzooR4lOryyEGvhfbAeybYtUIN5f2Spmgf3O9R9iK776sH6Ds40jD8VuDSLIdbvS
         UHyzAfUXxm6l2w40tukAX3jzgEntEITKilHOpt9yK21bEabtItQcxHYqNes7AlAVJACd
         c5/QfajFS28j8ux3PtGw7hFjj4Fx5KHTFhg8cQ6oouU6WFxVagCl9ANTTccYmUvuk097
         rBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ShH42rQzWj1EeMirCoVLYtSWZK8NNLe3xFxBUFTqrzg=;
        b=THbHL8O2OPHmFyQg0ASfdfZKlGlC4OdavmAOTujXQjdMi72Tn0sz9uvPI9S9TCuwHR
         2A8pfeQv0cpczR7DwUTQzjauD36LmzBTyK+Oqw5GCSKPiBFv0lxBlfw2vowFPUEqhEDK
         kArCOc/j0Bm0IuDorc5DDnAg3T60njL0f8js9ED2hRMybexFkdpAN65coU0XlaQ/N6HO
         Rg62Wmvevy9feZaHbE3luZbqG4uLXvGzFVLuaqs0AcD/hZBBfBcEpIqaBVHYajZ16Hkc
         fuIni/MzmE/l5osSHHHhNjkIUdZeZfgmNXRq37Y66iIm+Sfs4FzhkXMBPi3IkfFPEoxu
         K+uQ==
X-Gm-Message-State: ACgBeo3J9uVejclyzqM+cBChUuxCTaAKSkMGELGxKiRkZ9cdwOYIFy9n
        PuuX9pgOHmAcdXV21piirBs=
X-Google-Smtp-Source: AA6agR7u1aXeZyCxkPHIApJ5NqY0DcNDwSeniR7tuBytw0DKzogsqXa/urfzofZjb3ptQA08BjC7Uw==
X-Received: by 2002:a63:4a50:0:b0:41d:a203:a45d with SMTP id j16-20020a634a50000000b0041da203a45dmr20892659pgl.451.1661260962935;
        Tue, 23 Aug 2022 06:22:42 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79721000000b0053675c0b773sm5326274pfg.88.2022.08.23.06.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 06:22:42 -0700 (PDT)
Message-ID: <ec487d40-2bb0-b9b3-d520-c1516488c251@gmail.com>
Date:   Tue, 23 Aug 2022 06:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next v2] scsi: lpfc: add missing destroy_workqueue() on
 error path in lpfc_sli4_driver_resource_setup()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com
References: <20220823044237.285643-1-yangyingliang@huawei.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220823044237.285643-1-yangyingliang@huawei.com>
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

On 8/22/2022 9:42 PM, Yang Yingliang wrote:
> Add the missing destroy_workqueue() before return from
> lpfc_sli4_driver_resource_setup() in error path.
> 
> Fixes: 3cee98db2610 ("scsi: lpfc: Fix crash on driver unload in wq free")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>    correct label spelling error
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index c69c5a0979ec..55a1ad6eed03 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -8053,7 +8053,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   	/* Allocate device driver memory */
>   	rc = lpfc_mem_alloc(phba, SGL_ALIGN_SZ);
>   	if (rc)
> -		return -ENOMEM;
> +		goto out_destroy_workqueue;
>   
>   	/* IF Type 2 ports get initialized now. */
>   	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
> @@ -8481,6 +8481,9 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
>   	lpfc_destroy_bootstrap_mbox(phba);
>   out_free_mem:
>   	lpfc_mem_free(phba);
> +out_destroy_workqueue:
> +	destroy_workqueue(phba->wq);
> +	phba->wq = NULL;
>   	return rc;
>   }
>   

Thank You!

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

