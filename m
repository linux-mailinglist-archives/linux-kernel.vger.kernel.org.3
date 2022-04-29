Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE4514935
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359114AbiD2M1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359109AbiD2M1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75808C8BFE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651235038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq/HGTUEuDIYvjQxG6tT1C9QioXwhYqdZIKb2HytgqY=;
        b=CpGSxQjB3BlFo58IbznHBT8vcwAaz1eATGhVhM/s/EbD8EgQk6R0beJo+DQMnNBQKkgrog
        EGnxHV0PIFLwN3Jw1OYKkWhobFR549LxYTTAZTBB1bVZKePI/RIErkCpYWBgJA0K22pohC
        J9b706LgBBwMdscXEPr38L/PzunmmmI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-8R4og1O2OD28WWaKXIhyPg-1; Fri, 29 Apr 2022 08:23:57 -0400
X-MC-Unique: 8R4og1O2OD28WWaKXIhyPg-1
Received: by mail-qt1-f200.google.com with SMTP id b11-20020ac85bcb000000b002f398ecec5fso398704qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Iq/HGTUEuDIYvjQxG6tT1C9QioXwhYqdZIKb2HytgqY=;
        b=rRo0ei/E7Z7kbyQVVrao7O+8XXkw+HZtzICPXalMn7JDoyxy9IQIlTUmOSFW3JXbsv
         FHLebZ248zlwQ8zJYGMHuq/C9AR6IQMlz1Crydw/niIAakslRs96qEf47IwbLinpr9Kp
         Dmv6txJeYf9GfC6MbcXSfvSQZjuA7Ws91uPYjSmFkOINbMnl5xRutzx4u52zpnpTkgLh
         2GbBaONHcK5g4MfKbMFLDdjJvr2r1kHrcNrVMEol1TEl3Zv0piIN7+Gyt78X1zn4yWoW
         O4cwsN3I1OCnvPhyqalOOwlSBndJjEXXKc97UtJpofrG6SraKy0WhiDB9DeDqlVFnqsZ
         UNhQ==
X-Gm-Message-State: AOAM533p9TeW8o34Sdf7wuQh4jyVq8bEzWJ9MNeehDX/53EcBml1tewO
        8dm1XSBhwLfi93W+Y38ImqLgna4QVsO5EprKa/wgE4qTP5trXGVTgzYtRJKDcLOFRqnX/1baUC2
        n7xvn4UvXtZ9oFafsPHc69CQl
X-Received: by 2002:a37:ba04:0:b0:69f:840c:b627 with SMTP id k4-20020a37ba04000000b0069f840cb627mr9937308qkf.285.1651235036849;
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLIVdcXV1WqPzHlKJQANOcMOIrySvK7nYoaSfktcl+h9wZ9APF5knDfmrgNGkIJnQhWjWzag==
X-Received: by 2002:a37:ba04:0:b0:69f:840c:b627 with SMTP id k4-20020a37ba04000000b0069f840cb627mr9937301qkf.285.1651235036659;
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm1473751qtk.37.2022.04.29.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:23:56 -0700 (PDT)
Subject: Re: [PATCH v3] uio: dfl: add HSSI subsystem feature id
To:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220429005726.607804-1-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
Date:   Fri, 29 Apr 2022 05:23:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220429005726.607804-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/28/22 5:57 PM, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add the Device Feature List (DFL) feature id for the
> High Speed Serial Interface (HSSI) Subsystem to the
> table of ids supported by the uio_dfl driver.
>
> The HSSI Subsystem is a configurable set of IP blocks
> to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
> Like the Ethernet group used by the N3000 card, the HSSI
> Subsystem does not fully implement a network device from
> a Linux netdev perspective and is controlled and monitored
> from user space software via the uio interface.

Generally you should include the url for the dfl definitions.

Can you add it here to the commit log ?

Otherwise fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3: change the name of this feature id to HSSI_SUBSYS and rewrite
>      the git message.
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>   drivers/uio/uio_dfl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..8f39cc8bb034 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>   }
>   
>   #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
>   
>   static const struct dfl_device_id uio_dfl_ids[] = {
>   	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);

