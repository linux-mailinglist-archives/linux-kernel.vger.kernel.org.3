Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE84931F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbiASAkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:40:39 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43959 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:40:38 -0500
Received: by mail-pf1-f178.google.com with SMTP id 78so897298pfu.10;
        Tue, 18 Jan 2022 16:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y1bB9qyB9ag+6vVeCbo5dc/vKI8cQJOaLo3No5lo+P8=;
        b=nFktyUeZe2dimPnhcBmfxGMeVDN0egPAjVC6dYLCiOq507ZkdflG+vozxy2cL8/bUc
         bfkdhD1HGwUi/BgITtLH93O93yl+SHYxOaTTYW+UkonnuiNzOB1vbWbL2/aKHSPfIwYS
         vZgXRikX5POcYINrbLJlaF9pB3p3arl4p0X9UZKBr1UeRgtpeNT1YrVu7Hnrf7h6+ojc
         u3gNY36CQBH15FWwT49+ZuFWUu8oEmpwX0Opj1zgUph+icA6C8s0P+Uao8QjkQC43mwc
         pPbIjYQ/e3C7tK/GueUB2nWLel8Uuk1q2EwEwYs2x5zUcPNjhAex6Oa16ZjEeXWQ3/dc
         4KEg==
X-Gm-Message-State: AOAM532uwS1QYb4vcWuIl/JQLtmD42Zey5xtRLRHaKqXFDadgzvMDtMW
        ft7I2BJzN9/CsghB1eGrVFM=
X-Google-Smtp-Source: ABdhPJyoQQyu2Kg3q/7UKht4R4f/SQHNde7SFhs3HlxWVBvjcMqUU9INJhDiOzzaGyx/xetX8i19lA==
X-Received: by 2002:a62:b503:0:b0:4bc:657e:cfa6 with SMTP id y3-20020a62b503000000b004bc657ecfa6mr28067825pfe.25.1642552837400;
        Tue, 18 Jan 2022 16:40:37 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id q18sm19461083pfn.50.2022.01.18.16.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 16:40:36 -0800 (PST)
Message-ID: <f68bd8fa-e848-df11-1493-aff82911eb2c@acm.org>
Date:   Tue, 18 Jan 2022 16:40:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] scsi: ufs: see link lost as fatal
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220117103912epcas2p41c5d54a9242e46264c4e388a1db27f6b@epcas2p4.samsung.com>
 <1642415846-141110-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1642415846-141110-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 02:37, Kiwoong Kim wrote:
> This event is raised when link is lost as specified
> in UFSHCI spec. At the time, initializing UFS interface
> needs to be done.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/scsi/ufs/ufshci.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
> index 6a295c8..a7ff0e5 100644
> --- a/drivers/scsi/ufs/ufshci.h
> +++ b/drivers/scsi/ufs/ufshci.h
> @@ -142,7 +142,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
>   #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
>   				CONTROLLER_FATAL_ERROR |\
>   				SYSTEM_BUS_FATAL_ERROR |\
> -				CRYPTO_ENGINE_FATAL_ERROR)
> +				CRYPTO_ENGINE_FATAL_ERROR |\
> +				UIC_LINK_LOST)
>   
>   /* HCS - Host Controller Status 30h */
>   #define DEVICE_PRESENT				0x1

A patch description should not only explain what is changed but also why
a change is being made. Will the above patch cause the UFS error handler
to trigger a controller reset after the link has been lost? I'm missing
an explanation of why that change is necessary and also of why that
change is the right thing to do. All I found in the UFSHCI specification
about link loss is the following: "UIC Link Lost Status Enable (ULLSE): 
When set and IS.ULLS is set, the controller shall generate an 
interrupt." and also "UIC Link Lost Status (ULLS): This indicates a 
condition where remote end is trying to reestablish a link and the link 
is lost. This bit corresponds to the UniPro DME_LINKLOST.ind SAP primitive."

Did I perhaps overlook something?

Thanks,

Bart.
