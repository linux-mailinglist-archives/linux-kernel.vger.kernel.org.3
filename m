Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047BC501853
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiDNQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349744AbiDNP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:03 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEAA9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:40:25 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 1-20020a4a0901000000b003296ea2104eso931683ooa.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxYLdrXWJE+/+Zz2EhxEDTAaegDNnJy+1F4w0yBl53Y=;
        b=dZBkjodGez89buTH1gyFgngXJ0IvQWc1Kp9/9a5K2v12eZGmLXXBoxxUZHoBMF8HyR
         JckFvG0ogFppisRohAHNlkmWUuhvkyrvqs4xQm1vr7Whzt95NVeWYvaooQByt7rBZf7e
         O8Ty8uE2TOVazMExFJFdYjEYwyQTYAR0Yyvg624tXENPutQJSet9FWrF77ingV4g/0l0
         Tf04kmHimboCvu+5KeMpXglKGE1QoAsDaFH+ikvdKqJXKuL8rbUH1N3YcIrc3EVqGynE
         8OqZ+1d2HQxAjexPDZYjEa/DMDFj8Hb0BCqs35ZyxxThFnkr79sWqlb2jPjobSFScg+Q
         9PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxYLdrXWJE+/+Zz2EhxEDTAaegDNnJy+1F4w0yBl53Y=;
        b=ByB7HfTtI2G/U0YWDRl09bEftRd6+is6eANCS+FYa2izqadu2zQXetDs+hWeA9x7T5
         yQIlD7lPdVPNhtzVHC4uUMWLhjp0NMtrnvUzaCyK4kXgJUBvbmbeEGya4bUj2ROyy7i7
         TZmvXezw0QgEymOLvTLVmG+u2OhvX7gP9Itux9onuViVFcsRe3OWJshOc67mLw2QrBHp
         bTzTdAMuB9lnI5dYF19F+JIjmxyFrMhPpaiszPssaEcWFoPSaQs/jY2GMo9diYbr6PNP
         FX9yd/1WZ8oZeAmOicURYmaumorw1EMt/fN2GpESfyHDpeQWobfTNgUz6C9Xbk7LjDXb
         UL+w==
X-Gm-Message-State: AOAM531s+AzB+SVt3H669ymf9c3PXg5XOrUAAs0qtULFrLC76YqwbROx
        F8YweWz2Py5NWgopvy6+VLw=
X-Google-Smtp-Source: ABdhPJz+pFFarBMLATEHy2Xb9FQsgUBKBC8Sm9O31ONwEXjo0RLGJwrRI1n9JsCR2nfI9Z8C6UWntw==
X-Received: by 2002:a05:6820:515:b0:328:fdb2:5344 with SMTP id m21-20020a056820051500b00328fdb25344mr938826ooj.54.1649950824719;
        Thu, 14 Apr 2022 08:40:24 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id bn41-20020a056808232900b003222f6e2ae8sm124050oib.29.2022.04.14.08.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:40:24 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3e8ba74a-9527-6c1f-7a59-539360735a3a@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:40:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/7] staging: r8188eu: check firmware header existence
 before access
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
 <20220414083853.3422-8-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220414083853.3422-8-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 03:38, Michael Straube wrote:
> We should access the fields of fwhdr only if the check for firmware
> header existence is true. Move the affected code into the if block
> that checks firmware header existence.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> Do we need the IS_FW_HEADER_EXIST(fwhdr) check at all?
> The header _does_ exist in rtl8188eufw.bin and it's very
> unlikely that it ever changes _and_ the header will be
> removed.
> 
>   drivers/staging/r8188eu/core/rtw_fw.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index 64963507a346..c58bce1a1856 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -249,14 +249,13 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>   	fw_data = dvobj->firmware.data;
>   	fw_size = dvobj->firmware.size;
>   
> -	/*  To Check Fw header. Added by tynli. 2009.12.04. */
>   	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
>   
> -	pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
> -		DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
> -		le16_to_cpu(fwhdr->signature));
> -
>   	if (IS_FW_HEADER_EXIST(fwhdr)) {
> +		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
> +			DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
> +			le16_to_cpu(fwhdr->signature));
> +
>   		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
>   		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
>   	}

You can probably remove the IS_FW_HEADER_EXIST macro, but please restore the 
guard against logging the version more than once.

Larry

