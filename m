Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C60543A86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiFHRdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiFHRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:33:30 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615D262;
        Wed,  8 Jun 2022 10:33:29 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id n18so18238043plg.5;
        Wed, 08 Jun 2022 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=URIZCp/jWQNLisOjE8f9wYPe1lbI6/tMNbNejKjnaZ4=;
        b=lzGzqmwl6VU+mZZ7frpQ/BD/+BZh+cPqF9BLBHqMuIfiSIPx5qv8xw8N/8eW6zdPe+
         +abix3stO3x1VqcgKEk/KKhc9UyS0xRHR5rl3/9zMwoDn1l9e+PYK3wbqDrEAdVMzGrr
         DJ+H0YADbxOXrHD98ci4X3I8tTRQssvyKSGEJG1K4AfT2D01poOu1wpZN0YUMACuVWLV
         So0X2TqDojWxvw+fj7AFWQrYaeNNyMk1ZPdkXAlZVGYUtUMBp3dfPzbaIR7d+ug4G0Cy
         C5OGtFxXZ15IHH161TfnHcUvgC0OWVG9K7QcW8k4xQe+TuEyTQnHseMvg4AVPAYiKwAp
         k2PA==
X-Gm-Message-State: AOAM530bJezeTtIzOJ75zPyey0DN5LQ9RdnnTzSpBUBVSD9isTfNEYyD
        ZrXb6RaR1CoJt9uvRg62q+akuEvk+2c=
X-Google-Smtp-Source: ABdhPJyg/AK8j680Ym1MLmXvtMNO7idwCDt0mxe0LmDZt+QIharawT9S6BKDFL1MLiFHnWCay3fYlA==
X-Received: by 2002:a17:902:7886:b0:167:5c8c:4d3e with SMTP id q6-20020a170902788600b001675c8c4d3emr24496557pll.74.1654709608885;
        Wed, 08 Jun 2022 10:33:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39? ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b0015e8d4eb28esm15055558plb.216.2022.06.08.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 10:33:28 -0700 (PDT)
Message-ID: <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
Date:   Wed, 8 Jun 2022 10:33:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-4-git-send-email-john.garry@huawei.com>
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

On 6/6/22 02:30, John Garry wrote:
> +	if (dma_dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Since IOVA_RANGE_CACHE_MAX_SIZE = 6 this limits max_sectors to 2**6 * 
PAGE_SIZE or 256 KiB if the page size is 4 KiB. I think that's too 
small. Some (SRP) storage arrays require much larger transfers to 
achieve optimal performance.

Thanks,

Bart.
