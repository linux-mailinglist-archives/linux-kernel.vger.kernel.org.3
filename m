Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890D589147
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiHCRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiHCRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:23:48 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F952FD9;
        Wed,  3 Aug 2022 10:23:47 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id g12so17079298pfb.3;
        Wed, 03 Aug 2022 10:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0/8nr848GRaOG+Fxstqzc9TigPNxYkNf2h7q9hGBHq8=;
        b=3AjFLDDtX7qJms2TlRarbvxUmnm19BBZuKbRI+YINw7uleTiJpgFzHw48DGCg+R5MD
         bNDVzMoGIJoG80satlc0PqeZrcLM0lXZz75c8IjulAxr0C7HQvU6mIGKLQE0wq1EJTdQ
         hNKBQc370lJuQ5nDk+jg0gWH/CoPxERmKh08b8UlIKsPFXfNEEltCdQRiYKPr/cQ3k8A
         aDLHl50L53LI0Y+yJ38cdmPUE8Y3rPOipx5a3vLY7nYiMJcrnOPOUVOZ546P1qYK6X5x
         4a8KTWcSguk8omMv2XHxaxNWsuwfp7Y3Q1xEW8OYDxHRncDU58VkJY+kXi9gdSO1g1jE
         L8rw==
X-Gm-Message-State: AJIora+hdFxprqbtSTGSJlIOD8V7el4Wc/YcZdBjM2NwB4l4KTttPmXm
        zpTijuGawkQ0OsF34u4VDQ0=
X-Google-Smtp-Source: AGRyM1vgZohnjas8fupQWk0TGJ1ujqQbQ0c9VjCzhrzKOA3JUzR8cBuYkbzDzRvd/ngCVEXerrSzcQ==
X-Received: by 2002:a63:4f52:0:b0:41a:3744:d952 with SMTP id p18-20020a634f52000000b0041a3744d952mr21509471pgl.186.1659547427197;
        Wed, 03 Aug 2022 10:23:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id c25-20020aa79539000000b0052dfe83e19csm3180967pfp.16.2022.08.03.10.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:23:46 -0700 (PDT)
Message-ID: <4b6f14a1-2a96-da20-d56c-032a87dee7d2@acm.org>
Date:   Wed, 3 Aug 2022 10:23:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094812eucas1p271cea804453d9dd379b919067fe5b154@eucas1p2.samsung.com>
 <20220803094801.177490-10-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-10-p.raghav@samsung.com>
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
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if ((bdev_offset_from_zone_start(md->disk->part0,
> +						 clone->bi_iter.bi_sector)) != zwp_offset)

If this patch series needs to be reposted, please leave out the 
superfluous parentheses from the above statement.

Thanks,

Bart.
