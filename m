Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EB4B9024
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiBPSZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiBPSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:25:37 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23371F4667;
        Wed, 16 Feb 2022 10:25:25 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id z17so2625979plb.9;
        Wed, 16 Feb 2022 10:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AqCCqD9wQtmLixx1NU1hD0/tMIkij5uZp5ylQh1zyYg=;
        b=zD2W6fsinWWH4ZEts3PiehaT/9NAlqsdCKuZI+Lr72H2pkVnrSfAj1qOWSl6YqmBNX
         BT3vMFCdsTmpYwQg89BW7xvrAq1/L0LCr3UpkDgQ8aITrkVWaYs4OvxF9Ytz7N5YPE8o
         LB5Nbhk8o5Fi7DSSjfA4neniSvSe2t+Qp/oWvmGk/njMX1VQ1RyXGPlKY31eKANfcQeI
         Y6rDL5UBlakXhjrt5wMOKDIuuuHTi0RvdQLbdmhYDhIQtRp3usWVrFCP/nP2UXorv23a
         I/VYOj0D8L2ebS/crIkMOYppvSj/o1sAOEpODd/MrP2SNphpVxGjvKwmbdX+6NNeWD2N
         n+9Q==
X-Gm-Message-State: AOAM5319xxGHFmd80hKlMTw4xul4HeF2vlH+U52qv5o1UgvGnnkqz4Yv
        zadsohxpkxthWzaIBb7rNUPu8G6SW9C5MA==
X-Google-Smtp-Source: ABdhPJzUE42b9zqdrUfxN/gy0jGb7fxgXJOJ1IWVGd5qNCtJWkmLDd9WPweBESPzYeP3ZwyNzEnfkg==
X-Received: by 2002:a17:902:650e:b0:14f:21e:d088 with SMTP id b14-20020a170902650e00b0014f021ed088mr114393plk.61.1645035925039;
        Wed, 16 Feb 2022 10:25:25 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id rm8sm11776960pjb.5.2022.02.16.10.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:25:24 -0800 (PST)
Message-ID: <3b1f616b-7d76-1dd9-0e8f-3a40bb2f5b35@acm.org>
Date:   Wed, 16 Feb 2022 10:25:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Content-Language: en-US
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220216113212.83000-1-jianchao.wan9@gmail.com>
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

On 2/16/22 03:32, Wang Jianchao (Kuaishou) wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> When __alloc_disk_node() failed, there will not not del_gendisk()

Please use the present tense for patch descriptions (failed -> fails).

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
