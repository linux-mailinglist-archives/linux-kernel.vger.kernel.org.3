Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95547145A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhLKO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 09:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhLKO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 09:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639234741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbReCG1M7E0ucUZa8YIA4TGhLlaj5njMRz+VbhuZSV0=;
        b=Etes6CZ5pCfhZ/LDrn7hkdl3UXM+sdoSyCgvF/shUQjFt0EUbQLoR1tB389slkMd2DlpSi
        D6wc4DY92JtZ2rI1LTSlW4ADgUzK5CheIIs1EK3MjwChdyGisjg9bwQExjGvyDHBf2N2Qs
        Z+Aim7puNP0Ydzf97iblo+hKCvtwhCU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-ixCc5YdYNROg1z_jWSEU0w-1; Sat, 11 Dec 2021 09:57:54 -0500
X-MC-Unique: ixCc5YdYNROg1z_jWSEU0w-1
Received: by mail-oi1-f199.google.com with SMTP id i82-20020acab855000000b002bcea082cf7so8092339oif.22
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 06:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LbReCG1M7E0ucUZa8YIA4TGhLlaj5njMRz+VbhuZSV0=;
        b=rmK37dLOfhEc5sMCcd5d1xf8/j2ZovndOalcszRHRRWCuQxi8AKENc0WPm0qN9dsQX
         ZEQlNUNhleHsPeT7skA61/Du/Q4GT68PPxSHzympJXgsQ8/c2wljB/FDXzPxaQi92iLV
         FDhsb98D2owFc5BnyfJfr9Ftz2njoiAyCbTgIdsNkoLH2UJtvIuSkRJsQg6w8m8iMim+
         IvlLDpAG7L6iiQDPuQjUHjOt33KsiUqaWBcir7/nM5QxJMzOLDYS/AG/AYVoXag43bS9
         31q926m/YycMqqLi5K4TL+nNIYVA2M9gcnFtjteUwbEznCudCz0+xiKPVPIrXmwNhPwa
         x3xg==
X-Gm-Message-State: AOAM530UOht36DG+We102/kfax0eXoKPcf41u17YYL4ssmUlJzakJWQ3
        hAXaQButAa3aHB8iZkMHWwia6EywzXOG8DpvvR6+3he58M9hE1E1qQg0ZhgAPo8mnOYZLqPI0jZ
        ohpeDK+SwLk4+ram0RBIQQe2c
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr16132929ott.256.1639234673646;
        Sat, 11 Dec 2021 06:57:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwyDI/oAFmloRAsa09wcp3Lsx27/wivAjpheSVOipJIAFRmYQdqI5dYjCzcgKOY3TKMznxtA==
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr16132918ott.256.1639234673381;
        Sat, 11 Dec 2021 06:57:53 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a3sm1089158oti.29.2021.12.11.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:57:52 -0800 (PST)
Subject: Re: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com
References: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
 <20211211145038.31612-1-linmq006@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <97789bcc-0e5b-a822-854f-15d0fbe47844@redhat.com>
Date:   Sat, 11 Dec 2021 06:57:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211211145038.31612-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/21 6:50 AM, Miaoqian Lin wrote:
> The stratix10_svc_allocate_memory function does not return NULL. It
> returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/fpga/stratix10-soc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 047fd7f23706..91212bab5871 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	/* Allocate buffers from the service layer's pool. */
>   	for (i = 0; i < NUM_SVC_BUFS; i++) {
>   		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> -		if (!kbuf) {
> +		if (IS_ERR(kbuf)) {
>   			s10_free_buffers(mgr);
> -			ret = -ENOMEM;
> +			ret = PTR_ERR(kbuf);

Thanks!

Reviewed-by: Tom Rix <trix@redhat.com>

>   			goto init_done;
>   		}
>   

