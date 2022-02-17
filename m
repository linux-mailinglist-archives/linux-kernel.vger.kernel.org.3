Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422A4BA3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiBQOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiBQOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E8D71F5C91
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645109695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+CI1qPD5M4rhBxpRSCy0aUrExW3/wsAoTsjWZYSmuc=;
        b=i+X36+bDGTZrTlzvFrAAOBRXIy60bhrQjcjTCS9YcwCug/udSYhk2oXn4cl2cTuPsPfOZp
        1JGiPFhrXF0w7h3EtNnK2Bk1Ddr8kGJMjoroCryYS53YYtaslURyZPSxrLZSPTDRqU8WZW
        dSWj/7L/zu8LujK+kgl6/bs+ElKBfcY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-D2DY0eJcMEeR5jxRN2CliQ-1; Thu, 17 Feb 2022 09:54:51 -0500
X-MC-Unique: D2DY0eJcMEeR5jxRN2CliQ-1
Received: by mail-ej1-f69.google.com with SMTP id k21-20020a1709063e1500b006d0777c06d6so727310eji.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/+CI1qPD5M4rhBxpRSCy0aUrExW3/wsAoTsjWZYSmuc=;
        b=35yq36AE5xBK4DXO6q5WkO2rDMIQb3sH9s30RdgAregkQc252N1rujwNKqYXw3DIiJ
         71slOz8pS3DAm/L+bvdacVXK/bG/1gSOulElsR6vBmSKOn/TNjqIrzH+pyEq3M+Q/ukI
         aVqT6b2XuZNuwG0sSXso4jRqVUiRikY6Qfn6IPq43Q6HuUSAZgHm9/GqK29/C3Xx7HrN
         +hw0nappxnPmzEhm+38q8nkX27mh3O0uBLbFKTJ7uIMxWFNyYjuMqcox9QMzfoi5bhJN
         ff7CIExthqNfZj5giO5gsktkq28XRjpwIDsFxavkjvHc1QW4L+rmo4LLcQ8VrEMz6ti0
         y8hg==
X-Gm-Message-State: AOAM532rtd8fAAfRvjF36ILwZKLjhr8j2/o2G4rIs/piLGgjWV2tUUmo
        o4LuyOfUieZF+4VqnRQ+lIqVY9Sx6ufTBiAByeiTb5dJ6XlXxL6v0DTrWBrzlNsBNnvTPDgUdm6
        j3zuVtsSjjoioG8FA3+GMUTu1
X-Received: by 2002:a17:907:77c7:b0:6b7:98f2:6fa2 with SMTP id kz7-20020a17090777c700b006b798f26fa2mr2579122ejc.541.1645109689944;
        Thu, 17 Feb 2022 06:54:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBOb5FoSmtHAMkCHvIMm9oAk04ZTkWPmt1GX0fgxIWCjBK3S9qFHCZgWyteoo9/7xu0SwUNw==
X-Received: by 2002:a17:907:77c7:b0:6b7:98f2:6fa2 with SMTP id kz7-20020a17090777c700b006b798f26fa2mr2579108ejc.541.1645109689720;
        Thu, 17 Feb 2022 06:54:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id hs25sm1256788ejc.172.2022.02.17.06.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:54:49 -0800 (PST)
Message-ID: <d255cff2-08ff-3173-aac6-0abcd2a8bc57@redhat.com>
Date:   Thu, 17 Feb 2022 15:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/dcdbas: move EXPORT_SYMBOL after function
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mark Gross <markgross@kernel.org>
References: <20220212125908.357588-1-mat.jonczyk@o2.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220212125908.357588-1-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/12/22 13:59, Mateusz Jończyk wrote:
> The declaration
>         EXPORT_SYMBOL(dcdbas_smi_request);
> was placed after smi_request_store(), which made a false impression that
> dcdbas_smi_request() was not exported.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/dell/dcdbas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
> index 5e63d6225048..db3633fafbd5 100644
> --- a/drivers/platform/x86/dell/dcdbas.c
> +++ b/drivers/platform/x86/dell/dcdbas.c
> @@ -284,6 +284,7 @@ int dcdbas_smi_request(struct smi_cmd *smi_cmd)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(dcdbas_smi_request);
>  
>  /**
>   * smi_request_store:
> @@ -351,7 +352,6 @@ static ssize_t smi_request_store(struct device *dev,
>  	mutex_unlock(&smi_data_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL(dcdbas_smi_request);
>  
>  /**
>   * host_control_smi: generate host control SMI
> 

