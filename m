Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4454D26B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbiFOUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiFOUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:18:36 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03AF3FBC2;
        Wed, 15 Jun 2022 13:18:34 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso3205742pjg.1;
        Wed, 15 Jun 2022 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SNU2ULTl0ChHoBmMMoN7qtu5qLqYyEFI2kUe8MWmWMo=;
        b=1xfuyiZ4pemCYDrGJtKD1a9VxOw53omwsE6kn6VIrTTdg9gH0CAEdVltY9xDuiHv5B
         G9ke1gSr4WIUbKOciFnLo1PAdO16w89Q5cnqt53UZBZ5NKH7jVJn053pqhZZtKLsKaEp
         +UyMX2ESpJbaeaUPRIZjplFHic6qYedpH0SH+OtueqoqCNnz6ViWNAMT2KNxiGpTRJpp
         +RmmKN+qB5dpfIP0m28CKD/JTgrOv44UaVdkSkKG6fWT25rBk+nTl89KBgikA3G+216J
         3FPRKqonQhD6SPH4FL8qZE3Ztd4SXGErjH6CRG5rutYz4Cc7GzCohlGcLJUa8oLMRyEV
         aJ5g==
X-Gm-Message-State: AJIora9wluUylGRSf/DKhfOSST2MZi1Q4i+qqZPJr+bbDOk48MfJVmXR
        X2z178FE5oJerCiWcqdogmc=
X-Google-Smtp-Source: AGRyM1s3xzzOdnqeKw+fkjDbJVScgIu0tZCo++/2yYCKrn2XJapgnfJfEXIAyvKCytnUw+BXN2cYHQ==
X-Received: by 2002:a17:902:9a97:b0:168:a97e:2457 with SMTP id w23-20020a1709029a9700b00168a97e2457mr1297905plp.33.1655324314284;
        Wed, 15 Jun 2022 13:18:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d88900b001663185e654sm8464plz.280.2022.06.15.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:18:33 -0700 (PDT)
Message-ID: <c2269e99-b832-1c00-a08b-14af3be4d76b@acm.org>
Date:   Wed, 15 Jun 2022 13:18:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH v7 01/13] block: make blkdev_nr_zones and
 blk_queue_zone_no generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec@eucas1p1.samsung.com>
 <20220615101920.329421-2-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615101920.329421-2-p.raghav@samsung.com>
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

On 6/15/22 03:19, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
