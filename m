Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F21543E38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiFHVHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFHVHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:07:11 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A32271A5;
        Wed,  8 Jun 2022 14:07:09 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id f65so9848086pgc.7;
        Wed, 08 Jun 2022 14:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ecb3buQLdnsK4f3qTJQfieUPfKbyWt/zyj1SzIvpTM=;
        b=GT/cb+ne0jcS2KxL5TzPds92fvJZ70ZbabYgMvnNXbAXohuhQC/fGOVk6sMfwGtNUs
         +C9UE3wJg8m/rnwID+LXlkyFPHL99M6kZZVx4L8T4AmeWK3JsvYgxerUxBTBUQQ1toTB
         Zsbk4QZBeuuWvZHTs1sNgrxJZUwUtlfTeBVPJzj5cLMwrqi+8vFzinrc3BCd/E6dYzBv
         +jFYhOVgcioBAOY2kyq5pQmzwPt906i4cSBI2I276gfR5OUxeleBP2PgatRTU5AWC5Tp
         Vrb/0/W0jw9FPtv3VzJXccMLG39CYwTO1CpCWWFDwf7ND/W8+pTIqP8Nt77ji1V1UWm0
         6Stw==
X-Gm-Message-State: AOAM533iN6PH7/ywhyIw1ZauyjPAjFCARqkO2RE8H2gclk9DDIlSurnE
        PE8bxeId5ZsEf9jGqQdHZeg=
X-Google-Smtp-Source: ABdhPJwGJ0nRHde8RTl6xYLYR29tSKmbbRXlGMXSsUmS5fgFGnp4YCile/NXrK4PxwLOOdGqsZyMzw==
X-Received: by 2002:a63:18b:0:b0:3fe:e54b:da15 with SMTP id 133-20020a63018b000000b003fee54bda15mr789973pgb.571.1654722428389;
        Wed, 08 Jun 2022 14:07:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39? ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902d29400b00161947ecc82sm15020395plc.199.2022.06.08.14.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 14:07:07 -0700 (PDT)
Message-ID: <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
Date:   Wed, 8 Jun 2022 14:07:05 -0700
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
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
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

On 6/8/22 10:50, John Garry wrote:
> Please note that this limit only applies if we have an IOMMU enabled for 
> the scsi host dma device. Otherwise we are limited by dma direct or 
> swiotlb max mapping size, as before.

SCSI host bus adapters that support 64-bit DMA may support much larger 
transfer sizes than 128 KiB.

Thanks,

Bart.

