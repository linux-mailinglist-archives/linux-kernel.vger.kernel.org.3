Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBC5B04BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIGNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIGNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:08:33 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A927E31F;
        Wed,  7 Sep 2022 06:08:07 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 73so13549447pga.1;
        Wed, 07 Sep 2022 06:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HpnGD2A5QEDoI0b8szeNdkO2l9HYpACZ+X4q96YODug=;
        b=ptGAAgmGZp4RqEaP0G7fogYd0oCurTj5ceJO4gA7H6Nk2Rzz6fYBJFCw9sBUOdh8VQ
         lc049i3bwvht0/AO1OpQH615zarRUvgufp5R9MuM4oeteWq/xsLPLLJ3NJQuiVCwCFxF
         kqDA0bubq6+oG1gmeYVTP47rqkdU/rMDzGNoAN4a/z4SJy9ADK02TlLXWg9c9frDZ9nI
         8FZGX0Sh3W9GZVsLjoDHk3LHPUNXpkPXPSfs724HFXM/GII/ld4L0syjHTwecye6PCmv
         0mq1+xWiBeI1KLc3itsRNFzluU/WJZX7SGr8jTO6v8zCTic8wYFIaMZvbWET0w3pNZrF
         Wwpg==
X-Gm-Message-State: ACgBeo3S5X57GK5QFOYU2JPQ5sUaZPNn7cT+nKhzeL4kqf72ym9sGJnQ
        YzvPVcR71eupy6INi7qeijTbUrQ3/L8=
X-Google-Smtp-Source: AA6agR4R9vIVS9EnVhTy8P63dQhHevDyRLASFWR9vdqY/SqHJ5iKSGIv9lC1ETVW6UK0k/YRTMO/Pw==
X-Received: by 2002:a63:de07:0:b0:434:d973:5dff with SMTP id f7-20020a63de07000000b00434d9735dffmr3400015pgg.44.1662556087173;
        Wed, 07 Sep 2022 06:08:07 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b0042c5a1715d7sm10441942pgk.83.2022.09.07.06.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 06:08:06 -0700 (PDT)
Message-ID: <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org>
Date:   Wed, 7 Sep 2022 06:08:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kernel: export task_work_add
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20220829040013.549212-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220829040013.549212-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 21:00, Ming Lei wrote:
> Firstly task_work_add() is used in several drivers. In ublk driver's
> usage, request batching submission can only be applied with task_work_add,
> and usually get better IOPS.
> 
> Secondly from this API's definition, the added work is always run in
> the task context, and when task is exiting, either the work is rejected
> to be added, or drained in do_exit(). In this way, not see obvious
> disadvantage or potential issue by exporting it for module's usage.
> 
> So export it, then ublk driver can get simplified, meantime with better
> performance.

If task_work_add() is exported, shouldn't task_work_cancel() be exported
too? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
