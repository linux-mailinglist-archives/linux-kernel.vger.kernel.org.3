Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7296E526C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384685AbiEMVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEMVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:37:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C72369E9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:37:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so5828072otr.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=odMsEww+gcaMdcA958G3F7Vsds3bvFaYB9MyoQSM89g=;
        b=hDrLOeuKJsipyQfKzX0TM2aae1nYNUC4HRb6tKjp5Ct9l+ZXhWbZlmkHO9Q8GIYVTZ
         D8hBW/ziW2y770TZHT98H5DhRVrA8W84gYf9enyaCdDz1EkovnxGxKx9F+Ubinw/PtIC
         WEnge1ODNw1LEojdC1iKQV4TRzfWqbzZlllR1gwnZ4YEpoGwRXd8FLhCZhkwHWvGWiJ+
         068djzefY27daZcfb3I8fFxtP3qh5nkwH1unumsWpcGcXhCXl0qTy0m76dytl5fT5Qdo
         pbRGy1yYhvkbKroC14R3hIq4uDgTR2pnie2x77hxripS2k302a5Ny1r24z81R1/ge9jT
         3hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=odMsEww+gcaMdcA958G3F7Vsds3bvFaYB9MyoQSM89g=;
        b=6S0VvxmJ3iIZxMlqqnxu15rRROWKrOGrXrZ/Gw3iWcPop6U0ucHdbjOEec+bxcaBvw
         81/U8oYpZxd19PqqSLbTP0/WeM6mRCzxOUYwluR0zRfHebK1tB066m/V7C401/VuMntE
         ydZTAKNj8O4p09HkXJEiMd4mKnynuu2HOu2wnCS0sngJtPpa2UceoZ7Qn4oqQT+WzK+Q
         uk6BJMDpSiFGLcXI0bxJbuFo5a4rclRmYEQH2y3wPzTNb3Oi6eSF7FykOEl2cP+aSSii
         afFYN85j4II2v66yHh3xvBsb9ZWAwb+1ajAGrjBiO4l+jZVtkW7uqqN78uH6/pk61VP1
         qz0g==
X-Gm-Message-State: AOAM532b91ddIuaTjDjD/kAzNo7+DalCX169lRz9wND/nWb7SQsNgxSL
        PkJYEirQK5f2YezOhAgtExE=
X-Google-Smtp-Source: ABdhPJxBSPVaGm+LQsqJ72mxcKOZ82dDOs0t5KZgJ/LFG6IaNs7KN7FgxDyDVRa9C1lXYQcLSHtUnA==
X-Received: by 2002:a9d:4549:0:b0:605:f4c5:1af5 with SMTP id p9-20020a9d4549000000b00605f4c51af5mr2504772oti.140.1652477832289;
        Fri, 13 May 2022 14:37:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a4a6c0e000000b00333301670dcsm1557602ooc.2.2022.05.13.14.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 14:37:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <01fd17bd-fd4e-b40a-5a1d-619a7d2c5faa@roeck-us.net>
Date:   Fri, 13 May 2022 14:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] fsi: occ: Prevent use after free
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org
References: <20220513194424.53468-1-eajames@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220513194424.53468-1-eajames@linux.ibm.com>
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

On 5/13/22 12:44, Eddie James wrote:
> Use get_device and put_device in the open and close functions to
> make sure the device doesn't get freed while a file descriptor is
> open.
> Also, lock around the freeing of the device buffer and check the
> buffer before using it in the submit function.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
>   - Add lock around freeing/nulling the buffer in occ_remove
>   - Don't bother checking the buffer in open or in write, only in submit
> 
>   drivers/fsi/fsi-occ.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index c9cc75fbdfb9..28c176d038a2 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -94,6 +94,7 @@ static int occ_open(struct inode *inode, struct file *file)
>   	client->occ = occ;
>   	mutex_init(&client->lock);
>   	file->private_data = client;
> +	get_device(occ->dev);
>   
>   	/* We allocate a 1-page buffer, make sure it all fits */
>   	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
> @@ -197,6 +198,7 @@ static int occ_release(struct inode *inode, struct file *file)
>   {
>   	struct occ_client *client = file->private_data;
>   
> +	put_device(client->occ->dev);
>   	free_page((unsigned long)client->buffer);
>   	kfree(client);
>   
> @@ -493,12 +495,19 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>   	for (i = 1; i < req_len - 2; ++i)
>   		checksum += byte_request[i];
>   
> -	mutex_lock(&occ->occ_lock);
> +	rc = mutex_lock_interruptible(&occ->occ_lock);
> +	if (rc)
> +		return rc;
>   
>   	occ->client_buffer = response;
>   	occ->client_buffer_size = user_resp_len;
>   	occ->client_response_size = 0;
>   
> +	if (!occ->buffer) {
> +		rc = -ENOENT;
> +		goto done;
> +	}
> +
>   	/*
>   	 * Get a sequence number and update the counter. Avoid a sequence
>   	 * number of 0 which would pass the response check below even if the
> @@ -671,10 +680,13 @@ static int occ_remove(struct platform_device *pdev)
>   {
>   	struct occ *occ = platform_get_drvdata(pdev);
>   
> -	kvfree(occ->buffer);
> -
>   	misc_deregister(&occ->mdev);
>   
> +	mutex_lock(&occ->occ_lock);
> +	kvfree(occ->buffer);
> +	occ->buffer = NULL;
> +	mutex_unlock(&occ->occ_lock);
> +
>   	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
>   
>   	ida_simple_remove(&occ_ida, occ->idx);

