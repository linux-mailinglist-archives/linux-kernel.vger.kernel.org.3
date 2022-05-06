Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8E51DBAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442748AbiEFPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442777AbiEFPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:13:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0516D3A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:09:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k1so7711931pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=12UMdmYoYrrFYK3VfNeGnEK3WmXz254CwsHVBYebRMk=;
        b=LASvZd/kr+O0L5A3bEKuR8CTk3fHm5Tsd9lUjfYwpqn33d7k3Q1zsMSLxqM2Wvmjfi
         U9X9eV7HuBPN5VQdn6QkXC7TyhZPYAzEmjTJjpaD5GIOeD6QowBVqIADEj4QvOrPEVtg
         ixMVdzrHVAvfbZZWmaW4tVERpTCm8iDa/gmWxbCttBjaVWUI+z2M45U6eU6/izM7UmEw
         06W6+xGWjrV9ntNXVSJcxZeWZPlDMQeHyRKnhuxcRvfzKtHy8hThyvLAr/AALg2Mc12H
         wnFPOPC2IlEl29O2OH/A+ASOIh9PPps0VTvp/TnkmuOcnlQwc43q1Oz0o8B4VKCBOUQ8
         GpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=12UMdmYoYrrFYK3VfNeGnEK3WmXz254CwsHVBYebRMk=;
        b=RRBBGJCUXlDxdC6EPQ8IlvOS/8GXdjUMo5rAg4lyVCdHGJN+HV7sJJYrUbg4xGThNK
         P9lBqdwsxh9N4jPApoBGbq827KCDZzA28fHHBWDkywGryof1ignGtPfxAzmEG829kawS
         iE2qN/9uAxBjRdSBWjWUsAhgiXEQmfgXqu9JNtmxo7ZffTRYhiqMSmjKJ4GYNqKy2RfE
         pfQHzAVkS/5hFW0JEYbzKQn7MXA7bpqFOpvmgPm3n5UBQj0mmZK2RSBRSWk4Uy6pu/2y
         vn+1XG9vwW9toenWlMmnaiZcFUpVPXIIQgFppZuI0YK2PICejpE71UbFXm3AjjjeST5K
         OReg==
X-Gm-Message-State: AOAM533V5vCP7cfvp0uRsgogo0VKNkk/oTmC/XPskiOmMayo5CZ+BYLm
        Tqqs01rqSejH+JS1yhPAIJld2w==
X-Google-Smtp-Source: ABdhPJyXNCnjMbf233x1TRm9Ax9LXKujaxCcbwMHpOtAWrTw2hiA71j0kvmsMI4qbPaIDzeMtLIaSQ==
X-Received: by 2002:a17:902:ec83:b0:15e:b5d2:a81b with SMTP id x3-20020a170902ec8300b0015eb5d2a81bmr4083716plg.64.1651849783670;
        Fri, 06 May 2022 08:09:43 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902b70f00b0015ea0a679ddsm1868392pls.251.2022.05.06.08.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 08:09:43 -0700 (PDT)
Message-ID: <4a87c2d9-89fa-2cec-7707-08fc78c88bf8@kernel.dk>
Date:   Fri, 6 May 2022 09:09:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme: Ensure ret is always initialized in
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20220506150357.2443040-1-nathan@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220506150357.2443040-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 9:03 AM, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/nvme/host/ioctl.c:674:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>           if (ns)
>               ^~
>   drivers/nvme/host/ioctl.c:677:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   drivers/nvme/host/ioctl.c:674:2: note: remove the 'if' if its condition is always true
>           if (ns)
>           ^~~~~~~
>   drivers/nvme/host/ioctl.c:672:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> Initialize ret to zero so that it cannot be used uninitialized.

Thanks, will fold this in.

> Or alternatively, remove the 'if (ns)' if ns can never be NULL; I tried
> going down the rabbit hole to see if that is possible but I got a little
> lost :^)

For the admin queue, ns can be NULL.

-- 
Jens Axboe

