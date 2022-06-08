Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B56543A66
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiFHR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiFHR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:28:09 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8213586C;
        Wed,  8 Jun 2022 10:26:43 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id f65so9329940pgc.7;
        Wed, 08 Jun 2022 10:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vdq4x2cK2Kxb7bPLAXT0rRqzYQf9uH8WQ9IJlchFrLc=;
        b=jRFKiT1kHAmJTYJo2KyTn5ixFFyDjuFa6fxsl1WNSKLzhgNMDMOAi6WTiuKex7secK
         O6Gd/25v/L9ZGBaw3PJHmWaOZoWfKq+6z4Y4gU25o8vz/XIQuPEIbTs2oah4IP/+Xs3R
         mwe7tNnruEIRRzH/xAjbSaS5DU8a0x31WFh2UbNKZBYusnp4byTSIq9wyGmli/T/gtEr
         md6BytTdEaK8ss4WC5+529einlHqxdK3qCO3RZgBqIOIpT3l8DZlqZ1kcB04U3kQEwH7
         RbBsHsMxATaWjuqn/fSKEuF6rXGwgvzl9ZYMD628qvcYgL1bJrP9wcEUAP4VmnyPsSqV
         5Lqw==
X-Gm-Message-State: AOAM531RTOV1FyEIOHqez0JU1MEJTzS2fW5eq5woT6oYsPjKhMfviyVQ
        /VcVzxXcJsYH9w0Mzd3z5/0=
X-Google-Smtp-Source: ABdhPJy2XkL1wjH+iK3e6e2Hx2QMmfgjTy/wyGK/xCsPzQDJHM5fZRi20ssFAqNOW/TkC9QwcpHNxQ==
X-Received: by 2002:a05:6a00:1344:b0:51b:ed0d:dbbd with SMTP id k4-20020a056a00134400b0051bed0ddbbdmr26197497pfu.45.1654709202923;
        Wed, 08 Jun 2022 10:26:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39? ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
        by smtp.gmail.com with ESMTPSA id p5-20020a62d005000000b0050dc762813csm3282490pfg.22.2022.06.08.10.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 10:26:42 -0700 (PDT)
Message-ID: <d7a72f92-15c9-1d58-c711-83c47444094e@acm.org>
Date:   Wed, 8 Jun 2022 10:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
        liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 02:30, John Garry via iommu wrote:
> +unsigned long iova_rcache_range(void)
> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}

My understanding is that iova cache entries may be smaller than 
IOVA_RANGE_CACHE_MAX_SIZE and hence that even if code that uses the DMA 
mapping API respects this limit that a cache miss can still happen.

Thanks,

Bart.
