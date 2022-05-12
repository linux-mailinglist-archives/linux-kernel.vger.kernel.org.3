Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41447525820
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359394AbiELXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359393AbiELXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:10:50 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF16717054
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:10:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-ed9a75c453so8522262fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fUvo8JQzQvYNWRP4R5hC6ePxb8/F+QFQVGVerVzsRdY=;
        b=Bh1QNo7Cpq/M4g8JOfLWCXzgXKMgKxYGD/dalpwJSBEQI/yro7N9PUdjHrMxWJow36
         q8ufrmM3j2Zr2meGKviwz5fUEDmPEUV2M1xQ8vjxeK2NcfMqGhtQe/idAEApooXKQhSr
         M0A4OIAQBCPyaND/MG7W7t6Hj9Nkut9MvKHYt1lVpbt1j71suSKr2kNhCDyLL+Bg6xYN
         ZScM9xV8pBu5QUh/9eIjRsxSRDEc8dqmbk6qtjIhReK85KVzooIScF+edVmG+Vn8LQid
         b9xMSeb00ch+mIbktyQlX5gykKefROFb+TAHkL4kH9BDc26JOTmyxTUDHi/8ERJ7ESbR
         aiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fUvo8JQzQvYNWRP4R5hC6ePxb8/F+QFQVGVerVzsRdY=;
        b=Lk3P2kBoDPiRyB6cLalF+v25mfKpin0+NKJkv3m8+v3cJYdqqiup262MDy016Z3d9V
         Oc/UqySdN0Cp76wsral7TNiLLm6aubMM3fPt/MFILCJRYmbVw2G5jhw+Emr6WPZ/FlU6
         XItZHvB44Q/UtZW/9C+K8GoIXqbzDyUGrCND3X/NjqSl5ipXofoYRpkNtpnBAg4FzJl1
         hGmoa+jVcu4WRSvgwaUJQz/Yz81LVgEIJLEPHIwfvjQLWra/zAElQHpj4q97ff5hmEp6
         tuMTsZflb4kqN8KSkqbXD+VikjH0FvlVi2fQua8cYcZD3xPhWE4669rffrZ7xuRagF3T
         zBTA==
X-Gm-Message-State: AOAM530Lf4XonOb23E4Dwc3/y9Z1JC47yVoDogywbQdPfACaELR7nJmM
        fHq3uM8jDuy/RMBoM2Crp0464N90KNCjQQ==
X-Google-Smtp-Source: ABdhPJzNOgGevrCz/1SupsRSDLEV4rsiyh64RxLVgxaj2jH2A5cFl7+mOhWsHgdtYnu0pxnmFZXh0Q==
X-Received: by 2002:a05:6870:538f:b0:e1:e893:95c5 with SMTP id h15-20020a056870538f00b000e1e89395c5mr7203392oan.11.1652397048908;
        Thu, 12 May 2022 16:10:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020acab207000000b0032647f4e437sm415756oif.45.2022.05.12.16.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:10:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad258449-ddc3-6bd5-0371-becac42e7d47@roeck-us.net>
Date:   Thu, 12 May 2022 16:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fsi: occ: Prevent use after free
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     alistair@popple.id.au, linux-kernel@vger.kernel.org
References: <20220512210034.59907-1-eajames@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220512210034.59907-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 14:00, Eddie James wrote:
> Use get_device and put_device in the open and close functions to
> make sure the device doesn't get freed while a file descriptor is
> open.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/fsi/fsi-occ.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index c9cc75fbdfb9..9e48dc62b1c5 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -82,6 +82,9 @@ static int occ_open(struct inode *inode, struct file *file)
>   	struct miscdevice *mdev = file->private_data;
>   	struct occ *occ = to_occ(mdev);
>   
> +	if (!occ->buffer)
> +		return -ENOENT;
> +
>   	if (!client)
>   		return -ENOMEM;
>   
> @@ -94,6 +97,7 @@ static int occ_open(struct inode *inode, struct file *file)
>   	client->occ = occ;
>   	mutex_init(&client->lock);
>   	file->private_data = client;
> +	get_device(occ->dev);
>   
>   	/* We allocate a 1-page buffer, make sure it all fits */
>   	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
> @@ -143,7 +147,7 @@ static ssize_t occ_write(struct file *file, const char __user *buf,
>   	ssize_t rc;
>   	u8 *cmd;
>   
> -	if (!client)
> +	if (!client || !client->occ->buffer)
>   		return -ENODEV;
>   
>   	if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
> @@ -197,6 +201,7 @@ static int occ_release(struct inode *inode, struct file *file)
>   {
>   	struct occ_client *client = file->private_data;
>   
> +	put_device(client->occ->dev);
>   	free_page((unsigned long)client->buffer);
>   	kfree(client);
>   
> @@ -672,6 +677,7 @@ static int occ_remove(struct platform_device *pdev)
>   	struct occ *occ = platform_get_drvdata(pdev);
>   
>   	kvfree(occ->buffer);
> +	occ->buffer = NULL;

Isn't this slightly racy (there is no guarantee that occ->buffer is updated
by the time it is used by the write function, and there is no synchronization
across CPUs which ensures that the pointer is actually written to memory
before it is used) ?

Thanks,
Guenter
