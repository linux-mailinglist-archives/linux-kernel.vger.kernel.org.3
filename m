Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFB589121
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiHCRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiHCRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:18:48 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF5A53D25;
        Wed,  3 Aug 2022 10:18:45 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id s206so15705857pgs.3;
        Wed, 03 Aug 2022 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TwJQ/yYNiTQ3gXYdp9ajvzFbzU+GLcBJYBbzELtb76o=;
        b=s1/LhoPkyIuCHoYXtI0/xSzZG6Y20M1bKWO9hMpP3Zz0CucvG8VrMsc2A6BOZaJWxq
         OPIQHEtNgtXes0r8DNEy6n9KvnU0UMfo8gaoupIyzqkULbUrYfClyfjwlvJpIaNLh94X
         l/1KdlIlNlRQIYXR2U8BK36DHo08q6y9nngUN2cgYGYLiiCMgqIzE/9Nj/+ABSFTEQSj
         lrCj1Ta9PrYvHkHLyDkwHOJ+M5q3OJH/bhUZOPQtklnsroFY37kqwjNC5cUI5vmTzGuR
         FxuKV5BHDXBSFeYa1tvKRUympIhkvBaoIS/12fzaIBk0+eJJ6DYYd2xJHd2IkMWdp7A0
         eqOw==
X-Gm-Message-State: ACgBeo1FtTgc7SmHlsWZtjPsi0N86T3Z9sJ1B6Mb/6SX6ci+d81UUijr
        AnAIGdL0eKUC+11UNfEOwWU=
X-Google-Smtp-Source: AGRyM1ut0iw8ACYHFdssYF1RXnkAJwY8ims1WoIWh5sfrKcVetqVvRyv8YyN43reQB04YYQHCbVNEQ==
X-Received: by 2002:a05:6a00:3392:b0:52b:4896:b317 with SMTP id cm18-20020a056a00339200b0052b4896b317mr27047195pfb.17.1659547125023;
        Wed, 03 Aug 2022 10:18:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id d81-20020a621d54000000b0050dc76281f8sm3824637pfd.210.2022.08.03.10.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:18:44 -0700 (PDT)
Message-ID: <3dd40197-776d-9003-3c8f-1791587ade0b@acm.org>
Date:   Wed, 3 Aug 2022 10:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 03/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jaegeuk@kernel.org, matias.bjorling@wdc.com,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094805eucas1p1c68ba40d319331c2c34059f966ba2d83@eucas1p1.samsung.com>
 <20220803094801.177490-4-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 02:47, Pankaj Raghav wrote:
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_err("%s: Invalid zone capacity: %lld with non power-of-2 zone size: %lld",
> +			       disk->disk_name, zone->capacity, zone->len);

If this patch series needs to be reposted, please leave out the second 
and third colon (:) from the above error message. Once this comment has 
been addressed, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
