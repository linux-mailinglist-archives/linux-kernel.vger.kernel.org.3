Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F85140EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiD2DqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiD2DqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:46:17 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6E5F8F6;
        Thu, 28 Apr 2022 20:43:00 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id h12so6035315plf.12;
        Thu, 28 Apr 2022 20:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Bocyk6UeHmbUdYH1atVHF1u7NFW1/yOGUdCkKj/Jt0=;
        b=gldlARu92UdVfc6IEiVkVs3eMa8AEu+yfkOffjx4WX7bU0GLJ6KSn7lPj2zBsJM+nK
         1Kg/iRbCHOAJVATUKVFVu4jS0qY9jcyxa8+Gdmrg+BuUniEdY/jUUUANVGoUIXqkQ5ir
         47eW/RpgTYCII02jkMPfTDsxMGEv3l9ASabVH05yANPPz+BdRcUQxeDrYTjQlEs43I+q
         LiQhLyyf4O6CCERvMd7IqaRs0fMi5Xg4tyqvFshDPY7kKrS87iXwtOEM6khXu1BK2WgR
         BtGINsYJBTKQLopS4JJcLaobCkkOjCQugySeWfBhq+k20p7ly//i27r92AXnWmV3PWnl
         Y8TA==
X-Gm-Message-State: AOAM531ugQoNRFIFuSacGA5GXsnMUn6A2cxhNOH0OGcXvCzEHsICTNLP
        262P3/T+eEfJ6jyxL2tHBZ6da00Mw+k=
X-Google-Smtp-Source: ABdhPJzxG+eSxWkJUyJ8WGehfL1elb1as2Q5a+S9OH93/8uTWP6sQ6AffLQgj5WSL1CkDvZKFQXsYg==
X-Received: by 2002:a17:903:110c:b0:153:1293:5624 with SMTP id n12-20020a170903110c00b0015312935624mr36702064plh.149.1651203780122;
        Thu, 28 Apr 2022 20:43:00 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm1241994pfi.61.2022.04.28.20.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 20:42:59 -0700 (PDT)
Message-ID: <cefa5154-137c-9fc7-25cb-49bd47fd1710@acm.org>
Date:   Thu, 28 Apr 2022 20:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi: pmcraid: convert sysfs snprintf to sysfs_emit
Content-Language: en-US
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220428070245.255827-1-zhangxuezhi1@coolpad.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220428070245.255827-1-zhangxuezhi1@coolpad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 00:02, Xuezhi Zhang wrote:
> Fix the following coccicheck warnings:
> drivers/scsi/pmcraid.c:3591:8-16:
> WARNING: use scnprintf or sprintf
> drivers/scsi/pmcraid.c:3557:8-16:
> WARNING: use scnprintf or sprintf
> drivers/scsi/pmcraid.c:3496:8-16:
> WARNING: use scnprintf or sprintf

I'm not sure the above is sufficient as motivation for this patch. The 
current code looks fine to me. Why to change the snprintf() calls into 
sysfs_emit() calls?

> @@ -3554,8 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
>   	char *buf
>   )
>   {
> -	return snprintf(buf, PAGE_SIZE, "version: %s\n",
> -			PMCRAID_DRIVER_VERSION);
> +	return sysfs_emt(buf, "version: %s\n", PMCRAID_DRIVER_VERSION);
>   }

Something tells me that this patch has not been tested at all - not even 
compile tested. Are you perhaps checking whether it is possible to get a 
broken patch in the kernel tree?

Bart.
