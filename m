Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D84FAAF2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiDIVdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDIVdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:33:21 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7E1033;
        Sat,  9 Apr 2022 14:31:12 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id n9so10852724plc.4;
        Sat, 09 Apr 2022 14:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bXHLCa3dfzOIhVpo6ukpcQv28YFp7azGl7372EerRWE=;
        b=MW0T7rAGnneZdsW/GewBji04ECXWXw5jdFtHtuxEqvQokJavApef+EeyEAI1Ym45iY
         bpLW3vtiKZjz7KMujAB/aMDbY1J576TpiGzYbL13UfuXV7y8YFLrnBe9iWAroDlPa9KM
         M2OWZQiyVe5BnUulZtb7QCQ6yqX6/gNrlPLJQbmqaOghB98EeqgTRLtxFvSWSoM19GZo
         jlzG8sIJHaET0DAnUGpBG1gwMQGX/hUp4gRYZEerlXOetWTQW9CrZNrJwu3sWUUWCnHM
         Lov0x9FNO6wuCBDYidT3nD/D/aZ5uQC95h/nK6SQ7VB9nV87fjbcVMX2BzjepYufx+bi
         bj3A==
X-Gm-Message-State: AOAM533dU2RD3mSA44+Y0cuuyXwOoTehJ2pR5q868266DSKU4X1tFNTh
        jOHP6T3QebEjC1tD/HKGank=
X-Google-Smtp-Source: ABdhPJwiPGUKhP2E6gW5QpL4MVOIoeilAzAEraJsHe/m5MbOTFLPTdAH4Z2mmESVNoclbygW2iyhcQ==
X-Received: by 2002:a17:903:2284:b0:157:110f:1b27 with SMTP id b4-20020a170903228400b00157110f1b27mr13411872plh.108.1649539871960;
        Sat, 09 Apr 2022 14:31:11 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm31503976pfh.174.2022.04.09.14.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 14:31:11 -0700 (PDT)
Message-ID: <924169bb-4a94-e9b1-1aeb-86c99e8637e7@acm.org>
Date:   Sat, 9 Apr 2022 14:31:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
 <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
 <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 19:28, Jens Axboe wrote:
> The easiest is probably to try and send patches to a gmail account. If
> you don't have one, just create one. That will help you see the issue
> and verify whatever the fix might be. It might be a company email
> server issue, hower.

Hi Jens and Yu,

I think it's a company email issue. Many servers that receive email rely 
on the SPF, DKIM & DMARC standards to determine whether or not to 
classify email as spam. I had to add the following rule to my inbox 
receive Huawei.com emails:

Matches: from:(huawei.com)
Do this: Never send it to Spam

Thanks,

Bart.


