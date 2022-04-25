Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B350D75F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiDYDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiDYDMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:12:07 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C64E385;
        Sun, 24 Apr 2022 20:09:04 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id i24so13579084pfa.7;
        Sun, 24 Apr 2022 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tsGZFIEixUEnJNolXV8dfGKJqfTCfEpZ3B2cSrfx1vM=;
        b=eWbthMyR5pl1rFlPdMKr3HSLFSx73sk+wZ1uL96OKuPPahT/UJrpXsIkRtJRNAuCPN
         SZxKyWI70mcH+164+Um+v1onym4X4h+w11oNv0UkFLZvD10Gc/gidP138PHMOlE066iA
         Qs7Y2SWaimJBdX2sa6G7tZ6NDzzEv810ic0NC/KxYmZlphJ1ijHTLT7Q5ZmbEcRbC48f
         Pa6aBeDNFJ5hOpXcOqG0QDLUSTtDap6VAnSEWgf7/j04nJMpqcK5LSUuP3PJAGBcKSzY
         XugPnCCRPHSpHKZ0GLup7sgjpM5+1PY5L5d7S1PWxgMsaN0vyo8w9XBCu728UsefeJ8b
         qbeg==
X-Gm-Message-State: AOAM532k9noiUdzKMgIkVI2hTf86GQdehfXvov2VyY5HY/AKD7f39DBX
        OqdSuLVZnlO2DxeAuuEyusgRhrcCfyc=
X-Google-Smtp-Source: ABdhPJzOQj9ikbTemWkl0X4L6g7+gJVC6zzs6svuR4Q/oiKun077BKe3V8PtBTFA63SVbSHmMXRfuw==
X-Received: by 2002:a05:6a00:2d0:b0:4f4:1f34:e39d with SMTP id b16-20020a056a0002d000b004f41f34e39dmr16617024pft.14.1650856143804;
        Sun, 24 Apr 2022 20:09:03 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a448200b001cd4989ff40sm9147432pjg.7.2022.04.24.20.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 20:09:02 -0700 (PDT)
Message-ID: <450b5ab6-fb82-06dc-2a11-e0b464901c74@acm.org>
Date:   Sun, 24 Apr 2022 20:09:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com, qiulaibin@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220415101053.554495-1-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220415101053.554495-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 03:10, Yu Kuai wrote:
> The single io performance(randwrite):
> 
> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |

Although the above data is interesting, it is not sufficient. The above 
data comes from a setup with a single hard disk. There are many other 
configurations that are relevant (hard disk array, high speed NVMe, QD=1 
USB stick, ...) but for which no conclusions can be drawn from the above 
data.

Another question is whether the approach of this patch series is the 
right approach? I would expect that round-robin wakeup of waiters would 
be ideal from a fairness point of view. However, there are patches in 
this patch series that guarantee that wakeup of tag waiters won't happen 
in a round robin fashion.

Thanks,

Bart.
