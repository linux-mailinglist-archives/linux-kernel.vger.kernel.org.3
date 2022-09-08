Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6595B20E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiIHOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIHOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:40:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C96AA02
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:40:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l6so9341281ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pZDBeWxSoDaW9so+HKgnIStCCw0Inuk1PaP9mjbSPow=;
        b=dN8iGrQe1i0lBn6Y/EIQeR0beICKZxdPQWHi42MzhW+7/ssMDVDQtIOep6pl0p4qeQ
         qtgUs8lbdMrSTREUL0HMXP+7THi9YfX52Uofgfnvu1eqAQ/7yPh3Sfi2zfBF6JBhbyWv
         4FNafl8cGUipoIJvwyowSaJmsiWMmfB5YVSV0MvBL80VEDkcsF7XehPvoHtaM/9xFsNO
         qlti61PQtsC9J8zZ80yyrDsDqSshoZ8Lu42oB2i45Sc2YYmRFxtIW7sdM/FhpaNABUGh
         mfsBTPc0ciffdjRhqgqiMDTtxXhY8e5IesWDyNEtfpLpPIrWuvGzB5SkudT/INEzeuHF
         2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pZDBeWxSoDaW9so+HKgnIStCCw0Inuk1PaP9mjbSPow=;
        b=sBC8v9cs4w/TnRvQFgV49OhN40zVJ/XFvnunAGaFcA6/X/8BSEhgsVvVE9No+p41vP
         cN4Fa2EDztquunkVHd1XozWVs0+ADPt+czYFvuvPHEtkIEu9LGBc1u6AEimdTL/dit8w
         L66mU7wEBhLOoMANd9Sit5hPaf2exeYFWS1h9tvCD0h5VTYOG9RTuXhMiHfcAh0qW8jN
         eSpaMcXaaZnCm4jvd/UWwKywORWwKvbv8pGX/Wk+HwxiZOQ0hWu198TYsAtMEIzzf9VZ
         3MpVE3rGqZufa/nXi822+faMY8iVsJY7ZfwgOErLCgqMn8L+F3SA4drKlSY+XJwW4t6a
         VwRw==
X-Gm-Message-State: ACgBeo3bUPoQ+Vd9VbK14hIODOG7VVZH9w8DEOJZnJKTpxSEw7sXqjJk
        OIXFwGhZSSeO0g/drzQkODHtIA==
X-Google-Smtp-Source: AA6agR5W3eYq5Eak6estuvfuupN5ysbc8kQnmprzj2KXFpS8oupPo7ADaJCYelLa0ygWHxzZWm+jWA==
X-Received: by 2002:a05:6e02:1a8f:b0:2f1:dc7a:c514 with SMTP id k15-20020a056e021a8f00b002f1dc7ac514mr2041198ilv.242.1662648055502;
        Thu, 08 Sep 2022 07:40:55 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p63-20020a022942000000b0034a59bc9b87sm8268143jap.76.2022.09.08.07.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:40:54 -0700 (PDT)
Message-ID: <9cce17dc-2fba-d339-e88b-b76eb9a382b4@kernel.dk>
Date:   Thu, 8 Sep 2022 08:40:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND] sbitmap: Use atomic_{,long}_try_cmpxchg in
 sbitmap.c
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907182144.3245-1-ubizjak@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220907182144.3245-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 12:21 PM, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg instead of
> atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch
> and atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in __sbq_wake_up. x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
> 
> Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications, e.g.
> an extra memory read can be avoided in the loop.
> 
> No functional change intended.

It doesn't apply to the current tree, can you please resend one against
for-6.1/block?

-- 
Jens Axboe


