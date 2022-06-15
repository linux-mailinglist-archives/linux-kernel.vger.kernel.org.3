Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D954D1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347429AbiFOTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiFOTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 551A829815
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655321688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80vStOZaBcAfkx2F0Vpvkz4FvyHsZJU8xm8Q9HsP33Q=;
        b=PXWTFV70O/33G9oRs2cBlzV45OpK4RZolbxld+yvh1D5vGk694aQ1a1BRUEtewowAopzb0
        skmPEcukXkILSCNx+6j8cux8VgWN8Qd9Wvs1RmWaZwmfrwM72FD5X3pAl5aqIS6KSFdAcM
        KLXNijptvClTj+rE3G+6tsdWR7BGq7k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-46_Z9Y9QPZGUQQYvBMOz2g-1; Wed, 15 Jun 2022 15:34:47 -0400
X-MC-Unique: 46_Z9Y9QPZGUQQYvBMOz2g-1
Received: by mail-ed1-f71.google.com with SMTP id i20-20020a50fd14000000b0042dd305d0f7so9278488eds.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=80vStOZaBcAfkx2F0Vpvkz4FvyHsZJU8xm8Q9HsP33Q=;
        b=GT8gSndwQPGhoH8/W5VguIlOqWgnNQh1TqBo5NsmiJdOsxVZ39n5CSNei5L7sZ+FJ4
         N0LFGYsAh7tCjp9asYfuqhPk+a4Jl92ILcl6AiV249WHtATMoqFMh0WJvVvmnfTDlj5A
         FOxToz/VNnFX4VISRCSL7rOheLZSIL9mEv+D/feASo6D4Bf4GR+WCfDbiZX0RLBytpbe
         KKHGhayT83e8NlLH089zll2zSPyo6C+e4CLfHYIfnSD2MpgvBXDWzF5bEW9njG0voqcn
         wn2bVYy+cc/Dd2EHHBODxp5r+zeOFQodWNi7+qAeGj0l5OZKc+YhzKdXhoev10ObFlMR
         YbuQ==
X-Gm-Message-State: AJIora8RRcfaJ5hnxzOpGqKrCfUY42yReSliYBcZmsZpgu0pVLRZ7rDK
        /B/yz+29OXFVF2rpO+ZpEA+cqazEhmID7dfmt2CenRJCpQbQW9rjnfKii6p3npyO74fmheLRIOr
        HDFCncvaC6tXbn431t5wbIbBg
X-Received: by 2002:aa7:d8d8:0:b0:42d:dbb0:f05b with SMTP id k24-20020aa7d8d8000000b0042ddbb0f05bmr1729861eds.82.1655321686044;
        Wed, 15 Jun 2022 12:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMO7lU8SUzHOQRcWKOZNG4+RppmgPyLrEcObB5bwCLKVADj9bSdRBnn93QIuhb8xvFTgERQA==
X-Received: by 2002:aa7:d8d8:0:b0:42d:dbb0:f05b with SMTP id k24-20020aa7d8d8000000b0042ddbb0f05bmr1729853eds.82.1655321685899;
        Wed, 15 Jun 2022 12:34:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r4-20020aa7cb84000000b0042dc9aafbfbsm32277edt.39.2022.06.15.12.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:34:45 -0700 (PDT)
Message-ID: <982a47a2-8340-a9e6-0a44-b132b94e0b52@redhat.com>
Date:   Wed, 15 Jun 2022 21:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] vboxsf: Directly use ida_alloc()/free()
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615062930.2893-1-liubo03@inspur.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220615062930.2893-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/15/22 08:29, Bo Liu wrote:
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  fs/vboxsf/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index d2f6df69f611..24ef7ddecf89 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		}
>  	}
>  
> -	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
> +	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
>  	if (sbi->bdi_id < 0) {
>  		err = sbi->bdi_id;
>  		goto fail_free;
> @@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	vboxsf_unmap_folder(sbi->root);
>  fail_free:
>  	if (sbi->bdi_id >= 0)
> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
>  	idr_destroy(&sbi->ino_idr);
> @@ -268,7 +268,7 @@ static void vboxsf_put_super(struct super_block *sb)
>  
>  	vboxsf_unmap_folder(sbi->root);
>  	if (sbi->bdi_id >= 0)
> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
>  

