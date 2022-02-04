Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE64AA153
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiBDUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiBDUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:45:23 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:45:22 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 9so8927699iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppGT+raWqgqqnN9s+r4RdjtGpdEKJ0JDJJLNMb3GkT4=;
        b=Y+SGEPCT39d6nTdprEzcuB/1E2I10SK3H5VnNnBCTqviWf9TZ/07ZJjjoPIAO13nPs
         Sbv7HgI7W50jlCwQTfcW8LZFrJI4MoCb48QsGYB9a6yE8HSKyKeax7SRq10A2a878C88
         EiHYibPHJR33yi0mpGg7ZEcQjwOEy/H9TK2aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppGT+raWqgqqnN9s+r4RdjtGpdEKJ0JDJJLNMb3GkT4=;
        b=pytw/RMNN3Kw50E54yYzibqLWmQU6W9iTYrPucCzayd52hkxVDukMDNm8yFSZDUaee
         VleIbdkZJCCgG1KPrJjb81kekW/n3BpDCgw4lFPvgpC8FLTG2UgMVkNDwYdCSuI4xdo+
         14jeKvYMz3lPPwRSXNCA0RhLM11vUcPekCrn05iYxnbCSnFLd6SJF2o8TtP5MltJ7qAo
         ecpC7XYyzOKEWD1e4O8eSvVI5AHrLjCuTgG34r0OHsgULNTGffB2EDypA4eTcBuzvxnn
         DGQvPONQu/binaeJZDwC6rhXhQlZ2/Hhum6+60tEOfui0EjGCjS7V9P3TWCcSJs6olpd
         sIKw==
X-Gm-Message-State: AOAM530KXCV6mMtTpwECJyBpNSENRDKlGjwIi/fO8LzZlXfYWJpcvGTR
        u3YbpPDE4Fn/jKSPzSORUaJQQQ==
X-Google-Smtp-Source: ABdhPJwVpeHnhkM/J9L4r1eIvjRG2QNUrOOQM3WEz0dfY/B4PC+4Cx7zrl7A7+NEs6OtxcZ7g/gyqw==
X-Received: by 2002:a05:6602:1513:: with SMTP id g19mr418021iow.30.1644007521642;
        Fri, 04 Feb 2022 12:45:21 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a4sm1413618ili.80.2022.02.04.12.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:45:21 -0800 (PST)
Subject: Re: [PATCH v2] selftests/ir: fix build with ancient kernel headers
To:     Sean Young <sean@mess.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <Yfl+LOPk+KQdc0Us@gofer.mess.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d0da794-6fbd-1b82-eca2-68d9451fff46@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 13:45:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yfl+LOPk+KQdc0Us@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 11:38 AM, Sean Young wrote:
> Since commit e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h"),
> the build of the selftests fails on rhel 8 since its version of
> /usr/include/linux/lirc.h has no definition of RC_PROTO_RCMM32, etc [1].
> 
> [1] https://lkml.org/lkml/2022/1/28/275
> 
> Fixes: e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h")
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Sean Young <sean@mess.org>
> ---

Applied now to linux-kselftest fixes branch - decided to take
it through since there is no real dependency on previous patch
as far as the change goes.

Fixes: e2bcbd7769ee ("tools headers UAPI: remove stale lirc.h")

thanks,
-- Shuah
