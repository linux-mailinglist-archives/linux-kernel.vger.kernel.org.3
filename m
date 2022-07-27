Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38795583256
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiG0StV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiG0Ssz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:48:55 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F961260CD;
        Wed, 27 Jul 2022 10:46:07 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id w7so16659362ply.12;
        Wed, 27 Jul 2022 10:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CwHqZsQfdL6ooK+MOwY7nrJScksY8RWLMqEZaytjzK0=;
        b=cz3sFRO1jxSm/mLffRrbfLLKiG/tk61dlyAySmSXNfIu0GJnTvvA6+qILxcpm87Sd7
         c06NkD/WlIswcLEuSgUV6XlcUeXsj0RO8APAtREveIDI7c8OLT8FuqJC09tmKRhQkCOH
         IWeoWU898s0a7XaOLBJzirXMUXEEQqsr+p7WnzYcU0IoC5Sxsqv622BtXl5Uf0BOeIP1
         fhOh3YO8yqBh7YZWzfO8gOQvJUP7VOYeC4pRb8g2TegnOQDmFYf2+Fuf4Uwzg9s3NOw9
         c1G2SEeGKBvYHjZEEdlrG5MNLg1EpKWFTsOjkoJ7oeY7MZC5e3+7QooiM6Orj8sZWF/b
         NlNw==
X-Gm-Message-State: AJIora8pH6omqsXRk66Zi5I9B6aFeIeUa65m5M5R6KoCeEQpMSF4ghVl
        611crlh/oXLo9qihuqDlPAoyzeV2nZM=
X-Google-Smtp-Source: AGRyM1vSdws9gGiQL0MNT6VJGOpjq4fCaomo+H2LUi3A0HUnX/5tYnyPjkQq/6Z35NsnjRRsPH0wkg==
X-Received: by 2002:a17:902:bd47:b0:16a:71a4:9bfd with SMTP id b7-20020a170902bd4700b0016a71a49bfdmr22888898plx.109.1658943966412;
        Wed, 27 Jul 2022 10:46:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id lb18-20020a17090b4a5200b001f09d9b6673sm2139261pjb.7.2022.07.27.10.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:46:05 -0700 (PDT)
Message-ID: <a09de6e0-700b-0715-06a8-150ab41e8e7f@acm.org>
Date:   Wed, 27 Jul 2022 10:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     Chetan C R <quic_cchinnad@quicinc.com>, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
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

On 7/27/22 01:28, Chetan C R wrote:
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 90226f7..9d2f84e 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -9,6 +9,7 @@ menuconfig SCSI_UFSHCD
>   	select PM_DEVFREQ
>   	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>   	select NLS
> +	select UFS_QCOM_CMDLINE if ARCH_QCOM
>   	help
>   	  Enables support for UFS (Universal Flash Storage) host controllers.
>   	  A UFS host controller is an electronic component that is able to

[ ... ]

> +__setup("androidboot.bootdevice=", get_android_boot_dev_v3);

How can this work since __setup() declarations should occur in the core 
kernel and since the ufshcd driver can be built as a kernel module?

Thanks,

Bart.
