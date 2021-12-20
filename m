Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E398447B1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhLTRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:10:18 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:36554 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhLTRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:10:17 -0500
Received: by mail-pg1-f173.google.com with SMTP id 200so9950471pgg.3;
        Mon, 20 Dec 2021 09:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tJqbUHV90MYT7sauKSyrvUY9zVpGUS3+UEyHIr2dLnY=;
        b=UEasx0lBZEwvrRTO2FI4Z9/fnVWR1s3QCrGrlUITfopN6LpLLwNxOgOX6lUKm7ULtQ
         7zyipi1a289sY2K2+nHpSxTgfGnZcRGT9W56E7YXLuHaoZzFEF+iHJYUJcT8ycJa2DfG
         mYWI1TBJzs0jmZDXHIYK/7ylyCnjBT14U8NG0cwyYrT87TIg1zLzvqKiXV6yzVsxqZFI
         pdlGbRpUfy+DoXQOn2DvCBCNcToA0B9RaDp/HTVPCi1usbqEDYCngX9DYZ9c0KurDSz4
         PeMOXQq1ho/nawpGXY9TkILY7kIP55HEkHkL755+/vA+fPWzCCKuHwHUr+XS3Z0Dg16k
         +Ttw==
X-Gm-Message-State: AOAM530HMVuOXiOAS/ZHHzVWnRB1JMhgVtj2GHuC6yUajW6vPcvr7IzC
        OZTnABaWsyRHrb1VMU7l958=
X-Google-Smtp-Source: ABdhPJxwOSjE1jdX7wbjjGBxvw5S+FLJAIe83DDBI6cya2hxJp0wNz/zciDp+jHSlP+7qyAUAlUVLw==
X-Received: by 2002:a63:8ac2:: with SMTP id y185mr15868960pgd.205.1640020216814;
        Mon, 20 Dec 2021 09:10:16 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x33sm9549361pfh.212.2021.12.20.09.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:10:16 -0800 (PST)
Message-ID: <a4ba2441-83eb-dde2-09ae-7c5f42ff6ad3@acm.org>
Date:   Mon, 20 Dec 2021 09:10:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nbd: Don't use workqueue to handle recv work
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20211220122241.150-1-xieyongji@bytedance.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211220122241.150-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 04:22, Xie Yongji wrote:
> The rescuer thread might take over the works queued on
> the workqueue when the worker thread creation timed out.
> If this happens, we have no chance to create multiple
> recv threads which causes I/O hung on this nbd device.
> 
> To fix it, this tries to create kthreads directly to
> handle the recv work instead of using workqueue.

Why a kthread instead of only removing the WQ_MEM_RECLAIM flag from the 
alloc_workqueue() call? This should have been explained in the patch 
description. Additionally, a Fixes: tag is missing.

Thanks,

Bart.
