Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE2589108
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiHCRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiHCRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:11:16 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5E1583D;
        Wed,  3 Aug 2022 10:11:15 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so2769001pjf.5;
        Wed, 03 Aug 2022 10:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o2afx9aZmzEdoWwdGDbShaY9b54ZclDxz5tctOo//Fo=;
        b=7El/DZvJBhohLBUeCWp+TnY6nsmiBglx8zHtDWHe/Pnc6kuxuM1Z+e+fsYH/9djQ8n
         wtkd3BT5RxWphmBszVVkCAOF4Aq0p4yAmJ0p0bLcORatEKCzmFgjylhWJHogD1wkenU7
         jyg+xY+WfkIOe+u0372pZL6NDtSEKJ9qQ67Jh3UGRMq9Ul6fgfuGzz/+cf0Of1C8AAEJ
         UoKBdDhQ45gD9efTHHvuM71OEwjq4VeIzWqkhDEK+H0f7WO1iMnXqEPvIYm+i1VL7iqz
         T17gR1mCUWf7TG3sLSgL7FTVcv9lipPubaPfoL6AL51DABhhCQ1YD0ywDMqolztmAWpy
         W/aw==
X-Gm-Message-State: ACgBeo3iBRIF6mBUDhTmYuQDVMVjsvmIk3Y7JrO/JSkmONRN41fYAXUR
        H1TENxdZJxp+w2spOF5ZisyutG8njHwQTA==
X-Google-Smtp-Source: AA6agR6EBIzKze1/rFrYedIXXEbWGppFAk1TLH0M11oAyd1FFJw2h6QmbM00Fe9GucsJfuqW4gRWhw==
X-Received: by 2002:a17:903:245:b0:16b:9c49:6b1c with SMTP id j5-20020a170903024500b0016b9c496b1cmr26089750plh.153.1659546675071;
        Wed, 03 Aug 2022 10:11:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id w127-20020a623085000000b0052df34124b4sm3552742pfw.84.2022.08.03.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:11:14 -0700 (PDT)
Message-ID: <d091dcf8-ce01-06cb-bff0-b41a5bb1ee86@acm.org>
Date:   Wed, 3 Aug 2022 10:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 02/13] block:rearrange bdev_{is_zoned,
 zone_sectors, get_queue} helpers in blkdev.h
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jaegeuk@kernel.org, matias.bjorling@wdc.com
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803@eucas1p1.samsung.com>
 <20220803094801.177490-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-3-p.raghav@samsung.com>
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

On 8/3/22 02:47, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
