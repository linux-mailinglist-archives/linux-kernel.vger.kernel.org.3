Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32048CBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbiALTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbiALT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:29:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B58C03400E;
        Wed, 12 Jan 2022 11:28:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso5910689pjd.1;
        Wed, 12 Jan 2022 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PEnXAX+olmoKfZvXTGdewhEjU5UGuUJE4ReQqDTfiwY=;
        b=FFi4PcEl+SPmSBJ+fUunrRZ1ZHIfaD/4VyfL+6v0VGpitoALJuhaScmTR3w2uBXa1w
         m8bfjnRcFwrqwccjoDLb4UO08BYfD3wrb7zH6IgoVmvogt0366Q7MsED5id4jzaHT8jZ
         ENMFupDO+CpVBqzFDKT93Qa7o3bUBFHZrf9qyBBMjsDWvTdYIimFdD2/gMJzzvZX9NDq
         rmNw9sCSkRjulQ8xIUUj2nzAFYyj/2Hf2GvFNQ1izeRacZxicgsN4PR4AaLFBH0JG8qr
         0DZR+z08ecpZx8IhwmhvqB9CAkXlEPIoKEPK/0UfaTXqvjgf/DZu2S/axdDKiAGycInF
         P0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PEnXAX+olmoKfZvXTGdewhEjU5UGuUJE4ReQqDTfiwY=;
        b=iyBPyARV2zzhcn2XXWBKyXdKnjIz8VPPpI6ScMz9XtuUvYLKXd9y51Rz0ryWlcRbcq
         9iS4JY01t9cOG43/ROI4KRMX2SlXslfJ7Wk+D8rddGDoeN3ACVOIUZGdnxSyb2Uxa1J6
         n6t1wpQqLHp4tH2WtwRbBl3ZdT5uSweDzGAloeRaHJ2E7EOt88gonVYcb7hZ9+BEXFAt
         9X7dFBNRmPU8j8cDt/8FR4iIRyTn1ODfSid5mYZH8yaj4svLaF5VvwOQwjGwt22eIBOv
         3DsHKMZc57/qlQrT5eVGKd54abrK4/cfCa28NjxZYcWwH8wFmNSKUk0qOy1yjRbkmweV
         KWfQ==
X-Gm-Message-State: AOAM531AuiojyUFyswGQBxrTZoVs19MHLgGG3j4uNNNco9ANXSCSdLv8
        Z+96pHQO4l2bW4Xt9u+r6rA=
X-Google-Smtp-Source: ABdhPJzuc2ui2a6aGJRSU/SQqU161Mz8cxRnWt6fy7ED0LeNGlGWZNbBhQ1KsVQDaU5T3N08XL572A==
X-Received: by 2002:a63:b811:: with SMTP id p17mr968806pge.81.1642015729548;
        Wed, 12 Jan 2022 11:28:49 -0800 (PST)
Received: from [10.69.44.239] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id rm4sm454316pjb.4.2022.01.12.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:28:49 -0800 (PST)
Message-ID: <881ba4aa-2dc6-b116-869f-0fa2ecfe326b@gmail.com>
Date:   Wed, 12 Jan 2022 11:28:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next v2] scsi: efct: don't use GFP_KERNEL under spin lock
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     hch@lst.de, james.smart@broadcom.com, martin.petersen@oracle.com
References: <20220111012441.3232527-1-yangyingliang@huawei.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220111012441.3232527-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/2022 5:24 PM, Yang Yingliang wrote:
> GFP_KERNEL/GFP_DMA can't be used under a spin lock, according the
> comment of els_ios_lock, it's used to protect els ios list, so we
> can move down the spin lock to avoid using this flag under the lock.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 8f406ef72859 ("scsi: elx: libefc: Extended link Service I/O handling")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>    move up unlock to just protect list_add_tail()
> ---
>   drivers/scsi/elx/libefc/efc_els.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 

Looks fine.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james
