Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94ED5426C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiFHBz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587310AbiFGXxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:02 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FB2945E5;
        Tue,  7 Jun 2022 15:44:00 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so5942877pjg.5;
        Tue, 07 Jun 2022 15:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w8NDUBo3z6UDbWsc/XByX6YF7c4oG4yuYC7oAUnBsYY=;
        b=wmJNHrZm8vt1N3Fna/3p1FnnVcRuFZZyEy/21hgX49HizjQ9yvZQ53zCvdetoUatVE
         432zbmPjCUDVtLHXgY6WF2Ivztymj8hl6NqWHXa0mPQ4iQOpCLXwCcnMrFzcSmNGbQaj
         8ofK7SluYbs2cnAC1+h/0f/MXzhSLGBygpi5nXuTQMwJyBfiHKPPiBpWunGlpXEtGtHq
         Rj6CYPjj+W1C3sn6g3YobF9ktE01x9ja+yy1MBf2Hf8VGzfoWRBGu6EGXIHFUpNPOUZC
         IvqdeEoJTm/U1gyCG1ieunVWZO9WkxDZuNEbPl8v7osYuJMLlkesJi5fx4Ju5P8WT+2m
         +kWQ==
X-Gm-Message-State: AOAM532+nFS/mMnENlXByKy9Bdh+4jxEPPf5bKLS8/I9CvOyGLk/OQUm
        aN3qzw6VPJeJUd3HbFFRT3Q=
X-Google-Smtp-Source: ABdhPJyerYGytLfJP4UmMuvbsKpIxNlss+3u6Myd9djlsW8ZEBq2xQNYIWDPe/Kqg6qSLUHDPa8PZg==
X-Received: by 2002:a17:902:7088:b0:167:78c0:e05e with SMTP id z8-20020a170902708800b0016778c0e05emr13533905plk.149.1654641824895;
        Tue, 07 Jun 2022 15:43:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e794:fbe6:94b0:435b? ([2620:15c:211:201:e794:fbe6:94b0:435b])
        by smtp.gmail.com with ESMTPSA id v11-20020a62a50b000000b0051ba97b788bsm13451064pfm.27.2022.06.07.15.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:43:44 -0700 (PDT)
Message-ID: <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
Date:   Tue, 7 Jun 2022 15:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/4] DMA mapping changes for SCSI core
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
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
> As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA caching
> limit may see a big performance hit.
> 
> This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
> that drivers may know this limit when performance is a factor in the
> mapping.
> 
> Robin didn't like using dma_max_mapping_size() for this [1].
> 
> The SCSI core code is modified to use this limit.
> 
> I also added a patch for libata-scsi as it does not currently honour the
> shost max_sectors limit.
> 
> Note: Christoph has previously kindly offered to take this series via the
>        dma-mapping tree, so I think that we just need an ack from the
>        IOMMU guys now.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-iommu/f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com/

Regarding [0], that patch reverts commit 4e89dce72521 ("iommu/iova: 
Retry from last rb tree node if iova search fails"). Reading the 
description of that patch, it seems to me that the iova allocator can be 
improved. Shouldn't the iova allocator be improved such that we don't 
need this patch series? There are algorithms that handle fragmentation 
much better than the current iova allocator algorithm, e.g. the 
https://en.wikipedia.org/wiki/Buddy_memory_allocation algorithm.

Thanks,

Bart.
