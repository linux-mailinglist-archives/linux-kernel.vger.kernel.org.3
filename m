Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD158797D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHBI7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiHBI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9299DE81
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659430778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MQqUL0mybjOOLgRIVQsUeJkgad5ME8laUjqFvyJPCs=;
        b=VuZ/HGKal+mtpEgeJLFtZnryjG8p3W/MhKxfO8MnC5VeW+szMkfd4fjhZ8Kj0QtGVUMcTa
        uX/eKzN4cQ8nBrrn0dPslCgw9nY1kdEHquWK9Ohlcdnhqzg895B9Efr+Pj95lJS1nMlaQC
        jzkNw/vbBkvGor1jt1lHf1tyuOghWqY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-gQQs52hhNiaR-GIhZT7-YQ-1; Tue, 02 Aug 2022 04:59:36 -0400
X-MC-Unique: gQQs52hhNiaR-GIhZT7-YQ-1
Received: by mail-ej1-f69.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso264062ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6MQqUL0mybjOOLgRIVQsUeJkgad5ME8laUjqFvyJPCs=;
        b=ToOBn3GTtgyZyrJpTR4D16/Pagrj3YM3hSN1cHzIVEmoVSu9zBPgt20l69KTISkFi6
         5YnbuHXXdtx9RTry9e30IerHZbJMsGbUnPz4MWGijsCe1uejuEf69sFhwspXyacghwVv
         /GMNcMMjFK83OlCLpIjdTT3OQ7+HV2KD7KBjfaC1NEMB606YVVB8sAfowDNq7lzhdvMj
         wCDv/EimR9IgCW66hdGyG1n1NHa6cDLKHNoI/kiDvaHAHbDf1516+c9iQO9tQCqKe5cP
         gWl8TmQkcQ96k1gjvHYaD2lYtgzYtj+oOzxY8CMrcML4zbcsN9XJ+c5DhMX1cjiPwAKK
         EUXQ==
X-Gm-Message-State: ACgBeo2pOp0rJYmigOCUdUsVqyzkSNiFZjaS76OEzOGyeCTl/8HOynKZ
        +iqOBHh1WNuNiMVsSID1xA2OcNzg3DWeLaNUns/ER1zP510N6xesRAYfZ3NjTeOhTqGfEXXATy3
        5dZPwy23bB6bX0+/2SAEoA+0W
X-Received: by 2002:a17:906:ef90:b0:730:9af7:5702 with SMTP id ze16-20020a170906ef9000b007309af75702mr3470296ejb.107.1659430775135;
        Tue, 02 Aug 2022 01:59:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ag90gbUb5lOg4jO+d13erT7aUe+ctI2ejRiAU/9F51rP9BOtMPdRsY5gRFTqwjK+0er09dg==
X-Received: by 2002:a17:906:ef90:b0:730:9af7:5702 with SMTP id ze16-20020a170906ef9000b007309af75702mr3470284ejb.107.1659430774933;
        Tue, 02 Aug 2022 01:59:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ft6-20020a170907800600b007263481a43fsm6020946ejc.81.2022.08.02.01.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:59:34 -0700 (PDT)
Message-ID: <efaa69fc-2402-9cc4-f7c8-86d6a93c6b02@redhat.com>
Date:   Tue, 2 Aug 2022 10:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging/rtl8723bs/core: remove inactive initialization
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, gregkh@linuxfoundation.org,
        sevinj.aghayeva@gmail.com, fabioaiuto83@gmail.com,
        duoming@zju.edu.cn, keescook@chromium.org
Cc:     straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220802012513.2824-1-zeming@nfschina.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220802012513.2824-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/2/22 03:25, Li zeming wrote:
> The allocation address of the psta pointer variable is first performed
> in the function, no initialization assignment is required, and no
> invalid pointer will appear.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index f2242cf2dfb4..6498fd17e1d3 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2521,7 +2521,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
>  {
>  	u8 issued;
>  	int priority;
> -	struct sta_info *psta = NULL;
> +	struct sta_info *psta;
>  	struct ht_priv *phtpriv;
>  	struct pkt_attrib *pattrib = &pxmitframe->attrib;
>  	s32 bmcst = IS_MCAST(pattrib->ra);

