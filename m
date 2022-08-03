Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBB58914A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiHCRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiHCRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:24:45 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581154657;
        Wed,  3 Aug 2022 10:24:44 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4096225pjh.0;
        Wed, 03 Aug 2022 10:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PLueRrdRrDSAZCsSnEuO7ryjbF4cDa5AGSQHDpCb7Jo=;
        b=cnNUQOAfgHOxq55giri+w07WCRA5RjedrBU0T9+zvtAEjQOfNLx08oJWRT8RMiVhnK
         VQAb2SoPT+QptujtB72Zgd1mrDrrzfeyPw1PpSc1eLFieuJwSnFtP5MHo2QVYNix/oVV
         QhV53uoso0ybRES4++IxoRmnkaxyn8OcWsRU8D8CQbPmGkKUtZmjgf3vRTp0uqn3rsbA
         41q6yZG8L0CdJE0YG35RvEaWNyN9shKkwvvxv6FICBxPdC8TpNi3j0hKIA3v3Y80ze8q
         rltH2It7bJzel8UvPp8rSGz5GVXN+CKtG/j3fIZkIxdS/qP+gO+YICEaK5VD/x50/Erk
         r5jA==
X-Gm-Message-State: ACgBeo27UTtImrnkmqhsSt8zWKspPb7CTX/T5tCCw56d7JHeLUqCx6oF
        vkgJu9GVwHSaPPfHvTMusXkU6CFNX1bXLw==
X-Google-Smtp-Source: AA6agR4+errzcNzMPWB0CtPUqoFfU+/HvKqxJd9O453x9LrGJfJ/jGLweL2ivP559rQbToAj4CcR+Q==
X-Received: by 2002:a17:90a:d58e:b0:1f4:f9a5:22a8 with SMTP id v14-20020a17090ad58e00b001f4f9a522a8mr5883087pju.58.1659547483870;
        Wed, 03 Aug 2022 10:24:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b0016c2cdea409sm2217726pla.280.2022.08.03.10.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:24:43 -0700 (PDT)
Message-ID: <9de2428b-96b8-883c-bd96-01a7763758e8@acm.org>
Date:   Wed, 3 Aug 2022 10:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v9 10/13] dm-table: allow zoned devices with
 non power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jaegeuk@kernel.org, matias.bjorling@wdc.com
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82@eucas1p2.samsung.com>
 <20220803094801.177490-11-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220803094801.177490-11-p.raghav@samsung.com>
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
> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
