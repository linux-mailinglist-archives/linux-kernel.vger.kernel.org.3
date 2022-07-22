Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43657E5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiGVRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiGVRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:47:16 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CC951CB;
        Fri, 22 Jul 2022 10:47:16 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id x1so3388226plb.3;
        Fri, 22 Jul 2022 10:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGdkXOH2H16F8Hpn2Tgy5CKP/LKypAMrDZQSY+JK7dU=;
        b=FADGIx/0gSkWSbFMchH2y99NWZJ9RLXrd8kuW+mL4qcrvK6U2oQe5/liUSYQ9JKW1I
         f+Qlq3GvnH168uOegqmqQ17p0nMn9DTqI7RYyJjmZ0TdSqQv3li6fGALFWOGRKUwBFz3
         R1gyaaZsn1/lI1KaQgu47m62zN2yu9O0h7KgrqXATKCuEysyHFviYGdpRtqMgELQ91Nx
         iJ5ONf/nmv2FjSTJCeBZ+QUwDjfw+hSAVBJCD792oJH7BeKSKCRagmDV5VVUdTAeTlwp
         PXdM8Q1uuJ+GAehishKjaxzmNfCNUF8W/PcyRh+T1A9rUA75I4Cm5JlljcmvGrP4qGWT
         WQ0A==
X-Gm-Message-State: AJIora8cv8w00zuHYEvg4A0W5xayHNzR5+1fIbM5Pe3rvlmYhlPeqNT2
        y1inEdT6U5q3fYo06mLN69hqdIlKEac=
X-Google-Smtp-Source: AGRyM1vBu7of+c3BIe4do/ZrLP7ttCauBZUaY+0hH7OjkwPbfvjhKrUFzo0woNgcxnLKLfR5odb3dQ==
X-Received: by 2002:a17:90b:38c1:b0:1f1:f1c1:469c with SMTP id nn1-20020a17090b38c100b001f1f1c1469cmr18589427pjb.106.1658512035356;
        Fri, 22 Jul 2022 10:47:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cf6:7e29:d977:6fc7? ([2620:15c:211:201:9cf6:7e29:d977:6fc7])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001640aad2f71sm4013163plk.180.2022.07.22.10.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:47:14 -0700 (PDT)
Message-ID: <f798c875-0bb9-add7-d7a3-4ac2a76e85d9@acm.org>
Date:   Fri, 22 Jul 2022 10:47:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Prioritize first request
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangxiaohua@uniontech.com
References: <20220722095120.371212-1-wangyoua@uniontech.com>
 <20220722095120.371212-3-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220722095120.371212-3-wangyoua@uniontech.com>
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

On 7/22/22 02:51, Wang You wrote:
> The test hardware is:
> Kunpeng-920, HW-SAS3508+(MG04ACA400N * 2), RAID0.

What is MG04ACA400N? The test results suggest that it is an SSD but this 
is something that should be mentioned explicitly.

> - The test hardware is:
> Hygon C86, MG04ACA400N

What is MG04ACA400N?

> The test command is:
> fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1 -iodepth=1
> -thread -bs=512B -size=110g -numjobs=32 -runtime=300 -group_reporting
> -name=read -filename=/dev/sdc -ioscheduler=mq-deadline -rw=read[,write,rw]
> 
> The following is the test data:
> origin/master:
> read iops: 15463	write iops: 5949	rw iops: 574,576
> 
> nr_sched_batch = 1:
> read iops: 15082	write iops: 6283	rw iops: 783,786
> 
> nr_sched_batch = 1, use deadline_head_request:
> read iops: 15368	write iops: 6575	rw iops: 907,906

The above results are low enough such that these could come from a hard 
disk. However, the test results are hard to interpret since the I/O 
pattern is neither perfectly sequential nor perfectly random (32 
sequential jobs). Please provide separate measurements for sequential 
and random I/O.

The above results show that this patch makes reading from a hard disk 
slower. Isn't the primary use case of mq-deadline to make reading from 
hard disks faster? So why should these two patches be applied if these 
slow down reading from a hard disk?

Thanks,

Bart.
