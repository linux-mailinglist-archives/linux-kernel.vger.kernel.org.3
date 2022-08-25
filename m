Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D495A1B90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbiHYVrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiHYVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:45:49 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4AC2F87;
        Thu, 25 Aug 2022 14:45:12 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d12so926813plr.6;
        Thu, 25 Aug 2022 14:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lGNBkkp4BBDEjfSCq8/qdn5/LeotKxcjg6+Pkd51G6g=;
        b=fw7WX3t0mljUOYfMItQ9ZAi4Il5fTgPpijnMA+E6WYeWMrIagvMQ75nkJ7LcRi9fy3
         T8n1jUaJAhCre0WsEm950W6PidbraeAcpnJOu8Ki9d3b38XRX9GK/BoTQRxX6hHULq8U
         H8F7scvc+NK1xa7Y6sZ8KFUY5mdgyZ31xD5LcgtEPIvGTVTFV6Qw9TMYDjSlbJ9x8Ihi
         DOH4v3TXg4tx7yVvW0OqStYMsmSgyLWzslAYaXiqg5tJGpfa0hl3iwI9T47Bj4ybnaCL
         wmgckCtztJ62Z5hToQRyEUr8UgNcZawY+SPvF1HZR696TiKQS+X5N6h+xR6AKDOv5Pw5
         1A4Q==
X-Gm-Message-State: ACgBeo0kaqJMtl8Ggk70rOCzJR9U8moesuvJ8MnCs1OggWR0rHNCp+tE
        vQehv/vi5UdGALDTA3Wsc/c=
X-Google-Smtp-Source: AA6agR58tZ3AbGEr4+IDC4kJWx8+thB6yGtM5mk3JNCEDcPv9jIHtgQv1Iqu8vhglb6GJZCV3zC9Ag==
X-Received: by 2002:a17:903:2310:b0:173:10e1:3a76 with SMTP id d16-20020a170903231000b0017310e13a76mr991620plh.160.1661463909550;
        Thu, 25 Aug 2022 14:45:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id oe3-20020a17090b394300b001f5513f6fb9sm209053pjb.14.2022.08.25.14.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:45:08 -0700 (PDT)
Message-ID: <66c80b87-da28-bc9c-11c3-7a9f7354fa15@acm.org>
Date:   Thu, 25 Aug 2022 14:45:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121903eucas1p230518b312d5260d28e356ba911a27469@eucas1p2.samsung.com>
 <20220823121859.163903-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 05:18, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
> superfluous NULL check for request queue while we are at it.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.

It seems like a space is missing in the patch subject after the colon? 
Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
