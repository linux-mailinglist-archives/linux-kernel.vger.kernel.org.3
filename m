Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48829589137
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiHCRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbiHCRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:22:37 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7331221;
        Wed,  3 Aug 2022 10:22:36 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id gj1so2206379pjb.0;
        Wed, 03 Aug 2022 10:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=81PY4yBEEjUXxYOBG5CambynNE+HXFQDS99frEnDmrs=;
        b=CGfKva3CMvsWDePIc6xTlmFoJOD1YLJYwOtdI5TyUjSKFAYSN8kmF0QSPSR6fFxex7
         rKl51NaF91TEmC1clmqqADcVNdeu2TRqokPCx24imeLcxNZVBPB33dryBi4IXCCRMM80
         fslp7/abwy+LN13RvpWKKNF0Kz9/E4rIwVqD/zVCI4wxG1GomZbwWdCEdLs6ptejoBCI
         KjU0fIlNu0q5giNnxQWc5Thv+i0so/vD5LUxTDBJ68yDJa6lzGtGDpbyTsp8v67/ZXC4
         A9RYdAavbHA7w8Cwm6BhPDUANCnlBf4fG7o6yPj8p8EXINTDWvm1fBASMKuoHJGI1YVB
         zKoA==
X-Gm-Message-State: ACgBeo0ch/Lq7agu5NafHSkwomVve8aDV4nna1Z2oEycpbu7FREyWdyS
        k5OReraPweMYBOcs9Uh3Gq4=
X-Google-Smtp-Source: AA6agR4qAuR4iHmzSPdpkQ3mxXc1SGakIYA1aA7y7JsrpsmrjJ0SDtdisB5YYBMJ0qKrjfikQnBjiQ==
X-Received: by 2002:a17:902:f54e:b0:16f:206b:74cc with SMTP id h14-20020a170902f54e00b0016f206b74ccmr1132384plf.170.1659547355934;
        Wed, 03 Aug 2022 10:22:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b0016cd74dae66sm2275344pls.28.2022.08.03.10.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:22:35 -0700 (PDT)
Message-ID: <2616b59b-8c6b-a482-a396-d9408fa461a3@acm.org>
Date:   Wed, 3 Aug 2022 10:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
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
 <CGME20220803094808eucas1p1a6a800161d32fe4242d39e669e5f3527@eucas1p1.samsung.com>
 <20220803094801.177490-6-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-6-p.raghav@samsung.com>
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
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * Round down the sector value to the nearest zone start
> +	 */
> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;

Could bdev_offset_from_zone_start() be used here?

Thanks,

Bart.
