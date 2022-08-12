Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1985910E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiHLMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiHLMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:40:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B48EA7ABC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:40:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y141so851166pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=s3Kp5U/VqVuXGiRK973FMZHaRwO0ydhDLvBsgwOJLzA=;
        b=gLZsBiTTLEPVy2cmiA3Pwmxne/zs8SA1JDvPET37cNfShVVdR4C9eT2XTlOE/P/tss
         jRAVksKlRd3vS9kBOvGs2qpbgb1ijPxjVN2brh+pdtHi/8TU5Kr+Br0VD9GkT9IkLJDb
         DF2B4vwV0WhpfSSs/j0ehgRaEog8cd0gFzBWROL+2P3/MpviuVKN+KRVQtiO/DlUlSnu
         4XQ4+35mi269Ptxvpt3cqokzQnYPHfM3+QrKJirYutFmq3oFYxsYTGGm2DGlSZVSu7TQ
         1BQxqzoReT/ITmn+Ck6gxfg1PLOPTvEGh2XpW9XeZboXboeEG0ShuXV4i8Oe/xwUgYTe
         T5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=s3Kp5U/VqVuXGiRK973FMZHaRwO0ydhDLvBsgwOJLzA=;
        b=y2yq0S2XW4o4eRns2nB/9yzcv4DkZHkPXyv3Uemsysz9WIF6gOFw5Jhl3TaNS6aTnR
         DUb0MrgeXhw6HK0eELRVBHh/fr2KCYhasH2gxuYyjdeaBeVg0536ttviGJM7CGPEv4gZ
         joztLokgjy12uT6WAqreXQlH/rd/S82UXufH9zktqFGt3idNC+VIR28pHAMu9ezFO0AS
         +UK9Lk4VBEqKQxWSIK6/AIWOkGPDmXaL2qr8375aYdCoaKm/NdQWo9bEGzNRu9MdQKAf
         0hYw5YTi3XuDaTQ4cLTEKzYqTT/bVYoYgjXkN4Pv47jznH8LDYd9tiw+l7cSZDZPqBSM
         M9KA==
X-Gm-Message-State: ACgBeo2s8v1F0sq0vOT09TG1908LZPEX5h3cfD+NmUsGL3RLLj0gLOqg
        jzhBtvDgB06KiYvHVYcbiygRUQ==
X-Google-Smtp-Source: AA6agR45hdm0gHtQS1u4JLDnGlQnpfrE9Vhym1N9TiwMCG31vlAKdrRpslpiENNjFvZsFscXGyl94g==
X-Received: by 2002:a63:565c:0:b0:41d:17e1:32f with SMTP id g28-20020a63565c000000b0041d17e1032fmr2943973pgm.445.1660308034832;
        Fri, 12 Aug 2022 05:40:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a134900b001f766b6a879sm5249203pjf.44.2022.08.12.05.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:40:34 -0700 (PDT)
Message-ID: <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
Date:   Fri, 12 Aug 2022 06:40:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: move bio merge attempt to blk_mq_submit_bio()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812083944.79616-1-zhouchengming@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220812083944.79616-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 2:39 AM, Chengming Zhou wrote:
> We will try to get request from cache before alloc request, in
> both cases will first attempt bio merge.
> 
> This patch move this common part to blk_mq_submit_bio(), which
> simplify the code and avoid passing in the pointer of bio.

I don't think this will work. If we get a cached request, then we
know we have a reference to the queue. If you swap these around,
then that's no longer the case and we can have a use-after-free if
the queue goes away.

-- 
Jens Axboe

