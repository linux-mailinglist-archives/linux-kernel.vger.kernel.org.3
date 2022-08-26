Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4915A31B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbiHZWGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHZWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:05:56 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD4BC88B8;
        Fri, 26 Aug 2022 15:05:55 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so3139951pjj.5;
        Fri, 26 Aug 2022 15:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OVWnAlc8YN9XEQA0vd7Y2vromwbsVTjPra3Mrwq+1eU=;
        b=kZLSfSZqFOHt069kiIDcD0SsK60W63vlEm0L6ZUZ9fk5HfMe3zvkevQG8pq8iumCdI
         iBkWcbCUZ7zvqmJc8ARXR+UGFEvvPVtxh7XWTDHw+kE/fp684EF/iPgj033/ALB38QZu
         5VWsoiERAZFsht4XPOMYsk+NZ1xXCD1TMulA2tnWg7fWV7eBvbv98irBM1ealfYNe02h
         LY9lXCWXRmVmwI6KJIhX7/CQ06kvnA5wAIQgwRgZVYbrAfxj4GKbHrSz96X7BVqL+GOk
         RRiQrK48HodtZbZ4qNgxWaBGIo2CsNAtq3G/sTFEFOApyx1EDRaktIqhzCfrtsg0Qitp
         Nw0A==
X-Gm-Message-State: ACgBeo0Mr9fpqXiFT9FhDh4s+y/yIpEIbiu4IFMFw+CZsE++WAKmISYs
        v1cwPcJ+n3cZ+q4U8TpkMxM=
X-Google-Smtp-Source: AA6agR6QYEE4oV/Dk9br5PkInt4VOtU/dvU9A4fNw0WQPmxe3y5EiIuhTpAkWUv+RiF38x2a87VXEw==
X-Received: by 2002:a17:902:f64d:b0:172:d004:8b2d with SMTP id m13-20020a170902f64d00b00172d0048b2dmr5656685plg.14.1661551554938;
        Fri, 26 Aug 2022 15:05:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a12:b4b9:f1b3:ec63? ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b00168dadc7354sm2103935pln.78.2022.08.26.15.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 15:05:54 -0700 (PDT)
Message-ID: <5ba28a61-0aa2-14d7-61f0-0e9316844f70@acm.org>
Date:   Fri, 26 Aug 2022 15:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: core: Fix block I/O error of USB card reader during
 resume
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220817083438.118293-1-michael@allwinnertech.com>
 <ceba3c96-5f32-9b5a-bacc-0eb942b9b90b@acm.org>
 <6412c518-426a-69a4-e419-83dc97bebe27@allwinnertech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6412c518-426a-69a4-e419-83dc97bebe27@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 03:16, Michael Wu wrote:
> Yes... My patch did seem suspicious. Here's the scene about the block 
> I/O error: Some card reader does not respond the command 'MEDIUM REMOVAL 
> PREVENT' correctly, as a result, the host does not send subsequent cmd 
> 'MEDIUM REMOVAL ALLOW'/'MEDIUM REMOVAL PREVENT' before/after sleep, 
> which leads to a enumeration failure after system resume.
> I wonder, without changing the behavior of the device, is there's a 
> better way to solve this? -- Modifying the scsi core should not be a 
> good idea though :(

The above is not clear to me. My understanding is that "MEDIUM REMOVAL 
PREVENT" is a sense code instead of a SCSI command?

> Thanks for your kindly notice. I looked around in the latest linux 
> mainline repo, but could not find this code. Where can I get this 2002 
> version of scsi_lib.c? Thank you.

Please take a look at 
https://stackoverflow.com/questions/3264283/linux-kernel-historical-git-repository-with-full-history. 
That web page has instructions for how to configure a git repository 
such that history goes back before the time when Linus started using git.

Bart.


