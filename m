Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153184D9DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbiCOOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbiCOOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:34:53 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5F24586;
        Tue, 15 Mar 2022 07:33:37 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id a5so20000619pfv.2;
        Tue, 15 Mar 2022 07:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eQwF88zKGJNd0osI7kT3zN47aN665LOmHxpYhgazZW4=;
        b=apTv752JX/yFnToVj2RHAUg7DUj31hUeftoEFDePIhasDZ0rBoHZayCEaXdvxwbYlf
         UE/0oz++5cfLlcODibfdwVrEx0UzEcGpCAsgH7wVOOCY0vV6UxQglzPXN8IeyJP5r5qU
         CMFZRNH2Iz5vHn09Etl2yJtg7Cxpmcbdi+F5akUS33bGQWIiuTOqlq0pvZD3bD/jZd9y
         oTZwFTgbPZvk4xiByABn3Jnn/MFV60+HJ4tfuSfLE4rU/Nqa32jqb7whBBUQJXnvteos
         rFbKVBi+xOeUAoizqhMp3ubeR1Ery9M+AXH8fupPIAGefoLkPWnIkDvJRbyagSO8ibpj
         X2/w==
X-Gm-Message-State: AOAM532ZbXr0Hm++PXN2Y1dywVJcHHILOC/9A7yn1f97nKjz1SK4lDc0
        HRmYwAyHL0O2bOGd5yIg51o=
X-Google-Smtp-Source: ABdhPJxhD2Szkw0kyoPatvxJusEKW89tEb3gbRdR2T+xVPD6uCDt75xsIZh8M8tlIh2Ydw40EXIBYg==
X-Received: by 2002:aa7:859a:0:b0:4f6:aaa1:832f with SMTP id w26-20020aa7859a000000b004f6aaa1832fmr29029288pfn.9.1647354816634;
        Tue, 15 Mar 2022 07:33:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm3560418pjb.27.2022.03.15.07.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 07:33:36 -0700 (PDT)
Message-ID: <51c2d9da-a0c5-8ae5-5c22-ceb56c7f5a27@acm.org>
Date:   Tue, 15 Mar 2022 07:33:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, ming.lei@redhat.com, hch@lst.de,
        hare@suse.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.wilck@suse.com
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-2-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1647340746-17600-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 03:39, John Garry wrote:
> In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
> queue depth change"), the sbitmap for the device budget map may be
> reallocated after the slave device depth is configured.
> 
> When the sbitmap is reallocated we use the result from
> scsi_device_max_queue_depth() for the sbitmap size, but don't resize to
> match the actual device queue depth.
> 
> Fix by resizing the sbitmap after reallocating the budget sbitmap.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f4e6c68ac99e..2ef78083f1ef 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -223,6 +223,8 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>   	int ret;
>   	struct sbitmap sb_backup;
>   
> +	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
> +
>   	/*
>   	 * realloc if new shift is calculated, which is caused by setting
>   	 * up one new default queue depth after calling ->slave_configure
> @@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>   				scsi_device_max_queue_depth(sdev),
>   				new_shift, GFP_KERNEL,
>   				sdev->request_queue->node, false, true);
> +	if (!ret)
> +		sbitmap_resize(&sdev->budget_map, depth);

Hmm ... why to call both sbitmap_init_node() and sbitmap_resize() 
instead of combining both calls into a single call with the proper depth?

Thanks,

Bart.
